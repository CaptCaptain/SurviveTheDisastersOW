#!mainFile "../main.opy"

globalvar SHOP_HERO_SWITCH_POSITION
globalvar SHOP_CHALLENGES_POSITION
globalvar SHOP_EFFECTS_INDEX = 0
globalvar SHOP_EFFECTS = []
globalvar SHOP_CREATION_READY = false

#!define allocateShopEffect() \
SHOP_EFFECTS.append(getLastCreatedEntity()) \
SHOP_EFFECTS.append(getLastCreatedText()) \

#!define getShopPosition(slot) getSpawnPoints(Team.ALL)[slot].getPosition()

#!define createShop(position, color, text, icon)\
createEffect(getAllPlayers() , Effect.RING, color, evalOnce(position), evalOnce(3.25), EffectReeval.VISIBILITY_AND_COLOR)\
allocateShopEffect()\
\
createInWorldText(getAllPlayers(), text if distance(evalOnce(position), localPlayer.getPosition()) < 15 else "〔{0}〕".format(icon), evalOnce(position) + evalOnce(Vector.UP * 2.25), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, color, SpecVisibility.DEFAULT)\
allocateShopEffect()\
\
createBeam(getAllPlayers(), Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateShopEffect()\
\
createBeam(getAllPlayers(), Beam.GOOD, evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateShopEffect()\
\
createBeam(getAllPlayers(), Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 3), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateShopEffect()\
\
createBeam(getAllPlayers(), Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 2), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + evalOnce(Vector.UP * 2), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateShopEffect()\
\
createBeam(getAllPlayers(), Beam.GOOD, evalOnce(position) + (worldVector(Vector.LEFT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), evalOnce(position) + (worldVector(Vector.RIGHT, localPlayer, Transform.ROTATION) * 3) + (Vector.DOWN * 1), color, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateShopEffect()\
\

#!include "shop/challenges.opy"

subroutine createShopEffects
def createShopEffects():
    waitUntil(SHOP_CREATION_READY, 1)
    
    # Hero Switching
    createShop(SHOP_HERO_SWITCH_POSITION, Color.LIME_GREEN, "Hero Switching / Hold [{0}]".format(buttonString(Button.INTERACT)), iconString(Icon.RECYCLE))

    createEffect(getAllPlayers(), Effect.LUCIO_SOUND_BARRIER_PROTECTED, Team.1, SHOP_HERO_SWITCH_POSITION, 1, EffectReeval.VISIBILITY_AND_COLOR)
    allocateShopEffect()

    # Challenges
    createShop(SHOP_CHALLENGES_POSITION, Color.ROSE, "Challenges".format(buttonString(Button.INTERACT)), iconString(Icon.BOLT))
    
    createEffect(getAllPlayers(), Effect.SPARKLES, Color.ROSE, SHOP_CHALLENGES_POSITION, 1, EffectReeval.VISIBILITY_AND_COLOR)
    allocateShopEffect()

    createInWorldText(getAllPlayers(), "{1}{3} {0} {4}{2}\n\n\n".format(SHOP_CHALLENGES_ALL_OPTIONS[localPlayer.SHOP_CHALLENGES_OPTION], iconString(Icon.ARROW_LEFT), iconString(Icon.ARROW_RIGHT), buttonString(Button.PRIMARY_FIRE), buttonString(Button.SECONDARY_FIRE)) if distance(evalOnce(SHOP_CHALLENGES_POSITION), localPlayer.getPosition()) < 3 else "", evalOnce(SHOP_CHALLENGES_POSITION) + evalOnce(Vector.UP * 0.9), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    allocateShopEffect()

    createInWorldText(getAllPlayers(), ("[{0}Active]\n".format(iconString(Icon.CHECKMARK)) if localPlayer.SHOP_CHALLENGES_OPTION in localPlayer.SHOP_CHALLENGES_ACTIVE else "") if distance(evalOnce(SHOP_CHALLENGES_POSITION), localPlayer.getPosition()) < 3 else "", evalOnce(SHOP_CHALLENGES_POSITION) + evalOnce(Vector.UP * 0.9), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    allocateShopEffect()

    createInWorldText(getAllPlayers(), "[{0}] Activate [{0}]\n\n".format(buttonString(Button.INTERACT)) if distance(evalOnce(SHOP_CHALLENGES_POSITION), localPlayer.getPosition()) < 3 else "", evalOnce(SHOP_CHALLENGES_POSITION) + evalOnce(Vector.UP * 0.9), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    allocateShopEffect()

    createInWorldText(getAllPlayers(), "{0}".format(SHOP_CHALLENGES_ALL_DESC[localPlayer.SHOP_CHALLENGES_OPTION]) if distance(evalOnce(SHOP_CHALLENGES_POSITION), localPlayer.getPosition()) < 3 else "", evalOnce(SHOP_CHALLENGES_POSITION) + evalOnce(Vector.UP * 0.9), 1, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    allocateShopEffect()

    createInWorldText(getAllPlayers(), "{0}\n\n\n".format(SHOP_CHALLENGES_ALL_ICONS[localPlayer.SHOP_CHALLENGES_OPTION]) if distance(evalOnce(SHOP_CHALLENGES_POSITION), localPlayer.getPosition()) < 3 else "", evalOnce(SHOP_CHALLENGES_POSITION) + evalOnce(Vector.UP * 0.9), 2.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    allocateShopEffect()

    createInWorldText(getAllPlayers(), "{0} Toggling any challenge will reset survival streak {0}\n\n\n\n\n\n\n".format(iconString(Icon.WARNING)) if distance(evalOnce(SHOP_CHALLENGES_POSITION), localPlayer.getPosition()) < 3 else "", evalOnce(SHOP_CHALLENGES_POSITION) + evalOnce(Vector.UP * 0.9), 1.5, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)
    allocateShopEffect()

subroutine clearShopEffects
def clearShopEffects():
    for SHOP_EFFECTS_INDEX in range(0, len(SHOP_EFFECTS), 1):
        destroyEffect(SHOP_EFFECTS[SHOP_EFFECTS_INDEX])
        destroyIcon(SHOP_EFFECTS[SHOP_EFFECTS_INDEX])
        destroyInWorldText(SHOP_EFFECTS[SHOP_EFFECTS_INDEX])
        wait(0.016)
    SHOP_EFFECTS = []

rule "[shop/main.opy] Shop Init":
    waitUntil(any([player.hasSpawned() for player in getPlayers(Team.1)]), 9999)

    SHOP_HERO_SWITCH_POSITION = getShopPosition(0)
    SHOP_CHALLENGES_POSITION = getShopPosition(2)

    SHOP_CREATION_READY = true

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
