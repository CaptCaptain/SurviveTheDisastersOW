#!mainFile "../main.opy"

#!define disableLifeGripConditions [condition == true for condition in [getDisasterId(disasters.GET_DOWN) in activeDisasters and eventPlayer.getPosition().y > DISASTER_GET_DOWN_Y_POS]]

rule "[player/lifeweaver.opy]: Conditions for Disabling Life Grip":
    @Event eachPlayer
    @Team 1
    @Hero lifeweaver
    @Condition WS_SETTING_LIFE_GRIP_LIMITED
    @Condition disasterReady

    while disasterReady and eventPlayer.isAlive():
        if getDisasterId(disasters.GET_DOWN) in activeDisasters and eventPlayer.getEyePosition().y < DISASTER_GET_DOWN_Y_POS and DISASTER_GET_DOWN_RZ_POS > -200:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.setSecondaryFireEnabled(false)
        elif getDisasterId(disasters.GET_DOWN) in activeDisasters and eventPlayer.getEyePosition().y > DISASTER_GET_DOWN_Y_POS and DISASTER_GET_DOWN_RZ_POS > -200:
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.setSecondaryFireEnabled(false)
        elif getDisasterId(disasters.ACID) in activeDisasters and (playerIsBelowWaterLevel(eventPlayer, DISASTER_ACID_Y_POS, -1.5) or eventPlayer.isInAir()):
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.setSecondaryFireEnabled(true)
        elif getDisasterId(disasters.LAVA) in activeDisasters and (playerIsBelowWaterLevel(eventPlayer, DISASTER_LAVA_Y_POS, -1.5) or eventPlayer.isInAir()):
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.setSecondaryFireEnabled(true)
        elif getDisasterId(disasters.FLOOD) in activeDisasters and (playerIsBelowWaterLevel(eventPlayer, DISASTER_FLOOD_Y_POS, 0) or eventPlayer.isInAir()):
            eventPlayer.setAbility1Enabled(false)
            eventPlayer.setSecondaryFireEnabled(true)
        else:
            eventPlayer.setAbility1Enabled(true)
            eventPlayer.setSecondaryFireEnabled(true)

        wait(0.25)

    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setSecondaryFireEnabled(true)