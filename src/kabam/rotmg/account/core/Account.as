package kabam.rotmg.account.core {
public interface Account {

    function getPlatformToken():String;

    function setPlatformToken(_arg_1:String):void;

    function updateUser(_arg_1:String, _arg_2:String, _arg_3:String):void;

    function getUserName():String;

    function getUserId():String;

    function getPassword():String;

    function getToken():String;

    function getSecret():String;

    function getCredentials():Object;

    function isRegistered():Boolean;

    function clear():void;

    function reportIntStat(_arg_1:String, _arg_2:int):void;

    function getRequestPrefix():String;

    function gameNetworkUserId():String;

    function gameNetwork():String;

    function playPlatform():String;

    function getEntryTag():String;

    function verify(_arg_1:Boolean):void;

    function isVerified():Boolean;

    function getMoneyUserId():String;

    function getMoneyAccessToken():String;

}
}//package kabam.rotmg.account.core
