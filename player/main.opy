#!mainFile "../main.opy"

#!define notLastDisasterStringFormat "{2} {0}, {1}"
#!define lastDisasterStringFormat "{2} {0}, and {1}"
#!define getDisasterStringFormat(disaster, lastEntry) lastDisasterStringFormat.format(objectiveDescription, disaster[disasterData.NAME], disaster[disasterData.ICON]) if lastEntry else notLastDisasterStringFormat.format(objectiveDescription, disaster[disasterData.NAME], disaster[disasterData.ICON])

#!define appendDisasterString(disaster, lastEntry) \
    objectiveDescription = getDisasterStringFormat(disaster, lastEntry) if strLen(objectiveDescription) > 0 else "{1}  {0}".format(disaster[disasterData.NAME], disaster[disasterData.ICON])

#!define disasterLastEntryMacro (true if globalIndex == len(activeDisasters) - 1 and len(activeDisasters) > 1 else false)

#!define displayDisaster() \
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

#!define createScoreboardText(slot) hudText(localPlayer if getPlayersInSlot(slot, Team.1) and localPlayer.toggleScoreboard else null, heroIcon(getPlayersInSlot(slot, Team.1).getCurrentHero()), "Survival Streak: {0} | Achievements: {1}".format(getPlayersInSlot(slot, Team.1).survivalStreak, getPlayersInSlot(slot, Team.1).totalMedals), "[{0}]".format(getPlayersInSlot(slot, Team.1)), HudPosition.LEFT, (getPlayersInSlot(slot, Team.1).survivalStreak) * -1, Color.LIME_GREEN if getPlayersInSlot(slot, Team.1).isAlive else Color.RED, evalOnce(Color.ORANGE), evalOnce(Color.WHITE), HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR)

#!define createPlayerAttributeText(player, text, sort_order) hudSubheader(player if (player.toggleScoreboard) else null, text, HudPosition.LEFT, (sorted(getAllPlayers(), lambda survivalPlayer: survivalPlayer.survivalStreak).last().survivalStreak) + sort_order, Color.ORANGE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

playervar playerIndex = 0
playervar survivalStreak = 0
playervar totalMedals = 0
playervar isAlive = true
playervar timeJoined = 0
playervar toggleScoreboard = true

globalvar objectiveDescription = ""

globalvar disasterTypeShown = false
globalvar disasterTypeDescription = ""
globalvar disasterTypeColor = ""
subroutine displayDisasterType

#!include "player/dialogue.opy"
#!include "player/tank.opy"
#!include "player/sombra.opy"

rule "[player/main.opy] Hud":
    hudSubtext(localPlayer if localPlayer.toggleScoreboard else null, "▼ Scoreboard ▼", HudPosition.LEFT, (sorted(getAllPlayers(), lambda player: player.survivalStreak).last().survivalStreak * -1) - 1, Color.GREEN, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.DEFAULT)
    createScoreboardText(0)
    createScoreboardText(1)
    createScoreboardText(2)
    createScoreboardText(3)
    createScoreboardText(4)
    createScoreboardText(5)
    
    # Space
    hudSubheader(getAllPlayers(), " ", HudPosition.LEFT, (sorted(getAllPlayers(), lambda survivalPlayer: survivalPlayer.survivalStreak).last().survivalStreak) + 1, Color.ORANGE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

    # Co-op Changes
    hudSubtext(localPlayer if localPlayer.toggleScoreboard else null, "▼ Notable Co-Op Changes ▼", HudPosition.LEFT, (sorted(getAllPlayers(), lambda player: player.survivalStreak).last().survivalStreak) + 2, Color.ROSE, HudReeval.VISIBILITY_AND_SORT_ORDER, SpecVisibility.NEVER)

        # Limited Tank Health
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() in getTankHeroes() and WS_SETTING_LIMITED_TANK_HEALTH else null), "| Tank Health Limited to 300", 3)

        # Limited Stealth
    createPlayerAttributeText((localPlayer if localPlayer.getCurrentHero() == Hero.SOMBRA else null), "| Limited Duration on Stealth (Ability 1)", 3)

    # Hide Scoreboard
    hudSubheader(getAllPlayers(), "{1} [Hold {0}]".format(buttonString(Button.RELOAD), "Hide" if localPlayer.toggleScoreboard else "Show Scoreboard"), HudPosition.LEFT, (sorted(getAllPlayers(), lambda player: player.survivalStreak).last().survivalStreak * -1) - 2, Color.TURQUOISE, HudReeval.VISIBILITY_SORT_ORDER_AND_STRING, SpecVisibility.NEVER)

    # Disaster Type
    onScreenText(localPlayer if localPlayer.isAlive() and disasterTypeShown else null, disasterTypeDescription, 0, 1, 3, WorldTextReeval.VISIBILITY_POSITION_STRING_AND_COLOR, disasterTypeColor, SpecVisibility.DEFAULT)

    # Credits

    onScreenText(localPlayer if localPlayer.isAlive() else null, "https://workshop.codes/discord", 1.1, 2.12, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else null, "Gamemode by CaptCaptain#11421", -1.1, 2.12, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else null, "{0} Join Workshop Creators! {0}".format(iconString(Icon.ARROW_UP)), 1.1, 2.02, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else null, "Code: {0}".format(WORKSHOP_CODE), -1.1, 2.02, 1.25, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, rgb(rainbow(getTotalTimeElapsed() * 50)), SpecVisibility.DEFAULT)

    onScreenText(localPlayer if localPlayer.isAlive() else null, "★ Favorite the mode to ensure you always play on the latest version", 0, 2.22, 1, WorldTextReeval.VISIBILITY_POSITION_AND_COLOR, Color.WHITE, SpecVisibility.DEFAULT)
    

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

    wait(1, Wait.ABORT_WHEN_FALSE)

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