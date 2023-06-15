#!mainFile "../../main.opy"

globalvar FLOOD_TIME

#!define getFloodDamageBonus() (getTotalTimeElapsed() - FLOOD_TIME) * 2
#!define playerIsBelowWaterLevel(player, variable, offset) variable > player.getPosition().y + offset
#!define getGroundLevel() sorted([position.getPosition().y for position in getSpawnPoints(Team.ALL)])[0] - 1.5
#!define getHighestLevel() sorted([position.getPosition().y for position in getSpawnPoints(Team.ALL)]).last() - 1.5

#!include "events/floods/flood.opy"
#!include "events/floods/lava.opy"
#!include "events/floods/acid.opy"