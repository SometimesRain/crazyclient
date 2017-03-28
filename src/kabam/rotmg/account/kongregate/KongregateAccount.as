package kabam.rotmg.account.kongregate {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.kongregate.view.KongregateApi;

public class KongregateAccount implements Account {

    public static const NETWORK_NAME:String = "kongregate";

    [Inject]
    public var api:KongregateApi;
    private var userId:String = "";
    private var password:String;
    private var isVerifiedEmail:Boolean;
    private var platformToken:String;
    private var _rememberMe:Boolean;


    public function updateUser(_arg_1:String, _arg_2:String, _arg_3:String):void {
        this.userId = _arg_1;
        this.password = _arg_2;
    }

    public function getUserName():String {
        return (this.api.getUserName());
    }

    public function getUserId():String {
        return (this.userId);
    }

    public function getPassword():String {
        return ("");
    }

    public function getSecret():String {
        return (((this.password) || ("")));
    }

    public function getCredentials():Object {
        return ({
            "guid": this.getUserId(),
            "secret": this.getSecret()
        });
    }

    public function isRegistered():Boolean {
        return (!((this.getSecret() == "")));
    }

    public function gameNetworkUserId():String {
        return (this.api.getUserId());
    }

    public function gameNetwork():String {
        return (NETWORK_NAME);
    }

    public function playPlatform():String {
        return ("kongregate");
    }

    public function reportIntStat(_arg_1:String, _arg_2:int):void {
        this.api.reportStatistic(_arg_1, _arg_2);
    }

    public function getRequestPrefix():String {
        return ("/kongregate");
    }

    public function getEntryTag():String {
        return ("kongregate");
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
        throw (new Error("No current support for new Kabam offer wall on Kongregate."));
    }

    public function getMoneyUserId():String {
        throw (new Error("No current support for new Kabam offer wall on Kongregate."));
    }

    public function set rememberMe(_arg_1:Boolean):void
    {
        this._rememberMe = _arg_1;
    }

    public function get rememberMe():Boolean
    {
        return this._rememberMe;
    }

    public function getToken() : String
    {
        return "";
    }


}
}//package kabam.rotmg.account.kongregate
