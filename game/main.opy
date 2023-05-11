#!mainFile "../main.opy"

enum dangerMode:
    NULL,
    MULTI_DISASTER,
    MYSTERY,
    BOSS_HUNT

#!define createBossSpawn(position, color, text, icon)\
createEffect(getAllPlayers() if not disasterReady else null, Effect.RING, color, position, 3.25, EffectReeval.VISIBILITY_AND_COLOR)\
allocateEffect()\
\
createInWorldText(getAllPlayers() if not disasterReady else null, text if distance(position, localPlayer.getPosition()) < 15 else icon, position + (Vector.UP * 2.25), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, color, SpecVisibility.DEFAULT)\
allocateText()\
\
createEffect(getAllPlayers() if not disasterReady else null, Effect.BAD_AURA, Color.ORANGE, position, 0, EffectReeval.VISIBILITY_AND_COLOR)\
allocateEffect()\
\
createEffect(getAllPlayers() if not disasterReady else null, Effect.ORB, Color.ORANGE, position, 0, EffectReeval.VISIBILITY_AND_COLOR)\
allocateEffect()\

#!define setMatchTimeAndWait(time) \
setMatchTime(time)\
wait(0.032)\
waitUntil(getMatchTime() == 0, 9999)

#!define setMatchTimeWaitUntilAllDead(time) \
setMatchTime(time)\
wait(0.032)\
waitUntil(getMatchTime() == 0 or all([player.isAlive == false for player in getPlayersInMatch()]), 9999)

#!define setMatchTimeWaitUntilAllDeadOrBossDead(time) \
setMatchTime(time)\
wait(0.032)\
waitUntil(getMatchTime() == 0 or all([player.isAlive == false for player in getPlayersInMatch()]) or all([player.isDead() for player in getPlayers(Team.2)]), 9999)

#!define getHighestScoredPlayer() sorted(getPlayersInMatch(), lambda player: player.survivalScore).last()

#!define getHighestAchievingPlayer() sorted(getPlayersInMatch(), lambda player: player.totalMedals).last()

#!define getTeamScore() getPlayersInSlot(0, Team.1).survivalScore + getPlayersInSlot(1, Team.1).survivalScore + getPlayersInSlot(2, Team.1).survivalScore + getPlayersInSlot(3, Team.1).survivalScore + getPlayersInSlot(4, Team.1).survivalScore + getPlayersInSlot(5, Team.1).survivalScore

#!include "game/anti-crash.opy"

globalvar selectedDangerMode

rule "[game/main.opy] Init":
    disableGamemodeCompletion()
    disableAnnouncer()
    disableScoring()

    if not WS_SETTING_ENABLE_MUSIC:
        disableMusic()

    wait(1)

    if debugMode:
        return

    waitUntil(getNumberOfPlayers(Team.1) > 0, 9999)
    while isWaitingForPlayers():
        startGamemode()
        wait(0.016)

rule "[game/main.opy] Game Loop":
    waitUntil(isGameInProgress(), 9999)

    if debugMode:
        return

    setTeamScore(Team.2, WS_SETTING_MAX_ROUNDS)

    # Break Time
    objectiveDescription = "Break Time"
    setMatchTime(60 if WS_SETTING_LONG_BREAK else 20)

    waitUntil(getMatchTime() == 0, 9999)

    # Game Loop
    while true:
        # Disaster
        switch (selectedDangerMode):
            case dangerMode.MULTI_DISASTER:
                objectiveDescription = ""
                selectMultipleDisasters()
                wait(0.016)
                setMatchTimeWaitUntilAllDead(activeDisasterDuration)
                break
            case dangerMode.MYSTERY:
                objectiveDescription = ""
                addDisaster(disasters.MYSTERY)

                wait(3)

                disasterReady = true
                displayDisaster()

                wait(0.016)
                setMatchTimeWaitUntilAllDead(activeDisasterDuration)
                break
            case dangerMode.BOSS_HUNT:
                cleanupDisasterEffects()
                cleanupDisasterTexts()

                objectiveDescription = ""
                selectBossDisaster()

                fixedSmallMessageWithIcon(getAllPlayers(), iconString(Icon.WARNING), "Survive or defeat the boss!")

                wait(0.016)
                setMatchTimeWaitUntilAllDeadOrBossDead(activeDisasterDuration)

                if all([player.isDead() for player in getPlayers(Team.2)]):
                    wait(1)

                bigMessage([player for player in getPlayers(Team.1) if player.isAlive and Medals.BOSS_HUNTER[medalData.TITLE] in player.medalsEarned], "{0} Boss Defeat!  {0}".format(abilityIconString(Hero.ECHO, Button.SECONDARY_FIRE)))

                break
            default:
                objectiveDescription = ""
                selectDisaster()
                wait(0.016)
                setMatchTimeWaitUntilAllDead(activeDisasterDuration)
                break

        cleanupDisaster()
        selectedDangerMode = dangerMode.NULL

        getPlayersAlive().survivalStreak += 1

        bigMessage([player for player in getPlayers(Team.1) if player.isAlive and not Medals.BOSS_HUNTER[medalData.TITLE] in player.medalsEarned], "{0} Survived!  {0}".format(iconString(Icon.CHECKMARK)))

        bigMessage([player for player in getPlayers(Team.1) if not player.isAlive], "{0} Wipeout!  {0}".format(iconString(Icon.CROSS)))

        wait(1)

        if teamScore(Team.2) == 0:
            wait(2)

            getAllPlayers().disableGamemodeHud()

            # Create end results
                # Results
            onScreenText(getAllPlayers(), "End Results", 0, 1.8, 3, WorldTextReeval.VISIBILITY_AND_POSITION, Color.LIME_GREEN, SpecVisibility.DEFAULT)

                # Best Score
            onScreenText(getAllPlayers(), "Best Score", 0, 1.65, 1.5, WorldTextReeval.VISIBILITY_AND_POSITION, Color.ORANGE, SpecVisibility.DEFAULT)
            onScreenText(getAllPlayers(), "{0} ({1} PTS)".format(getHighestScoredPlayer(), getHighestScoredPlayer().survivalScore), 0, 1.55, 1.25, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)

                # Achievement Hunter
            onScreenText(getAllPlayers(), "Achievement Hunter", -1.1, 1.65, 1.5, WorldTextReeval.VISIBILITY_AND_POSITION, Color.ORANGE, SpecVisibility.DEFAULT)
            onScreenText(getAllPlayers(), "{0} ({1} Earned)".format(getHighestAchievingPlayer(), getHighestAchievingPlayer().totalMedals), -1.1, 1.55, 1.25, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)

                # Team Score
            onScreenText(getAllPlayers(), "Team Score", 1.1, 1.65, 1.5, WorldTextReeval.VISIBILITY_AND_POSITION, Color.ORANGE, SpecVisibility.DEFAULT)
            onScreenText(getAllPlayers(), "{0} PTS".format(getTeamScore()), 1.1, 1.55, 1.25, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.DEFAULT)

            wait(2)

            declareTeamVictory(Team.1)

        addToTeamScore(Team.1, 1)
        addToTeamScore(Team.2, -1)

        # Break
        if teamScore(Team.1) % 2 == 0 and teamScore(Team.1) > 0:
            selectedDangerMode = random.choice([dangerMode.BOSS_HUNT])
            
            switch (selectedDangerMode):
                case dangerMode.BOSS_HUNT:
                    objectiveDescription = "{0} Boss Hunt {0}".format(abilityIconString(Hero.KIRIKO, Button.ULTIMATE))
                    bigMessage(getAllPlayers(), "{0} Boss Hunt  {0}".format(abilityIconString(Hero.KIRIKO, Button.ULTIMATE)))

                    createBossSpawn(getSpawnPoints(Team.ALL)[1], Color.ORANGE, "{0} Boss Spawn {0}".format(iconString(Icon.ARROW_DOWN)), abilityIconString(Hero.KIRIKO, Button.ULTIMATE))

                    break
                default:
                    objectiveDescription = "{0} Warning {0}".format(iconString(Icon.WARNING))
                    bigMessage(getAllPlayers(), "{0} Warning  {0}".format(iconString(Icon.WARNING)))
                    break

            setMatchTimeAndWait(20)
            continue

        objectiveDescription = "Next Disaster In"
        setMatchTimeAndWait(20)