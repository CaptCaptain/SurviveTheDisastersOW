#!mainFile "../main.opy"

enum disasterData:
    ICON,
    NAME,
    ID,
    DURATION,
    RESPAWNABLE,
    BLACKLIST,
    BOT_TYPES,

enum disasterId:
    NULL,
    MOTHS,
    WIFELEAVER,
    MINEFIELD,
    BOB,
    SIMON, #TODO: Implement Simon
    ACID_RAIN,
    SOMBRA,
    WINTON,
    KAME,
    FLOOD,
    MYSTERY,
    GET_DOWN,
    DEATH_TRAMPOLINE, #TODO: Implement Death Trampoline
    GREEN_ZONE,
    MURDERERS,
    NULL_SECTOR,
    TALON,
    BUTTON,
    NINJA,
    COPYCAT,
    BLACK_HOLE,
    LAVA,
    ACID,
    SNIPER,
    BOMBS,
    #TODO: Implement the following disasters:
    VOLCANO,
    WISP,
    SANDSTORM,
    SLENDERMAN,
    FAKE_BP,

enum bossDisasterId:
    WITCH

enum disasters:
    MOTHS = [abilityIconString(Hero.MERCY, Button.ULTIMATE), "Moths", disasterId.MOTHS, 25, true, [], 1],
    WIFELEAVER = [iconString(Icon.HEART), "Peacemaker", disasterId.WIFELEAVER, 30, true, [], 1],
    MINEFIELD = [abilityIconString(Hero.HAMMOND, Button.ULTIMATE), "MINEFIELD", disasterId.MINEFIELD, 15, true, [], 1],
    BOB = [abilityIconString(Hero.ASHE, Button.ULTIMATE), "Big Omnic Butler", disasterId.BOB, 15, true, [], 1],
    SIMON = [iconString(Icon.STOP), "Simon Says", disasterId.SIMON, 60, true, [], 1], # Temporarily Disabled
    ACID_RAIN = [iconString(Icon.RADIOACTIVE), "Acid Rain", disasterId.ACID_RAIN, 25, true, [disasterId.FLOOD, disasterId.GREEN_ZONE], 0],
    SOMBRA = [abilityIconString(Hero.SOMBRA, Button.SECONDARY_FIRE), "Hackers", disasterId.SOMBRA, 30, true, [], 1],
    WINTON = [abilityIconString(Hero.WINSTON, Button.ULTIMATE), "Monke", disasterId.WINTON, 30, true, [], 1],
    KAME = [abilityIconString(Hero.MOIRA, Button.ULTIMATE), "Kamehameha", disasterId.KAME, 10, true, [], 1],
    FLOOD = [iconString(Icon.BOLT), "Flood", disasterId.FLOOD, 30, false, [disasterId.ACID_RAIN, disasterId.GREEN_ZONE, disasterId.GET_DOWN, disasterId.ACID, disasterId.LAVA, disasterId.BLACK_HOLE, disasterId.BUTTON], 0],
    MYSTERY = [iconString(Icon.QUESTION_MARK), "Mystery Disaster", disasterId.MYSTERY, 30, false, [], true],
    GET_DOWN = [iconString(Icon.ARROW_DOWN), "Get Down", disasterId.GET_DOWN, 10, false, [disasterId.ACID_RAIN, disasterId.FLOOD, disasterId.GREEN_ZONE], 0],
    DEATH_TRAMPOLINE = [iconString(Icon.HALO), "Death Trampoline", disasterId.DEATH_TRAMPOLINE, 10, false, [], 0], # Not Implemented
    GREEN_ZONE = [abilityIconString(Hero.RAMATTRA, Button.ABILITY_2), "Green Zone", disasterId.GREEN_ZONE, 20, false, [disasterId.ACID_RAIN, disasterId.FLOOD, disasterId.GET_DOWN, disasterId.BUTTON, disasterId.BLACK_HOLE], 0],
    MURDERERS = [abilityIconString(Hero.JUNKER_QUEEN, Button.SECONDARY_FIRE), "Murderers", disasterId.MURDERERS, 30, true, [], 1],
    NULL_SECTOR = [abilityIconString(Hero.BASTION, Button.ULTIMATE), "Null Sector", disasterId.NULL_SECTOR, 45, true, [disasterId.TALON], 2],
    TALON = [abilityIconString(Hero.DOOMFIST, Button.ULTIMATE), "Talon", disasterId.TALON, 45, true, [disasterId.NULL_SECTOR], 2],
    BUTTON = [abilityIconString(Hero.KIRIKO, Button.ABILITY_1), "Press the Button", disasterId.BUTTON, 30, false, [disasterId.BLACK_HOLE, disasterId.GREEN_ZONE, disasterId.ACID, disasterId.FLOOD, disasterId.LAVA, disasterId.FAKE_BP], 0],
    NINJA = [abilityIconString(Hero.GENJI, Button.ABILITY_2), "Ninjas", disasterId.NINJA, 30, true, [], 2],
    COPYCAT = [abilityIconString(Hero.ECHO, Button.ULTIMATE), "Copycats", disasterId.COPYCAT, 30, true, [], 2],
    BLACK_HOLE = [iconString(Icon.SPIRAL), "Black Hole", disasterId.BLACK_HOLE, 30, true, [disasterId.LAVA, disasterId.ACID, disasterId.FLOOD, disasterId.GREEN_ZONE, disasterId.BUTTON], 0],
    LAVA = [iconString(Icon.FIRE), "Rising Lava", disasterId.LAVA, 30, false, [disasterId.ACID_RAIN, disasterId.GREEN_ZONE, disasterId.GET_DOWN, disasterId.ACID, disasterId.FLOOD, disasterId.BLACK_HOLE, disasterId.BUTTON], 0],
    ACID = [iconString(Icon.POISON), "Rising Acid", disasterId.ACID, 30, false, [disasterId.ACID_RAIN, disasterId.GREEN_ZONE, disasterId.GET_DOWN, disasterId.LAVA, disasterId.FLOOD, disasterId.BLACK_HOLE, disasterId.BUTTON], 0],
    SNIPER = [abilityIconString(Hero.WIDOWMAKER, Button.ULTIMATE), "Snipers", disasterId.SNIPER, 30, true, [], 2],
    BOMBS = [abilityIconString(Hero.PHARAH, Button.ABILITY_2), "Bombers", disasterId.BOMBS, 25, true, [disasterId.FLOOD, disasterId.GREEN_ZONE], 0],
    FAKE_BP = [abilityIconString(Hero.ECHO, Button.SECONDARY_FIRE), "Free Battle Pass XP", disasterId.FAKE_BP, 30, true, [disasterId.BLACK_HOLE, disasterId.GREEN_ZONE, disasterId.ACID, disasterId.FLOOD, disasterId.LAVA, disasterId.BUTTON], 0],
    WISP = [abilityIconString(Hero.TRACER, Button.ULTIMATE), "Will-o'-wisp", disasterId.WISP, 30, true, [], 1],

enum bossDisasters:
    WITCH = [abilityIconString(Hero.ASHE, Button.ABILITY_2), "Witch", bossDisasterId.WITCH, 60, true, [], 1],
    
enum botFlags:
    RESPAWNABLE_NO_LOS

#!define getDisasterId(disaster) disaster[disasterData.ID]

#!define addDisasterToQueue(disaster) \
queuedDisasterId = disaster[disasterData.ID]\
queueDisaster()\

#!define addDisasterToQueueById(disasterId) \
queuedDisasterId = disasterId\
queueDisaster()\

#!define addDisaster(disaster) \
\
if activeDisasterEntityTypes + disaster[disasterData.BOT_TYPES] > 2: \
    return\
\
bigMessage(getAllPlayers(), "{0}  {1}   {0}".format(disaster[disasterData.ICON], disaster[disasterData.NAME]))\
activeDisasters.append(disaster[disasterData.ID])\
activeDisasterDuration = disaster[disasterData.DURATION]\
activeDisasterEntityTypes += disaster[disasterData.BOT_TYPES]\
if disaster[disasterData.BOT_TYPES] > 0: \
    activeDisasterEntitySpawning += 1\
disasterRespawnable = disaster[disasterData.RESPAWNABLE]\
blacklistedDisasters.append(disaster[disasterData.BLACKLIST])\

#!define cleanupDummyBots() \
for disasterIndex in range(0, getNumberOfPlayers(Team.2), 1): \
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATOR_DISAPPEAR, Team.2, getPlayersInSlot(disasterIndex, Team.2).getEyePosition(), 1)\
    playEffect(getAllPlayers(), DynamicEffect.SOMBRA_TRANSLOCATING_SOUND, Team.2, getPlayersInSlot(disasterIndex, Team.2).getEyePosition(), 25)\
    destroyDummy(Team.2, disasterIndex)\
    wait(0.016)\
\
if getNumberOfPlayers(Team.2) > 0: \
    destroyAllDummies()\
wait(0.016)\

#!define cleanupDisasterEffects() \
for disasterIndex in range(0, len(activeDisasterEffects), 1): \
    destroyEffect(activeDisasterEffects[disasterIndex])\
    destroyIcon(activeDisasterEffects[disasterIndex])\
    wait(0.016)\
\
activeDisasterEffects = []\
wait(0.016)\

#!define cleanupDisasterPlayerEffects(player) \
for player.playerIndex in range(0, len(player.activeDisasterPlayerEffects), 1): \
    destroyEffect(player.activeDisasterPlayerEffects[player.playerIndex])\
    destroyIcon(activeDisasterEffects[disasterIndex])\
    wait(0.016)\
\
player.activeDisasterPlayerEffects = []\
wait(0.016)\

#!define cleanupDisasterTexts() \
for disasterIndex in range(0, len(activeDisasterTexts), 1): \
    destroyInWorldText(activeDisasterTexts[disasterIndex])\
    wait(0.016)\
\
activeDisasterTexts = []\
wait(0.016)\

#!define allocateEffect() \
activeDisasterEffects.append(getLastCreatedEntity())\
wait(0.016)\

#!define allocatePlayerEffect(player) \
player.activeDisasterPlayerEffects.append(getLastCreatedEntity())\
wait(0.016)\

#!define allocateText() \
activeDisasterTexts.append(getLastCreatedText())\
wait(0.016)\

#!define allocateDummyBot() \
allocatedDummyBot = getLastCreatedEntity()\

#!define allocateDummyBotTag(tag) \
allocateDummyBot()\
wait(0.016)\
allocatedDummyBot.BOT_DISASTER_TAG = tag

#!define dummyBotLimit floor(WS_SETTING_MAX_BOTS / activeDisasterEntitySpawning)
#!define dummyBotSpawnAny(range) random.choice(getPlayersInMatch()).getPosition() + vect(random.randint(-range, range), sorted(getPlayersInMatch(), lambda player: player.getPosition().y).last().getPosition().y, random.randint(-range, range))
#!define dummyBotSpawnAnyHeight(range) vect(dummyBotSpawn(range).x, dummyBotSpawnAny(range).y, dummyBotSpawn(range).z)
#!define dummyBotSpawn(range) nearestWalkablePosition(dummyBotSpawnAny(range))

#!define waitForEntitySpawnFlag(disasterId) \
waitUntil(activeDisasters.index(disasterId) == entitySpawningIndex, 9999)

#!define applyEntityFlag(player, flag) \
player.BOT_DISASTER_FLAGS.append(flag)

#!define disasterPool [disasters.BOB[disasterData.ID], disasters.MINEFIELD[disasterData.ID], disasters.MOTHS[disasterData.ID], disasters.WIFELEAVER[disasterData.ID], disasters.ACID_RAIN[disasterData.ID], disasters.SOMBRA[disasterData.ID], disasters.WINTON[disasterData.ID], disasters.KAME[disasterData.ID], disasters.FLOOD[disasterData.ID], disasters.MYSTERY[disasterData.ID], disasters.GET_DOWN[disasterData.ID], disasters.GREEN_ZONE[disasterData.ID], disasters.MURDERERS[disasterData.ID], disasters.NULL_SECTOR[disasterData.ID], disasters.TALON[disasterData.ID], disasters.BUTTON[disasterData.ID], disasters.NINJA[disasterData.ID], disasters.COPYCAT[disasterData.ID], disasters.BLACK_HOLE[disasterData.ID], disasters.LAVA[disasterData.ID], disasters.ACID[disasterData.ID], disasters.SNIPER[disasterData.ID], disasters.BOMBS[disasterData.ID]]

subroutine queueDisaster
subroutine cleanupDisaster
subroutine selectDisaster
subroutine selectMultipleDisasters
subroutine queueDisasterEntities

globalvar selectedDisaster = 0
globalvar queuedDisasterId = 0
globalvar activeDisasters = []
globalvar activeDisasterTexts = []
globalvar activeDisasterEffects = []
globalvar activeDisasterDuration = 0
globalvar activeDisasterEntityTypes = 0
globalvar activeDisasterEntitySpawning = 0
globalvar allocatedDummyBot = null
globalvar entitySpawningIndex = 0
globalvar blacklistedDisasters = []
globalvar disastersAlreadyPlayed = []
globalvar disasterIndex = 0
globalvar disasterReady = false
globalvar disasterRespawnable = true
globalvar multipleDisastersMax = 1

playervar activeDisasterPlayerEffects = []
playervar BOT_DISASTER_TAG = ""
playervar BOT_DISASTER_FLAGS = []

#!include "events/moth.opy"
#!include "events/wife.opy"
#!include "events/minefield.opy"
#!include "events/bob.opy"
#!include "events/simon.opy"
#!include "events/acid_rain.opy"
#!include "events/sombra.opy"
#!include "events/winton.opy"
#!include "events/kamehameha.opy"
#!include "events/floods/main.opy"
#!include "events/mystery.opy"
#!include "events/get_down.opy"
#!include "events/green_zone.opy"
#!include "events/murderers.opy"
#!include "events/null_sector.opy"
#!include "events/talon.opy"
#!include "events/button.opy"
#!include "events/ninja.opy"
#!include "events/copycat.opy"
#!include "events/black_hole.opy"
#!include "events/sniper.opy"
#!include "events/bombs.opy"
#!include "events/fake_bp.opy"
#!include "events/wisp.opy"

def queueDisaster():
    @Name "[events/main.opy] Queue Disaster"

    switch (queuedDisasterId):
        case disasters.MOTHS[disasterData.ID]:
            addDisaster(disasters.MOTHS)
            break
        case disasters.WIFELEAVER[disasterData.ID]:
            addDisaster(disasters.WIFELEAVER)
            break
        case disasters.MINEFIELD[disasterData.ID]:
            addDisaster(disasters.MINEFIELD)
            break
        case disasters.BOB[disasterData.ID]:
            addDisaster(disasters.BOB)
            break
        case disasters.SIMON[disasterData.ID]:
            addDisaster(disasters.SIMON)
            break
        case disasters.ACID_RAIN[disasterData.ID]:
            addDisaster(disasters.ACID_RAIN)
            break
        case disasters.SOMBRA[disasterData.ID]:
            addDisaster(disasters.SOMBRA)
            break
        case disasters.WINTON[disasterData.ID]:
            addDisaster(disasters.WINTON)
            break
        case disasters.KAME[disasterData.ID]:
            addDisaster(disasters.KAME)
            break
        case disasters.FLOOD[disasterData.ID]:
            addDisaster(disasters.FLOOD)
            break
        case disasters.MYSTERY[disasterData.ID]:
            addDisaster(disasters.MYSTERY)
            break
        case disasters.GET_DOWN[disasterData.ID]:
            addDisaster(disasters.GET_DOWN)
            break
        case disasters.DEATH_TRAMPOLINE[disasterData.ID]:
            addDisaster(disasters.DEATH_TRAMPOLINE)
            break
        case disasters.GREEN_ZONE[disasterData.ID]:
            addDisaster(disasters.GREEN_ZONE)
            break
        case disasters.MURDERERS[disasterData.ID]:
            addDisaster(disasters.MURDERERS)
            break
        case disasters.NULL_SECTOR[disasterData.ID]:
            addDisaster(disasters.NULL_SECTOR)
            break
        case disasters.TALON[disasterData.ID]:
            addDisaster(disasters.TALON)
            break
        case disasters.BUTTON[disasterData.ID]:
            addDisaster(disasters.BUTTON)
            break
        case disasters.NINJA[disasterData.ID]:
            addDisaster(disasters.NINJA)
            break
        case disasters.COPYCAT[disasterData.ID]:
            addDisaster(disasters.COPYCAT)
            break
        case disasters.BLACK_HOLE[disasterData.ID]:
            addDisaster(disasters.BLACK_HOLE)
            break
        case disasters.LAVA[disasterData.ID]:
            addDisaster(disasters.LAVA)
            break
        case disasters.ACID[disasterData.ID]:
            addDisaster(disasters.ACID)
            break
        case disasters.SNIPER[disasterData.ID]:
            addDisaster(disasters.SNIPER)
            break
        case disasters.BOMBS[disasterData.ID]:
            addDisaster(disasters.BOMBS)
            break
        case disasters.FAKE_BP[disasterData.ID]:
            addDisaster(disasters.FAKE_BP)
            break
        case disasters.WISP[disasterData.ID]:
            addDisaster(disasters.WISP)
            break

def selectDisaster():
    disasterReady = false

    if len(disastersAlreadyPlayed) == len(disasterPool):
        disastersAlreadyPlayed = []
    
    selectedDisaster = random.choice(disasterPool.exclude(disastersAlreadyPlayed).exclude(blacklistedDisasters))
    addDisasterToQueueById(selectedDisaster)
    disastersAlreadyPlayed.append(selectedDisaster)
    
    wait(3)

    disasterReady = true
    displayDisaster()
    queueDisasterEntities()

def selectMultipleDisasters():
    disasterReady = false
    disasterTypeShown = true

    multipleDisastersMax = random.randint(2, 3)
    disasterTypeDescription = "Triple Threat" if multipleDisastersMax == 3 else "Double Trouble"
    disasterTypeColor = Color.RED

    # Reset disastersAlreadyPlayed when we went through every disaster
    if len(disastersAlreadyPlayed) == len(disasterPool):
        disastersAlreadyPlayed = []

    # Add disasters that have not already been selected
    while len(activeDisasters) < multipleDisastersMax:
        # Reset disastersAlreadyPlayed when we went through every disaster
        if len(disastersAlreadyPlayed) == len(disasterPool):
            disastersAlreadyPlayed = []
        
        selectedDisaster = random.choice(disasterPool.exclude(disastersAlreadyPlayed).exclude(blacklistedDisasters).exclude(activeDisasters).exclude([disasters.MYSTERY[disasterData.ID]]))

        # If no disaster is available, assume we went through all of them and reset
        if selectedDisaster == null:
            disastersAlreadyPlayed = []

        disastersAlreadyPlayed.append(selectedDisaster)

        addDisasterToQueueById(selectedDisaster)
        wait(0.5)

    disasterRespawnable = false
    activeDisasterDuration = 30
    
    wait(3)

    disasterReady = true
    disasterTypeShown = false
    displayDisaster()
    queueDisasterEntities()

def queueDisasterEntities():
    for entitySpawningIndex in range(0, len(activeDisasters), 1):
        wait(1)

def cleanupDisaster():
    @Name "[events/main.opy] Cleanup Disaster"

    cleanupDummyBots()
    cleanupDisasterEffects()
    cleanupDisasterTexts()
    activeDisasters = []
    blacklistedDisasters = []
    objectiveDescription = ""
    disasterReady = false
    disasterRespawnable = true
    disasterTypeShown = false
    disasterTypeColor = Color.WHITE
    disasterTypeDescription = ""
    activeDisasterEntityTypes = 0
    activeDisasterEntitySpawning = 0
    entitySpawningIndex = 0
    getDeadPlayers(Team.1).respawn()
    getAllPlayers().enableRespawn()

rule "[events/main.opy] Disable Respawning":
    @Event playerDied
    @Team 1
    @Condition disasterRespawnable == false

    eventPlayer.disableRespawn()