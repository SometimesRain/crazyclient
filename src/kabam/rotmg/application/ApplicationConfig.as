package kabam.rotmg.application {
import flash.display.DisplayObjectContainer;
import flash.display.LoaderInfo;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.application.api.DebugSetup;
import kabam.rotmg.application.impl.FixedIPSetup;
import kabam.rotmg.application.impl.LocalhostSetup;
import kabam.rotmg.application.impl.PrivateSetup;
import kabam.rotmg.application.impl.ProductionSetup;
import kabam.rotmg.application.impl.Testing2Setup;
import kabam.rotmg.application.impl.TestingSetup;
import kabam.rotmg.application.model.DomainModel;
import kabam.rotmg.application.model.PlatformModel;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.IConfig;

public class ApplicationConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var root:DisplayObjectContainer;
    [Inject]
    public var data:BuildData;
    [Inject]
    public var loaderInfo:LoaderInfo;
    [Inject]
    public var domainModel:DomainModel;


    public function configure():void {
        var _local_1:ApplicationSetup = this.makeTestingSetup();
        this.injector.map(DebugSetup).toValue(_local_1);
        this.injector.map(ApplicationSetup).toValue(_local_1);
        this.injector.map(PlatformModel).asSingleton();
    }

    private function makeTestingSetup():ApplicationSetup {
        var _local_1:BuildEnvironment = this.data.getEnvironment();
        switch (_local_1) {
            case BuildEnvironment.LOCALHOST:
                return (new LocalhostSetup());
            case BuildEnvironment.FIXED_IP:
                return (this.makeFixedIPSetup());
            case BuildEnvironment.PRIVATE:
                return (new PrivateSetup());
            case BuildEnvironment.TESTING:
                return (new TestingSetup());
            case BuildEnvironment.TESTING2:
                return (new Testing2Setup());
            default:
                return (new ProductionSetup());
        }
    }

    private function makeFixedIPSetup():FixedIPSetup {
        return (new FixedIPSetup().setAddress(this.data.getEnvironmentString()));
    }


}
}//package kabam.rotmg.application
