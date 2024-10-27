#!mainFile "../main.opy"

#!define playerIsSombra(player) (player.getCurrentHero() == Hero.SOMBRA or player.getHeroOfDuplication() == Hero.SOMBRA)

#!define startSombraInvisTimer() \
waitUntil(not eventPlayer.isUsingAbility2(), 9999)\
PLAYER_IGNORE.append(eventPlayer) \
waitUntil(eventPlayer.getAbilityCooldown(Button.ABILITY_2) == 0, 5) \
PLAYER_IGNORE.remove(eventPlayer) \

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