#!mainFile "../main.opy"

enum botFlags:
    NULL,
    RESPAWNABLE_NO_LOS,
    BOSS,
    NO_DAMAGE_SCALING,

enum disasterFlags:
    NULL,
    HARDCORE

#!define getDisasterId(disaster) disaster[disasterData.ID]

#!define addDisasterToQueue(disaster) \
queuedDisasterId = disaster[disasterData.ID]\
queueDisaster()\

#!define addDisasterToQueueById(disasterId) \
queuedDisasterId = disasterId\
queueDisaster()\

#!define addDisaster(disaster) \
\
currentDisaster = disaster\
wait(0.064)\
addDisasterSub()\

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
    destroyProgressBarHud(activeDisasterTexts[disasterIndex])\
    wait(0.016)\
\
activeDisasterTexts = []\
wait(0.016)\

#!define cleanupDisasterPlayerTexts(player) \
for player.playerIndex in range(0, len(player.activeDisasterPlayerTexts), 1): \
    destroyInWorldText(player.activeDisasterPlayerTexts[player.playerIndex])\
    destroyProgressBarHud(player.activeDisasterPlayerTexts[player.playerIndex])\
    wait(0.016)\
\
player.activeDisasterPlayerEffects = []\
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

#!define allocatePlayerText(player) \
player.activeDisasterPlayerTexts.append(getLastCreatedText())\
wait(0.016)\

#!define allocateDummyBot() \
allocatedDummyBot = getLastCreatedEntity()\

#!define allocateDummyBotTag(tag) \
allocateDummyBot()\
wait(0.016)\
allocatedDummyBot.BOT_DISASTER_TAG = tag

#!define dummyBotLimit floor(WS_SETTING_MAX_BOTS / activeDisasterEntitySpawning)
#!define dummyBotSpawnAny(range) random.choice(getPlayersAlive()).getPosition() + vect(random.randint(-range, range), sorted(getPlayersInMatch(), lambda player: player.getPosition().y).last().getPosition().y, random.randint(-range, range))
#!define dummyBotSpawnAnyHeight(range) vect(dummyBotSpawn(range).x, dummyBotSpawnAny(range).y, dummyBotSpawn(range).z)
#!define dummyBotSpawn(range) random.choice([random.choice(dummyBotSpawnArray.exclude([spawn for spawn in dummyBotSpawnArray if len(getPlayersInRadius(spawn + Vector.UP, range, Team.1, LosCheck.OFF)) > max(5, (getNumberOfPlayers(Team.1) * 2))])), random.choice(dummyBotSpawnArray.exclude([spawn for spawn in dummyBotSpawnArray if len(getPlayersInRadius(spawn + Vector.UP, range, Team.1, LosCheck.SURFACES)) > max(5, (getNumberOfPlayers(Team.1) * 2))])), nearestWalkablePosition(dummyBotSpawnAny(range)), random.choice(getSpawnPoints(Team.ALL)).getPosition()].exclude([null, 0, vect(0, 0, 0), []]))

#!define getBossHealth() 500 + (len(getPlayersInMatch()) * 500)

#!define waitForEntitySpawnFlag(disasterId) \
waitUntil(activeDisasters.index(disasterId) == entitySpawningIndex, 9999)

#!define applyEntityFlag(player, flag) \
player.BOT_DISASTER_FLAGS.append(flag)

#!define cleanupDialogue() \
is_dialoguing = true \
wait(0.016) \
main_dialogue = null \
is_dialoguing = false \

globalvar disasterPool = [disasters.BOB[disasterData.ID], disasters.MINEFIELD[disasterData.ID], disasters.MOTHS[disasterData.ID], disasters.WIFELEAVER[disasterData.ID], disasters.ACID_RAIN[disasterData.ID], disasters.SOMBRA[disasterData.ID], disasters.WINTON[disasterData.ID], disasters.KAME[disasterData.ID], disasters.FLOOD[disasterData.ID], disasters.GET_DOWN[disasterData.ID], disasters.GREEN_ZONE[disasterData.ID], disasters.MURDERERS[disasterData.ID], disasters.NULL_SECTOR[disasterData.ID], disasters.TALON[disasterData.ID], disasters.BUTTON[disasterData.ID], disasters.NINJA[disasterData.ID], disasters.COPYCAT[disasterData.ID], disasters.BLACK_HOLE[disasterData.ID], disasters.LAVA[disasterData.ID], disasters.ACID[disasterData.ID], disasters.SNIPER[disasterData.ID], disasters.BOMBS[disasterData.ID], disasters.FAKE_BP[disasterData.ID], disasters.WISP[disasterData.ID], disasters.BLIZZARD[disasterData.ID], disasters.SIMON[disasterData.ID], disasters.WITCH[disasterData.ID], disasters.PHARAMERCY[disasterData.ID], disasters.TIKTOK[disasterData.ID], disasters.VISHKAR[disasterData.ID], disasters.NUCLEAR_BOMB[disasterData.ID], disasters.DEATH_TRAMPOLINE[disasterData.ID], disasters.CRUSADERS[disasterData.ID], disasters.FLYING_BASTION[disasterData.ID], disasters.COWBOY[disasterData.ID]]

globalvar bossDisasterPool = [getDisasterId(disasters.GALACTIC_SIGMA), getDisasterId(disasters.ZEUS), getDisasterId(disasters.ZEUS)]

globalvar hardcoreDisasterPool = [getDisasterId(disasters.NINJA), getDisasterId(disasters.SNIPER), getDisasterId(disasters.MOTHS), getDisasterId(disasters.TIKTOK), getDisasterId(disasters.PHARAMERCY), getDisasterId(disasters.VISHKAR), getDisasterId(disasters.NUCLEAR_BOMB), getDisasterId(disasters.WIFELEAVER), getDisasterId(disasters.MURDERERS), getDisasterId(disasters.WINTON), getDisasterId(disasters.KAME), getDisasterId(disasters.BLACK_HOLE), getDisasterId(disasters.BLIZZARD), getDisasterId(disasters.FLYING_BASTION), disasters.COWBOY[disasterData.ID]]

subroutine queueDisaster
subroutine cleanupDisaster
subroutine selectDisaster
subroutine selectBossDisaster
subroutine selectHardcoreDisaster
subroutine selectMultipleDisasters
subroutine queueDisasterEntities

globalvar selectedDisaster = 0
globalvar queuedDisasterId = 0
globalvar activeDisasterFlags = []
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

globalvar tempDummyBotSpawnArray = []
globalvar dummyBotSpawnArray = []

playervar activeDisasterPlayerEffects = []
playervar activeDisasterPlayerTexts = []
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
#!include "events/blizzard.opy"
#!include "events/witch.opy"
#!include "events/tiktok.opy"
#!include "events/pharamercy.opy"
#!include "events/vishkar.opy"
#!include "events/death_trampoline.opy"
#!include "events/nuclear_bomb.opy"
#!include "events/crusaders.opy"
#!include "events/bastion.opy"
#!include "events/cowboy.opy"
#!include "events/junkers.opy"
#!include "events/bosses/galactic_sigma.opy"
#!include "events/bosses/zeus.opy"
#!include "events/bosses/orisa.opy"

subroutine addDisasterSub
globalvar currentDisaster
def addDisasterSub():
    if activeDisasterEntityTypes + currentDisaster[disasterData.BOT_TYPES] > 2:
        return
    bigMessage(getAllPlayers(), "{0}  {1}   {0}".format(currentDisaster[disasterData.ICON], currentDisaster[disasterData.NAME]))
    activeDisasters.append(currentDisaster[disasterData.ID])
    activeDisasterDuration = currentDisaster[disasterData.DURATION]
    activeDisasterEntityTypes += currentDisaster[disasterData.BOT_TYPES]
    if currentDisaster[disasterData.BOT_TYPES] > 0:
        activeDisasterEntitySpawning += 1
    disasterRespawnable = currentDisaster[disasterData.RESPAWNABLE] if disasterRespawnable else false
    blacklistedDisasters.append(currentDisaster[disasterData.BLACKLIST])

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
        case disasters.BLIZZARD[disasterData.ID]:
            addDisaster(disasters.BLIZZARD)
            break
        case disasters.WITCH[disasterData.ID]:
            addDisaster(disasters.WITCH)
            break
        case disasters.TIKTOK[disasterData.ID]:
            addDisaster(disasters.TIKTOK)
            break
        case disasters.PHARAMERCY[disasterData.ID]:
            addDisaster(disasters.PHARAMERCY)
            break
        case disasters.GALACTIC_SIGMA[disasterData.ID]:
            addDisaster(disasters.GALACTIC_SIGMA)
            break
        case disasters.VISHKAR[disasterData.ID]:
            addDisaster(disasters.VISHKAR)
            break
        case disasters.ZEUS[disasterData.ID]:
            addDisaster(disasters.ZEUS)
            break
        case disasters.NUCLEAR_BOMB[disasterData.ID]:
            addDisaster(disasters.NUCLEAR_BOMB)
            break
        case disasters.CRUSADERS[disasterData.ID]:
            addDisaster(disasters.CRUSADERS)
            break
        case disasters.ORISA_DEFENDER[disasterData.ID]:
            addDisaster(disasters.ORISA_DEFENDER)
            break
        case disasters.FLYING_BASTION[disasterData.ID]:
            addDisaster(disasters.FLYING_BASTION)
            break
        case disasters.COWBOY[disasterData.ID]:
            addDisaster(disasters.COWBOY)
            break
        case disasters.JUNKERS[disasterData.ID]:
            addDisaster(disasters.JUNKERS)
            break

def selectDisaster():
    disasterReady = false
    
    while selectedDisaster == null:
        selectedDisaster = random.choice(disasterPool.exclude(disastersAlreadyPlayed).exclude(blacklistedDisasters))
        addDisasterToQueueById(selectedDisaster)
        disastersAlreadyPlayed.append(selectedDisaster)

        if selectedDisaster == null:
            disastersAlreadyPlayed = []
            wait(0.016)
            continue

        wait(0.016)
    
    wait(3)

    disasterReady = true
    displayDisaster()
    queueDisasterEntities()

def selectBossDisaster():
    disasterReady = false
    disasterTypeShown = true

    disasterTypeDescription = "Boss Hunt"
    disasterTypeColor = Color.ORANGE
    
    selectedDisaster = random.choice(bossDisasterPool)
    addDisasterToQueueById(selectedDisaster)
    disastersAlreadyPlayed.append(selectedDisaster)
    
    wait(3)

    disasterReady = true
    disasterTypeShown = false
    displayDisaster()
    queueDisasterEntities()

def selectHardcoreDisaster():
    disasterReady = false
    disasterTypeShown = true

    disasterTypeDescription = "Hardcore"
    disasterTypeColor = Color.ROSE
    
    selectedDisaster = random.choice(hardcoreDisasterPool)
    addDisasterToQueueById(selectedDisaster)
    disastersAlreadyPlayed.append(selectedDisaster)
    activeDisasterFlags.append(disasterFlags.HARDCORE)

    for globalIndex in range(0, WS_SETTING_MAX_BOTS, 1):
        createEffect(getAllPlayers(), Effect.WINSTON_PRIMAL_RAGE, Team.2, getPlayersInSlot(evalOnce(globalIndex), Team.2), evalOnce(1), EffectReeval.VISIBILITY_POSITION_AND_RADIUS)
        allocateEffect()
    
    wait(3)

    disasterReady = true
    disasterTypeShown = false
    displayDisaster()
    queueDisasterEntities()

def selectMultipleDisasters():
    disasterReady = false
    disasterTypeShown = true

    multipleDisastersMax = random.randint(2, 3)
    disasterTypeDescription = "Triple Threat" if multipleDisastersMax == 3 else "Double Trouble"
    disasterTypeColor = Color.RED

    # Add disasters that have not already been selected
    while len(activeDisasters) < multipleDisastersMax:        
        selectedDisaster = random.choice(disasterPool.exclude(disastersAlreadyPlayed).exclude(blacklistedDisasters).exclude(activeDisasters).exclude([getDisasterId(disasters.MYSTERY), getDisasterId(disasters.SIMON)]))

        # If no disaster is available, assume we went through all of them and reset
        if selectedDisaster == null:
            disastersAlreadyPlayed = []
            wait(0.016)
            continue

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

    disasterReady = false
    cleanupDummyBots()
    cleanupDisasterEffects()
    cleanupDisasterTexts()
    cleanupDialogue()
    activeDisasters = []
    activeDisasterFlags = []
    blacklistedDisasters = []
    selectedDisaster = null
    objectiveDescription = ""
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