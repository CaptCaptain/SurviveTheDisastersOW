settings "lobby.opy.json"

#!suppressWarnings w_wait_until w_ow2_communicate_bug

#!optimizeForSize

#!extension projectiles
#!extension spawnMoreDummyBots
#!extension buffStatusEffects
#!extension buffAndDebuffSounds
#!extension energyExplosionEffects
#!extension explosionSounds

#!define getPlayersInMatch() [player for player in getPlayers(Team.1) if player.isAlive() and player.hasSpawned()]
#!define getPlayersAlive() [player for player in getPlayers(Team.1) if player.isAlive and player.hasSpawned()]

#!define globalBotDamagePercentage min(1, (getNumberOfPlayers(Team.1) / 4)) * (0.35 * WS_SETTING_GLOBAL_BOT_DAMAGE)

globalvar WS_SETTING_MAX_ROUNDS = createWorkshopSetting(int[10:30], "Gameplay", "Max Rounds", 20, 2)

#!define WS_SETTING_SPECIAL_EVENTS \
createWorkshopSetting(enum["Every 2 rounds", "Every 5 Rounds", "Every 10 Rounds"], "Gameplay", "Special Events", 1, 2)

globalvar WS_SETTING_MAX_BOTS = createWorkshopSetting(int[6:18], "Gameplay", "Max Bots", 10, 2)

#!define WS_SETTING_GLOBAL_BOT_DAMAGE \
createWorkshopSetting(int[50:200], "Gameplay", "Global Bot Damage Modifier (%)", 100, 3)

#!define WS_SETTING_LONG_BREAK \
createWorkshopSetting(bool, "Gameplay", "Long Break Time", false, 1)

#!define WS_SETTING_ENABLE_MUSIC \
createWorkshopSetting(bool, "General", "Enable Music", true, 1)

#!define WS_SETTING_ANTI_CRASH_DELAY \
[1, 2, 3][createWorkshopSetting(enum["Prioritize Server Stability", "Balanced", "Prioritize Server Performance"], "General", "Anti-Crash Priority", 0, 3)]

globalvar WS_SETTING_LIMITED_TANK_HEALTH = createWorkshopSetting(bool, "Heroes", "Tank Role: Limited Health", true, 3)

globalvar WS_SETTING_LIFE_GRIP_LIMITED = createWorkshopSetting(bool, "Heroes", "Lifeweaver: Life Grip / Petal Platform Protection", true, 4)

globalvar WS_SETTING_LIMITED_STEALTH = createWorkshopSetting(bool, "Heroes", "Sombra: Limited Stealth", true, 4)

#!include "../overpy-modules/src/customHealth.opy"
#!include "../overpy-modules/src/fixedSmallMessages.opy"
#!include "../overpy-modules/src/onScreenText.opy"
#!include "../overpy-modules/src/restart.opy"
#!include "../overpy-modules/src/rainbow.opy"
#!include "../overpy-modules/src/alignHudText.opy"

globalvar WS_DIFFICULTY = 1

#!include "../Bot-Playground/src/bot/controller.opy"
#!include "../Bot-Playground/src/bot/heroes/all.opy"

globalvar globalIndex
globalvar debugMode = createWorkshopSetting(bool, "General", "Debug Mode", false, 3)
globalvar WORKSHOP_CODE = "GWZB4"

globalvar CREDITS_THERISTER = createWorkshopSetting(enum["Therister"], "Credits", "Dialogue System", 0, 1)
globalvar CREDITS_ZEZOMBYE = createWorkshopSetting(enum["Zezombye"], "Credits", "Anti-Crash System & Overpy", 0, 1)

# Shop Variables

enum shopAccessibilityOptions:
    3PC = [0, "Third Person Camera", "View the world in third person.", iconString(Icon.EYE)],

enum shopAccessibilityData:
    ID,
    NAME,
    DESCRIPTION,
    ICON,

globalvar SHOP_ACCESSIBILITY_ALL_OPTIONS = [shopAccessibilityOptions.3PC[shopAccessibilityData.NAME]]
globalvar SHOP_ACCESSIBILITY_ALL_DESC = [shopAccessibilityOptions.3PC[shopAccessibilityData.DESCRIPTION]]
globalvar SHOP_ACCESSIBILITY_ALL_ICONS = [shopAccessibilityOptions.3PC[shopAccessibilityData.ICON]]
playervar SHOP_ACCESSIBILITY_OPTION = 0
playervar SHOP_ACCESSIBILITY_ACTIVE = []

enum shopChallengeOptions:
    HACKED = [0, "Hacked", "Cannot use any abilities (1.25x PTS)", abilityIconString(Hero.SOMBRA, Button.SECONDARY_FIRE)],
    HARDCORE = [1, "Hardcore", "Increased damage taken (1.1x PTS)", abilityIconString(Hero.MCCREE, Button.ULTIMATE)],
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

# Imports

#!include "disasterData.opy"
#!include "player/main.opy"
#!include "events/main.opy"
#!include "player/mercy.opy"
#!include "player/lifeweaver.opy"
#!include "player/reinhardt.opy"
#!include "bot/main.opy"
#!include "shop/main.opy"
#!include "player/medals.opy"
#!include "game/main.opy"
#!include "game/anti-crash.opy"

#!include "debug.opy"

rule "[main.opy] Disable Inspector":
    disableInspector()