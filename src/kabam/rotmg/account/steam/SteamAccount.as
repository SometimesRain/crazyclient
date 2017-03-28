package kabam.rotmg.account.steam {
import com.company.util.EmailValidator;

import kabam.rotmg.account.core.Account;

public class SteamAccount implements Account {

    public static const NETWORK_NAME:String = "steam";

    [Inject]
    public var api:SteamApi;
    private var userId:String = "";
    private var password:String = null;
    private var isVerifiedEmail:Boolean;
    private var platformToken:String;


    public function updateUser(_arg_1:String, _arg_2:String, _arg_3:String):void {
        this.userId = _arg_1;
        this.password = _arg_2;
    }

    public function getUserName():String {
        return (this.api.getPersonaName());
    }

    public function getUserId():String {
        return ((this.userId = ((this.userId) || (""))));
    }

    public function getPassword():String {
        return ("");
    }

    public function getSecret():String {
        return ((this.password = ((this.password) || (""))));
    }

    public function getCredentials():Object {
        var _local_1:Object = {};
        _local_1.guid = this.getUserId();
        _local_1.secret = this.getSecret();
        _local_1.steamid = this.api.getSteamId();
        return (_local_1);
    }

    public function isRegistered():Boolean {
        return (!((this.getSecret() == "")));
    }

    public function isLinked():Boolean {
        return (EmailValidator.isValidEmail(this.userId));
    }

    public function gameNetworkUserId():String {
        return (this.api.getSteamId());
    }

    public function gameNetwork():String {
        return (NETWORK_NAME);
    }

    public function playPlatform():String {
        return ("steam");
    }

    public function reportIntStat(_arg_1:String, _arg_2:int):void {
        this.api.reportStatistic(_arg_1, _arg_2);
    }

    public function getRequestPrefix():String {
        return ("/steamworks");
    }

    public function getEntryTag():String {
        return ("steamworks");
    }

    public function clear():void {
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
        throw (new Error("No current support for new Kabam offer wall on Steam."));
    }

    public function getMoneyUserId():String {
        throw (new Error("No current support for new Kabam offer wall on Steam."));
    }

    public function getToken():String
    {
        return "";
    }


}
}//package kabam.rotmg.account.steam
