package kabam.rotmg.build.impl {
import flash.display.LoaderInfo;
import flash.net.LocalConnection;
import flash.system.Capabilities;

import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;

public class CompileTimeBuildData implements BuildData {

    private static const DESKTOP:String = "Desktop";
    private static const ROTMG:String = "www.realmofthemadgod.com";
    private static const ROTMG_APPSPOT:String = "realmofthemadgodhrd.appspot.com";
    private static const ROTMG_TESTING:String = "rotmgtesting.appspot.com";
    private static const ROTMG_TESTING_MAP:String = "testing.realmofthemadgod.com";
    private static const ROTMG_TESTING2:String = "realmtesting2.appspot.com";
    private static const STEAM_PRODUCTION_CONFIG:String = "Production";

    [Inject]
    public var loaderInfo:LoaderInfo;
    [Inject]
    public var environments:BuildEnvironments;
    private var isParsed:Boolean = false;
    private var environment:BuildEnvironment;


    public function getEnvironmentString():String {
        return ("production".toLowerCase());
    }

    public function getEnvironment():BuildEnvironment {
        ((this.isParsed) || (this.parseEnvironment()));
        return (this.environment);
    }

    private function parseEnvironment():void {
        this.isParsed = true;
        this.setEnvironmentValue(this.getEnvironmentString());
    }

    private function setEnvironmentValue(_arg_1:String):void {
        var _local_3:LocalConnection;
        var _local_2:Boolean = this.conditionsRequireTesting(_arg_1);
        if (_local_2) {
            _local_3 = new LocalConnection();
            if ((((_local_3.domain == ROTMG_TESTING)) || ((_local_3.domain == ROTMG_TESTING_MAP)))) {
                this.environment = BuildEnvironment.TESTING;
            }
            else {
                if (_local_3.domain == ROTMG_TESTING2) {
                    this.environment = BuildEnvironment.TESTING2;
                }
            }
        }
        else {
            this.environment = this.environments.getEnvironment(_arg_1);
        }
    }

    private function conditionsRequireTesting(_arg_1:String):Boolean {
        return ((((_arg_1 == BuildEnvironments.PRODUCTION)) && (!(this.isMarkedAsProductionRelease()))));
    }

    private function isMarkedAsProductionRelease():Boolean {
        return (((this.isDesktopPlayer()) ? this.isSteamProductionDeployment() : this.isHostedOnProductionServers()));
    }

    private function isDesktopPlayer():Boolean {
        return ((Capabilities.playerType == DESKTOP));
    }

    private function isSteamProductionDeployment():Boolean {
        var _local_1:Object = this.loaderInfo.parameters;
        return ((_local_1.deployment == STEAM_PRODUCTION_CONFIG));
    }

    private function isHostedOnProductionServers():Boolean {
        var _local_1:LocalConnection = new LocalConnection();
        return ((((_local_1.domain == ROTMG)) || ((_local_1.domain == ROTMG_APPSPOT))));
    }


}
}//package kabam.rotmg.build.impl
