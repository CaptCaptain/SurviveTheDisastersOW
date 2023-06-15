#!mainFile "../main.opy"

#!define DISASTER_BUTTON_DAMAGE_EFFECT() \
createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.RED, DISASTER_BUTTON_POS + (Vector.UP * 25), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
\
createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.RED, DISASTER_BUTTON_POS, 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\
\
createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.RED, DISASTER_BUTTON_POS + (Vector.DOWN * 25), 10, EffectReeval.VISIBILITY_POSITION_AND_RADIUS)\
allocateEffect()\

#!define DISASTER_BUTTON_POS (getDisasterVariable(disasterVariables_1, getDisasterId(disasters.BUTTON)))

rule "[events/button.opy] Disaster Initialization":
    @Condition disasters.BUTTON[disasterData.ID] in activeDisasters
    @Condition disasterReady

    wait(1)

    DISASTER_BUTTON_POS = random.choice(getSpawnPoints(Team.ALL)).getPosition()

    createIcon(localPlayer if not localPlayer.isInViewAngle(DISASTER_BUTTON_POS, 90) and localPlayer.isAlive() else [], DISASTER_BUTTON_POS, Icon.ARROW_DOWN, IconReeval.VISIBILITY, Color.GREEN, true)
    allocateEffect()

    createInWorldText(localPlayer if localPlayer.isInViewAngle(DISASTER_BUTTON_POS, 90) and localPlayer.isAlive() else [], "> {0} <\n".format(abilityIconString(Hero.KIRIKO, Button.ABILITY_1)), DISASTER_BUTTON_POS, 2, Clip.NONE, WorldTextReeval.VISIBILITY, Color.GREEN, SpecVisibility.DEFAULT)
    allocateText()

    createEffect(getAllPlayers(), Effect.RING, Color.GRAY, DISASTER_BUTTON_POS, 3, EffectReeval.VISIBILITY)
    allocateEffect()
    createEffect(getAllPlayers(), Effect.ORB, Color.LIME_GREEN, DISASTER_BUTTON_POS, 1, EffectReeval.VISIBILITY)
    allocateEffect()
    createEffect(getAllPlayers(), Effect.LIGHT_SHAFT, Color.LIME_GREEN, DISASTER_BUTTON_POS, 0.05, EffectReeval.VISIBILITY)
    allocateEffect()

    waitUntil(any([distance(player, DISASTER_BUTTON_POS) < 3 for player in getPlayers(Team.1)]) or not disasterReady, 9999)

    if not disasterReady:
        return

    DISASTER_BUTTON_DAMAGE_EFFECT()

    if len(activeDisasters) == 1:
        setMatchTime(getMatchTime() / 2)

    while disasters.BUTTON[disasterData.ID] in activeDisasters:
        kill([player for player in getPlayers(Team.ALL) if distance(player.getPosition(), DISASTER_BUTTON_POS) > 10], getPlayersInRadius(DISASTER_BUTTON_POS, 3, Team.1, LosCheck.OFF))
        wait(0.25)