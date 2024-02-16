enum MatchRestartBehavior:
    DO_NOTHING,
    AFTER_VICTORY,
	AFTER_VICTORY_POSE,
    AFTER_POTG

globalvar DesiredMatchRestartBehavior = createWorkshopSetting(enum["Do Nothing", "After Victory Screen", "After Victory Pose", "After Play of the Game"], "General", "Restart Match", 3, 0)

rule "Restart Match":
    @Condition isMatchComplete()
    @Delimiter

    switch getCurrentGamemode():
        case Gamemode.FFA:
            wait([9999, 3.25, 30.5, 20.5][[MatchRestartBehavior.DO_NOTHING, MatchRestartBehavior.AFTER_VICTORY, MatchRestartBehavior.AFTER_POTG].index(DesiredMatchRestartBehavior)])
            restartMatch()
            break
        default:
            wait([9999, 3.25, 8.5, 26][[MatchRestartBehavior.DO_NOTHING, MatchRestartBehavior.AFTER_VICTORY, MatchRestartBehavior.AFTER_VICTORY_POSE, MatchRestartBehavior.AFTER_POTG].index(DesiredMatchRestartBehavior)])
            restartMatch()
            break