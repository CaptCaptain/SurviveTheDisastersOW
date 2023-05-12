#!mainFile "../main.opy"

#!define hasDisasterTag(tag) eventPlayer.BOT_DISASTER_TAG == tag

#!define botWaitUntilReady() waitUntil((entityExists(eventPlayer.BOT_PLAYER) or entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER)) and eventPlayer.isAlive(), 9999)

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
#!include "bot/wisp.opy"
#!include "bot/blizzard.opy"
#!include "bot/witch.opy"
#!include "bot/tiktok.opy"
#!include "bot/pharamercy.opy"
#!include "bot/bosses/galactic_sigma.opy"
#!include "bot/bosses/seer_mercy.opy"
#!include "bot/bosses/infinite_admiral.opy"
#!include "bot/bosses/royal_captain.opy"
#!include "bot/bosses/space_prince.opy"

playervar dummyBotLosSpawnPos

rule "[bot/main.opy] Init":
    # Global Bot Damage
    startDamageModification(getPlayers(Team.1), getPlayers(Team.2), globalBotDamagePercentage, DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)

rule "[bot/main.opy] Respawn Bot When Not Within Line Of Sight Once":
    @Event eachPlayer
    @Team 2
    @Condition botFlags.RESPAWNABLE_NO_LOS in eventPlayer.BOT_DISASTER_FLAGS
    @Condition all([not isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)])

    waitUntil(any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]), random.uniform(5, 10))
    if any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]):
        return

    eventPlayer.dummyBotLosSpawnPos = sorted(getPlayersAlive(), lambda player: player.survivalStreak).last()
    eventPlayer.dummyBotLosSpawnPos = [spawn for spawn in dummyBotSpawnArray if eventPlayer.dummyBotLosSpawnPos.y > spawn - 1 and eventPlayer.dummyBotLosSpawnPos.y < spawn + 1]
    eventPlayer.dummyBotLosSpawnPos = random.choice(eventPlayer.dummyBotLosSpawnPos.exclude([spawn for spawn in eventPlayer.dummyBotLosSpawnPos if not isInLoS(getClosestPlayer(spawn, Team.1).getEyePosition(), spawn + Vector.UP, BarrierLos.PASS_THROUGH_BARRIERS) or not getClosestPlayer(spawn, Team.1).isAlive]))

    if eventPlayer.dummyBotLosSpawnPos == null or eventPlayer.dummyBotLosSpawnPos == vect(0, 0, 0) or eventPlayer.dummyBotLosSpawnPos == []:
        eventPlayer.respawn()
        wait(0.25)
        eventPlayer.teleport(dummyBotSpawn(15))
        return

    eventPlayer.respawn()

    wait(0.25)

    eventPlayer.teleport(eventPlayer.dummyBotLosSpawnPos)
    eventPlayer.setStatusEffect(null, Status.ROOTED, 1)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 1)

    wait(5)

    if RULE_CONDITION: goto RULE_START


rule "[bot/main.opy] Prevent Bot Respawn Clumping":
    @Event playerDied
    @Team 2

    waitUntil(eventPlayer.isAlive(), 9999)

    wait(0.032)

    eventPlayer.teleport(dummyBotSpawn(15))

rule "[bot/main.opy] Track Player Positions":
    tempDummyBotSpawnArray = [player for player in getPlayersInMatch() if player.isOnGround() and player.isMoving()]
    dummyBotSpawnArray.append([player.getPosition() for player in getAllPlayers()])

    if len(dummyBotSpawnArray) >= 1000:
        dummyBotSpawnArray = []
        return

    wait(1)

    if RULE_CONDITION: goto RULE_START

rule "[bot/main.opy] Respawn if Teleported to Null":
    @Event eachPlayer
    @Team 2
    
    waitUntil(eventPlayer.getPosition() == vect(0, 0, 0), 9999)
    wait(0.016)
    eventPlayer.respawn()
    wait(0.016)
    eventPlayer.teleport(nearestWalkablePosition(dummyBotSpawnAny(15)))
    wait(0.25)
    goto RULE_START