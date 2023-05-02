#!mainFile "../main.opy"

#!define playerIsSombra(player) (player.getCurrentHero() == Hero.SOMBRA or player.getHeroOfDuplication() == Hero.SOMBRA)

#!define startSombraInvisTimer() \
eventPlayer.sombraMaxInvisTimer = 100\
\
while eventPlayer.sombraMaxInvisTimer > 0 and eventPlayer.isUsingAbility1():\
    eventPlayer.sombraMaxInvisTimer -= 0.2\
    wait(0.016)\
\
eventPlayer.forceButtonPress(Button.ABILITY_1)\

playervar sombraMaxInvisTimer = 0
globalvar sombraMaxInvisTextId

rule "[player/sombra.opy]: Sombra Init":
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition any([playerIsSombra(player) for player in getPlayers(Team.1)])

    progressBarHud(localPlayer if playerIsSombra(localPlayer) and localPlayer.isUsingAbility1() else [], localPlayer.sombraMaxInvisTimer, abilityIconString(Hero.SOMBRA, Button.ABILITY_1), HudPosition.TOP, 3, Color.VIOLET, Color.WHITE, ProgressHudReeval.VISIBILITY_AND_VALUES, SpecVisibility.NEVER)
    sombraMaxInvisTextId = getLastCreatedText()

    waitUntil(all([player.getCurrentHero() != Hero.SOMBRA and player.getHeroOfDuplication() != Hero.SOMBRA for player in getPlayers(Team.1)]), 9999)

    destroyProgressBarHud(sombraMaxInvisTextId)

rule "[player/sombra.opy]: Sombra Invis Timer":
    @Event eachPlayer
    @Hero sombra
    @Team 1
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition eventPlayer.isUsingAbility1()

    startSombraInvisTimer()

rule "[player/sombra.opy]: Sombra Invis Timer":
    @Event eachPlayer
    @Hero echo
    @Team 1
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition eventPlayer.getHeroOfDuplication() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility1()

    startSombraInvisTimer()