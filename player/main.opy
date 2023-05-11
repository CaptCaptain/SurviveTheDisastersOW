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

#!define scoreboardPosition(slot) scoreboardPlayers.index(getPlayersInSlot(slot, Team.1)) * -1

#!define firstOnScoreboardPosition() scoreboardPlayers.index(scoreboardPlayers[0])

#!define lastOnScoreboardPosition() scoreboardPlayers.index(scoreboardPlayers.last())

#!define createScoreboardText(slot) hudText(localPlayer if getPlayersInSlot(slot, Team.1) and localPlayer.toggleScoreboard else [], heroIcon(getPlayersInSlot(slot, Team.1).getCurrentHero()), "Score: {2} | Survival Streak: {0} | Achievements: {1}".format(getPlayersInSlot(slot, Team.1).survivalStreak, getPlayersInSlot(slot, Team.1).totalMedals, getPlayersInSlot(slot, Team.1).survivalScore), "[{0}]".format(getPlayersInSlot(slot, Team.1)), HudPosition.LEFT, scoreboardPosition(slot), Color.LIME_GREEN if getPlayersInSlot(slot, Team.1).isAlive else Color.RED, evalOnce(Color.ORANGE), evalOnce(Color.WHITE), HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)

#!define createPlayerAttributeText(player, text, sort_order) hudSubheader(player if (player.toggleScoreboard) else [], text, HudPosition.LEFT, lastOnScoreboardPosition() + sort_order, Color.ORANGE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

playervar playerIndex = 0
playervar survivalScore = 0
playervar survivalStreak = 0
playervar totalMedals = 0
playervar isAlive = true
playervar timeJoined = 0
playervar toggleScoreboard = true

globalvar scoreboardPlayers = []

globalvar objectiveDescription = ""

globalvar disasterTypeShown = false
globalvar disasterTypeDescription = ""
globalvar disasterTypeColor = ""

#!include "player/dialogue.opy"
#!include "player/tank.opy"
#!include "player/sombra.opy"

subroutine displayDisasterSub
globalvar displayedDisaster
def displayDisaster():
    displayDisasterMacro()

rule "[player/main.opy] Hud":
    hudSubtext(localPlayer if localPlayer.toggleScoreboard else [], "▼ Scoreboard ▼", HudPosition.LEFT, -7, Color.GREEN, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.DEFAULT)
    createScoreboardText(0)
    createScoreboardText(1)
    createScoreboardText(2)
    createScoreboardText(3)
    createScoreboardText(4)
    createScoreboardText(5)
    
    # Space
    hudSubheader(getAllPlayers(), " ", HudPosition.LEFT, lastOnScoreboardPosition() + 1, Color.ORANGE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

    # Co-op Changes
    hudSubtext(localPlayer if localPlayer.toggleScoreboard else [], "▼ Notable Co-Op Changes ▼", HudPosition.LEFT, lastOnScoreboardPosition() + 2, Color.ROSE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

        # Limited Tank Health
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() in getTankHeroes() and evalOnce(WS_SETTING_LIMITED_TANK_HEALTH) else []), "| Tank Health Limited to 300", 3)

        # Limited Stealth
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() == Hero.SOMBRA and evalOnce(WS_SETTING_LIMITED_STEALTH) else []), "| Limited Duration on Stealth (Ability 1)", 3)

        # Limited Stealth
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() == Hero.LIFEWEAVER and evalOnce(WS_SETTING_LIFE_GRIP_LIMITED) else []), "| {0} Life Grip / {1} Petal Platform restricted\n| during certain disasters".format(abilityIconString(Hero.LIFEWEAVER, Button.ABILITY_2), abilityIconString(Hero.LIFEWEAVER, Button.ABILITY_1)), 4)

    # Hide Scoreboard
    hudSubheader(getAllPlayers(), "{1} [Hold {0}]".format(buttonString(Button.RELOAD), "Hide" if localPlayer.toggleScoreboard else "Show Scoreboard"), HudPosition.LEFT, -8, Color.TURQUOISE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.NEVER)

    # Disaster Type
    onScreenText(localPlayer if localPlayer.isAlive() and disasterTypeShown else [], disasterTypeDescription, 0, 1, 3, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, disasterTypeColor, SpecVisibility.DEFAULT)

    # Credits

    onScreenText(localPlayer if localPlayer.isAlive() else [], "https://workshop.codes/discord", 1.1, 2.12, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else [], "Mode by CaptCaptain ▶ {}".format(WORKSHOP_CODE), -1.1, 2.12, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else [], "{0} Join Workshop Creators! {0}".format(iconString(Icon.ARROW_UP)), 1.1, 2.02, 1, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else [], "https://workshop.codes/survive-disasters".format(WORKSHOP_CODE), -1.1, 2.02, 1, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else [], "★ Import code {} to ensure you always play on the latest version".format(WORKSHOP_CODE), 0, 2.22, 1, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    

rule "[player/main.opy] Init":
    @Event eachPlayer
    @Team 1

    eventPlayer.timeJoined = getTotalTimeElapsed()

    waitUntil(eventPlayer.hasSpawned(), 9999)

    setObjectiveDescription(eventPlayer, objectiveDescription, HudReeval.VISIBILITY_AND_STRING)

    while true:
        waitUntil(objectiveDescription != evalOnce(objectiveDescription), 9999)
        setObjectiveDescription(eventPlayer, objectiveDescription, HudReeval.VISIBILITY_AND_STRING)
        wait(0.016)

rule "[player/main.opy] Toggle Scoreboard":
    @Event eachPlayer
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    wait(0.5, Wait.ABORT_WHEN_FALSE)

    eventPlayer.toggleScoreboard = not eventPlayer.toggleScoreboard

    if eventPlayer.toggleScoreboard:
        fixedSmallMessageWithIcon(eventPlayer, iconString(Icon.CHECKMARK), "Scoreboard Visible")
    else:
        fixedSmallMessageWithIcon(eventPlayer, iconString(Icon.NO), "Scoreboard Hidden")

rule "[player/main.opy] Reset Survival Streak on Death":
    @Event eachPlayer
    @Condition eventPlayer.isDead()

    eventPlayer.isAlive = false

    # We don't want to use the playerDied event as it won't trigger with Acid Rain

    eventPlayer.survivalStreak = 0

    waitUntil(objectiveDescription == "", 9999)

    wait(1)

    eventPlayer.isAlive = true

rule "[player/main.opy] Update Scoreboard":
    while true:
        scoreboardPlayers = sorted(getPlayers(Team.1), lambda player: player.survivalScore)
        wait(1)