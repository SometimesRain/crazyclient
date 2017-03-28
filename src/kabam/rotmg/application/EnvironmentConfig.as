package kabam.rotmg.application {
import kabam.rotmg.application.model.DomainModel;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class EnvironmentConfig implements IConfig {

    [Inject]
    public var injector:Injector;


    public function configure():void {
        this.injector.map(DomainModel).asSingleton();
    }


}
}//package kabam.rotmg.application
