#!mainFile "../main.opy"

globalvar accessibilityIndex = 0

rule "[shop/accessibility.opy] Buttons":
    @Event eachPlayer
    @Team 1
    @Condition distance(eventPlayer.getPosition(), SHOP_ACCESSIBILITY_POSITION) < 3
    @Condition not disasterReady

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)

    while not disasterReady and distance(eventPlayer.getPosition(), SHOP_ACCESSIBILITY_POSITION) < 3:
        waitUntil(disasterReady or distance(eventPlayer.getPosition(), SHOP_ACCESSIBILITY_POSITION) > 3 or any([eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), eventPlayer.isHoldingButton(Button.INTERACT)]), 9999)

        if disasterReady or distance(eventPlayer.getPosition(), SHOP_ACCESSIBILITY_POSITION) > 3:
            break

        if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
            eventPlayer.SHOP_ACCESSIBILITY_OPTION -= 1
            eventPlayer.SHOP_ACCESSIBILITY_OPTION = max(0, eventPlayer.SHOP_ACCESSIBILITY_OPTION)
        elif eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
            eventPlayer.SHOP_ACCESSIBILITY_OPTION += 1
            eventPlayer.SHOP_ACCESSIBILITY_OPTION = min(len(SHOP_ACCESSIBILITY_ALL_OPTIONS) - 1, eventPlayer.SHOP_ACCESSIBILITY_OPTION)
        elif eventPlayer.isHoldingButton(Button.INTERACT):
            if eventPlayer.SHOP_ACCESSIBILITY_OPTION in eventPlayer.SHOP_ACCESSIBILITY_ACTIVE:
                eventPlayer.SHOP_ACCESSIBILITY_ACTIVE.remove(eventPlayer.SHOP_ACCESSIBILITY_OPTION)

                playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.SKY_BLUE, SHOP_ACCESSIBILITY_POSITION, 10)
                playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.SKY_BLUE, SHOP_ACCESSIBILITY_POSITION, 1)
                playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_ARMOR_SOUND, Color.SKY_BLUE, SHOP_ACCESSIBILITY_POSITION, 50)

                switch (eventPlayer.SHOP_ACCESSIBILITY_OPTION):
                    case shopAccessibilityOptions.3PC[shopAccessibilityData.ID]:
                        eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + (eventPlayer.getFacingDirection() * 1), 60)
                        wait(0.08)
                        eventPlayer.stopCamera()
                        
                        break
            else:
                eventPlayer.SHOP_ACCESSIBILITY_ACTIVE.append(eventPlayer.SHOP_ACCESSIBILITY_OPTION)

                playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.SKY_BLUE, SHOP_ACCESSIBILITY_POSITION, 10)
                playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.SKY_BLUE, SHOP_ACCESSIBILITY_POSITION, 1)
                playEffect(eventPlayer, DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, Color.SKY_BLUE, SHOP_ACCESSIBILITY_POSITION, 50)

                switch (eventPlayer.SHOP_ACCESSIBILITY_OPTION):
                    case shopAccessibilityOptions.3PC[shopAccessibilityData.ID]:
                        eventPlayer.startCamera(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection(), 0)
                        wait(0.032)
                        eventPlayer.startCamera(updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + worldVector(vect(1 * -1, 0, 0), eventPlayer, Transform.ROTATION) + eventPlayer.getFacingDirection() * -2.5, getAllPlayers(), eventPlayer, false).getHitPosition()), updateEveryTick(raycast(eventPlayer.getEyePosition(), eventPlayer.getEyePosition() + eventPlayer.getFacingDirection() * 200, getAllPlayers(), eventPlayer, false).getHitPosition()), 60)

                        break

        wait(0.25)

    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)

rule "[shop/accessibility.opy] Update Status":
    wait(2)
    while true:

        #!define accessibilityPlayer getPlayers(Team.1)[accessibilityIndex]
        # Applying
        for accessibilityIndex in range(0, len(getPlayers(Team.1)), 1):
            accessibilityPlayer.onScreenTextEyePosition = null
            accessibilityPlayer.onScreenTextFacingDirection = null

            if not shopAccessibilityOptions.3PC[shopAccessibilityData.ID] in accessibilityPlayer.SHOP_ACCESSIBILITY_ACTIVE:
                continue

            accessibilityPlayer.onScreenTextEyePosition = raycast(accessibilityPlayer.getEyePosition(), accessibilityPlayer.getEyePosition() + worldVector(vect(1 * -1, 0, 0), accessibilityPlayer, Transform.ROTATION) + accessibilityPlayer.getFacingDirection() * -2.5, getAllPlayers(), accessibilityPlayer, false).getHitPosition() if shopAccessibilityOptions.3PC[shopAccessibilityData.ID] in accessibilityPlayer.SHOP_ACCESSIBILITY_ACTIVE else accessibilityPlayer.getEyePosition()

            accessibilityPlayer.onScreenTextFacingDirection = directionTowards(raycast(accessibilityPlayer.getEyePosition(), accessibilityPlayer.getEyePosition() + worldVector(vect(1 * -1, 0, 0), accessibilityPlayer, Transform.ROTATION) + accessibilityPlayer.getFacingDirection() * -2.5, getAllPlayers(), accessibilityPlayer, false).getHitPosition(), raycast(accessibilityPlayer.getEyePosition(), accessibilityPlayer.getEyePosition() + accessibilityPlayer.getFacingDirection() * 200, getAllPlayers(), accessibilityPlayer, false).getHitPosition()) if shopAccessibilityOptions.3PC[shopAccessibilityData.ID] in accessibilityPlayer.SHOP_ACCESSIBILITY_ACTIVE else accessibilityPlayer.getFacingDirection()

        waitUntil(any([player for player in getPlayers(Team.1) if shopAccessibilityOptions.3PC[shopAccessibilityData.ID] in player.SHOP_ACCESSIBILITY_ACTIVE and player.getFacingDirection() != evalOnce(player.getFacingDirection()) or player.isMoving() != evalOnce(player.isMoving())]), 0.5)
        waitUntil(not disasterReady, 0.5)
        wait(0.016)