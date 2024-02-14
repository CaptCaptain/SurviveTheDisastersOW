#!mainFile "../controller.opy"

globalvar PLAYER_IGNORE

subroutine EXECUTE_ALL_BEHAVIOR
subroutine UPDATE_BOT_TEAMMATE
subroutine UPDATE_BOT_TEAMMATE_DEFAULT
subroutine UPDATE_COMBAT_POSITION
subroutine UPDATE_SUPPORT_POSITION
subroutine RESET_TO_IDLE

subroutine PRESS_PRIMARY_FIRE
subroutine PRESS_SECONDARY_FIRE
subroutine PRESS_ABILITY_1
subroutine PRESS_ABILITY_2
subroutine PRESS_ULTIMATE_ABILITY
subroutine PRESS_ABILITY_CONFIRM

subroutine EXECUTE_DEFENSE_ABILITY_1
subroutine EXECUTE_DEFENSE_ABILITY_2
subroutine EXECUTE_OFFENSE_ABILITY_1
subroutine EXECUTE_OFFENSE_ABILITY_2
subroutine EXECUTE_ULTIMATE_ABILITY
subroutine EXECUTE_ULTIMATE_PLACEMENT
subroutine EXECUTE_ATTACK_BASED_ON_RANGE
subroutine EXECUTE_SCOPING
subroutine EXECUTE_ULTIMATE_DEFLECT

subroutine EXECUTE_PATHFIND

playervar BOT_PLAYER
playervar TEMP_BOT_PLAYER
playervar BOT_TEAMMATE
playervar DEFLECT_BUTTON
playervar OFFENSE_ABILITY_THRESHOLD = 0.5
playervar DEFENSE_ABILITY_THRESHOLD = 0.5

#!define GET_G_COST(starting_node, current_node) distance(current_node, starting_node)
#!define GET_H_COST(end_node, current_node) distance(current_node, end_node)
#!define GET_F_COST(g_cost, f_cost) g_cost + f_cost
#!define ROUND_VECTOR(vector) vect(round(vector.x), round(vector.y), round(vector.z))
#!define NODE(offset, multiplier) vect(round(eventPlayer.getPosition().x), round(eventPlayer.getPosition().y), round(eventPlayer.getPosition().z)) + Vector.UP + (offset * multiplier)

playervar NODE_LIST
playervar NODE_EXCLUSION_LIST = []
playervar STARTING_NODE
playervar ENDING_NODE
playervar SELECTED_NODE
playervar NODE_INDEX

#Player variables

/*
playervar i 115
playervar params 116
playervar END 117
playervar START 118
playervar for2 119
playervar for1 120
playervar Height1 121
playervar direction 122
playervar Libra 123
playervar Height2 124
playervar local_distance 125
playervar distance 126
playervar matrix 127

def EXECUTE_PATHFIND():
    @Name "A*"
    
    disableInspector()
    if eventPlayer.params != 0:
        goto lbl_0
    eventPlayer.params = [createWorkshopSetting(float[1:20], "a*", "matrix size", 6, 1), createWorkshopSetting(float[0:20], "a*", "num(/)", 0.4, 2), createWorkshopSetting(int[1:50], "a*", "count of operation", 5, 3), createWorkshopSetting(bool, "a*", "nearst walkable position of matrix", true, 4), createWorkshopSetting(bool, "a*", "nearst walkable position of final libra", false, 5), createWorkshopSetting(float[0:5], "a*", "chaos of the size and shape of the matrix", 0.5, 6), createWorkshopSetting(float[0:10], "a*", "chaos of computing", 1, 7), createWorkshopSetting(float[1:5], "a*", "data update time per second", 2, 8)]
    lbl_0:
    eventPlayer.matrix = []
    eventPlayer.direction = []
    eventPlayer.Height1 = []
    eventPlayer.Height2 = []
    eventPlayer.distance = []
    eventPlayer.local_distance = []
    eventPlayer.Libra = []
    for eventPlayer.i in range(1, eventPlayer.params[2] + 1):
        for eventPlayer.for1 in range(eventPlayer.params[0], (eventPlayer.params[0] + 1) * -1, eventPlayer.params[0] * -1):
            for eventPlayer.for2 in range(eventPlayer.params[0], (eventPlayer.params[0] + 1) * -1, eventPlayer.params[0] * -1):
                eventPlayer.matrix.append(eventPlayer.STARTING_NODE + vect(evalOnce(eventPlayer.for2), 0, evalOnce(eventPlayer.for1)))
        for eventPlayer.for1 in range(9 * eventPlayer.i - 9, 9 * eventPlayer.i):
            eventPlayer.matrix[eventPlayer.for1] = eventPlayer.matrix[eventPlayer.for1] + vect(random.uniform(eventPlayer.params[5] * -1, eventPlayer.params[5]), random.uniform(eventPlayer.params[5] * -1, eventPlayer.params[5]), random.uniform(eventPlayer.params[5] * -1, eventPlayer.params[5]))
        if eventPlayer.params[3] == true:
            for eventPlayer.for1 in range(9 * eventPlayer.i - 9, 9 * eventPlayer.i):
                eventPlayer.matrix[eventPlayer.for1] = nearestWalkablePosition(eventPlayer.matrix[eventPlayer.for1])
        for eventPlayer.for1 in range(9 * eventPlayer.i - 9, 9 * eventPlayer.i):
            eventPlayer.distance.append(distance(eventPlayer.ENDING_NODE, eventPlayer.matrix[eventPlayer.for1]))
            eventPlayer.Height1.append((sqrt((eventPlayer.getPosition().y - eventPlayer.matrix[eventPlayer.for1].y) ** 2)) * 1)
            eventPlayer.Height2.append((sqrt((eventPlayer.ENDING_NODE.y - eventPlayer.matrix[eventPlayer.for1].y) ** 2)) * 1)
        for eventPlayer.for1 in range(9 * eventPlayer.i - 9, 9 * eventPlayer.i):
            eventPlayer.local_distance.append(100000000 if len([player for player in eventPlayer.matrix if distance(eventPlayer.STARTING_NODE, player) < eventPlayer.params[1]]) > 9 or not isInLoS(eventPlayer.STARTING_NODE, eventPlayer.matrix[eventPlayer.for1], BarrierLos.PASS_THROUGH_BARRIERS) else distance(eventPlayer.ENDING_NODE, eventPlayer.matrix[eventPlayer.for1]) / 3 * -1 if isInLoS(eventPlayer.ENDING_NODE, eventPlayer.matrix[eventPlayer.for1], BarrierLos.PASS_THROUGH_BARRIERS) else distance(eventPlayer, eventPlayer.matrix[eventPlayer.for1]) / 4 * -1)
        for eventPlayer.for1 in range(9 * eventPlayer.i - 9, 9 * eventPlayer.i):
            eventPlayer.Libra.append(eventPlayer.distance[eventPlayer.for1] + eventPlayer.local_distance[eventPlayer.for1] + eventPlayer.Height2[eventPlayer.for1] + eventPlayer.Height1[eventPlayer.for1])
        for eventPlayer.for1 in range(9 * eventPlayer.i - 9, 9 * eventPlayer.i):
            eventPlayer.Libra[eventPlayer.for1] += random.uniform(eventPlayer.params[6] * -1, eventPlayer.params[6])
        eventPlayer.STARTING_NODE = eventPlayer.Libra[0]
        for eventPlayer.for1 in range(len(eventPlayer.Libra)):
            if eventPlayer.Libra[eventPlayer.for1] <= eventPlayer.STARTING_NODE:
                eventPlayer.STARTING_NODE = eventPlayer.Libra[eventPlayer.for1]
        eventPlayer.STARTING_NODE = eventPlayer.matrix[eventPlayer.Libra.index(eventPlayer.STARTING_NODE)]
        if eventPlayer.params[4] == true:
            eventPlayer.STARTING_NODE = nearestWalkablePosition(eventPlayer.STARTING_NODE)
        eventPlayer.direction.append(eventPlayer.STARTING_NODE)
        wait(random.uniform(0.1, 0.5))
        if isInLoS(eventPlayer.STARTING_NODE, eventPlayer.ENDING_NODE, BarrierLos.PASS_THROUGH_BARRIERS) and distance(eventPlayer.STARTING_NODE, eventPlayer.ENDING_NODE) < 5:
            goto lbl_1
    lbl_1:
    enableInspector()
    waitUntil(len(eventPlayer.direction) == 0 or eventPlayer.isDead(), eventPlayer.params[7])
    wait(random.uniform(0.1, 0.5))
*/
def EXECUTE_PATHFIND():
    eventPlayer.NODE_LIST = [
        NODE(Vector.BACKWARD, 5),
        NODE(Vector.FORWARD, 5),
        NODE(Vector.LEFT, 5),
        NODE(Vector.RIGHT, 5),
        NODE(Vector.BACKWARD + Vector.LEFT, 5),
        NODE(Vector.BACKWARD + Vector.RIGHT, 5),
        NODE(Vector.FORWARD + Vector.LEFT, 5),
        NODE(Vector.FORWARD + Vector.RIGHT, 5)
    ]
    eventPlayer.NODE_LIST = [node for node in eventPlayer.NODE_LIST if isInLoS(eventPlayer.getEyePosition(), node, BarrierLos.PASS_THROUGH_BARRIERS) and node.y < eventPlayer.getEyePosition().y].exclude(eventPlayer.NODE_EXCLUSION_LIST)
    eventPlayer.NODE_LIST.append([nearestWalkablePosition(node) for node in eventPlayer.NODE_LIST])
    eventPlayer.SELECTED_NODE = sorted(eventPlayer.NODE_LIST, lambda node: GET_F_COST(GET_G_COST(eventPlayer.STARTING_NODE, node), GET_H_COST(eventPlayer.ENDING_NODE, node)))[0]
    eventPlayer.NODE_EXCLUSION_LIST.append(eventPlayer.SELECTED_NODE)
    eventPlayer.BOT_GOAL_POSITION = nearestWalkablePosition(eventPlayer.SELECTED_NODE)
    eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), vect(eventPlayer.BOT_GOAL_POSITION.x, eventPlayer.getEyePosition().y, eventPlayer.BOT_GOAL_POSITION.z)), 200, Relativity.TO_WORLD, FacingReeval.NONE)
    printLog("Executing pathfinding for {}".format(eventPlayer))

def PRESS_PRIMARY_FIRE():
    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
    wait()
    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false

def PRESS_SECONDARY_FIRE():
    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
    wait()
    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false

def PRESS_ABILITY_1():
    eventPlayer.BOT_ABILITY_1_ENABLED = true
    wait()
    eventPlayer.BOT_ABILITY_1_ENABLED = false

def PRESS_ABILITY_2():
    eventPlayer.BOT_ABILITY_2_ENABLED = true
    wait()
    eventPlayer.BOT_ABILITY_2_ENABLED = false

def PRESS_ULTIMATE_ABILITY():
    eventPlayer.BOT_ULTIMATE_ENABLED = true
    wait()
    eventPlayer.BOT_ULTIMATE_ENABLED = false

def PRESS_ABILITY_CONFIRM():
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)
    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false

def EXECUTE_ULTIMATE_DEFLECT():
    if any([(eventPlayer.BOT_PLAYER.getCurrentHero() == hero or eventPlayer.BOT_PLAYER.getHeroOfDuplication() == hero) and eventPlayer.BOT_PLAYER.getUltCharge() == 0 for hero in [Hero.ZARYA, Hero.TRACER, Hero.MEI, Hero.HANZO, Hero.ROADHOG, Hero.REAPER, Hero.PHARAH, Hero.SOLDIER, Hero.TORBJORN, Hero.MCCREE, Hero.BASTION]]):
        eventPlayer.startForcingButton(eventPlayer.DEFLECT_BUTTON)
    else:
        eventPlayer.stopForcingButton(eventPlayer.DEFLECT_BUTTON)

def EXECUTE_ULTIMATE_PLACEMENT():
    if eventPlayer.getUltCharge() == 100:
        eventPlayer.stopFacing()
        eventPlayer.setFacing(directionTowards(eventPlayer.getEyePosition(), eventPlayer.getPosition()), Relativity.TO_WORLD)
        PRESS_ULTIMATE_ABILITY()
        wait()
        PRESS_ABILITY_CONFIRM()

def EXECUTE_SCOPING():
    # Applies to heroes that can scope in
    if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) > 6 and eventPlayer.isInViewAngle(eventPlayer.BOT_PLAYER, 45):
        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true
    else:
        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false

def EXECUTE_ATTACK_BASED_ON_RANGE():
    # Applies to heroes that have two unique attacks
    if distance(eventPlayer.getPosition(), eventPlayer.BOT_PLAYER.getPosition()) < 12 and eventPlayer.isInViewAngle(eventPlayer.BOT_PLAYER, 45):
        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = true
        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
    else:
        eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
        eventPlayer.BOT_SECONDARY_FIRE_ENABLED = true

def EXECUTE_DEFENSE_ABILITY_1():
    if eventPlayer.getNormalizedHealth() < eventPlayer.DEFENSE_ABILITY_THRESHOLD:
        PRESS_ABILITY_1()

def EXECUTE_DEFENSE_ABILITY_2():
    if eventPlayer.getNormalizedHealth() < eventPlayer.DEFENSE_ABILITY_THRESHOLD:
        PRESS_ABILITY_2()

def EXECUTE_OFFENSE_ABILITY_1():
    if eventPlayer.BOT_PLAYER.getNormalizedHealth() < eventPlayer.OFFENSE_ABILITY_THRESHOLD and eventPlayer.isInViewAngle(eventPlayer.BOT_PLAYER, 45):
        PRESS_ABILITY_1()

def EXECUTE_OFFENSE_ABILITY_2():
    if eventPlayer.BOT_PLAYER.getNormalizedHealth() < eventPlayer.OFFENSE_ABILITY_THRESHOLD and eventPlayer.isInViewAngle(eventPlayer.BOT_PLAYER, 45):
        PRESS_ABILITY_2()

def EXECUTE_ULTIMATE_ABILITY():
    if eventPlayer.getUltCharge() == 100:
        PRESS_ULTIMATE_ABILITY()

def RESET_TO_IDLE():
    eventPlayer.BOT_PLAYER = false
    eventPlayer.BOT_OVERRIDE_FACING_PLAYER = false
    eventPlayer.BOT_GOAL_POSITION = null
    eventPlayer.stopFacing()
    eventPlayer.BOT_PRIMARY_FIRE_ENABLED = false
    eventPlayer.BOT_SECONDARY_FIRE_ENABLED = false
    eventPlayer.BOT_ABILITY_1_ENABLED = false
    eventPlayer.BOT_ABILITY_2_ENABLED = false
    eventPlayer.BOT_ULTIMATE_ENABLED = false
    eventPlayer.BOT_MELEE_ENABLED = false
    eventPlayer.BOT_JUMP_ENABLED = false
    eventPlayer.BOT_CROUCH_ENABLED = false
    eventPlayer.STARTING_NODE = null
    eventPlayer.ENDING_NODE = null
    eventPlayer.SELECTED_NODE = null
    eventPlayer.NODE_LIST = []
    eventPlayer.NODE_EXCLUSION_LIST = []
    eventPlayer.forceButtonPress(Button.RELOAD)

def UPDATE_COMBAT_POSITION():
    if eventPlayer.BOT_OVERRIDE_POSITION == true:
        return
    eventPlayer.BOT_GOAL_POSITION = nearestWalkablePosition(eventPlayer.BOT_PLAYER.getPosition() + (-vect(random.randint(-1, 1), random.randint(-1, 1), random.randint(-1, 1)) * BOT_POSITION_RANGE)) if nearestWalkablePosition(eventPlayer.getPosition()) != 0 else eventPlayer.BOT_PLAYER.getPosition() + (-vect(random.randint(-1, 1), random.randint(-1, 1), random.randint(-1, 1)) * BOT_POSITION_RANGE)
    waitUntil(eventPlayer.BOT_GOAL_POSITION == null, BOT_POSITION_UPDATE_RATE)

def UPDATE_SUPPORT_POSITION():
    if eventPlayer.BOT_OVERRIDE_POSITION == true:
        return
    eventPlayer.BOT_GOAL_POSITION = nearestWalkablePosition(worldVector(eventPlayer.getThrottle() + vect(0, 0, -3), eventPlayer.BOT_OVERRIDE_FACING_PLAYER, Transform.ROTATION_AND_TRANSLATION))
    waitUntil(eventPlayer.BOT_GOAL_POSITION == null, 1)

def UPDATE_BOT_TEAMMATE_DEFAULT():
    if getCurrentGamemode() == Gamemode.FFA: return
    eventPlayer.BOT_TEAMMATE = sorted(getPlayersInRadius(eventPlayer.getEyePosition(), 1000, eventPlayer.getTeam(), LosCheck.SURFACES).exclude(eventPlayer), lambda player: player.getNormalizedHealth())

def UPDATE_BOT_TEAMMATE():
    UPDATE_BOT_TEAMMATE_DEFAULT()
    eventPlayer.BOT_TEAMMATE = eventPlayer.BOT_TEAMMATE.exclude(getDeadPlayers(Team.ALL)).exclude([player for player in getAllPlayers() if player.getNormalizedHealth() > 0.5])

    eventPlayer.BOT_OVERRIDE_FACING_PLAYER = eventPlayer.BOT_TEAMMATE[0] if eventPlayer.BOT_TEAMMATE[0] else null

def EXECUTE_ALL_BEHAVIOR():
	waitUntil(eventPlayer.isAlive(), waitDelayCalculation)

    if entityExists(eventPlayer.BOT_PLAYER) or entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
        # Make bot face the target player
        eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), (eventPlayer.BOT_PLAYER.getEyePosition() if not eventPlayer.BOT_PLAYER.hasStatusEffect(Status.KNOCKED_DOWN) and not eventPlayer.BOT_PLAYER.hasStatusEffect(Status.ASLEEP) and not (eventPlayer.BOT_PLAYER.getCurrentHero() == Hero.HAMMOND and eventPlayer.BOT_PLAYER.isInAlternateForm()) else eventPlayer.BOT_PLAYER.getPosition()) if not entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER) else eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getEyePosition() if not (eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getCurrentHero() == Hero.HAMMOND and eventPlayer.BOT_OVERRIDE_FACING_PLAYER.isInAlternateForm()) else eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getPosition()), BOT_TURN_RATE, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)

        if entityExists(eventPlayer.BOT_PLAYER) and eventPlayer.BOT_PLAYER.isAlive() and isInLoS(eventPlayer.getEyePosition(), eventPlayer.BOT_PLAYER, BarrierLos.PASS_THROUGH_BARRIERS):
            # Update the bot's goal position
            async(UPDATE_COMBAT_POSITION, AsyncBehavior.NOOP)
            # If target player is within range, make the bot melee
            eventPlayer.BOT_MELEE_ENABLED = true if distance(eventPlayer, eventPlayer.BOT_PLAYER) < 2 and eventPlayer.BOT_PLAYER.getHealth() <= 30 else false
            eventPlayer.BOT_CROUCH_ENABLED = true if random.randint(0, 5) == 0 and eventPlayer.BOT_CROUCH_SPAM else false
        else:
            if not entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER): RESET_TO_IDLE()
    else:
        eventPlayer.BOT_PLAYER = sorted(getPlayersInRadius(eventPlayer.getEyePosition(), 100, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), lambda player: distance(player, eventPlayer)).exclude(eventPlayer).exclude(getDeadPlayers(Team.ALL)).exclude(PLAYER_IGNORE)

        if eventPlayer.STARTING_NODE == null or eventPlayer.ENDING_NODE == null:
            eventPlayer.STARTING_NODE = eventPlayer.getPosition()
            eventPlayer.ENDING_NODE = sorted([player for player in getPlayersInRadius(eventPlayer, 500, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if player.isAlive()], lambda x: distance(eventPlayer, x)).exclude(eventPlayer)[0]
        else:
            if eventPlayer.BOT_GOAL_POSITION == null and entityExists(getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam()))):
                eventPlayer.STARTING_NODE = eventPlayer.getPosition()
                eventPlayer.ENDING_NODE = sorted([player for player in getPlayersInRadius(eventPlayer, 500, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if player.isAlive()], lambda x: distance(eventPlayer, x)).exclude(eventPlayer)[0]
                EXECUTE_PATHFIND()
            else:
                if not isInLoS(eventPlayer.getEyePosition(), eventPlayer.SELECTED_NODE, BarrierLos.PASS_THROUGH_BARRIERS):
                    eventPlayer.BOT_GOAL_POSITION = null


    /* switch entityExists(eventPlayer.BOT_PLAYER) or entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER):
        case true:
            # Make bot face the target player
            eventPlayer.startFacing(directionTowards(eventPlayer.getEyePosition(), (eventPlayer.BOT_PLAYER.getEyePosition() if not eventPlayer.BOT_PLAYER.hasStatusEffect(Status.KNOCKED_DOWN) and not eventPlayer.BOT_PLAYER.hasStatusEffect(Status.ASLEEP) and not (eventPlayer.BOT_PLAYER.getCurrentHero() == Hero.HAMMOND and eventPlayer.BOT_PLAYER.isInAlternateForm()) else eventPlayer.BOT_PLAYER.getPosition()) if not entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER) else eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getEyePosition() if not (eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getCurrentHero() == Hero.HAMMOND and eventPlayer.BOT_OVERRIDE_FACING_PLAYER.isInAlternateForm()) else eventPlayer.BOT_OVERRIDE_FACING_PLAYER.getPosition()), BOT_TURN_RATE, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
            #
            switch entityExists(eventPlayer.BOT_PLAYER) and eventPlayer.BOT_PLAYER.isAlive() and isInLoS(eventPlayer.getEyePosition(), eventPlayer.BOT_PLAYER, BarrierLos.PASS_THROUGH_BARRIERS):
                case true:
                    # Update the bot's goal position
                    async(UPDATE_COMBAT_POSITION, AsyncBehavior.NOOP)
                    # If target player is within range, make the bot melee
                    eventPlayer.BOT_MELEE_ENABLED = true if distance(eventPlayer, eventPlayer.BOT_PLAYER) < 2 and eventPlayer.BOT_PLAYER.getHealth() <= 30 else false
                    eventPlayer.BOT_CROUCH_ENABLED = true if random.randint(0, 5) == 0 and eventPlayer.BOT_CROUCH_SPAM else false
                    break
                default:
                    if not entityExists(eventPlayer.BOT_OVERRIDE_FACING_PLAYER): RESET_TO_IDLE()
                    break
            break
        default:
            eventPlayer.TEMP_BOT_PLAYER = sorted(getPlayersInRadius(eventPlayer.getEyePosition(), 100, getOppositeTeam(eventPlayer.getTeam()), LosCheck.SURFACES), lambda player: distance(player, eventPlayer))
            eventPlayer.TEMP_BOT_PLAYER.remove(eventPlayer)
            eventPlayer.TEMP_BOT_PLAYER.remove(getDeadPlayers(Team.ALL))
            eventPlayer.TEMP_BOT_PLAYER.remove([player for player in getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam())) if player.isUsingAbility1() and distance(player, eventPlayer) > 2.5])
            eventPlayer.BOT_PLAYER = eventPlayer.TEMP_BOT_PLAYER
            switch eventPlayer.STARTING_NODE == null or eventPlayer.ENDING_NODE == null:
                case true:
                    eventPlayer.STARTING_NODE = eventPlayer.getPosition()
                    eventPlayer.ENDING_NODE = sorted([player for player in getPlayersInRadius(eventPlayer, 500, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if player.isAlive()], lambda x: distance(eventPlayer, x)).exclude(eventPlayer)[0]
                    break
                case false:
                    switch eventPlayer.BOT_GOAL_POSITION == null and entityExists(getClosestPlayer(eventPlayer, getOppositeTeam(eventPlayer.getTeam()))):
                        case true:
                            eventPlayer.STARTING_NODE = eventPlayer.getPosition()
                            eventPlayer.ENDING_NODE = sorted([player for player in getPlayersInRadius(eventPlayer, 500, getOppositeTeam(eventPlayer.getTeam()), LosCheck.OFF) if player.isAlive()], lambda x: distance(eventPlayer, x)).exclude(eventPlayer)[0]
                            EXECUTE_PATHFIND()
                            break
                        case false:
                            if not isInLoS(eventPlayer.getEyePosition(), eventPlayer.SELECTED_NODE, BarrierLos.PASS_THROUGH_BARRIERS):
                                eventPlayer.BOT_GOAL_POSITION = null
                            break
                    break
            break */

rule "All Heroes":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition not isMatchComplete()

    if not eventPlayer.isDummy(): return
    waitUntil(not eventPlayer.BOT_DISABLE_AI, 9999)
    EXECUTE_ALL_BEHAVIOR()
    waitThrottle(Wait.IGNORE_CONDITION)
    if RULE_CONDITION:
        goto RULE_START

/*
rule "Delete line":
    @Disabled
    @Event eachPlayer
    @Condition not entityExists(eventPlayer.BOT_PLAYER)
    @Condition (distance(eventPlayer, eventPlayer.direction[0]) < 5 and (isInLoS(eventPlayer, eventPlayer.direction[1], BarrierLos.PASS_THROUGH_BARRIERS) if eventPlayer.direction[1] != [] else true)) == true
    @Condition eventPlayer.direction.last() != 0
    
    eventPlayer.direction = eventPlayer.direction.exclude(eventPlayer.direction[0])
    wait(random.uniform(0, 0.1))
    if RULE_CONDITION:
        goto RULE_START

rule "Start Walk":
    @Disabled
    @Event eachPlayer
    @Condition eventPlayer.STARTING_NODE != null
    @Condition eventPlayer.ENDING_NODE != null
    @Condition not entityExists(eventPlayer.BOT_PLAYER)
    @Condition eventPlayer.isDummy() == true
    
    eventPlayer.startThrottleInDirection(vectorTowards(eventPlayer, eventPlayer.direction[0]), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    eventPlayer.startFacing(vectorTowards(eventPlayer, eventPlayer.direction[0]), 100, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
    while eventPlayer.isAlive() and not entityExists(eventPlayer.BOT_PLAYER):
        eventPlayer.STARTING_NODE = eventPlayer.getEyePosition()
        EXECUTE_PATHFIND()
    eventPlayer.stopThrottleInDirection()
    eventPlayer.stopFacing()
*/

rule "Reset":
    @Event playerDied
    if not eventPlayer.isDummy(): return
    if eventPlayer.BOT_DISABLE_AI:
        return
    wait(3)
    if getCurrentGamemode() == Gamemode.FFA or getCurrentGamemode() == Gamemode.TDM: eventPlayer.forceButtonPress(Button.JUMP)
    waitUntil(eventPlayer.isAlive(), 7)
    RESET_TO_IDLE()