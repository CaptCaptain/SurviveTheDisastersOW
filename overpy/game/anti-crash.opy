#!mainFile "../main.opy"

#Global variables

globalvar antiCrashActivated


rule "anti crash":
    @Condition antiCrashActivated == false
    @Condition getServerLoad() >= 255
    
    wait(WS_SETTING_ANTI_CRASH_DELAY, Wait.ABORT_WHEN_FALSE)
    fixedSmallMessageWithIcon(getAllPlayers(), iconString(Icon.WARNING), "Server experiencing instability")
    #setSlowMotion(10)
    antiCrashActivated = true

rule "disable anti crash":
    @Condition antiCrashActivated == true

    while getServerLoad() > 200:
        if getNumberOfPlayers(Team.2) > 5 and selectedDangerMode != dangerMode.BOSS_HUNT:
            if getNumberOfDeadPlayers(Team.1) > 0:
                destroyDummy(Team.2, random.choice(getDeadPlayers(Team.2)).getSlot())
            else:
                destroyDummy(Team.2, random.choice(getPlayers(Team.2)).getSlot())
                
        waitUntil(getServerLoad() < 200, 1)
        wait(0.016)
    
    #setSlowMotion(100)
    antiCrashActivated = false