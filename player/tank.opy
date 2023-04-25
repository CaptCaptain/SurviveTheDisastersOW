#!mainFile "../main.opy"

#!define limitedMaxHealth(maxHealth) (300 / maxHealth)
#!define limitedMaxHealthType(healthType) floor(eventPlayer.getMaxHealthOfType(healthType) * (limitedMaxHealth(eventPlayer.getMaxHealth())))
#!define maxCustomHealth(player) (player.HEALTH_NORMAL + player.HEALTH_ARMOR + player.HEALTH_SHIELDS)

rule "[player/tank.opy] Limit Tank Health to 300":
    @Event eachPlayer
    @Team 1
    @Condition WS_SETTING_LIMITED_TANK_HEALTH
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.getCurrentHero() in getTankHeroes()
    @Condition not (eventPlayer.isInAlternateForm() and eventPlayer.getCurrentHero() == Hero.DVA)

    wait(1.016 if not eventPlayer.isUsingUltimate() else 0.016, Wait.ABORT_WHEN_FALSE)

    eventPlayer.HEALTH_NORMAL = limitedMaxHealthType(Health.NORMAL)
    eventPlayer.HEALTH_ARMOR = limitedMaxHealthType(Health.ARMOR)
    eventPlayer.HEALTH_SHIELDS = limitedMaxHealthType(Health.SHIELDS)

    if maxCustomHealth(eventPlayer) < 300:
        eventPlayer.HEALTH_NORMAL += 300 - maxCustomHealth(eventPlayer)

    applyCustomHealth()

    waitUntil(eventPlayer.getCurrentHero() != evalOnce(eventPlayer.getCurrentHero()) or (eventPlayer.isInAlternateForm() and eventPlayer.getCurrentHero() == Hero.DVA), 9999)
    if RULE_CONDITION: goto RULE_START

rule "[player/tank.opy] D.Va Alternate Form Large Health Fix":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isInAlternateForm()

    clearCustomHealth()