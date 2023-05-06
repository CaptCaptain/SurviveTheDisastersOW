#!mainFile "../main.opy"

subroutine UPDATE_MERCY_TEAMMATE

def UPDATE_MERCY_TEAMMATE():
    UPDATE_BOT_TEAMMATE_DEFAULT()
    if eventPlayer.getAbilityCooldown(Button.ABILITY_2) > 0: eventPlayer.BOT_TEAMMATE.remove(getDeadPlayers(Team.ALL))
    
    eventPlayer.BOT_TEAMMATE.remove(getPlayersOnHero(Hero.MERCY, Team.2))

    eventPlayer.BOT_OVERRIDE_FACING_PLAYER = eventPlayer.BOT_TEAMMATE[0] if eventPlayer.BOT_TEAMMATE[0] else null

rule "[bot/pharamercy.opy]: Pharah Behavior":
    @Event eachPlayer
    @Hero pharah
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.PHARAMERCY))

    eventPlayer.startForcingName(random.choice(["Pharah", "Her Pharah"]))

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_PLAYER):
            case true:
                switch eventPlayer.BOT_PLAYER.isAlive():
                    case true:
                        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                        PRESS_ABILITY_1()
                        eventPlayer.BOT_JUMP_ENABLED = true if eventPlayer.getAltitude() < 25 else false
                        eventPlayer.setAbilityResource(Button.JUMP, 100)
                        EXECUTE_DEFENSE_ABILITY_2()
                        EXECUTE_ULTIMATE_ABILITY()
                break
                
        waitThrottle(Wait.IGNORE_CONDITION)

rule "[bot/pharamercy.opy]: Pharah Death Behavior":
    @Event playerDied
    @Hero pharah
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.PHARAMERCY))

    eventPlayer.disableRespawn()

rule "[bot/pharamercy.opy]: Mercy Behavior":
    @Event eachPlayer
    @Hero mercy
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.PHARAMERCY))

    eventPlayer.startForcingName(random.choice(["Mercy", "His Mercy"]))

    while true:
        botWaitUntilReady()
        switch entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
            case true:
                eventPlayer.setWeapon(1)
                async(UPDATE_SUPPORT_POSITION, AsyncBehavior.NOOP)
                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true if eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getNormalizedHealth() == 1 else false
                eventPlayer.BOT_ABILITY_1_ENABLED = true if distance(eventPlayer.getPosition(), eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getPosition()) > 2 else false
                eventPlayer.setAbilityCooldown(Button.ABILITY_2, 0)
                PRESS_ABILITY_2()
                EXECUTE_ULTIMATE_ABILITY()
                break
            default:
                switch entityExists(eventPlayer.BOT_PLAYER):
                    case true:
                        switch eventPlayer.BOT_PLAYER.isAlive():
                            case true:
                                eventPlayer.setWeapon(2)
                                eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
                                EXECUTE_ULTIMATE_ABILITY()
                        break
                break
        
        UPDATE_MERCY_TEAMMATE()
                
        waitThrottle(Wait.IGNORE_CONDITION)