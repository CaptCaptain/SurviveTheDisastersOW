#!mainFile "../main.opy"

#!define limitedMaxHealth(maxHealth) (350 / maxHealth)
#!define limitedMaxHealthType(healthType) round(eventPlayer.getMaxHealthOfType(healthType) * (limitedMaxHealth(eventPlayer.getMaxHealth())))
#!define maxCustomHealth(player) (player.customHealthData[customHealthDataType.NORMAL] + player.customHealthData[customHealthDataType.ARMOR] + player.customHealthData[customHealthDataType.SHIELDS])

rule "[player/tank.opy] Limit Tank Health to 300":
    @Event eachPlayer
    @Team 1
    @Condition WS_SETTING_LIMITED_TANK_HEALTH
    @Condition eventPlayer.hasSpawned()
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.getCurrentHero() in getTankHeroes()
    @Condition not (eventPlayer.isInAlternateForm() and eventPlayer.getCurrentHero() == Hero.DVA)

    wait(1.016 if not eventPlayer.isUsingUltimate() else 0.016, Wait.ABORT_WHEN_FALSE)

    eventPlayer.customHealthData = [limitedMaxHealthType(Health.NORMAL), limitedMaxHealthType(Health.ARMOR), limitedMaxHealthType(Health.SHIELDS), 100]

    if maxCustomHealth(eventPlayer) < 300:
        eventPlayer.customHealthData[customHealthDataType.NORMAL] += 300 - maxCustomHealth(eventPlayer)

    clearCustomHealth()
    applyCustomHealth()

    waitUntil(eventPlayer.getCurrentHero() != evalOnce(eventPlayer.getCurrentHero()) or (eventPlayer.isInAlternateForm() and eventPlayer.getCurrentHero() == Hero.DVA), 9999)
    if RULE_CONDITION: goto RULE_START

rule "[player/tank.opy] D.Va Alternate Form Large Health Fix":
    @Event eachPlayer
    @Hero dva
    @Condition eventPlayer.isInAlternateForm()

    clearCustomHealth()