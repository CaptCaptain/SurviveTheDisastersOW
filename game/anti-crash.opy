#!mainFile "../main.opy"

#Global variables

globalvar antiCrashActivated


rule "anti crash":
    @Condition antiCrashActivated == false
    @Condition getServerLoad() >= 255
    
    wait(WS_SETTING_ANTI_CRASH_DELAY, Wait.ABORT_WHEN_FALSE)
    fixedSmallMessageWithIcon(getAllPlayers(), iconString(Icon.WARNING), "Server experiencing instability")
    setSlowMotion(10)
    antiCrashActivated = true


rule "disable anti crash":
    @Condition antiCrashActivated == true
    @Condition getServerLoad() < 200
    
    setSlowMotion(100)
    antiCrashActivated = false


