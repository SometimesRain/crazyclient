package kabam.rotmg.account.kongregate.view {
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.Security;

import kabam.rotmg.account.kongregate.services.KongregateSharedObject;
import kabam.rotmg.account.kongregate.signals.RelayApiLoginSignal;

import org.osflash.signals.Signal;

import robotlegs.bender.framework.api.ILogger;

public class LiveKongregateApi extends Sprite implements KongregateApi {

    [Inject]
    public var local:KongregateSharedObject;
    [Inject]
    public var apiLogin:RelayApiLoginSignal;
    [Inject]
    public var logger:ILogger;
    private var _loaded:Signal;
    private var _purchaseResponse:Signal;
    private var loader:Loader;
    private var api:*;

    public function LiveKongregateApi() {
        this._loaded = new Signal();
        this._purchaseResponse = new Signal(Object);
    }

    public function load(_arg_1:String):void {
        Security.allowDomain(_arg_1);
        this.logger.info("kongregate api loading");
        addChild((this.loader = new Loader()));
        this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onAPILoaded);
        this.loader.load(new URLRequest(_arg_1));
    }

    private function onAPILoaded(_arg_1:Event):void {
        this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onAPILoaded);
        this.api = _arg_1.target.content;
        this.api.services.connect();
        this.addExternalLoginListenerForGuestUser();
        this.loaded.dispatch();
        this.logger.info("kongregate api loaded");
    }

    private function addExternalLoginListenerForGuestUser():void {
        if (this.api.services.isGuest()) {
            this.logger.info("kongregate guest detected - listening for external login");
            this.api.services.addEventListener("login", this.onExternalLogin);
        }
    }

    private function onExternalLogin(_arg_1:Event):void {
        this.logger.info("external login from kongregate detected");
        this.apiLogin.dispatch();
    }

    public function get loaded():Signal {
        return (this._loaded);
    }

    public function showRegistrationDialog():void {
        this.logger.info("showRegistrationBox request sent to kongregate");
        this.api.services.showRegistrationBox();
    }

    public function isGuest():Boolean {
        return (this.api.services.isGuest());
    }

    public function getAuthentication():Object {
        var _local_1:Object = {};
        _local_1.userId = this.api.services.getUserId();
        _local_1.username = this.api.services.getUsername();
        _local_1.gameAuthToken = this.api.services.getGameAuthToken();
        return (_local_1);
    }

    public function reportStatistic(_arg_1:String, _arg_2:int):void {
        this.api.stats.submit(_arg_1, _arg_2);
    }

    public function getUserName():String {
        return (this.api.services.getUsername());
    }

    public function getUserId():String {
        return (this.api.services.getUserId());
    }

    public function purchaseItems(_arg_1:Object):void {
        this.api.mtx.purchaseItems([_arg_1], this.onPurchase);
    }

    private function onPurchase(_arg_1:Object):void {
        this._purchaseResponse.dispatch(_arg_1);
    }

    public function get purchaseResponse():Signal {
        return (this._purchaseResponse);
    }


}
}//package kabam.rotmg.account.kongregate.view
