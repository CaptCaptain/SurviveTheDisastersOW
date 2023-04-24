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

rule "[bot/main.opy] Init":
    # Global Bot Damage
    startDamageModification(getPlayers(Team.1), getPlayers(Team.2), (getNumberOfPlayers(Team.1) / 6) * (0.35 * WS_SETTING_GLOBAL_BOT_DAMAGE), DamageReeval.RECEIVERS_DAMAGERS_AND_DMGPERCENT)

rule "[bot/main.opy] Respawn Bot When Not Within Line Of Sight Once":
    @Event eachPlayer
    @Team 2
    @Disabled

    waitUntil(all([not isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]), 3)

    while all([not isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]):
        waitUntil(any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]), 3)
        if any([isInLoS(player.getEyePosition(), eventPlayer.getEyePosition(), BarrierLos.PASS_THROUGH_BARRIERS) for player in getPlayers(Team.1)]):
            break
        eventPlayer.respawn()
        wait(0.016)
        eventPlayer.teleport(dummyBotSpawn(10))

    wait(Math.INFINITY)


rule "[bot/main.opy] Prevent Bot Respawn Clumping":
    @Event playerDied
    @Team 2

    waitUntil(eventPlayer.isAlive(), 9999)

    wait(0.032)

    eventPlayer.teleport(dummyBotSpawn(15))