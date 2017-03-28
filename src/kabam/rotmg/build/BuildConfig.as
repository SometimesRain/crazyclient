package kabam.rotmg.build {
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.impl.BuildEnvironments;
import kabam.rotmg.build.impl.CompileTimeBuildData;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class BuildConfig implements IConfig {

    [Inject]
    public var injector:Injector;


    public function configure():void {
        this.injector.map(BuildEnvironments).asSingleton();
        this.injector.map(BuildData).toSingleton(CompileTimeBuildData);
    }


}
}//package kabam.rotmg.build
