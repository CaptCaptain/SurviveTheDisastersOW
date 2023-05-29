#!mainFile "../main.opy"

#Global variables

globalvar line_number 0
globalvar i_vocal 1
globalvar active_dialogue_list 2
globalvar main_speaker 3
globalvar dialogue_bot 4
globalvar vocalisation 5
globalvar letter_scroll 6
globalvar i2_vocal 7
globalvar is_dialoguing 8
globalvar subtitle_speed 9
globalvar main_dialogue 10
globalvar dialogue_priority 11
globalvar newline 12
globalvar names_array 13
globalvar heroes_array 14
globalvar hero_colours 15
globalvar fullwidth_spaces 16
globalvar skip_cutscene_pos 17
globalvar sky 18
globalvar dialogue_texts = []
globalvar dialogue_effects = []


#Player variables

playervar no_dialogue 0


#Subroutine names

subroutine main_dialogue 0
subroutine spawnDialogueBot

#!define setDialogueNames(array)\
names_array = array

#!define setDialogueHeroes(array)\
heroes_array = array

#!define setDialogueHeroColors(array)\
hero_colours = array

#!define startDialogueOnce(dialoguePriority, activeDialogue, skipCutscenePosition) \
    #indicate the dialogue priority number here! a higher priority dialogue will interrupt and override a lower priority dialogue but NOT vice versa.\
    if dialogue_priority > dialoguePriority:\
        return\
    #indicate the dialogue priority number here! a higher priority dialogue will interrupt and override a lower priority dialogue but NOT vice versa.\
    dialogue_priority = dialoguePriority\
    #input where you want players to group up to skip the dialogue! if you don't want the skip dialogue option to appear, just input Global.sky here!\
    skip_cutscene_pos = skipCutscenePosition\
    is_dialoguing = true\
    waitUntil(not main_dialogue, 99999)\
    is_dialoguing = false\
    #input your dialogue here! \
    #		1st input = character's hero\
    #		2nd input = dialogue string\
    #		3rd input = delay in seconds before next line starts\
    active_dialogue_list = activeDialogue\
    main_dialogue()\
    dialogue_priority = false\
    skip_cutscene_pos = sky\

#!define startDialogue(dialoguePriority, activeDialogue, skipCutscenePosition) \
    wait(0.25)\
    spawnDialogueBot()\
    wait(0.25)\
    startDialogueOnce(dialoguePriority, activeDialogue, skipCutscenePosition)

#!define createDialogueEffects() \
onScreenText(localPlayer, "{0}{1}{2}".format("[{0} {1}]: ".format(heroIcon(main_speaker), names_array[heroes_array.index(main_speaker)]), main_dialogue.substring(0, letter_scroll), fullwidth_spaces.substring(0, strLen(main_dialogue) - letter_scroll + true)) if main_dialogue else " ", 0, -0.9, 1.5, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, hero_colours[heroes_array.index(main_speaker)], SpecVisibility.NEVER) \
\
createEffect(getAllPlayers(), Effect.RING, Color.AQUA, skip_cutscene_pos, 2, EffectReeval.VISIBILITY_POSITION_AND_RADIUS) \
\
createInWorldText(getAllPlayers() if skip_cutscene_pos.y < 900 else [], "Group up here to skip the dialogue!", skip_cutscene_pos, 1.2, Clip.NONE, WorldTextReeval.VISIBILITY_POSITION_AND_STRING, Color.AQUA, SpecVisibility.DEFAULT) \

rule "global init":
    subtitle_speed = createWorkshopSetting(float[1:10], "General", "Subtitle speed", 4, 1)
    newline = "\n"
    hudSubtext(getAllPlayers(), " {0}{0}{1}".format("{0}{0}{0}{0}{0}{0}{0}{0}{0}".format(newline), newline), HudPosition.TOP, true, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)
    #input your character names here in a specific order!
    names_array = []
    #input your character heroes here in the same order!
    heroes_array = []
    #input your character colours here in the same order!
    hero_colours = []
    fullwidth_spaces = "                                                                                                                                "
    createDialogueEffects()
    sky = vect(9999, 9999, 9999)
    skip_cutscene_pos = sky
    #hudText(getAllPlayers(), null, "Dialogue System by Therister#1251", "  {0} bit.ly/therister".format(iconString(Icon.HEART)), HudPosition.RIGHT, -0.8, Color.WHITE, rgb(174, 158, 255), rgb(196, 102, 255), HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

rule "dialogue effects":
    @Condition is_dialoguing
    @Disabled

    printLog("Dialoguing")

    createDialogueEffects()

    waitUntil(not is_dialoguing, 9999)

    for hudIndex in range(0, len(dialogue_effects), 1):
        destroyEffect(dialogue_effects[hudIndex])
    wait(0.016)

    for hudIndex in range(0, len(dialogue_texts), 1):
        destroyInWorldText(dialogue_texts[hudIndex])
    wait(0.016)

    dialogue_effects = []
    dialogue_texts = []


def spawnDialogueBot():    
    createDummy(random.choice([player.getCurrentHero() for player in getPlayers(Team.2)]), Team.2, -1, sky, Vector.UP)
    dialogue_bot = getLastCreatedEntity()
    dialogue_bot.no_dialogue = true
    dialogue_bot.setInvisibility(Invis.ALL)
    dialogue_bot.setStatusEffect(null, Status.PHASED_OUT, 9999)
    dialogue_bot.setStatusEffect(null, Status.INVINCIBLE, 9999)
    dialogue_bot.setGravity(false)
    dialogue_bot.startForcingName("Dialogue-chan")
    dialogue_bot.startForcingPosition(([player for player in getPlayersOnHero(main_speaker, Team.ALL) if not player.no_dialogue])[0] if vocalisation else sky, true)
    dialogue_bot.disablePlayerCollision()
    dialogue_bot.BOT_DISABLE_AI = true


def main_dialogue():
    @Name "main dialogue subr"
    
    line_number = null
    for i_vocal in range(0, len(active_dialogue_list), true):
        main_speaker = active_dialogue_list[line_number][0]
        dialogue_bot.startForcingHero(main_speaker)
        dialogue_bot.BOT_DISABLE_AI = true
        vocalisation = true
        main_dialogue = active_dialogue_list[line_number][true]
        letter_scroll = null
        for i2_vocal in range(0, strLen(main_dialogue), true):
            waitUntil(is_dialoguing, 0.035)
            letter_scroll += true
            if main_dialogue.substring(letter_scroll - true, 2) in [", ", ". ", "? ", "! ", "- "]:
                vocalisation = false
                waitUntil(is_dialoguing, 0.25 if main_dialogue.charAt(letter_scroll - true) in [",", "-"] else 0.5)
                vocalisation = true
            if not letter_scroll % 3:
                if getNumberOfHeroes(main_speaker, Team.ALL) > true:
                    dialogue_bot.setStatusEffect(null, Status.HACKED, 0.001)
            if is_dialoguing:
                break
        vocalisation = false
        waitUntil(is_dialoguing, active_dialogue_list[line_number][2] * 0.5 * subtitle_speed)
        if is_dialoguing:
            break
        line_number += true
    main_dialogue = null


rule "skip cutscene":
    @Condition main_dialogue != null
    @Condition skip_cutscene_pos.y < 100
    @Condition (all([distance(i, skip_cutscene_pos) < 2.3 for i in [player for player in getAllPlayers() if not player.isDummy()]])) == true

    wait(0.5, Wait.ABORT_WHEN_FALSE)
    
    is_dialoguing = true
    waitUntil(not main_dialogue, 99999)
    is_dialoguing = false


rule "dialogue template":
    @Condition hostPlayer.isHoldingButton(Button.INTERACT) == true
    @Disabled
    
    #indicate the dialogue priority number here! a higher priority dialogue will interrupt and override a lower priority dialogue but NOT vice versa.
    if dialogue_priority > 1:
        return
    #indicate the dialogue priority number here! a higher priority dialogue will interrupt and override a lower priority dialogue but NOT vice versa.
    dialogue_priority = 1
    #input where you want players to group up to skip the dialogue! if you don't want the skip dialogue option to appear, just input Global.sky here!
    skip_cutscene_pos = vect(0, 0, 0)
    is_dialoguing = true
    waitUntil(not main_dialogue, 99999)
    is_dialoguing = false
    #input your dialogue here! 
    #		1st input = character's hero
    #		2nd input = dialogue string
    #		3rd input = delay in seconds before next line starts
    active_dialogue_list = [[Hero.KIRIKO, "Wait till you see me on my bike!", 1], [Hero.KIRIKO, "Crikey! Look at this, my dearest monster! We're in another gamemode!", 1]]
    main_dialogue()
    dialogue_priority = false
    skip_cutscene_pos = sky