settings "lobby.opy.json"

#!suppressWarnings w_wait_until w_ow2_communicate_bug

#!extension projectiles
#!extension spawnMoreDummyBots
#!extension buffStatusEffects
#!extension buffAndDebuffSounds
#!extension energyExplosionEffects
#!extension explosionSounds

#!define getPlayersInMatch() [player for player in getPlayers(Team.1) if player.isAlive() and player.hasSpawned()]
#!define getPlayersAlive() [player for player in getPlayers(Team.1) if player.isAlive and player.hasSpawned()]

#!define globalBotDamagePercentage min(1, (getNumberOfPlayers(Team.1) / 3)) * (0.35 * WS_SETTING_GLOBAL_BOT_DAMAGE)

#!define WS_SETTING_MAX_ROUNDS \
createWorkshopSetting(int[10:30], "Gameplay", "Max Rounds", 20, 2)

globalvar WS_SETTING_MAX_BOTS = createWorkshopSetting(int[6:18], "Gameplay", "Max Bots", 10, 2)

#!define WS_SETTING_GLOBAL_BOT_DAMAGE \
createWorkshopSetting(int[50:200], "Gameplay", "Global Bot Damage Modifier (%)", 100, 3)

#!define WS_SETTING_LONG_BREAK \
createWorkshopSetting(bool, "Gameplay", "Long Break Time", false, 1)

#!define WS_SETTING_ENABLE_MUSIC \
createWorkshopSetting(bool, "General", "Enable Music", true, 1)

#!define WS_SETTING_ANTI_CRASH_DELAY \
[1, 2, 3][createWorkshopSetting(enum["Prioritize Server Stability", "Balanced", "Prioritize Server Performance"], "General", "Anti-Crash Priority", 2, 3)]

globalvar WS_SETTING_LIMITED_TANK_HEALTH = createWorkshopSetting(bool, "Heroes", "Tank Role: Limited Health", true, 3)

globalvar WS_SETTING_LIFE_GRIP_LIMITED = createWorkshopSetting(bool, "Heroes", "Lifeweaver: Life Grip / Petal Platform Protection", true, 4)

globalvar WS_SETTING_LIMITED_STEALTH = createWorkshopSetting(bool, "Heroes", "Sombra: Limited Stealth", true, 4)

#!include "../overpy-modules/src/customHealth.opy"
#!include "../overpy-modules/src/fixedSmallMessages.opy"
#!include "../overpy-modules/src/onScreenText.opy"
#!include "../overpy-modules/src/restart.opy"
#!include "../overpy-modules/src/rainbow.opy"

globalvar WS_DIFFICULTY = 1

#!include "../Bot-Playground/src/bot/controller.opy"
#!include "../Bot-Playground/src/bot/heroes/all.opy"

globalvar globalIndex
globalvar debugMode = createWorkshopSetting(bool, "General", "Debug Mode", false, 3)
globalvar WORKSHOP_CODE = "GWZB4"

globalvar CREDITS_THERISTER = createWorkshopSetting(enum["Therister"], "Credits", "Dialogue System", 0, 1)
globalvar CREDITS_ZEZOMBYE = createWorkshopSetting(enum["Zezombye"], "Credits", "Anti-Crash System & Overpy", 0, 1)

#!include "disasterData.opy"
#!include "player/main.opy"
#!include "events/main.opy"
#!include "player/lifeweaver.opy"
#!include "bot/main.opy"
#!include "player/medals.opy"
#!include "game/main.opy"
#!include "shop/main.opy"

#!include "debug.opy"

rule "[main.opy] Disable Inspector":
    disableInspector()