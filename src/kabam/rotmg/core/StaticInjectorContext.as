package kabam.rotmg.core {
import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.impl.Context;

public class StaticInjectorContext extends Context {

    public static var injector:Injector;

    public function StaticInjectorContext() {
        if (!StaticInjectorContext.injector) {
            StaticInjectorContext.injector = this.injector;
        }
    }

    public static function getInjector():Injector {
        return (injector);
    }


}
}//package kabam.rotmg.core
