package kabam.rotmg.language.control {
import kabam.lib.console.signals.HideConsoleSignal;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.language.service.GetLanguageService;
import kabam.rotmg.ui.signals.ShowLoadingUISignal;

import org.swiftsuspenders.Injector;

public class SetLanguageCommand {

    [Inject]
    public var language:String;
    [Inject]
    public var model:LanguageModel;
    [Inject]
    public var loading:ShowLoadingUISignal;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var task:GetLanguageService;
    [Inject]
    public var reload:ReloadCurrentScreenSignal;
    [Inject]
    public var hideConsole:HideConsoleSignal;
    [Inject]
    public var monitor:TaskMonitor;


    public function execute():void {
        this.model.setLanguage(this.language);
        this.loading.dispatch();
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(this.task);
        _local_1.add(new DispatchSignalTask(this.reload));
        _local_1.add(new DispatchSignalTask(this.hideConsole));
        this.monitor.add(_local_1);
        _local_1.start();
    }


}
}//package kabam.rotmg.language.control
