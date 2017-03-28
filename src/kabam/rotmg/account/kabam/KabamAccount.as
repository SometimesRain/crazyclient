package kabam.rotmg.account.kabam {
import flash.external.ExternalInterface;

import kabam.lib.json.JsonParser;
import kabam.rotmg.account.core.Account;

public class KabamAccount implements Account {

    public static const NETWORK_NAME:String = "kabam.com";
    private static const PLAY_PLATFORM_NAME:String = "kabam.com";

    private var entryTag:String;
    private var userId:String = "";
    private var password:String = null;
    private var token:String = null;
    private var isVerifiedEmail:Boolean;
    private var platformToken:String;
    public var signedRequest:String;
    public var userSession:Object;
    [Inject]
    public var json:JsonParser;

    public function KabamAccount() {
        var _local_1:String;
        super();
        try {
            _local_1 = ExternalInterface.call("rotmg.UrlLib.getParam", "entrypt");
            if (_local_1 != null) {
                this.entryTag = _local_1;
            }
        }
        catch (error:Error) {
        }
    }

    public function updateUser(_arg_1:String, _arg_2:String, _arg_3:String):void {
        this.userId = _arg_1;
        this.password = _arg_2;
        this.token = _arg_3;
    }

    public function getRequestPrefix():String {
        return ("/credits");
    }

    public function getCredentials():Object {
        return ({
            "guid": this.getUserId(),
            "secret": this.getSecret(),
            "signedRequest": this.signedRequest
        });
    }
	
    public function getToken():String {
        return "";
    }

    public function getEntryTag():String {
        return (((this.entryTag) || ("")));
    }

    public function gameNetworkUserId():String {
        if ((((this.userSession == null)) || ((this.userSession["kabam_naid"] == null)))) {
            return ("");
        }
        return (this.userSession["kabam_naid"]);
    }

    public function gameNetwork():String {
        return (NETWORK_NAME);
    }

    public function getUserName():String {
        if ((((((this.userSession == null)) || ((this.userSession["user"] == null)))) || ((this.userSession["user"]["email"] == null)))) {
            return ("");
        }
        var _local_1:String = this.userSession["user"]["email"];
        var _local_2:Array = _local_1.split("@", 2);
        if (_local_2.length != 2) {
            return ("");
        }
        return (_local_2[0]);
    }

    public function getUserId():String {
        return (this.userId);
    }

    public function isLinked():Boolean {
        return (false);
    }

    public function isRegistered():Boolean {
        return (true);
    }

    public function playPlatform():String {
        return (PLAY_PLATFORM_NAME);
    }

    public function getSecret():String {
        return (((this.password) || ("")));
    }

    public function getPassword():String {
        return ("");
    }

    public function clear():void {
    }

    public function reportIntStat(_arg_1:String, _arg_2:int):void {
    }

    public function verify(_arg_1:Boolean):void {
        this.isVerifiedEmail = _arg_1;
    }

    public function isVerified():Boolean {
        return (this.isVerifiedEmail);
    }

    public function getPlatformToken():String {
        return (((this.platformToken) || ("")));
    }

    public function setPlatformToken(_arg_1:String):void {
        this.platformToken = _arg_1;
    }

    public function getMoneyAccessToken():String {
        return (this.userSession["oauth_token"]);
    }

    public function getMoneyUserId():String {
        return (this.gameNetworkUserId());
    }


}
}//package kabam.rotmg.account.kabam
