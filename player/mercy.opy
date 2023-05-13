#!mainFile "../main.opy"

playervar resurrectedPlayer

rule "[player/mercy.opy]: Resurrecting a Player considers them Alive":
    @Event eachPlayer
    @Team 1
    @Hero mercy
    @Condition eventPlayer.isUsingAbility2()

    if not eventPlayer.isAlive:
        return

    eventPlayer.resurrectedPlayer = sorted([player for player in getPlayers(Team.1) if not player.isAlive and player.hasSpawned()], lambda player: distance(eventPlayer.getPosition(), player.getPosition()) + angleBetweenVectors(eventPlayer.getFacingDirection(), directionTowards(eventPlayer.getEyePosition(), player.getEyePosition())))[0]

    waitUntil(not eventPlayer.isUsingAbility2(), 9999)

    if eventPlayer.resurrectedPlayer.isAlive():
        eventPlayer.resurrectedPlayer.isAlive = true