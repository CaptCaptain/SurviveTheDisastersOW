#!mainFile "../main.opy"

#!define hasDisasterTag(tag) eventPlayer.BOT_DISASTER_TAG == tag

#!define botWaitUntilReady() waitUntil((entityExists(eventPlayer.BOT_PLAYER) or entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER)) and eventPlayer.isAlive(), 9999)

#!define createBossName(player, Icon, IconString, color)\
createIcon(localPlayer if not localPlayer.isInViewAngle(player.getEyePosition(), 90) and player.isAlive() else null, player, Icon, IconReeval.VISIBILITY, color, true)\
allocateEffect()\
\
createInWorldText(localPlayer if localPlayer.isInViewAngle(player.getEyePosition(), 90) and player.isAlive() else null, "[{0}]\n".format(IconString), player, 2, Clip.NONE, WorldTextReeval.VISIBILITY, color, SpecVisibility.DEFAULT)\
allocateText()\
\
createEffect(getAllPlayers(), Effect.RING, color, player, 3, EffectReeval.VISIBILITY)\
allocateEffect()\
allocatePlayerEffect(player)\

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
#!include "bot/vishkar.opy"
#!include "bot/nuclear_bomb.opy"
#!include "bot/crusaders.opy"
#!include "bot/black_hole.opy"
#!include "bot/bastion.opy"
#!include "bot/cowboy.opy"
#!include "bot/bosses/galactic_sigma.opy"
#!include "bot/bosses/seer_mercy.opy"
#!include "bot/bosses/infinite_admiral.opy"
#!include "bot/bosses/royal_captain.opy"
#!include "bot/bosses/space_prince.opy"
#!include "bot/bosses/zeus.opy"
#!include "bot/bosses/orisa.opy"

playervar dummyBotLosSpawnPos

subroutine respawnNearPlayer
def respawnNearPlayer():
    eventPlayer.respawn()

    wait(0.25)

    eventPlayer.teleport(dummyBotSpawn(15))
    eventPlayer.setStatusEffect(null, Status.ROOTED, 1)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 1)

rule "[bot/main.opy] Respawn Bot When Not Within Line Of Sight Once":
    @Event eachPlayer
    @Team 2
    @Condition botFlags.RESPAWNABLE_NO_LOS in eventPlayer.BOT_DISASTER_FLAGS
    @Condition all([not isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)])

    waitUntil(any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]), random.uniform(5, 10))
    if any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]):
        return

    respawnNearPlayer()

    wait(5)

    if RULE_CONDITION: goto RULE_START


rule "[bot/main.opy] Prevent Bot Respawn Clumping":
    @Event playerDied
    @Team 2

    waitUntil(eventPlayer.isAlive(), 9999)

    wait(0.032)

    respawnNearPlayer()

rule "[bot/main.opy] Track Player Positions":
    dummyBotSpawnArray.append([player.getPosition() for player in getPlayersInMatch() if player.isOnGround() and player.isMoving()])

    if len(dummyBotSpawnArray) >= 1000:
        dummyBotSpawnArray = []
        return

    wait(1)

    if RULE_CONDITION: goto RULE_START