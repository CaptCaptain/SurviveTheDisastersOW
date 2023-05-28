#!mainFile "../main.opy"

globalvar DISASTER_FAKE_BP_POS

rule "[events/button.opy] Disaster Initialization":
    @Condition disasters.FAKE_BP[disasterData.ID] in activeDisasters
    @Condition disasterReady

    wait(1)

    DISASTER_FAKE_BP_POS = random.choice(getSpawnPoints(Team.ALL)).getPosition()

    createIcon(localPlayer if not localPlayer.isInViewAngle(DISASTER_FAKE_BP_POS, 90) and localPlayer.isAlive() else [], DISASTER_FAKE_BP_POS, Icon.ASTERISK, IconReeval.VISIBILITY, Color.ORANGE, true)
    allocateEffect()

    createInWorldText(localPlayer if localPlayer.isInViewAngle(DISASTER_FAKE_BP_POS, 90) and localPlayer.isAlive() else [], "+50000 BP", DISASTER_FAKE_BP_POS, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.ORANGE, SpecVisibility.DEFAULT)
    allocateText()

    createEffect(getAllPlayers(), Effect.RING, Color.YELLOW, DISASTER_FAKE_BP_POS, 3, EffectReeval.VISIBILITY)
    allocateEffect()
    createEffect(getAllPlayers(), Effect.SPARKLES, Color.ORANGE, DISASTER_FAKE_BP_POS, 1, EffectReeval.VISIBILITY)
    allocateEffect()
    createEffect(getAllPlayers(), Effect.GOOD_AURA, Color.ORANGE, DISASTER_FAKE_BP_POS + (Vector.UP * 2) + (Vector.UP * sin(getTotalTimeElapsed() * 5)), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()
    createEffect(getAllPlayers(), Effect.ORB, Color.ORANGE, DISASTER_FAKE_BP_POS + (Vector.UP * 2) + (Vector.UP * sin(getTotalTimeElapsed() * 5)), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
    allocateEffect()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.ORANGE, DISASTER_FAKE_BP_POS, 0.05, EffectReeval.VISIBILITY)
    allocateEffect()

    while all([distance(player, DISASTER_FAKE_BP_POS) > 3 for player in getPlayers(Team.1)]) and disasterReady:
        createProjectile(Projectile.MERCY_CADUCEUS_BLASTER, null, DISASTER_FAKE_BP_POS + Vector.UP, Vector.UP + (Vector.LEFT * random.randint(-1, 1)) + (Vector.FORWARD * random.randint(-1, 1)), Relativity.TO_WORLD, ModifyHealth.HEAL, Team.1, 1, 1, 1, DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT, DynamicEffect.BRIGITTE_REPAIR_PACK_IMPACT_SOUND, 0, 10, 5, 0, 0, 30)
        wait(0.25)

    if not disasterReady:
        return

    if len(activeDisasters) == 1:
        setMatchTime(getMatchTime() / 2)

    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION, Team.2, DISASTER_FAKE_BP_POS, 1)
    playEffect(getAllPlayers(), DynamicEffect.DVA_SELF_DESTRUCT_EXPLOSION_SOUND, Team.2, DISASTER_FAKE_BP_POS, 50)

    kill([player for player in getPlayers(Team.ALL) if distance(player.getPosition(), DISASTER_FAKE_BP_POS) < 20], null)