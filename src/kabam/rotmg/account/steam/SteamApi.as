package kabam.rotmg.account.steam {
import org.osflash.signals.OnceSignal;
import org.osflash.signals.Signal;

public interface SteamApi {

    function load(_arg_1:String):void;

    function get loaded():Signal;

    function requestSessionTicket():void;

    function get sessionReceived():Signal;

    function getSessionAuthentication():Object;

    function getSteamId():String;

    function reportStatistic(_arg_1:String, _arg_2:int):void;

    function get paymentAuthorized():OnceSignal;

    function getPersonaName():String;

    function get isOverlayEnabled():Boolean;

}
}//package kabam.rotmg.account.steam
