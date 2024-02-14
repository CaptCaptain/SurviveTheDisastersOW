playervar BOT_PRIMARY_FIRE_ENABLED
playervar BOT_SECONDARY_FIRE_ENABLED
playervar BOT_ABILITY_1_ENABLED
playervar BOT_ABILITY_2_ENABLED
playervar BOT_ULTIMATE_ENABLED
playervar BOT_MELEE_ENABLED
playervar BOT_JUMP_ENABLED
playervar BOT_CROUCH_ENABLED
playervar BOT_GOAL_POSITION
playervar BOT_OVERRIDE_FACING_PLAYER
playervar BOT_OVERRIDE_POSITION
playervar BOT_DISABLE_AI = false
playervar BOT_CROUCH_SPAM = true

globalvar BOT_TURN_RATE = [200, 500, 1000][WS_DIFFICULTY]
globalvar BOT_RESPONSE_RATE = [2, 1, 0.3][WS_DIFFICULTY]
globalvar BOT_POSITION_UPDATE_RATE = [1, 0.5, 0.3][WS_DIFFICULTY]
globalvar BOT_POSITION_RANGE = [5, 10, 15][WS_DIFFICULTY]

# So we don't have to copy and paste this for every button we want to control
#!define UseButton(button, buttonVar) eventPlayer.startForcingButton(button)\
waitUntil(buttonVar == false, 9999)\
eventPlayer.stopForcingButton(button)\

#!define waitDelayCalculation ((getAverageServerLoad()) / 255) * BOT_RESPONSE_RATE

# waitThrottle pauses execution of the code for x seconds based on current server load
#!define waitThrottle(waitBehavior)\
wait(waitDelayCalculation, waitBehavior)\
wait(0.016)

rule "Use Primary Fire":
    @Event eachPlayer
    @Condition eventPlayer.BOT_PRIMARY_FIRE_ENABLED

    UseButton(Button.PRIMARY_FIRE, eventPlayer.BOT_PRIMARY_FIRE_ENABLED)
rule "Use Secondary Fire":
    @Event eachPlayer
    @Condition eventPlayer.BOT_SECONDARY_FIRE_ENABLED

    UseButton(Button.SECONDARY_FIRE, eventPlayer.BOT_SECONDARY_FIRE_ENABLED)
rule "Use Ability 1":
    @Event eachPlayer
    @Condition eventPlayer.BOT_ABILITY_1_ENABLED

    UseButton(Button.ABILITY_1, eventPlayer.BOT_ABILITY_1_ENABLED)
rule "Use Ability 2":
    @Event eachPlayer
    @Condition eventPlayer.BOT_ABILITY_2_ENABLED

    UseButton(Button.ABILITY_2, eventPlayer.BOT_ABILITY_2_ENABLED)
rule "Use Ultimate":
    @Event eachPlayer
    @Condition eventPlayer.BOT_ULTIMATE_ENABLED
    @Condition eventPlayer.getUltCharge() == 100

    UseButton(Button.ULTIMATE, eventPlayer.BOT_ULTIMATE_ENABLED)
rule "Use Melee":
    @Event eachPlayer
    @Condition eventPlayer.BOT_MELEE_ENABLED

    UseButton(Button.MELEE, eventPlayer.BOT_MELEE_ENABLED)
rule "Use Jump":
    @Event eachPlayer
    @Condition eventPlayer.BOT_JUMP_ENABLED

    UseButton(Button.JUMP, eventPlayer.BOT_JUMP_ENABLED)
rule "Use Crouch":
    @Event eachPlayer
    @Condition eventPlayer.BOT_CROUCH_ENABLED

    UseButton(Button.CROUCH, eventPlayer.BOT_CROUCH_ENABLED)

rule "Go To Goal":
    @Event eachPlayer
    @Condition eventPlayer.BOT_GOAL_POSITION != null

    # Move bot toward position
    eventPlayer.startThrottleInDirection(directionTowards(eventPlayer.getPosition(), eventPlayer.BOT_GOAL_POSITION), 1, Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)

    # Stop the bot from moving when they reach their destination
    waitUntil(distance(eventPlayer.getPosition(), eventPlayer.BOT_GOAL_POSITION) < 2 or eventPlayer.BOT_GOAL_POSITION == null, 5)
    eventPlayer.stopThrottleInDirection()
    eventPlayer.BOT_GOAL_POSITION = null

    wait()
    if RULE_CONDITION: goto RULE_START

rule "Jump Over Obstacle":
    @Event eachPlayer
    @Condition eventPlayer.isMoving()
    @Condition eventPlayer.getHorizontalSpeed() < 1 #1.92

    if eventPlayer.BOT_DISABLE_AI: return
    if not eventPlayer.isDummy(): return
    if eventPlayer.BOT_DISABLE_AI:
        return

    # Make the bot jump when blocked by an obstacle 
    eventPlayer.BOT_JUMP_ENABLED = true
    wait(2)
    eventPlayer.BOT_JUMP_ENABLED = false
    if RULE_CONDITION:
        goto RULE_START