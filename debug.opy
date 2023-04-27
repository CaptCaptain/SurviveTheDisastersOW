#!mainFile "main.opy"

playervar debugMenuEnabled = false
playervar debugDisasterId = 0

rule "[debug.opy] Enable Inspector / Create Debug Header":
    @Condition debugMode
    
    hudText(localPlayer if localPlayer.debugMenuEnabled else null, localPlayer.debugDisasterId, "Disaster Id", "", HudPosition.TOP, 69, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)

    hudSubheader(localPlayer if localPlayer.debugMenuEnabled else null, "{0}{1} Select {2}{3} | [{4}]: Add Disaster | [{5}]: Reset".format(iconString(Icon.ARROW_LEFT), buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE), iconString(Icon.ARROW_RIGHT), buttonString(Button.ABILITY_2), buttonString(Button.RELOAD)), HudPosition.TOP, 70, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)

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

rule "[debug.opy] Toggle Debug Menu":
    @Event eachPlayer
    @Condition debugMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    wait(0.5, Wait.ABORT_WHEN_FALSE)

    eventPlayer.debugMenuEnabled = not eventPlayer.debugMenuEnabled

    eventPlayer.setAbility1Enabled(not eventPlayer.debugMenuEnabled)
    eventPlayer.setAbility2Enabled(not eventPlayer.debugMenuEnabled)
    eventPlayer.setPrimaryFireEnabled(not eventPlayer.debugMenuEnabled)
    eventPlayer.setSecondaryFireEnabled(not eventPlayer.debugMenuEnabled)

    if not eventPlayer.debugMenuEnabled and len(activeDisasters) > 0:
        disasterReady = true
        displayDisaster()
        queueDisasterEntities()

rule "[debug.opy] Input":
    @Event eachPlayer
    @Condition debugMode
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.debugMenuEnabled
    @Condition any([eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), eventPlayer.isHoldingButton(Button.RELOAD), eventPlayer.isHoldingButton(Button.ABILITY_2)])

    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        eventPlayer.debugDisasterId -= 5 if eventPlayer.isHoldingButton(Button.ABILITY_1) else 1
        eventPlayer.debugDisasterId = max(0, eventPlayer.debugDisasterId)
    if eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        eventPlayer.debugDisasterId += 5 if eventPlayer.isHoldingButton(Button.ABILITY_1) else 1
        eventPlayer.debugDisasterId = min(30, eventPlayer.debugDisasterId)
    if eventPlayer.isHoldingButton(Button.ABILITY_2):
        addDisasterToQueueById(eventPlayer.debugDisasterId)
    if eventPlayer.isHoldingButton(Button.RELOAD):
        cleanupDisaster()

    /* selectMultipleDisasters() */
    /* disasterReady = false

    addDisasterToQueueById(disasters.COPYCAT[disasterData.ID])
    
    wait(3)

    disasterReady = true
    displayDisaster()
    queueDisasterEntities()

    waitUntil(eventPlayer.isHoldingButton(Button.INTERACT), 9999)

    cleanupDisaster() */
    