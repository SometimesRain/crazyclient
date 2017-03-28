package kabam.rotmg.protip {
import kabam.rotmg.protip.commands.ShowProTipCommand;
import kabam.rotmg.protip.model.EmbeddedProTipModel;
import kabam.rotmg.protip.model.IProTipModel;
import kabam.rotmg.protip.signals.ShowProTipSignal;
import kabam.rotmg.protip.view.ProTipView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class ProTipConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var commandMap:ISignalCommandMap;


    public function configure():void {
        this.injector.map(ProTipView).asSingleton();
        this.injector.map(IProTipModel).toSingleton(EmbeddedProTipModel);
        this.commandMap.map(ShowProTipSignal).toCommand(ShowProTipCommand);
    }


}
}//package kabam.rotmg.protip
