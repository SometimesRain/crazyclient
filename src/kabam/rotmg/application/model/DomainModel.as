package kabam.rotmg.application.model {
import flash.net.LocalConnection;
import flash.system.Security;

public class DomainModel {

    private const LOCALHOST:String = "localhost";
    private const PRODUCTION_WHITELIST:Array = ["www.realmofthemadgod.com", "realmofthemadgodhrd.appspot.com", "realmofthemadgod.appspot.com"];
    private const TESTING_WHITELIST:Array = ["testing.realmofthemadgod.com", "rotmgtesting.appspot.com", "rotmghrdtesting.appspot.com"];
    private const TESTING2_WHITELIST:Array = ["realmtesting2.appspot.com"];
    private const TRANSLATION_WHITELIST:Array = ["xlate.kabam.com"];
    private const WHITELIST:Array = PRODUCTION_WHITELIST.concat(TESTING_WHITELIST).concat(TRANSLATION_WHITELIST).concat(TESTING2_WHITELIST);

    [Inject]
    public var client:PlatformModel;
    private var localDomain:String;


    public function applyDomainSecurity():void {
        var _local_1:String;
        for each (_local_1 in this.WHITELIST) {
            Security.allowDomain(_local_1);
        }
    }

    public function isLocalDomainValid():Boolean {
        return (((this.client.isDesktop()) || (this.isLocalDomainInWhiteList())));
    }

    public function isLocalDomainProduction():Boolean {
        var _local_1:String = this.getLocalDomain();
        return (!((this.PRODUCTION_WHITELIST.indexOf(_local_1) == -1)));
    }

    private function isLocalDomainInWhiteList():Boolean {
        var _local_3:String;
        var _local_1:String = this.getLocalDomain();
        var _local_2:Boolean = (_local_1 == this.LOCALHOST);
        for each (_local_3 in this.WHITELIST) {
            _local_2 = ((_local_2) || ((_local_1 == _local_3)));
        }
        return (_local_2);
    }

    private function getLocalDomain():String {
        return ((this.localDomain = ((this.localDomain) || (new LocalConnection().domain))));
    }


}
}//package kabam.rotmg.application.model
