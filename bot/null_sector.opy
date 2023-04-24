#!mainFile "../main.opy"

rule "[bot/null_sector.opy]: Ramattra Behavior":
    @Event eachPlayer
    @Hero ramattra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NULL_SECTOR))

    eventPlayer.HEALTH_NORMAL = getNumberOfLivingPlayers(Team.1) * 250
    eventPlayer.HEALTH_ARMOR = getNumberOfLivingPlayers(Team.1) * 250
    eventPlayer.startScalingSize(1.5, false)

    wait(1)
    applyCustomHealth()

    createIcon(localPlayer if not localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, eventPlayer, Icon.EXCLAMATION_MARK, IconReeval.VISIBILITY, Color.PURPLE, true)
    allocateEffect()

    createInWorldText(localPlayer if localPlayer.isInViewAngle(eventPlayer.getEyePosition(), 90) and eventPlayer.isAlive() else null, "[{0}]\n".format(abilityIconString(Hero.RAMATTRA, Button.ULTIMATE)), eventPlayer, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.PURPLE, SpecVisibility.DEFAULT)
    allocateText()

    createEffect(getAllPlayers(), Effect.RING, Color.PURPLE, eventPlayer, 3, EffectReeval.VISIBILITY)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    eventPlayer.startForcingOutlineFor(getAllPlayers(), true, Color.PURPLE, OutlineVisibility.DEFAULT)

    while eventPlayer.isAlive():
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) or eventPlayer.isDead(), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        if eventPlayer.getMaxHealth() > 600:
                            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if eventPlayer.getNormalizedHealth() < 0.5 else false
                            eventPlayer.BOT_ABILITY_1_ENABLED = false
                        else:
                            eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                            eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
                            eventPlayer.BOT_ABILITY_1_ENABLED = true if eventPlayer.BOT_PLAYER.getNormalizedHealth() < 0.5 or eventPlayer.getNormalizedHealth() < 0.5 and eventPlayer.getAbilityCooldown(Button.ABILITY_1) == 0 and not eventPlayer.isUsingUltimate() else false
                            EXECUTE_ULTIMATE_ABILITY()
    
                        eventPlayer.BOT_ABILITY_2_ENABLED = true if eventPlayer.BOT_PLAYER.isInAir() else false
    
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_EFFECT, Team.1, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_EMP_EXPLOSION_SOUND, Team.1, eventPlayer, 50)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.stopFacing()
    cleanupDisasterPlayerEffects(eventPlayer)

    if len(activeDisasters) == 1:
        setMatchTime(min(5, getMatchTime()))

rule "[bot/null_sector.opy]: Ramattra Ult":
    @Event eachPlayer
    @Hero ramattra
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NULL_SECTOR))
    @Condition eventPlayer.getNormalizedHealth() < 0.3

    wait(0.1, Wait.ABORT_WHEN_FALSE)

    eventPlayer.setUltCharge(100)

    wait(9999)

rule "[bot/null_sector.opy]: Orisa Behavior":
    @Event eachPlayer
    @Hero orisa
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NULL_SECTOR))

    eventPlayer.startForcingName("OR13-A")
    eventPlayer.HEALTH_NORMAL = 200
    eventPlayer.HEALTH_ARMOR = 100

    wait(1)
    applyCustomHealth()
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true, Color.PURPLE, OutlineVisibility.DEFAULT)

    while true:
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) or getPlayersOnHero(Hero.RAMATTRA, Team.2)[0].isDead(), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        eventPlayer.BOT_ABILITY_1_ENABLED = true if not eventPlayer.isUsingAbility1() and eventPlayer.getNormalizedHealth() < 0.5 else false
                        eventPlayer.BOT_ABILITY_2_ENABLED = true if not eventPlayer.isUsingAbility2() and eventPlayer.BOT_PLAYER.isFiringPrimaryFire() else false
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

    eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 9999)
    eventPlayer.setStatusEffect(null, Status.HACKED, 9999)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.stopFacing()

rule "[bot/null_sector.opy]: Bastion Behavior":
    @Event eachPlayer
    @Hero bastion
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NULL_SECTOR))

    eventPlayer.startForcingName("E-54")
    eventPlayer.HEALTH_NORMAL = 100
    eventPlayer.HEALTH_ARMOR = 200

    wait(1)
    applyCustomHealth()
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true, Color.PURPLE, OutlineVisibility.DEFAULT)

    while true:
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) or getPlayersOnHero(Hero.RAMATTRA, Team.2)[0].isDead(), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        eventPlayer.BOT_ABILITY_1_ENABLED = true if not eventPlayer.isUsingAbility1() else false
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

    eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 9999)
    eventPlayer.setStatusEffect(null, Status.HACKED, 9999)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.stopFacing()

rule "[bot/null_sector.opy]: Nulltrooper Behavior":
    @Event eachPlayer
    @Hero baptiste
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.NULL_SECTOR))

    eventPlayer.startForcingName("Nulltrooper")
    eventPlayer.HEALTH_NORMAL = 200

    wait(1)
    applyCustomHealth()
    eventPlayer.startForcingOutlineFor(getAllPlayers(), true, Color.PURPLE, OutlineVisibility.DEFAULT)

    while true:
        waitUntil(entityExists(eventPlayer.BOT_PLAYER) or getPlayersOnHero(Hero.RAMATTRA, Team.2)[0].isDead(), 9999)
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        break
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

    eventPlayer.setStatusEffect(null, Status.KNOCKED_DOWN, 9999)
    eventPlayer.setStatusEffect(null, Status.HACKED, 9999)
    eventPlayer.disableRespawn()
    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.stopFacing()