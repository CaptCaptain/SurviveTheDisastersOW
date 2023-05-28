#!mainFile "../../main.opy"

globalvar DISASTER_ZEUS_PHASE = 0

rule "[events/zeus.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.ZEUS) in activeDisasters
    @Condition disasterReady

    setDialogueNames(["Zeus"])
    setDialogueHeroes([Hero.JUNKER_QUEEN])
    setDialogueHeroColors([rgb(255, 255, 255)])
    DISASTER_ZEUS_PHASE = 0

    waitForEntitySpawnFlag(getDisasterId(disasters.ZEUS))

    createDummy(Hero.JUNKER_QUEEN, Team.2, -1, getSpawnPoints(Team.ALL)[1], null)
    allocateDummyBotTag(getDisasterId(disasters.ZEUS))
    applyEntityFlag(allocatedDummyBot, botFlags.BOSS)

    startDialogue(1, [[Hero.JUNKER_QUEEN, random.choice(["Face the might of Zeus!", "You dare oppose Olympus?", "Olympus is where I say it is!"]), 1]], sky)

    waitUntil(is_dialoguing == false, 9999)
    if not disasterReady: return

    waitUntil(evalOnce(allocatedDummyBot).getNormalizedHealth() < 0.5 or not disasterReady, 9999)
    if not disasterReady: return

    heal(allocatedDummyBot, null, allocatedDummyBot.getMaxHealth())
    allocatedDummyBot.forceButtonPress(Button.ABILITY_1)

    startDialogueOnce(1, [[Hero.JUNKER_QUEEN, random.choice(["Hubris, eh? Bold move, mortals!", "You can't kill a god!", "That's it! Everyone's going to Hades!"]), 1]], sky)
    waitUntil(is_dialoguing == false, 9999)

    allocatedDummyBot.setUltCharge(100)
    DISASTER_ZEUS_PHASE = 1

    while disasterReady:
        if allocatedDummyBot.getUltCharge() < 90:
            allocatedDummyBot.setUltCharge(75)
        wait(1)