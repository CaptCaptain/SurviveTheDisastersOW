#!mainFile "../main.opy"

#!define playerIsSombra(player) (player.getCurrentHero() == Hero.SOMBRA or player.getHeroOfDuplication() == Hero.SOMBRA)

#!define startSombraInvisTimer() \
waitUntil(not eventPlayer.isUsingAbility2(), 9999)\
eventPlayer.sombraMaxInvisTimer = 100\
eventPlayer.sombraIsInvisible = true\
PLAYER_IGNORE.append(eventPlayer) \
\
while eventPlayer.sombraMaxInvisTimer > 0:\
    eventPlayer.sombraMaxInvisTimer -= 0.3\
    wait(0.016)\
\
eventPlayer.sombraIsInvisible = false\
eventPlayer.setStatusEffect(null, Status.STUNNED, 0.016) \
PLAYER_IGNORE.remove(eventPlayer) \

playervar sombraMaxInvisTimer = 0
playervar sombraIsInvisible = false
globalvar sombraMaxInvisTextId

rule "[player/sombra.opy]: Sombra Init":
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition any([playerIsSombra(player) for player in getPlayers(Team.1)])

    progressBarHud(localPlayer if playerIsSombra(localPlayer) and localPlayer.sombraMaxInvisTimer > 0 else [], localPlayer.sombraMaxInvisTimer, abilityIconString(Hero.SOMBRA, Button.ABILITY_2), HudPosition.TOP, 3, Color.VIOLET, Color.WHITE, ProgressHudReeval.VISIBILITY_AND_VALUES, SpecVisibility.NEVER)
    sombraMaxInvisTextId = getLastCreatedText()

    waitUntil(all([player.getCurrentHero() != Hero.SOMBRA and player.getHeroOfDuplication() != Hero.SOMBRA for player in getPlayers(Team.1)]), 9999)

    destroyProgressBarHud(sombraMaxInvisTextId)
    PLAYER_IGNORE = []

rule "[player/sombra.opy]: Sombra Keep Out Of Invis":
    @Event eachPlayer
    @Hero sombra
    @Team 1
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition eventPlayer.sombraIsInvisible == false

    #!define allowSombraInStealthConditions eventPlayer.isFiringPrimaryFire() or eventPlayer.isFiringSecondaryFire() or eventPlayer.isUsingAbility1() or eventPlayer.isUsingAbility2() or eventPlayer.isReloading()

    waitUntil(allowSombraInStealthConditions or (eventPlayer.sombraIsInvisible != evalOnce(eventPlayer.sombraIsInvisible)), 3)
    if allowSombraInStealthConditions or eventPlayer.sombraIsInvisible == true:
        wait(0.016)
        goto RULE_START
    
    eventPlayer.setStatusEffect(null, Status.STUNNED, 0.016)

    wait(0.016)

    if RULE_CONDITION:
        goto RULE_START

rule "[player/sombra.opy]: End Timer Early When Hit":
    @Event eachPlayer
    @Hero sombra
    @Team 1
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition eventPlayer.sombraIsInvisible == true

    waitUntil(eventPlayer.sombraIsInvisible == false or eventPlayer.getHealth() < evalOnce(eventPlayer.getHealth()) or eventPlayer.isHoldingButton(Button.PRIMARY_FIRE) or eventPlayer.isHoldingButton(Button.ABILITY_1) or eventPlayer.isHoldingButton(Button.MELEE), 9999)

    wait(0.25)
    
    eventPlayer.sombraMaxInvisTimer = 0

rule "[player/sombra.opy]: Sombra Invis Timer":
    @Event eachPlayer
    @Hero sombra
    @Team 1
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition eventPlayer.isUsingAbility2()

    startSombraInvisTimer()

rule "[player/sombra.opy]: Sombra Invis Timer":
    @Event eachPlayer
    @Hero echo
    @Team 1
    @Condition WS_SETTING_LIMITED_STEALTH
    @Condition eventPlayer.getHeroOfDuplication() == Hero.SOMBRA
    @Condition eventPlayer.isUsingAbility2()

    startSombraInvisTimer()