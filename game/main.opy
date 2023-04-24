#!mainFile "../main.opy"

#!define setMatchTimeAndWait(time) \
setMatchTime(time)\
wait(0.032)\
waitUntil(getMatchTime() == 0, 9999)

#!define setMatchTimeWaitUntilAllDead(time) \
setMatchTime(time)\
wait(0.032)\
waitUntil(getMatchTime() == 0 or len(getPlayersInMatch()) == 0, 9999)

#!define getPlayersAlive() [player for player in getPlayers(Team.1) if player.isAlive and player.hasSpawned()]

#!include "game/anti-crash.opy"

rule "[game/main.opy] Init":
    disableGamemodeCompletion()
    disableAnnouncer()
    disableScoring()

    wait(1)

    if debugMode:
        return

    waitUntil(getNumberOfPlayers(Team.1) > 0, 9999)
    while not isGameInProgress():
        startGamemode()
        wait(0.016)

rule "[game/main.opy] Game Loop":
    @Condition isGameInProgress()

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
        if teamScore(Team.1) % 5 == 0 and teamScore(Team.1) > 0:
            # Double Disaster
            objectiveDescription = ""
            selectMultipleDisasters()
            wait(0.016)
            setMatchTimeWaitUntilAllDead(activeDisasterDuration)
        else:
            objectiveDescription = ""
            selectDisaster()
            wait(0.016)
            setMatchTimeWaitUntilAllDead(activeDisasterDuration)

        cleanupDisaster()

        if teamScore(Team.2) == 0:
            declareTeamVictory(Team.1)

        addToTeamScore(Team.1, 1)
        addToTeamScore(Team.2, -1)
        getPlayersAlive().survivalStreak += 1

        bigMessage([player for player in getPlayers(Team.1) if player.isAlive], "{0} Survived!  {0}".format(iconString(Icon.CHECKMARK)))

        bigMessage([player for player in getPlayers(Team.1) if not player.isAlive], "{0} Wipeout!  {0}".format(iconString(Icon.CROSS)))

        wait(1)

        # Break
        if teamScore(Team.1) % 5 == 0 and teamScore(Team.1) > 0:
            objectiveDescription = "{0} Warning {0}".format(iconString(Icon.WARNING))
            bigMessage(getAllPlayers(), "{0} Warning  {0}".format(iconString(Icon.WARNING)))
            setMatchTimeAndWait(20)
            continue

        objectiveDescription = "Next Disaster In"
        setMatchTimeAndWait(20)