#!mainFile "../main.opy"

rule "[bot/minefield.opy]: Behavior":
    @Event eachPlayer
    @Hero hammond
    @Team 2
    @Condition hasDisasterTag(eventPlayer, getDisasterId(disasters.MINEFIELD))

    eventPlayer.setInvisibility(Invis.ENEMIES)
    eventPlayer.setUltCharge(100)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 9999)
    eventPlayer.disablePlayerCollision()
    eventPlayer.setDamageDealt(500)
    eventPlayer.startForcingName("Minefield")
    eventPlayer.BOT_DISABLE_AI = true

    createEffect(getAllPlayers(), Effect.RING, evalOnce(Team.2), eventPlayer.getPosition(), 7, EffectReeval.VISIBILITY_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, evalOnce(Team.2), eventPlayer.getPosition(), 0.25, EffectReeval.VISIBILITY_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.ORB, evalOnce(Team.2), eventPlayer.getEyePosition(), 0.5, EffectReeval.VISIBILITY_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    createEffect(getAllPlayers(), Effect.ENERGY_SOUND, evalOnce(Team.2), eventPlayer.getPosition(), 100, EffectReeval.VISIBILITY_AND_COLOR)
    allocateEffect()
    allocatePlayerEffect(eventPlayer)

    wait(3)

    eventPlayer.forceButtonPress(Button.ULTIMATE)
    wait(0.1)
    eventPlayer.setStatusEffect(null, Status.FROZEN, 0.016)

    playEffect(getAllPlayers(), DynamicEffect.ORISA_HALT_IMPLOSION, Team.2, eventPlayer.getEyePosition(), 1
    )
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Team.2, eventPlayer.getEyePosition(), 5
    )

    cleanupDisasterPlayerEffects(eventPlayer)

    wait(0.064)

    eventPlayer.startForcingPosition(vect(0, 9999, 0), false)