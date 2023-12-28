#!mainFile "../main.opy"

#!define notLastDisasterStringFormat "{2} {0}, {1}"
#!define lastDisasterStringFormat "{2} {0}, and {1}"
#!define getDisasterStringFormat(disaster, lastEntry) lastDisasterStringFormat.format(objectiveDescription, disaster[disasterData.NAME], disaster[disasterData.ICON]) if lastEntry else notLastDisasterStringFormat.format(objectiveDescription, disaster[disasterData.NAME], disaster[disasterData.ICON])

#!define appendDisasterString(disaster, lastEntry) \
    objectiveDescription = getDisasterStringFormat(disaster, lastEntry) if strLen(objectiveDescription) > 0 else "{1}  {0}".format(disaster[disasterData.NAME], disaster[disasterData.ICON])

#!define disasterLastEntryMacro (true if globalIndex == len(activeDisasters) - 1 and len(activeDisasters) > 1 else false)

#!define displayDisasterMacro() \
for globalIndex in range(0, len(activeDisasters), 1):\
    switch (activeDisasters[globalIndex]):\
        case disasters.MOTHS[disasterData.ID]:\
            appendDisasterString(disasters.MOTHS, disasterLastEntryMacro)\
            break\
        case disasters.WIFELEAVER[disasterData.ID]:\
            appendDisasterString(disasters.WIFELEAVER, disasterLastEntryMacro)\
            break\
        case disasters.MINEFIELD[disasterData.ID]:\
            appendDisasterString(disasters.MINEFIELD, disasterLastEntryMacro)\
            break\
        case disasters.BOB[disasterData.ID]:\
            appendDisasterString(disasters.BOB, disasterLastEntryMacro)\
            break\
        case disasters.SIMON[disasterData.ID]:\
            appendDisasterString(disasters.SIMON, disasterLastEntryMacro)\
            break\
        case disasters.ACID_RAIN[disasterData.ID]:\
            appendDisasterString(disasters.ACID_RAIN, disasterLastEntryMacro)\
            break\
        case disasters.SOMBRA[disasterData.ID]:\
            appendDisasterString(disasters.SOMBRA, disasterLastEntryMacro)\
            break\
        case disasters.WINTON[disasterData.ID]:\
            appendDisasterString(disasters.WINTON, disasterLastEntryMacro)\
            break\
        case disasters.KAME[disasterData.ID]:\
            appendDisasterString(disasters.KAME, disasterLastEntryMacro)\
            break\
        case disasters.FLOOD[disasterData.ID]:\
            appendDisasterString(disasters.FLOOD, disasterLastEntryMacro)\
            break\
        case disasters.MYSTERY[disasterData.ID]:\
            appendDisasterString(disasters.MYSTERY, disasterLastEntryMacro)\
            break\
        case disasters.GET_DOWN[disasterData.ID]:\
            appendDisasterString(disasters.GET_DOWN, disasterLastEntryMacro)\
            break\
        case disasters.DEATH_TRAMPOLINE[disasterData.ID]:\
            appendDisasterString(disasters.DEATH_TRAMPOLINE, disasterLastEntryMacro)\
            break\
        case disasters.GREEN_ZONE[disasterData.ID]:\
            appendDisasterString(disasters.GREEN_ZONE, disasterLastEntryMacro)\
            break\
        case disasters.MURDERERS[disasterData.ID]:\
            appendDisasterString(disasters.MURDERERS, disasterLastEntryMacro)\
            break\
        case disasters.NULL_SECTOR[disasterData.ID]:\
            appendDisasterString(disasters.NULL_SECTOR, disasterLastEntryMacro)\
            break\
        case disasters.TALON[disasterData.ID]:\
            appendDisasterString(disasters.TALON, disasterLastEntryMacro)\
            break\
        case disasters.BUTTON[disasterData.ID]:\
            appendDisasterString(disasters.BUTTON, disasterLastEntryMacro)\
            break\
        case disasters.NINJA[disasterData.ID]:\
            appendDisasterString(disasters.NINJA, disasterLastEntryMacro)\
            break\
        case disasters.COPYCAT[disasterData.ID]:\
            appendDisasterString(disasters.COPYCAT, disasterLastEntryMacro)\
            break\
        case disasters.BLACK_HOLE[disasterData.ID]:\
            appendDisasterString(disasters.BLACK_HOLE, disasterLastEntryMacro)\
            break\
        case disasters.LAVA[disasterData.ID]:\
            appendDisasterString(disasters.LAVA, disasterLastEntryMacro)\
            break\
        case disasters.ACID[disasterData.ID]:\
            appendDisasterString(disasters.ACID, disasterLastEntryMacro)\
            break\
        case disasters.SNIPER[disasterData.ID]:\
            appendDisasterString(disasters.SNIPER, disasterLastEntryMacro)\
            break\
        case disasters.BOMBS[disasterData.ID]:\
            appendDisasterString(disasters.BOMBS, disasterLastEntryMacro)\
            break\
        case disasters.FAKE_BP[disasterData.ID]:\
            appendDisasterString(disasters.FAKE_BP, disasterLastEntryMacro)\
            break\
        case disasters.WISP[disasterData.ID]:\
            appendDisasterString(disasters.WISP, disasterLastEntryMacro)\
            break\
        case disasters.BLIZZARD[disasterData.ID]:\
            appendDisasterString(disasters.BLIZZARD, disasterLastEntryMacro)\
            break\
        case disasters.GALACTIC_SIGMA[disasterData.ID]:\
            appendDisasterString(disasters.GALACTIC_SIGMA, disasterLastEntryMacro)\
            break\
        case disasters.WITCH[disasterData.ID]:\
            appendDisasterString(disasters.WITCH, disasterLastEntryMacro)\
            break\
        case disasters.TIKTOK[disasterData.ID]:\
            appendDisasterString(disasters.TIKTOK, disasterLastEntryMacro)\
            break\
        case disasters.PHARAMERCY[disasterData.ID]:\
            appendDisasterString(disasters.PHARAMERCY, disasterLastEntryMacro)\
            break\
        case disasters.VISHKAR[disasterData.ID]:\
            appendDisasterString(disasters.VISHKAR, disasterLastEntryMacro)\
            break\
        case disasters.ZEUS[disasterData.ID]:\
            appendDisasterString(disasters.ZEUS, disasterLastEntryMacro)\
            break\
        case disasters.NUCLEAR_BOMB[disasterData.ID]:\
            appendDisasterString(disasters.NUCLEAR_BOMB, disasterLastEntryMacro)\
            break\
        case disasters.CRUSADERS[disasterData.ID]:\
            appendDisasterString(disasters.CRUSADERS, disasterLastEntryMacro)\
            break\
        case disasters.ORISA_DEFENDER[disasterData.ID]:\
            appendDisasterString(disasters.ORISA_DEFENDER, disasterLastEntryMacro)\
            break\
        case disasters.FLYING_BASTION[disasterData.ID]:\
            appendDisasterString(disasters.FLYING_BASTION, disasterLastEntryMacro)\
            break\
        case disasters.COWBOY[disasterData.ID]:\
            appendDisasterString(disasters.COWBOY, disasterLastEntryMacro)\
            break\
        case disasters.JUNKERS[disasterData.ID]:\
            appendDisasterString(disasters.JUNKERS, disasterLastEntryMacro)\
            break\
        case disasters.CLIMATOLOGIST[disasterData.ID]:\
            appendDisasterString(disasters.CLIMATOLOGIST, disasterLastEntryMacro)\
            break\
        case disasters.INTI_WARRIORS[disasterData.ID]:\
            appendDisasterString(disasters.INTI_WARRIORS, disasterLastEntryMacro)\
            break\
        case disasters.THIS_ENDS[disasterData.ID]:\
            appendDisasterString(disasters.THIS_ENDS, disasterLastEntryMacro)\
            break\
        case disasters.FROGGERS[disasterData.ID]:\
            appendDisasterString(disasters.FROGGERS, disasterLastEntryMacro)\
            break\

#!define getOnScreenTextEyePosition(player) (player.onScreenTextEyePosition if player.onScreenTextEyePosition else player.getEyePosition())

#!define getOnScreenTextFacingPosition(player) (player.onScreenTextFacingDirection if player.onScreenTextFacingDirection else player.getFacingDirection())

#!define scoreboardPosition(slot) scoreboardPlayers.index(evalOnce(getPlayersInSlot(slot, Team.1))) * -1

#!define firstOnScoreboardPosition() scoreboardPlayers.index(scoreboardPlayers[0])

#!define lastOnScoreboardPosition() scoreboardPlayers.index(scoreboardPlayers.last())

#!define createScoreboardText(slot) hudText([player for player in getPlayers(Team.1) if player.toggleScoreboard], heroIcon(evalOnce(getPlayersInSlot(slot, Team.1)).getCurrentHero()), "Score: {2} | Survival Streak: {0} | Achievements: {1}".format(evalOnce(getPlayersInSlot(slot, Team.1)).survivalStreak, evalOnce(getPlayersInSlot(slot, Team.1)).totalMedals, evalOnce(getPlayersInSlot(slot, Team.1)).survivalScore), alignLeftString("[{0}] {1}".format(evalOnce(getPlayersInSlot(slot, Team.1)), evalOnce(getPlayersInSlot(slot, Team.1)).scoreboardChallenges)), HudPosition.LEFT, scoreboardPosition(slot), Color.LIME_GREEN if evalOnce(getPlayersInSlot(slot, Team.1)).isAlive else Color.RED, evalOnce(Color.ORANGE), evalOnce(Color.WHITE), HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)

#!define createPlayerAttributeText(player, text, sort_order) hudSubheader(player if (player.toggleScoreboard) else [], text, HudPosition.LEFT, lastOnScoreboardPosition() + sort_order, Color.ORANGE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

#!define allocate(array, lastCreated) \
array.append(lastCreated) \

#!define allocateHudText(array) \
array.append(getLastCreatedText()) \

#!define cleanupHudTextFor(array) \
for hudIndex in range(0, len(array), 1): \
    destroyInWorldText(array[hudIndex]) \
wait(0.016) \
array = [] \

#!define nextAIBot [player for player in getPlayers(Team.1) if player.isAIBot][0]

playervar playerIndex = 0
playervar survivalScore = 0
playervar survivalStreak = 0
playervar totalMedals = 0
playervar isAlive = true
playervar timeJoined = 0
playervar toggleScoreboard = true
playervar scoreboardChallenges = ""
playervar isAIBot = false

globalvar scoreboardPlayerRef = []
globalvar scoreboardTextID = []

globalvar botBeingRemoved

globalvar hudIndex = 0

globalvar toggleCredits = false
globalvar creditsTexts = []

globalvar scoreboardPlayers = []

globalvar objectiveDescription = ""

globalvar disasterTypeShown = false
globalvar disasterTypeDescription = ""
globalvar disasterTypeColor = ""
globalvar disasterTypeTexts = []

playervar onScreenTextEyePosition
playervar onScreenTextFacingDirection

#!include "player/dialogue.opy"
#!include "player/tank.opy"
#!include "player/sombra.opy"

subroutine displayDisasterSub
globalvar displayedDisaster
def displayDisaster():
    displayDisasterMacro()

rule "[player/main.opy] Hud":
    hudSubtext(localPlayer if localPlayer.toggleScoreboard else [], alignLeftString("▼ Scoreboard ▼"), HudPosition.LEFT, -7, Color.GREEN, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.DEFAULT)
    
    # Space
    hudSubheader(getAllPlayers(), " ", HudPosition.LEFT, lastOnScoreboardPosition() + 1, Color.ORANGE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

    # Co-op Changes
    hudSubtext(localPlayer if localPlayer.toggleScoreboard else [], alignLeftString("▼ Notable Co-Op Changes ▼"), HudPosition.LEFT, lastOnScoreboardPosition() + 2, Color.ROSE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

        # Limited Tank Health
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() in getTankHeroes() and evalOnce(WS_SETTING_LIMITED_TANK_HEALTH) else []), alignLeftString("| Tank Health Limited to 300"), 3)

        # Limited Stealth
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() == Hero.SOMBRA and evalOnce(WS_SETTING_LIMITED_STEALTH) else []), alignLeftString("| Limited Duration on Stealth (Passive)"), 3)

        # Limited Lifegrip
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() == Hero.LIFEWEAVER and evalOnce(WS_SETTING_LIFE_GRIP_LIMITED) else []), alignLeftString("| {0} Life Grip / {1} Petal Platform limited\n| during certain disasters".format(abilityIconString(Hero.LIFEWEAVER, Button.ABILITY_2), abilityIconString(Hero.LIFEWEAVER, Button.ABILITY_1))), 4)

        # Buffed Resurrect
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() == Hero.MERCY else []), alignLeftString("| {0} Resurrect cooldown reduced".format(abilityIconString(Hero.MERCY, Button.ABILITY_2))), 5)

    # Hide Scoreboard
    hudSubheader(getAllPlayers(), alignLeftString("{1} [Hold {0}]".format(buttonString(Button.RELOAD), "Hide" if localPlayer.toggleScoreboard else "Show Scoreboard")), HudPosition.LEFT, -8, Color.TURQUOISE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.NEVER)

rule "[player/main.opy] Credits Hud":
    @Condition toggleCredits
    
    # Credits

    onScreenTextCustomRender(getPlayers(Team.1), "         Mode by CaptCaptain ▶ {}\nworkshop.codes/survive-disasters".format(WORKSHOP_CODE), getOnScreenTextEyePosition(localPlayer), getOnScreenTextFacingPosition(localPlayer), -1.1, 2.04, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)
    allocateHudText(creditsTexts)

    onScreenTextCustomRender(getPlayers(Team.1), "   {0} Join Workshop Creators! {0}\nhttps://workshop.codes/discord".format(iconString(Icon.ARROW_DOWN)), getOnScreenTextEyePosition(localPlayer), getOnScreenTextFacingPosition(localPlayer), 1.1, 2.04, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)
    allocateHudText(creditsTexts)

    waitUntil(not toggleCredits, 9999)

    cleanupHudTextFor(creditsTexts)

rule "[player/main.opy] Disaster Type Hud":
    @Condition disasterTypeShown
    
    # Disaster Type
    onScreenTextCustomRender(localPlayer, disasterTypeDescription, getOnScreenTextEyePosition(localPlayer), getOnScreenTextFacingPosition(localPlayer), 0, 1, 3, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, disasterTypeColor, SpecVisibility.DEFAULT)
    allocateHudText(disasterTypeTexts)

    waitUntil(not disasterTypeShown, 9999)

    cleanupHudTextFor(disasterTypeTexts)
    

rule "[player/main.opy] Init":
    @Event eachPlayer
    @Team 1

    eventPlayer.timeJoined = getTotalTimeElapsed()
    
    if eventPlayer.isDummy():
        return

    eventPlayer.startForcingName("¤")
    if "{}".format(eventPlayer).strIndex("¤") != -1:
        eventPlayer.isAIBot = true
        eventPlayer.startForcingName("")

    waitUntil(eventPlayer.hasSpawned(), 9999)

    setObjectiveDescription(eventPlayer, objectiveDescription, HudReeval.VISIBILITY_AND_STRING)

rule "[player/main.opy] Update Objective Description":
    @Event global

    while true:
        waitUntil(objectiveDescription != evalOnce(objectiveDescription), 9999)
        setObjectiveDescription(getPlayers(Team.1), objectiveDescription, HudReeval.VISIBILITY_AND_STRING)
        wait(0.016)

rule "[player/main.opy] Joining Rules":
    @Event playerJoined
    @Team 1

    wait(0.016)

    # Create Scoreboard Hud Text if player is not an AI or dummy bot
    if not eventPlayer.isAIBot and not eventPlayer.isDummy():
        createScoreboardText(eventPlayer.getSlot())
        allocate(scoreboardTextID, getLastCreatedText())
        allocate(scoreboardPlayerRef, eventPlayer)
    #
    
    # Make room for more players by removing any AI bots present
    while getNumberOfPlayers(Team.1) == 6 and len([player for player in getPlayers(Team.1) if player.isAIBot]) > 0:
        wait(0.016)

        botBeingRemoved = nextAIBot

        removeFromGame(botBeingRemoved)
        waitUntil(not entityExists(botBeingRemoved), 9999)

rule "[player/main.opy] Leaving Rules":
    @Event playerLeft
    @Team 1

    # Remove scoreboard hud text
    destroyHudText([ID for ID in scoreboardTextID if not entityExists(scoreboardPlayerRef[scoreboardTextID.index(ID)])])

rule "[player/main.opy] Toggle Scoreboard":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    wait(0.5, Wait.ABORT_WHEN_FALSE)

    eventPlayer.toggleScoreboard = not eventPlayer.toggleScoreboard

    if eventPlayer.toggleScoreboard:
        fixedSmallMessageWithIcon(eventPlayer, iconString(Icon.CHECKMARK), "Scoreboard Visible")
    else:
        fixedSmallMessageWithIcon(eventPlayer, iconString(Icon.NO), "Scoreboard Hidden")

rule "[player/main.opy] Update Scoreboard":
    wait(1)
    while true:
        waitUntil(getPlayers(Team.1) != evalOnce(getPlayers(Team.1)), 0.5)
        scoreboardPlayers = sorted(getPlayers(Team.1), lambda player: player.survivalScore)
        wait(0.5)