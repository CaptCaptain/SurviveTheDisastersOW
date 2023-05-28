#!mainFile "../../main.opy"

rule "[events/orisa.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.ORISA_DEFENDER) in activeDisasters
    @Condition disasterReady

    setDialogueNames(["OR-15A"])
    setDialogueHeroes([Hero.ORISA])
    setDialogueHeroColors([rgb(255, 255, 255)])

    waitForEntitySpawnFlag(getDisasterId(disasters.ORISA_DEFENDER))

    createDummy(Hero.ORISA, Team.2, -1, getSpawnPoints(Team.ALL)[1], null)
    allocateDummyBotTag(getDisasterId(disasters.ORISA_DEFENDER))
    applyEntityFlag(allocatedDummyBot, botFlags.BOSS)

    waitUntil(evalOnce(allocatedDummyBot).getNormalizedHealth() < 0.5 or not disasterReady, 9999)
    if not disasterReady: return

    heal(allocatedDummyBot, null, allocatedDummyBot.getMaxHealth())
    allocatedDummyBot.forceButtonPress(Button.ABILITY_1)
    allocatedDummyBot.setUltCharge(100)

    while disasterReady:
        if allocatedDummyBot.getUltCharge() < 90:
            allocatedDummyBot.setUltCharge(75)
        wait(1)