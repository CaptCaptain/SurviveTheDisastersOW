#!mainFile "../main.opy"

enum disasterSimonInstructions:
    JUMP,
    ULT,
    ABILITY

#!define DISASTER_SIMON_SAYS(message) \
startDialogueOnce(1, [[Hero.REINHARDT, "Simon says: {0}".format(message), 1]], sky)\

#!define DISASTER_SIMON_SAYS_PLAYER_DOES(condition) \
waitUntil((condition) or eventPlayer.isDead() or not disasters.SIMON[disasterData.ID] in activeDisasters, 9999)\
if (condition):\
    eventPlayer.DISASTER_SIMON_PASSED = true\
    playEffect(eventPlayer, DynamicEffect.BUFF_IMPACT_SOUND, Team.1, eventPlayer, 100)\
    printLog("{0} passed Simon Says!".format(eventPlayer))

globalvar DISASTER_SIMON_INSTRUCTION = 0

playervar DISASTER_SIMON_PASSED = true

rule "[events/simon.opy] Disaster Initialization":
    @Condition disasters.SIMON[disasterData.ID] in activeDisasters
    @Condition disasterReady

    createDummy(Hero.REINHARDT, Team.2, -1, random.choice(getSpawnPoints(Team.ALL)).getPosition(), null)
    wait(0.016)
    getLastCreatedEntity().BOT_DISASTER_TAG = disasters.SIMON[disasterData.ID]

    wait(1)
    setDialogueNames(["Simon"])
    setDialogueHeroes([Hero.REINHARDT])
    setDialogueHeroColors([rgb(255, 255, 255)])
    startDialogue(1, [[Hero.REINHARDT, random.choice(["Hello! I am Simon.", "Hey gamers, Simon here."]), 1], [Hero.REINHARDT, "The rules are simple, follow exactly what I do when I say \"Simon Says\"!", 1]], dummyBotSpawn(15))

    waitUntil(is_dialoguing == false, 9999)
    wait(0.016)

    startDialogueOnce(1, [[Hero.REINHARDT, random.choice(["Are you all ready? Let's start!"]), 1]], sky)

    while getMatchTime() > 10:
        getPlayers(Team.1).setAbilityCooldown(Button.ABILITY_1, 0)
        getPlayers(Team.1).setAbilityCooldown(Button.ABILITY_2, 0)
        getPlayers(Team.1).setAbilityCooldown(Button.SECONDARY_FIRE, 0)
        getPlayers(Team.1).setUltCharge(100)
        getPlayers(Team.1).cancelPrimaryAction()

        DISASTER_SIMON_INSTRUCTION = random.choice([disasterSimonInstructions.JUMP, disasterSimonInstructions.ULT, disasterSimonInstructions.ABILITY])
        getPlayers(Team.1).DISASTER_SIMON_PASSED = false

        switch (DISASTER_SIMON_INSTRUCTION):
            case disasterSimonInstructions.JUMP:
                DISASTER_SIMON_SAYS("Jump!")
                break
            case disasterSimonInstructions.ULT:
                DISASTER_SIMON_SAYS("Use your Ultimate!")
                break
            case disasterSimonInstructions.ABILITY:
                DISASTER_SIMON_SAYS("Use your abilities!")
                break

        waitUntil(is_dialoguing == false, 9999)
        wait(2)

        kill([player for player in getPlayers(Team.1) if player.DISASTER_SIMON_PASSED == false and disasters.SIMON[disasterData.ID] in activeDisasters], null)

rule "[events/simon.opy] Player Followed Simon Says":
    @Event eachPlayer
    @Team 1
    @Condition disasters.SIMON[disasterData.ID] in activeDisasters
    @Condition eventPlayer.DISASTER_SIMON_PASSED == false

    printLog("Waiting for {0} to follow Simon Instruction Id {1}".format(eventPlayer, DISASTER_SIMON_INSTRUCTION))

    switch (DISASTER_SIMON_INSTRUCTION):
        case disasterSimonInstructions.JUMP:
            DISASTER_SIMON_SAYS_PLAYER_DOES(eventPlayer.isJumping())
            break
        case disasterSimonInstructions.ULT:
            DISASTER_SIMON_SAYS_PLAYER_DOES(eventPlayer.isUsingUltimate())
            break
        case disasterSimonInstructions.ABILITY:
            DISASTER_SIMON_SAYS_PLAYER_DOES(eventPlayer.isUsingAbility1() or eventPlayer.isUsingAbility2())
            break