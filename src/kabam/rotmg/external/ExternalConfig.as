package kabam.rotmg.external {
import kabam.rotmg.external.command.MapExternalCallbacksCommand;
import kabam.rotmg.external.command.MapExternalCallbacksSignal;
import kabam.rotmg.external.command.RequestPlayerCreditsCommand;
import kabam.rotmg.external.command.RequestPlayerCreditsCompleteSignal;
import kabam.rotmg.external.command.RequestPlayerCreditsSignal;
import kabam.rotmg.external.service.ExternalServiceHelper;
import kabam.rotmg.external.service.RequestPlayerCreditsTask;
import kabam.rotmg.startup.control.StartupSequence;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class ExternalConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var startupSequence:StartupSequence;


    public function configure():void {
        this.injector.map(RequestPlayerCreditsTask);
        this.injector.map(ExternalServiceHelper).asSingleton();
        this.injector.map(RequestPlayerCreditsCompleteSignal).asSingleton();
        this.commandMap.map(RequestPlayerCreditsSignal).toCommand(RequestPlayerCreditsCommand);
        this.commandMap.map(MapExternalCallbacksSignal).toCommand(MapExternalCallbacksCommand);
        this.startupSequence.addSignal(MapExternalCallbacksSignal);
    }


}
}//package kabam.rotmg.external
