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

                clearScoreboardIcon(eventPlayer, SHOP_CHALLENGES_ALL_ICONS[eventPlayer.SHOP_CHALLENGES_OPTION])

                eventPlayer.survivalStreak = 0
            else:
                eventPlayer.SHOP_CHALLENGES_ACTIVE.append(eventPlayer.SHOP_CHALLENGES_OPTION)

                playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION, Color.ROSE, SHOP_CHALLENGES_POSITION, 10)
                playEffect(eventPlayer, DynamicEffect.GOOD_PICKUP_EFFECT, Color.ROSE, SHOP_CHALLENGES_POSITION, 1)
                playEffect(eventPlayer, DynamicEffect.ANA_BIOTIC_GRENADE_INCREASED_HEALING_SOUND, Color.ROSE, SHOP_CHALLENGES_POSITION, 50)

                addScoreboardIcon(eventPlayer, SHOP_CHALLENGES_ALL_ICONS[eventPlayer.SHOP_CHALLENGES_OPTION])

                eventPlayer.survivalStreak = 0

        wait(0.25)

    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)

rule "[shop/challenges.opy] Update Challenge Status":
    while true:
        # Applying
        [player for player in getPlayers(Team.1) if shopChallengeOptions.HACKED[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE and not player.hasStatusEffect(Status.HACKED)].setStatusEffect(null, Status.HACKED, Math.INFINITY)

        [player for player in getPlayers(Team.1) if shopChallengeOptions.HARDCORE[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE].setDamageReceived(150)

        [player for player in getPlayers(Team.1) if shopChallengeOptions.PACIFIST[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE].setPrimaryFireEnabled(false)
        [player for player in getPlayers(Team.1) if shopChallengeOptions.PACIFIST[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE].setSecondaryFireEnabled(false)

        # Stop applying
        [player for player in getPlayers(Team.1) if not shopChallengeOptions.HACKED[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE].clearStatusEffect(Status.HACKED)

        [player for player in getPlayers(Team.1) if not shopChallengeOptions.HARDCORE[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE].setDamageReceived(100)

        [player for player in getPlayers(Team.1) if not shopChallengeOptions.PACIFIST[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE].setPrimaryFireEnabled(true)
        [player for player in getPlayers(Team.1) if not shopChallengeOptions.PACIFIST[shopChallengeData.ID] in player.SHOP_CHALLENGES_ACTIVE].setSecondaryFireEnabled(true)

        waitUntil(any([player for player in getPlayers(Team.1) if player.SHOP_CHALLENGES_ACTIVE != evalOnce(player.SHOP_CHALLENGES_ACTIVE)]), 0.5)
        wait(0.5)