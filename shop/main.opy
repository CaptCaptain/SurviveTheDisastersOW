#!mainFile "../main.opy"

globalvar SHOP_HERO_SWITCH_POSITION
globalvar SHOP_HERO_UPGRADES_POSITION
globalvar SHOP_DISASTER_INFO_POSITION

#!define getShopPosition(slot) getSpawnPoints(Team.ALL)[slot].getPosition()

#!define createShop(position, color, text, icon)\
createEffect(getAllPlayers() if not disasterReady else [], Effect.RING, color, evalOnce(position), evalOnce(3.25), EffectReeval.VISIBILITY_AND_COLOR)\
createInWorldText(getAllPlayers() if not disasterReady else [], text if distance(evalOnce(position), localPlayer.getPosition()) < 15 else "〔{0}〕".format(icon), evalOnce(position) + evalOnce(Vector.UP * 2.25), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, color, SpecVisibility.DEFAULT)\
\
createBeam(getAllPlayers() if not disasterReady else [], Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
createBeam(getAllPlayers() if not disasterReady else [], Beam.GOOD, evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
createBeam(getAllPlayers() if not disasterReady else [], Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
createBeam(getAllPlayers() if not disasterReady else [], Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 2), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 2), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
createBeam(getAllPlayers() if not disasterReady else [], Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\

rule "[shop/main.opy] Shop Init":
    waitUntil(any([player.hasSpawned() for player in getPlayers(Team.1)]), 9999)

    SHOP_HERO_SWITCH_POSITION = getShopPosition(0)
    SHOP_HERO_UPGRADES_POSITION = getShopPosition(1)
    SHOP_DISASTER_INFO_POSITION = getShopPosition(2)

    createShop(SHOP_HERO_SWITCH_POSITION, Color.LIME_GREEN, "Hero Switching / Hold [{0}]".format(buttonString(Button.INTERACT)), iconString(Icon.RECYCLE))
    createEffect(getAllPlayers() if not disasterReady else [], Effect.LUCIO_SOUND_BARRIER_PROTECTED, Team.1, SHOP_HERO_SWITCH_POSITION, 1, EffectReeval.VISIBILITY_AND_COLOR)

    /* createShop(SHOP_HERO_UPGRADES_POSITION, Color.PURPLE, "Coming Soon", iconString(Icon.BOLT))

    createShop(SHOP_DISASTER_INFO_POSITION, Color.BLUE, "Coming Soon", iconString(Icon.QUESTION_MARK))
    createEffect(getAllPlayers() if not disasterReady else null, Effect.SPARKLES, Color.BLUE, SHOP_DISASTER_INFO_POSITION, 1, EffectReeval.VISIBILITY_AND_COLOR) */

rule "[shop/main.opy] Switch Heroes":
    @Event eachPlayer
    @Team 1
    @Condition distance(eventPlayer.getPosition(), SHOP_HERO_SWITCH_POSITION) < 3
    @Condition not disasterReady
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    eventPlayer.setAllowedHeroes(eventPlayer.getAllowedHeroes().exclude(eventPlayer.getCurrentHero()))
    wait(0.125)
    eventPlayer.resetHeroAvailability()

    waitUntil(eventPlayer.hasSpawned() or disasterReady, 9999)
    if disasterReady and not eventPlayer.hasSpawned():
        eventPlayer.startForcingHero(random.choice(getAllHeroes()))

    wait(0.032)

    eventPlayer.teleport(SHOP_HERO_SWITCH_POSITION)
    eventPlayer.stopForcingCurrentHero()
