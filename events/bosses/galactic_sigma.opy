#!mainFile "../../main.opy"

enum disasterGalacticEmperorSupport:
    MERCY = Hero.MERCY,
    SOJOURN = Hero.SOJOURN,
    BRIGITTE = Hero.BRIGITTE,
    LUCIO = Hero.LUCIO,

globalvar DISASTER_GALACTIC_SIGMA_SUPPORT

rule "[events/galactic_sigma.opy] Disaster Initialization":
    @Condition disasters.GALACTIC_SIGMA[disasterData.ID] in activeDisasters
    @Condition disasterReady

    DISASTER_GALACTIC_SIGMA_SUPPORT = random.choice([disasterGalacticEmperorSupport.MERCY, disasterGalacticEmperorSupport.SOJOURN, disasterGalacticEmperorSupport.BRIGITTE])

    setDialogueNames(["Infinite Seer", "Infinite Admiral", "Royal Captain", "Space Prince", "Galactic Emperor"])
    setDialogueHeroes([Hero.MERCY, Hero.SOJOURN, Hero.BRIGITTE, Hero.LUCIO, Hero.SIGMA])
    setDialogueHeroColors([rgb(255, 255, 255), rgb(255, 255, 255), rgb(255, 255, 255), rgb(255, 255, 255), rgb(255, 255, 255)])

    waitForEntitySpawnFlag(disasters.GALACTIC_SIGMA[disasterData.ID])

    createDummy(Hero.SIGMA, Team.2, -1, getSpawnPoints(Team.ALL)[1], null)
    allocateDummyBotTag(getDisasterId(disasters.GALACTIC_SIGMA))
    applyEntityFlag(allocatedDummyBot, botFlags.BOSS)

    startDialogueOnce(1, [[Hero.SIGMA, random.choice(["Suffer the wrath of the Infinite!", "The universe bows to me!"]), 1]], sky)

    waitUntil(is_dialoguing == false, 9999)
    if not disasterReady: return

    waitUntil(getPlayersOnHero(Hero.SIGMA, Team.2)[0].getNormalizedHealth() < 0.5 or not disasterReady, 9999)
    if not disasterReady: return

    createDummy(DISASTER_GALACTIC_SIGMA_SUPPORT, Team.2, -1, getPlayersOnHero(Hero.SIGMA, Team.2)[0].getPosition(), null)
    allocateDummyBotTag(getDisasterId(disasters.GALACTIC_SIGMA))

    switch (DISASTER_GALACTIC_SIGMA_SUPPORT):
        case disasterGalacticEmperorSupport.MERCY:
            startDialogue(1, [[Hero.MERCY, random.choice(["I will protect you, my excellency!", "Do not fear, your excellency. I forsee victory!", "The Infinite Empire shall not fall!"]), 1]], sky)
            waitUntil(is_dialoguing == false, 9999)
            break
        case disasterGalacticEmperorSupport.SOJOURN:
            startDialogue(1, [[Hero.SOJOURN, "This ends... NOW!", 1]], sky)
            waitUntil(is_dialoguing == false, 9999)
            break
        case disasterGalacticEmperorSupport.BRIGITTE:
            startDialogue(1, [[Hero.BRIGITTE, "The Infinite Empire shall crush you!", 1]], sky)
            waitUntil(is_dialoguing == false, 9999)
            break
        case disasterGalacticEmperorSupport.LUCIO:
            startDialogue(1, [[Hero.LUCIO, "Let's get a noise violation!!", 1]], sky)
            waitUntil(is_dialoguing == false, 9999)
            break