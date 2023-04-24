#!mainFile "../../main.opy"

#!define playerIsBelowWaterLevel(player, variable, offset) variable > player.getPosition().y + offset
#!define getGroundLevel() nearestWalkablePosition(vect(0, 0, 0) + (Vector.DOWN + 100)).y - 1.5

#!include "events/floods/flood.opy"
#!include "events/floods/lava.opy"
#!include "events/floods/acid.opy"