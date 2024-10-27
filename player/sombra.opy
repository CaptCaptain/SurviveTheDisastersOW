#!mainFile "../main.opy"

#!define playerIsSombra(player) (player.getCurrentHero() == Hero.SOMBRA or player.getHeroOfDuplication() == Hero.SOMBRA)

playervar sombraIsInvisible

#!define startSombraInvisTimer() \
eventPlayer.sombraIsInvisible = true \
PLAYER_IGNORE.append(eventPlayer) \
waitUntil(not eventPlayer.sombraIsInvisible, 5.25)\
PLAYER_IGNORE.remove(eventPlayer) \
eventPlayer.sombraIsInvisible = false

rule "[player/sombra.opy]: End Stealth Early":
    @Event eachPlayer
    @Hero sombra
    @Team 1
    @Condition eventPlayer.sombraIsInvisible == true

    waitUntil(eventPlayer.sombraIsInvisible == false or eventPlayer.getHealth() < evalOnce(eventPlayer.getHealth()) or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.ABILITY_1) or eventPlayer.isHoldingButton(Button.MELEE), 9999)

    wait(0.25)

    PLAYER_IGNORE.remove(eventPlayer)
    eventPlayer.sombraIsInvisible = false

rule "[player/sombra.opy]: Sombra Invis Timer":
    @Event eachPlayer
    @Hero sombra
    @Team 1
    @Condition eventPlayer.isUsingAbility2()

    startSombraInvisTimer()

rule "[player/sombra.opy]: Sombra Invis Timer":
    @Event eachPlayer
    @Hero echo
    @Team 1
    @Condition eventPlayer.getHeroOfDuplication() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility2()

    startSombraInvisTimer()