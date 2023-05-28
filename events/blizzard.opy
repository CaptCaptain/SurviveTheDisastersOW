#!mainFile "../main.opy"

playervar DISASTER_BLIZZARD_HEAT
globalvar DISASTER_BLIZZARD_FIRES = []
globalvar DISASTER_BLIZZARD_INDEX = 0

#!define DISASTER_BLIZZARD_CREATE_FIRE(position) \
createIcon(localPlayer if not localPlayer.isInViewAngle(evalOnce(position), 90) and localPlayer.isAlive() else null, evalOnce(position), Icon.FIRE, IconReeval.VISIBILITY_AND_POSITION, Color.ORANGE, true)\
allocateEffect()\
createInWorldText(localPlayer if localPlayer.isInViewAngle(evalOnce(position), 90) and localPlayer.isAlive() else null, "{0}\n".format(iconString(Icon.FIRE)), evalOnce(position), 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.GREEN, SpecVisibility.DEFAULT)\
allocateText()\
createEffect(getAllPlayers(), Effect.RING, Color.ORANGE, evalOnce(position), 3, EffectReeval.VISIBILITY)\
allocateEffect()\
createEffect(getAllPlayers(), Effect.BAD_AURA, Color.ORANGE, evalOnce(position), 1, EffectReeval.VISIBILITY)\
allocateEffect()\
createEffect(getAllPlayers(), Effect.GOOD_AURA, Color.ORANGE, evalOnce(position), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
createEffect(getAllPlayers(), Effect.ORB, Color.ORANGE, evalOnce(position), 1, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\

rule "[events/blizzard.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.BLIZZARD) in activeDisasters
    @Condition disasterReady

    getPlayers(Team.1).DISASTER_BLIZZARD_HEAT = 100

    waitForEntitySpawnFlag(getDisasterId(disasters.BLIZZARD))

    createDummy(Hero.MEI, Team.2, -1, nearestWalkablePosition(vect(0, 1000, 0)), null)
    allocateDummyBotTag(getDisasterId(disasters.BLIZZARD))

    wait(1, Wait.ABORT_WHEN_FALSE)

    createFog(localPlayer, 30, Color.WHITE)
    
    progressBarHud(localPlayer, localPlayer.DISASTER_BLIZZARD_HEAT, iconString(Icon.FIRE), HudPosition.TOP, 3, Color.ORANGE, Color.WHITE, ProgressHudReeval.VISIBILITY_AND_VALUES, SpecVisibility.NEVER)
    allocateText()

    createEffect(localPlayer, Effect.MEI_FROZEN_SOUND, Team.2, localPlayer, 500, EffectReeval.VISIBILITY)
    allocateEffect()

    createEffect(localPlayer if localPlayer.DISASTER_BLIZZARD_HEAT <= 0 else null, Effect.DECAL_SOUND, Team.1, localPlayer, 100, EffectReeval.VISIBILITY)
    allocateEffect()

    for disasterIndex in range(0, 3, 1):
        DISASTER_BLIZZARD_FIRES.append(getSpawnPoints(Team.ALL)[disasterIndex].getPosition())
        DISASTER_BLIZZARD_CREATE_FIRE(DISASTER_BLIZZARD_FIRES.last())

    wait(0.25)

    while disasterReady:
        for DISASTER_BLIZZARD_INDEX in range(0, len(DISASTER_BLIZZARD_FIRES), 1):
            getPlayersInRadius(DISASTER_BLIZZARD_FIRES[DISASTER_BLIZZARD_INDEX], 3, Team.1, LosCheck.OFF).DISASTER_BLIZZARD_HEAT += 20 if disasterFlags.HARDCORE in activeDisasterFlags else 10

        getPlayers(Team.1).DISASTER_BLIZZARD_HEAT -= 10 if disasterFlags.HARDCORE in activeDisasterFlags else 5
        
        ([player for player in getPlayers(Team.1) if player.DISASTER_BLIZZARD_HEAT > 100]).DISASTER_BLIZZARD_HEAT = 100

        (getDeadPlayers(Team.1)).DISASTER_BLIZZARD_HEAT = 100

        ([player for player in getPlayers(Team.1) if player.DISASTER_BLIZZARD_HEAT < 0]).DISASTER_BLIZZARD_HEAT = 0
        damage(([player for player in getPlayers(Team.1) if player.DISASTER_BLIZZARD_HEAT <= 0]), null, 6.25)
        wait(0.25)

rule "[events/blizzard.opy] Disaster Initialization":
    @Condition getDisasterId(disasters.BLIZZARD) in activeDisasters
    @Condition disasterReady

    while disasterReady:
        ([player for player in getPlayers(Team.1) if player.DISASTER_BLIZZARD_HEAT <= 0]).setStatusEffect(null, Status.FROZEN, 1)
        wait(3)