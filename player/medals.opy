#!mainFile "../main.opy"

enum medalData:
    ICON,
    TITLE,
    SOUND

enum medalSoundData:
    ID,
    EFFECT

enum MedalSounds:
    GOOD = [1, DynamicEffect.BUFF_IMPACT_SOUND],
    OKAY = [2, DynamicEffect.RING_EXPLOSION_SOUND],
    BAD = [3, DynamicEffect.DEBUFF_IMPACT_SOUND],

enum Medals:
    SURVIVED = [iconString(Icon.CHECKMARK), "Survived!", MedalSounds.GOOD[medalSoundData.ID]],
    NOT_TODAY = [abilityIconString(Hero.BAPTISTE, Button.ABILITY_2), "Not Today, Thank You", MedalSounds.GOOD[medalSoundData.ID]],
    SUPPORTER = [iconString(Icon.PLUS), "Supporter", MedalSounds.GOOD[medalSoundData.ID]],
    CLOSE_FINISH = [abilityIconString(Hero.LUCIO, Button.ABILITY_2), "Close Finish...!", MedalSounds.OKAY[medalSoundData.ID]],
    PACIFIST = [iconString(Icon.HEART), "Pacifist Challenge", MedalSounds.GOOD[medalSoundData.ID]],
    STREAK_3 = [iconString(Icon.FIRE), "3 Survival Streak!", MedalSounds.GOOD[medalSoundData.ID]],
    STREAK_7 = [iconString(Icon.FIRE), "7 Survival Streak!", MedalSounds.GOOD[medalSoundData.ID]],
    STREAK_13 = [iconString(Icon.FIRE), "13 Survival Streak!", MedalSounds.GOOD[medalSoundData.ID]],
    STREAK_21 = [iconString(Icon.HEART), "21 Survival Streak!", MedalSounds.GOOD[medalSoundData.ID]],
    SLAYER = [abilityIconString(Hero.REAPER, Button.ULTIMATE), "Slayer", MedalSounds.GOOD[medalSoundData.ID]],
    MVP = [iconString(Icon.DIAMOND), "MVP", MedalSounds.GOOD[medalSoundData.ID]],
    TEAMWORK = [iconString(Icon.STOP), "Teamwork Triumph", MedalSounds.GOOD[medalSoundData.ID]],
    KARMA = [abilityIconString(Hero.LIFEWEAVER, Button.PRIMARY_FIRE), "Karma", MedalSounds.BAD[medalSoundData.ID]],
    BUZZKILL = [abilityIconString(Hero.KIRIKO, Button.ABILITY_1), "Button Masher", MedalSounds.OKAY[medalSoundData.ID]],
    VICTIM = [abilityIconString(Hero.JUNKER_QUEEN, Button.SECONDARY_FIRE), "Unwitting Victim", MedalSounds.OKAY[medalSoundData.ID]],
    LAST_ONE_STANDING = [iconString(Icon.SPADE), "Last One Standing", MedalSounds.GOOD[medalSoundData.ID]],
    NO_BP = [iconString(Icon.ASTERISK), "Too Good to Be True", MedalSounds.BAD[medalSoundData.ID]],
    BOSS_HUNTER = [iconString(Icon.SKULL), "Boss Hunter", MedalSounds.GOOD[medalSoundData.ID]],
    HACKED_BONUS = [abilityIconString(Hero.SOMBRA, Button.SECONDARY_FIRE), "Hacked Challenge", MedalSounds.GOOD[medalSoundData.ID]],
    HARDCORE_BONUS = [abilityIconString(Hero.MCCREE, Button.ULTIMATE), "Hardcore Challenge", MedalSounds.GOOD[medalSoundData.ID]]

#!define queueMedal(player, medal) \
    if player.hasSpawned():\
        player.array_medal_titles.append(medal[medalData.TITLE])\
        player.array_medal_icons.append(medal[medalData.ICON])\
        player.array_medal_sounds.append(medal[medalData.SOUND])\
        if not medal[medalData.TITLE] in player.medalsEarned:\
            player.medalsEarned.append(medal[medalData.TITLE])\
            player.totalMedals += 1\

#!define queueMedalWithPoints(player, medal, points) \
    queueMedal(player, medal) \
    player.array_medal_titles[player.array_medal_titles.index(player.array_medal_titles.last())] = "{0} [+{1} PTS]".format(player.array_medal_titles[player.array_medal_titles.index(player.array_medal_titles.last())], points)\
    player.survivalScore += points\
    player.medalRoundPointsEarned += points\

#!define createMedalSFX(player, dynamicEffect) playEffect(player, dynamicEffect, Color.WHITE, player, 50)

#!define playMedalSound(player, medalSound) \
    switch(medalSound[medalSoundData.ID]): \
        case MedalSounds.GOOD[medalSoundData.ID]: \
            createMedalSFX(player, MedalSounds.GOOD[medalSoundData.EFFECT])\
            break\
        case MedalSounds.BAD[medalSoundData.ID]: \
            createMedalSFX(player, MedalSounds.BAD[medalSoundData.EFFECT])\
            break\
        case MedalSounds.OKAY[medalSoundData.ID]: \
            createMedalSFX(player, MedalSounds.OKAY[medalSoundData.EFFECT])\
            break\

#!define damagePointsMultiplier (0.5 if eventPlayer.getCurrentHero() in getSupportHeroes() else 1)
#!define healingPointsMultiplier (0.5 if not eventPlayer.getCurrentHero() in getSupportHeroes() else 1)
#!define getDamagePoints(player) ceil(((player.getStatistic(Stat.FINAL_BLOWS) - player.damageStatistic) * 10) * damagePointsMultiplier)
#!define getHealingPoints(player) ceil(((player.getStatistic(Stat.HEALING_DEALT) - player.healingStatistic) / 10) * healingPointsMultiplier)

subroutine displayEarnedMedals

playervar array_medal_titles = []
playervar array_medal_icons = []
playervar array_medal_sounds = []
playervar medalsEarned = []
playervar medalsDisplayed = false
playervar medalsDisplayLimit = 0
playervar medalRoundPointsEarned = 0

playervar damageStatistic
playervar healingStatistic

def displayEarnedMedals():
    eventPlayer.medalsDisplayed = true
    while len(eventPlayer.array_medal_titles) > 0:
        fixedSmallMessageWithIcon(eventPlayer, eventPlayer.array_medal_icons[0], eventPlayer.array_medal_titles[0])
        playMedalSound(eventPlayer, eventPlayer.array_medal_sounds[0])

        eventPlayer.medalsDisplayLimit += 1

        if eventPlayer.medalsDisplayLimit >= 3:
            wait(1)
            eventPlayer.medalsDisplayLimit = 0

        wait(0.064)
        
        del eventPlayer.array_medal_titles[0]
        del eventPlayer.array_medal_icons[0]
        del eventPlayer.array_medal_sounds[0]

        wait(0.5)
    wait(2.25)
    eventPlayer.medalsDisplayed = false
    eventPlayer.medalsDisplayLimit = 0

rule "[player/medals.opy] Init":
    onScreenText(localPlayer if localPlayer.medalsDisplayed else [], "Achievements", 0, -0.6, 1.2, WorldTextReeval.VISIBILITY_AND_POSITION, Color.WHITE, SpecVisibility.NEVER)

rule "[player/medals.opy] Queue Medal Messages":
    @Event eachPlayer
    @Team 1
    @Condition disasterReady == false
    @Condition len(eventPlayer.array_medal_titles) > 0

    wait(1)
    displayEarnedMedals()

rule "[player/medals.opy] Survival Streak Medals / MVP Medals / Teamwork Medal":
    @Event eachPlayer
    @Team 1
    @Condition disasterReady == true

    eventPlayer.medalRoundPointsEarned = 0

    waitUntil(disasterReady == false, 9999)

    if eventPlayer.isAlive:
        queueMedalWithPoints(eventPlayer, Medals.SURVIVED, 100)

    if eventPlayer.survivalStreak == 21:
        queueMedal(eventPlayer, Medals.STREAK_21)
    elif eventPlayer.survivalStreak == 13:
        queueMedal(eventPlayer, Medals.STREAK_13)
    elif eventPlayer.survivalStreak == 7:
        queueMedal(eventPlayer, Medals.STREAK_7)
    elif eventPlayer.survivalStreak == 3:
        queueMedal(eventPlayer, Medals.STREAK_3)

    if sorted(getPlayers(Team.1), lambda player: player.survivalStreak).last() == eventPlayer and getNumberOfPlayers(Team.1) >= 3 and eventPlayer.survivalStreak > 0:
        queueMedalWithPoints(eventPlayer, Medals.MVP, 50)

    if all([player.isAlive for player in getPlayers(Team.1)]) and getNumberOfPlayers(Team.1) > 1:
        queueMedalWithPoints(eventPlayer, Medals.TEAMWORK, 50)

    if len([player for player in getPlayers(Team.1) if player.isAlive]) == 1 and eventPlayer.isAlive and getNumberOfPlayers(Team.1) > 3:
        queueMedalWithPoints(eventPlayer, Medals.LAST_ONE_STANDING, 100)

    if shopChallengeOptions.PACIFIST[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE and eventPlayer.isAlive:
        queueMedalWithPoints(eventPlayer, Medals.PACIFIST, round(eventPlayer.medalRoundPointsEarned * 0.25))

    if shopChallengeOptions.HACKED[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE and eventPlayer.isAlive:
        queueMedalWithPoints(eventPlayer, Medals.HACKED_BONUS, round(eventPlayer.medalRoundPointsEarned * 0.25))

    if shopChallengeOptions.HARDCORE[shopChallengeData.ID] in eventPlayer.SHOP_CHALLENGES_ACTIVE and eventPlayer.isAlive:
        queueMedalWithPoints(eventPlayer, Medals.HARDCORE_BONUS, round(eventPlayer.medalRoundPointsEarned * 0.25))

rule "[player/medals.opy] Slayer Medal":
    @Event eachPlayer
    @Team 1
    @Condition disasterReady == true

    eventPlayer.damageStatistic = eventPlayer.getStatistic(Stat.FINAL_BLOWS)

    waitUntil(disasterReady == false, 9999)
    if getDamagePoints(eventPlayer) > 1:
        queueMedalWithPoints(eventPlayer, Medals.SLAYER, getDamagePoints(eventPlayer))

rule "[player/medals.opy] Boss Hunter Medal":
    @Event playerEarnedElimination
    @Team 1
    @Condition disasterReady == true

    if botFlags.BOSS in victim.BOT_DISASTER_FLAGS:
        queueMedalWithPoints(eventPlayer, Medals.BOSS_HUNTER, 75)

    waitUntil(disasterReady == false, 9999)

rule "[player/medals.opy] Supporter Medal":
    @Event eachPlayer
    @Team 1
    @Condition disasterReady == true

    eventPlayer.healingStatistic = eventPlayer.getStatistic(Stat.HEALING_DEALT)

    waitUntil(disasterReady == false, 9999)
    if getHealingPoints(eventPlayer) > 1:
        queueMedalWithPoints(eventPlayer, Medals.SUPPORTER, getHealingPoints(eventPlayer))
    
rule "[player/medals.opy] Not Today, Thank You Medal":
    @Event eachPlayer
    @Team 1
    @Condition disasterReady == true

    waitUntil(disasterReady == false or eventPlayer.isDead(), 9999)
    if disasterReady == false and eventPlayer.getNormalizedHealth() < 0.3:
        queueMedal(eventPlayer, Medals.NOT_TODAY)

rule "[player/medals.opy] Player Died Medals":
    @Event playerDied
    @Team 1
    @Condition disasterReady == true

    if disasters.WIFELEAVER[disasterData.ID] in activeDisasters and attacker.getCurrentHero() == Hero.LIFEWEAVER:
        queueMedal(eventPlayer, Medals.KARMA)
    if disasters.FAKE_BP[disasterData.ID] in activeDisasters and distance(eventPlayer.getPosition(), DISASTER_FAKE_BP_POS) < 20:
        queueMedal(eventPlayer, Medals.NO_BP)

    waitUntil(disasterReady == false, 9999)