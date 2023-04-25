#!mainFile "../main.opy"

#!define hasDisasterTag(tag) eventPlayer.BOT_DISASTER_TAG == tag

#!include "bot/moth.opy"
#!include "bot/wife.opy"
#!include "bot/minefield.opy"
#!include "bot/bob.opy"
#!include "bot/simon.opy"
#!include "bot/sombra.opy"
#!include "bot/winton.opy"
#!include "bot/kamehameha.opy"
#!include "bot/murderer.opy"
#!include "bot/null_sector.opy"
#!include "bot/talon.opy"
#!include "bot/ninja.opy"
#!include "bot/copycat.opy"
#!include "bot/sniper.opy"

playervar dummyBotLosSpawnPos

globalvar dummyBotSpawnArray = []

rule "[bot/main.opy] Init":
    # Global Bot Damage
    startDamageModification(getPlayers(Team.1), getPlayers(Team.2), globalBotDamagePercentage, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)

rule "[bot/main.opy] Respawn Bot When Not Within Line Of Sight Once":
    @Event eachPlayer
    @Team 2
    @Condition botFlags.RESPAWNABLE_NO_LOS in eventPlayer.BOT_DISASTER_FLAGS
    @Condition all([not isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)])

    waitUntil(any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]), random.uniform(5, 15))
    if any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]):
        return

    eventPlayer.respawn()

    wait(0.25)

    eventPlayer.dummyBotLosSpawnPos = sorted(getPlayersInMatch(), lambda player: player.getPosition().y).last()
    eventPlayer.dummyBotLosSpawnPos = [spawn for spawn in dummyBotSpawnArray if eventPlayer.dummyBotLosSpawnPos.y > spawn - 1 and eventPlayer.dummyBotLosSpawnPos.y < spawn + 1]
    eventPlayer.dummyBotLosSpawnPos = random.choice(eventPlayer.dummyBotLosSpawnPos.exclude([spawn for spawn in eventPlayer.dummyBotLosSpawnPos if not isInLoS(getClosestPlayer(spawn, Team.1), spawn, BarrierLos.PASS_THROUGH_BARRIERS) and not getClosestPlayer(spawn, Team.1).isAlive]))
    eventPlayer.teleport(eventPlayer.dummyBotLosSpawnPos)

    wait(5)

    if RULE_CONDITION: goto RULE_START


rule "[bot/main.opy] Prevent Bot Respawn Clumping":
    @Event playerDied
    @Team 2

    waitUntil(eventPlayer.isAlive(), 9999)

    wait(0.032)

    eventPlayer.teleport(dummyBotSpawn(15))

rule "[bot/main.opy] Track Player Positions":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isOnGround()
    @Condition eventPlayer.isMoving()
    @Condition eventPlayer.isAlive()
    @Condition all([distance(eventPlayer.getPosition(), spawn) > 1 for spawn in dummyBotSpawnArray])

    dummyBotSpawnArray.append(eventPlayer.getPosition())

    wait(1)

    if RULE_CONDITION: goto RULE_START