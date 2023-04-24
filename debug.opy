#!mainFile "main.opy"

rule "[debug.opy] Enable Inspector / Create Debug Header":
    @Condition debugMode

    #hudHeader(localPlayer, "{0} \n{1} \n{2}".format("{0} fx {1} txt".format(getNumberOfEntityIds(), getNumberOfTextIds()), "{0} ld {1} avg {2} pk".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()), "{0} \n{1}".format("{0} pos \n {1} facing \n {2} facing angles".format(localPlayer.getPosition(), localPlayer.getFacingDirection(), "({0}°, {1}°)".format(localPlayer.getHorizontalFacingAngle(), localPlayer.getVerticalFacingAngle())), "spd {0} hspd {1} vspd {2}".format(localPlayer.getSpeed(), localPlayer.getHorizontalSpeed(), localPlayer.getVerticalSpeed()))), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

    wait(0.032)

    enableInspector()

rule "[debug.opy] Debug Rule #1":
    @Condition debugMode
    @Condition hostPlayer.hasSpawned()
    @Disabled

    while getNumberOfPlayers(Team.1) < 6:
        createDummy(getAllHeroes().exclude([player.getCurrentHero() for player in getPlayers(Team.1)]), Team.1, -1, random.choice(getSpawnPoints(Team.ALL)).getPosition(), null)
        getLastCreatedEntity().BOT_DISABLE_AI = true
        wait(0.016)

rule "[debug.opy] Debug Rule #2":
    @Event eachPlayer
    @Team 1
    @Condition debugMode
    @Condition eventPlayer.isDummy()
    @Condition eventPlayer.BOT_DISABLE_AI == false

    eventPlayer.BOT_DISABLE_AI = true

rule "[debug.opy] Debug Rule #3":
    @Event eachPlayer
    @Condition debugMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    /* selectMultipleDisasters() */
    disasterReady = false

    addDisasterToQueueById(disasters.COPYCAT[disasterData.ID])
    
    wait(3)

    disasterReady = true
    displayDisaster()
    queueDisasterEntities()

    waitUntil(eventPlayer.isHoldingButton(Button.INTERACT), 9999)

    cleanupDisaster()
    