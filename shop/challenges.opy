#!mainFile "../main.opy"

enum shopChallengeOptions:
    HACKED = [0, "Hacked", "Cannot use any abilities (1.25x PTS)", abilityIconString(Hero.SOMBRA, Button.SECONDARY_FIRE)],
    HARDCORE = [1, "Hardcore", "Increased damage taken (1.25x PTS)", abilityIconString(Hero.MCCREE, Button.ULTIMATE)],
    PACIFIST = [2, "Pacifist", "Cannot use weapon (1.25x PTS)", iconString(Icon.HEART)]

enum shopChallengeData:
    ID,
    NAME,
    DESCRIPTION,
    ICON,

globalvar SHOP_CHALLENGES_ALL_OPTIONS = [shopChallengeOptions.HACKED[shopChallengeData.NAME], shopChallengeOptions.HARDCORE[shopChallengeData.NAME], shopChallengeOptions.PACIFIST[shopChallengeData.NAME]]
globalvar SHOP_CHALLENGES_ALL_DESC = [shopChallengeOptions.HACKED[shopChallengeData.DESCRIPTION], shopChallengeOptions.HARDCORE[shopChallengeData.DESCRIPTION], shopChallengeOptions.PACIFIST[shopChallengeData.DESCRIPTION]]
globalvar SHOP_CHALLENGES_ALL_ICONS = [shopChallengeOptions.HACKED[shopChallengeData.ICON], shopChallengeOptions.HARDCORE[shopChallengeData.ICON], shopChallengeOptions.PACIFIST[shopChallengeData.ICON]]
playervar SHOP_CHALLENGES_OPTION = 0
playervar SHOP_CHALLENGES_ACTIVE = []

#!define addScoreboardIcon(player, iconString) \
player.scoreboardChallenges = "{0}{1}".format(player.scoreboardChallenges, iconString)

#!define clearScoreboardIcon(player, iconString) \
player.scoreboardChallenges = player.scoreboardChallenges.replace(iconString, "")

rule "[shop/challenges.opy] Buttons":
    @Event eachPlayer
    @Team 1
    @Condition distance(eventPlayer.getPosition(), SHOP_CHALLENGES_POSITION) < 3
    @Condition not disasterReady

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    
    while not disasterReady and distance(eventPlayer.getPosition(), SHOP_CHALLENGES_POSITION) < 3:
        waitUntil(disasterReady or distance(eventPlayer.getPosition(), SHOP_CHALLENGES_POSITION) > 3 or any([eventPlayer.isHoldingButton(Button.PRIMARY_FIRE), eventPlayer.isHoldingButton(Button.SECONDARY_FIRE), eventPlayer.isHoldingButton(Button.INTERACT)]), 9999)

        if disasterReady or distance(eventPlayer.getPosition(), SHOP_CHALLENGES_POSITION) > 3:
            break

        if eventPlayer.isHoldingButton(Button.PRIMARY_FIRE):
            eventPlayer.SHOP_CHALLENGES_OPTION -= 1
            eventPlayer.SHOP_CHALLENGES_OPTION = max(0, eventPlayer.SHOP_CHALLENGES_OPTION)
        elif eventPlayer.isHoldingButton(Button.SECONDARY_FIRE):
            eventPlayer.SHOP_CHALLENGES_OPTION += 1
            eventPlayer.SHOP_CHALLENGES_OPTION = min(len(SHOP_CHALLENGES_ALL_OPTIONS) - 1, eventPlayer.SHOP_CHALLENGES_OPTION)
        elif eventPlayer.isHoldingButton(Button.INTERACT):
            if eventPlayer.SHOP_CHALLENGES_OPTION in eventPlayer.SHOP_CHALLENGES_ACTIVE:
                eventPlayer.SHOP_CHALLENGES_ACTIVE.remove(eventPlayer.SHOP_CHALLENGES_OPTION)

                playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.ROSE, SHOP_CHALLENGES_POSITION, 10)
                playEffect(eventPlayer, DynamicEffect.BAD_PICKUP_EFFECT, Color.ROSE, SHOP_CHALLENGES_POSITION, 1)
                playEffect(eventPlayer, DynamicEffect.ANA_BIOTIC_GRENAGE_NO_HEALING_SOUND, Color.ROSE, SHOP_CHALLENGES_POSITION, 50)
            else:
                eventPlayer.SHOP_CHALLENGES_ACTIVE.append(eventPlayer.SHOP_CHALLENGES_OPTION)

                playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.ROSE, SHOP_CHALLENGES_POSITION, 10)
                playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.ROSE, SHOP_CHALLENGES_POSITION, 1)
                playEffect(eventPlayer, DynamicEffect.ANA_BIOTIC_GRENADE_INCREASED_HEALING_SOUND, Color.ROSE, SHOP_CHALLENGES_POSITION, 50)

            eventPlayer.survivalScore = 0

        wait(0.25)

    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)

rule "[shop/challenges.opy] Hacked Mode":
    @Event eachPlayer
    @Team 1
    @Condition shopChallengeOptions.HACKED[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE

    addScoreboardIcon(eventPlayer, shopChallengeOptions.HACKED[shopChallengeData.ICON])

    while shopChallengeOptions.HACKED[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE:
        waitUntil(not shopChallengeOptions.HACKED[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE or not eventPlayer.hasStatusEffect(Status.HACKED), 9999)
        if not shopChallengeOptions.HACKED[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE:
            break

        eventPlayer.setStatusEffect(null, Status.HACKED, Math.INFINITY)

        wait(0.016)

    eventPlayer.clearStatusEffect(Status.HACKED)

    clearScoreboardIcon(eventPlayer, shopChallengeOptions.HACKED[shopChallengeData.ICON])

rule "[shop/challenges.opy] Hardcore Mode":
    @Event eachPlayer
    @Team 1
    @Condition shopChallengeOptions.HARDCORE[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE

    addScoreboardIcon(eventPlayer, shopChallengeOptions.HARDCORE[shopChallengeData.ICON])

    eventPlayer.setDamageReceived(150)

    waitUntil(not shopChallengeOptions.HARDCORE[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE, 9999)

    eventPlayer.setDamageReceived(100)

    clearScoreboardIcon(eventPlayer, shopChallengeOptions.HARDCORE[shopChallengeData.ICON])

rule "[shop/challenges.opy] Pacifist Mode":
    @Event eachPlayer
    @Team 1
    @Condition shopChallengeOptions.PACIFIST[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE

    addScoreboardIcon(eventPlayer, shopChallengeOptions.PACIFIST[shopChallengeData.ICON])

    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)

    waitUntil(not shopChallengeOptions.PACIFIST[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE, 9999)

    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)

    clearScoreboardIcon(eventPlayer, shopChallengeOptions.PACIFIST[shopChallengeData.ICON])