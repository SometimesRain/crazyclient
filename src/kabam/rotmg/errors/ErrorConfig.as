package kabam.rotmg.errors {
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.errors.control.ErrorSignal;
import kabam.rotmg.errors.control.LogErrorCommand;
import kabam.rotmg.errors.control.ReportErrorToAppEngineCommand;
import kabam.rotmg.errors.view.ErrorMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class ErrorConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var setup:ApplicationSetup;


    public function configure():void {
        this.mediatorMap.map(WebMain).toMediator(ErrorMediator);
        this.mapErrorCommand();
    }

    private function mapErrorCommand():void {
        if (this.setup.areErrorsReported()) {
            this.commandMap.map(ErrorSignal).toCommand(ReportErrorToAppEngineCommand);
        }
        else {
            this.commandMap.map(ErrorSignal).toCommand(LogErrorCommand);
        }
    }


}
}//package kabam.rotmg.errors
