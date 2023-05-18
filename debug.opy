#!mainFile "main.opy"

playervar debugMenuEnabled = false
playervar debugDisasterId = 0
playervar debugDisasterName = ""

#!define displayDebugDisaster(disaster) \
eventPlayer.debugDisasterName = "{0} {1} {0}".format(disaster[disasterData.ICON], disaster[disasterData.NAME])

subroutine displayDebugDisasterName

def displayDebugDisasterName():
    switch (eventPlayer.debugDisasterId):
        case disasters.MOTHS[disasterData.ID]:
            displayDebugDisaster(disasters.MOTHS)
            break
        case disasters.WIFELEAVER[disasterData.ID]:
            displayDebugDisaster(disasters.WIFELEAVER)
            break
        case disasters.MINEFIELD[disasterData.ID]:
            displayDebugDisaster(disasters.MINEFIELD)
            break
        case disasters.BOB[disasterData.ID]:
            displayDebugDisaster(disasters.BOB)
            break
        case disasters.SIMON[disasterData.ID]:
            displayDebugDisaster(disasters.SIMON)
            break
        case disasters.ACID_RAIN[disasterData.ID]:
            displayDebugDisaster(disasters.ACID_RAIN)
            break
        case disasters.SOMBRA[disasterData.ID]:
            displayDebugDisaster(disasters.SOMBRA)
            break
        case disasters.WINTON[disasterData.ID]:
            displayDebugDisaster(disasters.WINTON)
            break
        case disasters.KAME[disasterData.ID]:
            displayDebugDisaster(disasters.KAME)
            break
        case disasters.FLOOD[disasterData.ID]:
            displayDebugDisaster(disasters.FLOOD)
            break
        case disasters.MYSTERY[disasterData.ID]:
            displayDebugDisaster(disasters.MYSTERY)
            break
        case disasters.GET_DOWN[disasterData.ID]:
            displayDebugDisaster(disasters.GET_DOWN)
            break
        case disasters.DEATH_TRAMPOLINE[disasterData.ID]:
            displayDebugDisaster(disasters.DEATH_TRAMPOLINE)
            break
        case disasters.GREEN_ZONE[disasterData.ID]:
            displayDebugDisaster(disasters.GREEN_ZONE)
            break
        case disasters.MURDERERS[disasterData.ID]:
            displayDebugDisaster(disasters.MURDERERS)
            break
        case disasters.NULL_SECTOR[disasterData.ID]:
            displayDebugDisaster(disasters.NULL_SECTOR)
            break
        case disasters.TALON[disasterData.ID]:
            displayDebugDisaster(disasters.TALON)
            break
        case disasters.BUTTON[disasterData.ID]:
            displayDebugDisaster(disasters.BUTTON)
            break
        case disasters.NINJA[disasterData.ID]:
            displayDebugDisaster(disasters.NINJA)
            break
        case disasters.COPYCAT[disasterData.ID]:
            displayDebugDisaster(disasters.COPYCAT)
            break
        case disasters.BLACK_HOLE[disasterData.ID]:
            displayDebugDisaster(disasters.BLACK_HOLE)
            break
        case disasters.LAVA[disasterData.ID]:
            displayDebugDisaster(disasters.LAVA)
            break
        case disasters.ACID[disasterData.ID]:
            displayDebugDisaster(disasters.ACID)
            break
        case disasters.SNIPER[disasterData.ID]:
            displayDebugDisaster(disasters.SNIPER)
            break
        case disasters.BOMBS[disasterData.ID]:
            displayDebugDisaster(disasters.BOMBS)
            break
        case disasters.FAKE_BP[disasterData.ID]:
            displayDebugDisaster(disasters.FAKE_BP)
            break
        case disasters.WISP[disasterData.ID]:
            displayDebugDisaster(disasters.WISP)
            break
        case disasters.BLIZZARD[disasterData.ID]:
            displayDebugDisaster(disasters.BLIZZARD)
            break
        case disasters.WITCH[disasterData.ID]:
            displayDebugDisaster(disasters.WITCH)
            break
        case disasters.TIKTOK[disasterData.ID]:
            displayDebugDisaster(disasters.TIKTOK)
            break
        case disasters.PHARAMERCY[disasterData.ID]:
            displayDebugDisaster(disasters.PHARAMERCY)
            break
        case disasters.GALACTIC_SIGMA[disasterData.ID]:
            displayDebugDisaster(disasters.GALACTIC_SIGMA)
            break
        case disasters.VISHKAR[disasterData.ID]:
            displayDebugDisaster(disasters.VISHKAR)
            break
        case disasters.ZEUS[disasterData.ID]:
            displayDebugDisaster(disasters.ZEUS)
            break
        case disasters.NUCLEAR_BOMB[disasterData.ID]:
            displayDebugDisaster(disasters.NUCLEAR_BOMB)
            break
        default:
            displayDebugDisaster([iconString(Icon.QUESTION_MARK), "No Data"])
            break

rule "[debug.opy] Enable Inspector / Create Debug Header":
    @Condition debugMode
    
    hudText(localPlayer if localPlayer.debugMenuEnabled else [], localPlayer.debugDisasterId, "Disaster Id", localPlayer.debugDisasterName, HudPosition.TOP, 69, Color.WHITE, Color.WHITE, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)

    hudSubheader(localPlayer if localPlayer.debugMenuEnabled else [], "{0}{1} Select {2}{3} | [{4}]: Add Disaster | [{6}] Add Hardcore Disaster | [{5}]: Reset".format(iconString(Icon.ARROW_LEFT), buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE), iconString(Icon.ARROW_RIGHT), buttonString(Button.ABILITY_2), buttonString(Button.RELOAD), buttonString(Button.ULTIMATE)), HudPosition.TOP, 70, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.NEVER)

    hudHeader(localPlayer, "{0} \n{1} \n{2}".format("{0} fx {1} txt".format(getNumberOfEntityIds(), getNumberOfTextIds()), "{0} ld {1} avg {2} pk".format(getServerLoad(), getAverageServerLoad(), getPeakServerLoad()), "{0} \n{1}".format("{0} pos \n {1} facing \n {2} facing angles".format(localPlayer.getPosition(), localPlayer.getFacingDirection(), "({0}°, {1}°)".format(localPlayer.getHorizontalFacingAngle(), localPlayer.getVerticalFacingAngle())), "spd {0} hspd {1} vspd {2}".format(localPlayer.getSpeed(), localPlayer.getHorizontalSpeed(), localPlayer.getVerticalSpeed()))), HudPosition.RIGHT, 0, Color.WHITE, HudReeval.VISIBILITY_AND_STRING, SpecVisibility.DEFAULT)

    wait(0.032)

    enableInspector()

rule "[debug.opy] Debug Rule #1":
    @Condition debugMode
    @Condition hostPlayer.hasSpawned()
    @Disabled

    while getNumberOfPlayers(Team.1) < 6:
        createDummy(getAllHeroes().exclude([player.getCurrentHero() for player in getPlayers(Team.1)]), Team.1, -1, random.choice(getSpawnPoints(Team.ALL)).getPosition(), [])
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
    @Condition any([eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), eventPlayer.isHoldingButton(Button.RELOAD), eventPlayer.isHoldingButton(Button.ABILITY_2), eventPlayer.isHoldingButton(Button.ULTIMATE)])

    if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
        eventPlayer.debugDisasterId -= 5 if eventPlayer.isHoldingButton(Button.ABILITY_1) else 1
        eventPlayer.debugDisasterId = max(0, eventPlayer.debugDisasterId)
        displayDebugDisasterName()
    if eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
        eventPlayer.debugDisasterId += 5 if eventPlayer.isHoldingButton(Button.ABILITY_1) else 1
        eventPlayer.debugDisasterId = eventPlayer.debugDisasterId
        displayDebugDisasterName()
    if eventPlayer.isHoldingButton(Button.ABILITY_2):
        addDisasterToQueueById(eventPlayer.debugDisasterId)
    if eventPlayer.isHoldingButton(Button.ULTIMATE):
        addDisasterToQueueById(eventPlayer.debugDisasterId)
        activeDisasterFlags.append(disasterFlags.HARDCORE)
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
    