enum customHealthDataType:
	NORMAL,
	ARMOR,
	SHIELDS,
	MAX_HEALTH,
	
#!define reapplyCustomHealthByDefault false
	
playervar customHealthData = [0, 0, 0, 100]
playervar reapplyCustomHealth = reapplyCustomHealthByDefault

#!define applyCustomHealthFor(player, health_normal, health_armor, health_shields)\
    eventPlayer.customHealthData = [health_normal, health_armor, health_shields, 100] \
    applyCustomHealth()
#!define isHero(player, hero) (player.getCurrentHero() == hero or player.getHeroOfDuplication() == hero)

#!define applyCustomHealthWithMaxHealthFor(player, health_normal, health_armor, health_shields, max_health)\
	eventPlayer.customHealthData = [health_normal, health_armor, health_shields, max_health] \
    applyCustomHealth()

playervar storedSpawnPosition
playervar customHealthPools

playervar HEALTH_NORMAL
playervar HEALTH_ARMOR
playervar HEALTH_SHIELDS
playervar MAX_HEALTH

subroutine clearCustomHealth
subroutine applyCustomHealth

def clearCustomHealth():
    @Name "[customHealthHandler.opy]: Clear Custom Health"

    removeHealthPool(eventPlayer.customHealthPools[0])
	removeHealthPool(eventPlayer.customHealthPools[1])
	removeHealthPool(eventPlayer.customHealthPools[2])
    wait(0.016)
    eventPlayer.setMaxHealth(100.001)
    wait(0.016)
    eventPlayer.setMaxHealth(100)
    heal(eventPlayer, null, Math.INFINITY)
	eventPlayer.customHealthData[customHealthDataType.MAX_HEALTH] = 100

def applyCustomHealth():
    @Name "[customHealthHandler.opy]: Apply Custom Health"

    clearCustomHealth()
    
	waitUntil(eventPlayer.hasSpawned(), 9999)
	
	while eventPlayer.getHealth() >= eventPlayer.getMaxHealth():
		damage(eventPlayer, eventPlayer, 1)
		wait(0.016)
		
	heal(eventPlayer, eventPlayer, 1)
	
	wait(0.016)
	
    # If the player is in spawn, teleport them out as they are invulnerable in spawn
    if eventPlayer.isInSpawnRoom():
        eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection(), 0.001)
        wait(0.032)
        eventPlayer.storedSpawnPosition = eventPlayer.getPosition()
        eventPlayer.teleport(eventPlayer.getPosition() + vect(0, 100, 0))
        waitUntil(not eventPlayer.isInSpawnRoom() and not eventPlayer.hasStatusEffect(Status.INVINCIBLE) and not eventPlayer.hasStatusEffect(Status.UNKILLABLE), 1)
        wait(0.016)
    # If the player is duplicating a hero, wait until Echo is no longer invulnerable
    if eventPlayer.isDuplicatingAHero():
        waitUntil(not eventPlayer.hasStatusEffect(Status.INVINCIBLE) and not eventPlayer.hasStatusEffect(Status.UNKILLABLE), 1)
        wait(0.016)
		
	# Set Max Health
	eventPlayer.setMaxHealth(eventPlayer.customHealthData[customHealthDataType.MAX_HEALTH])

    ## Applying Custom Health ##
    # Apply an unkillable status so we don't accidentally kill the player
    eventPlayer.setStatusEffect(eventPlayer, Status.UNKILLABLE, 1)
    # Damage the player so they're at one health
    damage(eventPlayer, null, Math.INFINITY)

    wait(0.016)

    # Apply temporary base health to the player
    eventPlayer.addHealthPool(Health.NORMAL, Math.INFINITY, true, true)
	eventPlayer.customHealthPools[0] = getLastCreatedHealthPool()
	
    eventPlayer.addHealthPool(Health.ARMOR, Math.INFINITY, true, true)
	eventPlayer.customHealthPools[1] = getLastCreatedHealthPool()
	
    eventPlayer.addHealthPool(Health.SHIELDS, Math.INFINITY, true, true)
	eventPlayer.customHealthPools[2] = getLastCreatedHealthPool()
	

    wait(0.016)

    # Remove temporary base health from the player
    removeHealthPool(eventPlayer.customHealthPools[0])
	removeHealthPool(eventPlayer.customHealthPools[1])
	removeHealthPool(eventPlayer.customHealthPools[2])

    wait(0.016)


    # Apply custom health pool to player
    if eventPlayer.customHealthData[customHealthDataType.NORMAL] > 0:
        eventPlayer.addHealthPool(Health.NORMAL, max(1, eventPlayer.customHealthData[customHealthDataType.NORMAL] - 1), true, true)
		eventPlayer.customHealthPools[0] = getLastCreatedHealthPool()
    if eventPlayer.customHealthData[customHealthDataType.ARMOR] > 0:
        eventPlayer.addHealthPool(Health.ARMOR, max(1, eventPlayer.customHealthData[customHealthDataType.ARMOR]), true, true)
		eventPlayer.customHealthPools[1] = getLastCreatedHealthPool()
    if eventPlayer.customHealthData[customHealthDataType.SHIELDS] > 0:
        eventPlayer.addHealthPool(Health.SHIELDS, max(1, eventPlayer.customHealthData[customHealthDataType.SHIELDS]), true, true)
		eventPlayer.customHealthPools[2] = getLastCreatedHealthPool()
    heal(eventPlayer, null, Math.INFINITY)

    # Teleport player back if they were in spawn.
    if eventPlayer.storedSpawnPosition:
        wait(0.016)
        eventPlayer.teleport(eventPlayer.storedSpawnPosition)
        eventPlayer.storedSpawnPosition = null
        eventPlayer.stopCamera()

rule "[customHealthHandler.opy]: Remove Custom Health Conditions":
    @Event eachPlayer
	
	waitUntil(eventPlayer.hasSpawned(), 9999)
	wait(0.25)
	
	while true:
		# Health pools persist between hero switching, so we remove it when player's switch or duplicate to another hero, or when D.Va switches between forms.
		waitUntil(eventPlayer.getCurrentHero() != evalOnce(eventPlayer.getCurrentHero()) or eventPlayer.getHeroOfDuplication() != evalOnce(eventPlayer.getHeroOfDuplication()) or (isHero(eventPlayer, Hero.DVA) and eventPlayer.isInAlternateForm() != evalOnce(eventPlayer.isInAlternateForm())), 9999)

		clearCustomHealth()

		wait(0.016)
		
		if eventPlayer.reapplyCustomHealth:
			applyCustomHealthFor(eventPlayer, eventPlayer.customHealthData[customHealthDataType.NORMAL], eventPlayer.customHealthData[customHealthDataType.ARMOR], eventPlayer.customHealthData[customHealthDataType.SHIELDS])

rule "[customHealthHandler.opy]: Debug Rule":
    @Event eachPlayer
    @Disabled
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    applyCustomHealthFor(eventPlayer, 100, 50, 50)
