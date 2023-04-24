#!mainFile "../main.opy"

#!define createFog(player, fog_distance, color) \
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * 0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(player, Effect.BAD_AURA, color, player.getEyePosition() + player.getFacingDirection() * fog_distance * -0.2, 200, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\

rule "[events/mystery.opy] Disaster Initialization":
    @Condition disasters.MYSTERY[disasterData.ID] in activeDisasters
    @Condition disasterReady

    # Hide Scoreboard to remove disaster information from the player
    getPlayers(Team.1).disableScoreboard()

    # Fog
    createFog(localPlayer, 50, Color.WHITE)

    wait(3)

    # Random Disaster
    activeDisasters.append(random.choice(disasterPool.exclude(disasters.MYSTERY[disasterData.ID])))
    queueDisasterEntities()
    
    waitUntil(not disasters.MYSTERY[disasterData.ID] in activeDisasters, 9999)

    getPlayers(Team.1).enableScoreboard()