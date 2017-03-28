package kabam.rotmg.application.model {
import flash.display.DisplayObjectContainer;
import flash.display.LoaderInfo;
import flash.system.Capabilities;

public class PlatformModel {

    private static var platform:PlatformType;

    private const DESKTOP:String = "Desktop";

    [Inject]
    public var root:DisplayObjectContainer;


    public function isWeb():Boolean {
        return (!((Capabilities.playerType == this.DESKTOP)));
    }

    public function isDesktop():Boolean {
        return ((Capabilities.playerType == this.DESKTOP));
    }

    public function getPlatform():PlatformType {
        return ((platform = ((platform) || (this.determinePlatform()))));
    }

    private function determinePlatform():PlatformType {
        var _local_1:Object = LoaderInfo(this.root.stage.root.loaderInfo).parameters;
        if (this.isKongregate(_local_1)) {
            return (PlatformType.KONGREGATE);
        }
        if (this.isSteam(_local_1)) {
            return (PlatformType.STEAM);
        }
        if (this.isKabam(_local_1)) {
            return (PlatformType.KABAM);
        }
        return (PlatformType.WEB);
    }

    private function isKongregate(_arg_1:Object):Boolean {
        return (!((_arg_1.kongregate_api_path == null)));
    }

    private function isSteam(_arg_1:Object):Boolean {
        return (!((_arg_1.steam_api_path == null)));
    }

    private function isKabam(_arg_1:Object):Boolean {
        return (!((_arg_1.kabam_signed_request == null)));
    }


}
}//package kabam.rotmg.application.model
