package kabam.rotmg.arena {
import kabam.rotmg.arena.control.ArenaDeathCommand;
import kabam.rotmg.arena.control.ArenaDeathSignal;
import kabam.rotmg.arena.control.ClearCurrentRunCommand;
import kabam.rotmg.arena.control.ImminentArenaWaveCommand;
import kabam.rotmg.arena.control.ImminentArenaWaveSignal;
import kabam.rotmg.arena.control.ReloadLeaderboard;
import kabam.rotmg.arena.model.ArenaLeaderboardModel;
import kabam.rotmg.arena.model.BestArenaRunModel;
import kabam.rotmg.arena.model.CurrentArenaRunModel;
import kabam.rotmg.arena.service.GetArenaLeaderboardTask;
import kabam.rotmg.arena.service.GetBestArenaRunTask;
import kabam.rotmg.arena.view.ArenaLeaderboard;
import kabam.rotmg.arena.view.ArenaLeaderboardListItem;
import kabam.rotmg.arena.view.ArenaLeaderboardListItemMediator;
import kabam.rotmg.arena.view.ArenaLeaderboardMediator;
import kabam.rotmg.arena.view.ArenaQueryPanel;
import kabam.rotmg.arena.view.ArenaQueryPanelMediator;
import kabam.rotmg.arena.view.ArenaTimer;
import kabam.rotmg.arena.view.ArenaTimerMediator;
import kabam.rotmg.arena.view.ArenaWaveCounter;
import kabam.rotmg.arena.view.ArenaWaveCounterMediator;
import kabam.rotmg.arena.view.BattleSummaryDialog;
import kabam.rotmg.arena.view.BattleSummaryDialogMediator;
import kabam.rotmg.arena.view.ContinueOrQuitDialog;
import kabam.rotmg.arena.view.ContinueOrQuitMediator;
import kabam.rotmg.arena.view.HostQueryDialog;
import kabam.rotmg.arena.view.HostQueryDialogMediator;
import kabam.rotmg.arena.view.ImminentWaveCountdownClock;
import kabam.rotmg.arena.view.ImminentWaveCountdownClockMediator;
import kabam.rotmg.game.signals.GameClosedSignal;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class ArenaConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var commandCenter:ICommandCenter;


    public function configure():void {
        this.injector.map(GetArenaLeaderboardTask);
        this.injector.map(GetBestArenaRunTask);
        this.injector.map(CurrentArenaRunModel).asSingleton();
        this.injector.map(BestArenaRunModel).asSingleton();
        this.injector.map(ReloadLeaderboard).asSingleton();
        this.injector.map(ArenaLeaderboardModel).asSingleton();
        this.commandMap.map(ArenaDeathSignal).toCommand(ArenaDeathCommand);
        this.commandMap.map(ImminentArenaWaveSignal).toCommand(ImminentArenaWaveCommand);
        this.commandMap.map(GameClosedSignal).toCommand(ClearCurrentRunCommand);
        this.mediatorMap.map(ContinueOrQuitDialog).toMediator(ContinueOrQuitMediator);
        this.mediatorMap.map(HostQueryDialog).toMediator(HostQueryDialogMediator);
        this.mediatorMap.map(ArenaQueryPanel).toMediator(ArenaQueryPanelMediator);
        this.mediatorMap.map(ArenaLeaderboard).toMediator(ArenaLeaderboardMediator);
        this.mediatorMap.map(ArenaLeaderboardListItem).toMediator(ArenaLeaderboardListItemMediator);
        this.mediatorMap.map(ImminentWaveCountdownClock).toMediator(ImminentWaveCountdownClockMediator);
        this.mediatorMap.map(ArenaTimer).toMediator(ArenaTimerMediator);
        this.mediatorMap.map(BattleSummaryDialog).toMediator(BattleSummaryDialogMediator);
        this.mediatorMap.map(ArenaWaveCounter).toMediator(ArenaWaveCounterMediator);
    }


}
}//package kabam.rotmg.arena
