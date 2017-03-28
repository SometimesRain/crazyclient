package kabam.rotmg.assets {
import kabam.rotmg.assets.services.CharacterFactory;
import kabam.rotmg.assets.services.IconFactory;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class AssetsConfig implements IConfig {

    [Inject]
    public var injector:Injector;


    public function configure():void {
        this.injector.map(CharacterFactory).asSingleton();
        this.injector.map(IconFactory).asSingleton();
    }


}
}//package kabam.rotmg.assets
