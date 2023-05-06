#!mainFile "../main.opy"

enum disasterSimonInstructions:
    JUMP,
    ULT,
    ABILITY,
    CROUCH,
    RELOAD,

#!define DISASTER_SIMON_SAYS(message) \
startDialogueOnce(1, [[Hero.REINHARDT, "{1}{0}".format(message, "Simon says: " if DISASTER_SIMON_DO else random.choice(["", "Simon says: DON'T "])), 1]], sky)\

#!define DISASTER_SIMON_SAYS_PLAYER_DOES(condition) \
waitUntil((condition) or eventPlayer.isDead() or eventPlayer.DISASTER_SIMON_PASSED == true or not disasters.SIMON[disasterData.ID] in activeDisasters, 9999)\
if (condition):\
    eventPlayer.DISASTER_SIMON_PASSED = true\
    if DISASTER_SIMON_DO == true:\
        playEffect(eventPlayer, DynamicEffect.BUFF_IMPACT_SOUND, Team.1, eventPlayer, 100)\
        fixedSmallMessageWithIcon(eventPlayer, iconString(Icon.CHECKMARK), "You did as Simon Says!")\
        printLog("{0} passed Simon Says!".format(eventPlayer))\
    else:\
        playEffect(eventPlayer, DynamicEffect.DEBUFF_IMPACT_SOUND, Team.1, eventPlayer, 100)\
        fixedSmallMessageWithIcon(eventPlayer, iconString(Icon.NO), "You didn't do as Simon Says...")\
        printLog("{0} did not pass Simon Says!".format(eventPlayer))\

globalvar DISASTER_SIMON_INSTRUCTION = 0
globalvar DISASTER_SIMON_DO = true

playervar DISASTER_SIMON_PASSED = true

rule "[events/simon.opy] Disaster Initialization":
    @Condition disasters.SIMON[disasterData.ID] in activeDisasters
    @Condition disasterReady
    
    getPlayers(Team.1).DISASTER_SIMON_PASSED = true

    waitForEntitySpawnFlag(disasters.SIMON[disasterData.ID])

    createDummy(Hero.REINHARDT, Team.2, -1, random.choice(getSpawnPoints(Team.ALL)).getPosition(), null)
    allocateDummyBotTag(getDisasterId(disasters.SIMON))

    wait(1)
    setDialogueNames(["Simon"])
    setDialogueHeroes([Hero.REINHARDT])
    setDialogueHeroColors([rgb(255, 255, 255)])
    startDialogue(1, [[Hero.REINHARDT, random.choice(["Hello! I am Simon.", "Hey gamers, Simon here.", "Welcome to Simon Says, sponsored by Raid Shadow Legends!"]), 1], [Hero.REINHARDT, "The rules are simple, follow exactly what I do when I say \"Simon Says\"!", 1]], sky)

    waitUntil(is_dialoguing == false, 9999)
    wait(0.016)

    startDialogueOnce(1, [[Hero.REINHARDT, random.choice(["Are you all ready? Let's start!"]), 1]], sky)

    for disasterIndex in range(0, 10, 1):
        getPlayers(Team.1).DISASTER_SIMON_PASSED = true
        getPlayers(Team.1).setAbilityCooldown(Button.ABILITY_1, 0)
        getPlayers(Team.1).setAbilityCooldown(Button.ABILITY_2, 0)
        getPlayers(Team.1).setAbilityCooldown(Button.SECONDARY_FIRE, 0)
        getPlayers(Team.1).setUltCharge(100)
        getPlayers(Team.1).cancelPrimaryAction()

        wait(0.25, Wait.ABORT_WHEN_FALSE)

        DISASTER_SIMON_INSTRUCTION = random.choice([disasterSimonInstructions.JUMP, disasterSimonInstructions.ULT, disasterSimonInstructions.ABILITY, disasterSimonInstructions.CROUCH])
        DISASTER_SIMON_DO = random.choice([true, false])
        getPlayers(Team.1).DISASTER_SIMON_PASSED = false

        switch (DISASTER_SIMON_INSTRUCTION):
            case disasterSimonInstructions.JUMP:
                DISASTER_SIMON_SAYS("Jump!")
                break
            case disasterSimonInstructions.ULT:
                DISASTER_SIMON_SAYS("Use your Ultimate!")
                break
            case disasterSimonInstructions.ABILITY:
                DISASTER_SIMON_SAYS("Use your 1st or 2nd Ability")
                break
            case disasterSimonInstructions.CROUCH:
                DISASTER_SIMON_SAYS("Crouch!")
                break
            /* case disasterSimonInstructions.RELOAD:
                DISASTER_SIMON_SAYS("Reload!")
                break */

        waitUntil(is_dialoguing == false, 9999)
        wait(1, Wait.ABORT_WHEN_FALSE)

        kill([player for player in getPlayersAlive() if player.DISASTER_SIMON_PASSED == not DISASTER_SIMON_DO and disasters.SIMON[disasterData.ID] in activeDisasters], null)
    
    applyEntityFlag([player for player in getPlayers(Team.2) if player.BOT_DISASTER_TAG == getDisasterId(disasters.SIMON)], -69)

    getPlayers(Team.1).DISASTER_SIMON_PASSED = true

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
            DISASTER_SIMON_SAYS_PLAYER_DOES(eventPlayer.getUltCharge() < 100)
            break
        case disasterSimonInstructions.ABILITY:
            DISASTER_SIMON_SAYS_PLAYER_DOES(eventPlayer.getAbilityCooldown(Button.ABILITY_1) > 0 or eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0 or eventPlayer.getAbilityCooldown(Button.SECONDARY_FIRE) > 0)
            break
        case disasterSimonInstructions.CROUCH:
            DISASTER_SIMON_SAYS_PLAYER_DOES(eventPlayer.isCrouching())
            break
        /* case disasterSimonInstructions.RELOAD:
            DISASTER_SIMON_SAYS_PLAYER_DOES(eventPlayer.isReloading())
            break */