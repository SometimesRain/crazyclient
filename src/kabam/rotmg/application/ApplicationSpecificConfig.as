package kabam.rotmg.application {
import kabam.lib.console.ConsoleExtension;
import kabam.rotmg.application.api.ApplicationSetup;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class ApplicationSpecificConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var applicationSetup:ApplicationSetup;


    public function configure():void {
        if (this.applicationSetup.isDebug()) {
            this.context.extend(ConsoleExtension);
        }
    }


}
}//package kabam.rotmg.application
