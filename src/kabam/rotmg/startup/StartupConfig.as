package kabam.rotmg.startup {
import kabam.rotmg.startup.control.StartupCommand;
import kabam.rotmg.startup.control.StartupSequence;
import kabam.rotmg.startup.control.StartupSignal;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class StartupConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.injector.map(StartupSequence).asSingleton();
        this.commandMap.map(StartupSignal).toCommand(StartupCommand);
    }


}
}//package kabam.rotmg.startup
