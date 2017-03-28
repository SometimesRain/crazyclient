package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;

public class Testing2Setup implements ApplicationSetup {

    private const SERVER:String = "realmtesting2.appspot.com";
    private const UNENCRYPTED:String = ("http://" + SERVER);
    private const ENCRYPTED:String = ("https://" + SERVER);
    private const BUILD_LABEL:String = "<font color='#FF0000'>TESTING 2 </font> #{VERSION}";


    public function getAppEngineUrl(_arg_1:Boolean = false):String {
        return (((_arg_1) ? this.UNENCRYPTED : this.ENCRYPTED));
    }

    public function getBuildLabel():String {
        var _local_1:String = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
        return (this.BUILD_LABEL.replace("{VERSION}", _local_1));
    }

    public function useLocalTextures():Boolean {
        return (true);
    }

    public function isToolingEnabled():Boolean {
        return (true);
    }

    public function isGameLoopMonitored():Boolean {
        return (true);
    }

    public function areErrorsReported():Boolean {
        return (false);
    }

    public function useProductionDialogs():Boolean {
        return (true);
    }

    public function areDeveloperHotkeysEnabled():Boolean {
        return (false);
    }

    public function isDebug():Boolean {
        return (false);
    }


}
}//package kabam.rotmg.application.impl
