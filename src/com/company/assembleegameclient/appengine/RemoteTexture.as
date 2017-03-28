package com.company.assembleegameclient.appengine {
import flash.display.BitmapData;
import flash.net.URLLoaderDataFormat;
import flash.utils.ByteArray;

import ion.utils.png.PNGDecoder;

import kabam.rotmg.appengine.api.RetryLoader;
import kabam.rotmg.appengine.impl.AppEngineRetryLoader;
import kabam.rotmg.core.StaticInjectorContext;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.ILogger;

public class RemoteTexture {

    private static const URL_PATTERN:String = "http://{DOMAIN}/picture/get";
    private static const ERROR_PATTERN:String = "Remote Texture Error: {ERROR} (id:{ID}, instance:{INSTANCE})";
    private static const START_TIME:int = int(new Date().getTime());

    public var id_:String;
    public var instance_:String;
    public var callback_:Function;
    private var logger:ILogger;

    public function RemoteTexture(_arg_1:String, _arg_2:String, _arg_3:Function):void {
        this.id_ = _arg_1;
        this.instance_ = _arg_2;
        this.callback_ = _arg_3;
        var _local_4:Injector = StaticInjectorContext.getInjector();
        this.logger = _local_4.getInstance(ILogger);
    }

    public function run():void {
        var _local_1:String = (((this.instance_) == "testing") ? "rotmghrdtesting.appspot.com" : "realmofthemadgodhrd.appspot.com");
        var _local_2:String = URL_PATTERN.replace("{DOMAIN}", _local_1);
        var _local_3:Object = {};
        _local_3.id = this.id_;
        _local_3.time = START_TIME;
        var _local_4:RetryLoader = new AppEngineRetryLoader();
        _local_4.setDataFormat(URLLoaderDataFormat.BINARY);
        _local_4.complete.addOnce(this.onComplete);
        _local_4.sendRequest(_local_2, _local_3);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.makeTexture(_arg_2);
        }
        else {
            this.reportError(_arg_2);
        }
    }

    public function makeTexture(_arg_1:ByteArray):void {
        var _local_2:BitmapData = PNGDecoder.decodeImage(_arg_1);
        this.callback_(_local_2);
    }

    public function reportError(_arg_1:String):void {
        _arg_1 = ERROR_PATTERN.replace("{ERROR}", _arg_1).replace("{ID}", this.id_).replace("{INSTANCE}", this.instance_);
        this.logger.warn("RemoteTexture.reportError: {0}", [_arg_1]);
        var _local_2:BitmapData = new BitmapDataSpy(1, 1);
        this.callback_(_local_2);
    }


}
}//package com.company.assembleegameclient.appengine
