#!mainFile "../main.opy"

rule "[bot/black_hole.opy]: Behavior":
    @Event eachPlayer
    @Hero zarya
    @Team 2
    @Condition hasDisasterTag(getDisasterId(disasters.BLACK_HOLE))

    eventPlayer.BOT_DISABLE_AI = true
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)

    wait(1)
    
    while true:
        eventPlayer.stopForcingPosition()
        eventPlayer.teleport(dummyBotSpawn(25) + vect(0, 5, 0))

        eventPlayer.setUltCharge(100)
        eventPlayer.startFacing(vect(0, -1, 0), Math.INFINITY, Relativity.TO_WORLD, FacingReeval.NONE)
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        eventPlayer.setStatusEffect(null, Status.FROZEN, 0.016)
        
        wait(0.001)

        eventPlayer.startForcingPosition(sky, false)

        wait(0.016)

        waitUntil(not eventPlayer.isUsingUltimate(), 9999)