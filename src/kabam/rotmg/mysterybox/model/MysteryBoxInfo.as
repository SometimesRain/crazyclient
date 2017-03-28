package kabam.rotmg.mysterybox.model {
import com.company.assembleegameclient.util.TimeUtil;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import kabam.display.Loader.LoaderProxy;
import kabam.display.Loader.LoaderProxyConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class MysteryBoxInfo extends EventDispatcher {

    public static var chestImageEmbed:Class = MysteryBoxInfo_chestImageEmbed;

    public var _id:String;
    public var _title:String;
    private var _description:String;
    public var _weight:String;
    public var _contents:String;
    public var _priceAmount:String;
    public var _priceCurrency:String;
    public var _saleAmount:String;
    public var _saleCurrency:String;
    public var _quantity:String;
    public var _saleEnd:Date;
    public var _iconImageUrl:String;
    private var _iconImage:DisplayObject;
    public var _infoImageUrl:String;
    private var _infoImage:DisplayObject;
    public var _startTime:Date;
    public var _endTime:Date;
    private var _loader:LoaderProxy;
    private var _infoImageLoader:LoaderProxy;
    public var _rollsWithContents:Vector.<Vector.<int>>;
    public var _rollsWithContentsUnique:Vector.<int>;
    private var _unitsLeft:int = -1;
    private var _totalUnits:int = -1;

    public function MysteryBoxInfo() {
        this._loader = new LoaderProxyConcrete();
        this._infoImageLoader = new LoaderProxyConcrete();
        this._rollsWithContents = new Vector.<Vector.<int>>();
        this._rollsWithContentsUnique = new Vector.<int>();
        super();
    }

    public function get id():String {
        return (this._id);
    }

    public function set id(_arg_1:String):void {
        this._id = _arg_1;
    }

    public function get title():String {
        return (this._title);
    }

    public function set title(_arg_1:String):void {
        this._title = _arg_1;
    }

    public function get description():String {
        return (this._description);
    }

    public function set description(_arg_1:String):void {
        this._description = _arg_1;
    }

    public function get weight():String {
        return (this._weight);
    }

    public function set weight(_arg_1:String):void {
        this._weight = _arg_1;
    }

    public function get contents():String {
        return (this._contents);
    }

    public function set contents(_arg_1:String):void {
        this._contents = _arg_1;
    }

    public function get priceAmount():* {
        return (this._priceAmount);
    }

    public function set priceAmount(_arg_1:String):void {
        this._priceAmount = _arg_1;
    }

    public function get priceCurrency():* {
        return (this._priceCurrency);
    }

    public function set priceCurrency(_arg_1:String):void {
        this._priceCurrency = _arg_1;
    }

    public function get saleAmount():* {
        return (this._saleAmount);
    }

    public function set saleAmount(_arg_1:String):void {
        this._saleAmount = _arg_1;
    }

    public function get saleCurrency():* {
        return (this._saleCurrency);
    }

    public function set saleCurrency(_arg_1:String):void {
        this._saleCurrency = _arg_1;
    }

    public function get quantity():String {
        return (this._quantity);
    }

    public function set quantity(_arg_1:String):void {
        this._quantity = _arg_1;
    }

    public function get saleEnd():Date {
        return (this._saleEnd);
    }

    public function set saleEnd(_arg_1:Date):void {
        this._saleEnd = _arg_1;
    }

    public function get iconImageUrl():String {
        return (this._iconImageUrl);
    }

    public function set iconImageUrl(_arg_1:String):void {
        this._iconImageUrl = _arg_1;
        this.loadIconImageFromUrl(this._iconImageUrl);
    }

    private function loadIconImageFromUrl(_arg_1:String):void {
        ((this._loader) && (this._loader.unload()));
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onError);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
        this._loader.load(new URLRequest(_arg_1));
    }

    private function onError(_arg_1:IOErrorEvent):void {
        this._iconImage = new chestImageEmbed();
    }

    private function onComplete(_arg_1:Event):void {
        this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onComplete);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR, this.onError);
        this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onError);
        this._iconImage = DisplayObject(this._loader);
    }

    public function get iconImage():DisplayObject {
        return (this._iconImage);
    }

    public function get infoImageUrl():String {
        return (this._infoImageUrl);
    }

    public function set infoImageUrl(_arg_1:String):void {
        this._infoImageUrl = _arg_1;
        this.loadInfomageFromUrl(this._infoImageUrl);
    }

    private function loadInfomageFromUrl(_arg_1:String):void {
        this.loadImageFromUrl(_arg_1, this._infoImageLoader);
    }

    private function loadImageFromUrl(_arg_1:String, _arg_2:LoaderProxy):void {
        ((_arg_2) && (_arg_2.unload()));
        _arg_2.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onInfoComplete);
        _arg_2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onInfoError);
        _arg_2.contentLoaderInfo.addEventListener(IOErrorEvent.DISK_ERROR, this.onInfoError);
        _arg_2.contentLoaderInfo.addEventListener(IOErrorEvent.NETWORK_ERROR, this.onInfoError);
        _arg_2.load(new URLRequest(_arg_1));
    }

    private function onInfoError(_arg_1:IOErrorEvent):void {
    }

    private function onInfoComplete(_arg_1:Event):void {
        this._infoImageLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.onInfoComplete);
        this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.onInfoError);
        this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.DISK_ERROR, this.onInfoError);
        this._infoImageLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.NETWORK_ERROR, this.onInfoError);
        this._infoImage = DisplayObject(this._infoImageLoader);
    }

    public function get startTime():Date {
        return (this._startTime);
    }

    public function set startTime(_arg_1:Date):void {
        this._startTime = _arg_1;
    }

    public function get endTime():Date {
        return (this._endTime);
    }

    public function set endTime(_arg_1:Date):void {
        this._endTime = _arg_1;
    }

    public function parseContents():void {
        var _local_3:String;
        var _local_4:Vector.<int>;
        var _local_5:Array;
        var _local_6:String;
        var _local_1:Array = this._contents.split(";");
        var _local_2:Dictionary = new Dictionary();
        for each (_local_3 in _local_1) {
            _local_4 = new Vector.<int>();
            _local_5 = _local_3.split(",");
            for each (_local_6 in _local_5) {
                if (_local_2[int(_local_6)] == null) {
                    _local_2[int(_local_6)] = true;
                    this._rollsWithContentsUnique.push(int(_local_6));
                }
                _local_4.push(int(_local_6));
            }
            this._rollsWithContents.push(_local_4);
        }
    }

    public function isNew():Boolean {
        var _local_1:Date = new Date();
        return ((Math.ceil(TimeUtil.secondsToDays(((_local_1.time - this._startTime.time) / 1000))) <= 1));
    }

    public function isOnSale():Boolean {
        var _local_1:Date;
        if (this._saleEnd) {
            _local_1 = new Date();
            return ((_local_1.time < this._saleEnd.time));
        }
        return (false);
    }

    public function getSaleTimeLeftStringBuilder():LineBuilder {
        var _local_1:Date = new Date();
        var _local_2:String = "";
        var _local_3:Number = ((this._saleEnd.time - _local_1.time) / 1000);
        var _local_4:LineBuilder = new LineBuilder();
        if (_local_3 > TimeUtil.DAY_IN_S) {
            _local_4.setParams("MysteryBoxInfo.saleEndStringDays", {"amount": String(Math.ceil(TimeUtil.secondsToDays(_local_3)))});
        }
        else {
            if (_local_3 > TimeUtil.HOUR_IN_S) {
                _local_4.setParams("MysteryBoxInfo.saleEndStringHours", {"amount": String(Math.ceil(TimeUtil.secondsToHours(_local_3)))});
            }
            else {
                _local_4.setParams("MysteryBoxInfo.saleEndStringMinutes", {"amount": String(Math.ceil(TimeUtil.secondsToMins(_local_3)))});
            }
        }
        return (_local_4);
    }

    public function get currencyName():String
    {
        switch(this._priceCurrency)
        {
            case "0":
                return LineBuilder.getLocalizedStringFromKey("Currency.gold").toLowerCase();
            case "1":
                return LineBuilder.getLocalizedStringFromKey("Currency.fame").toLowerCase();
            default:
                return "";
        }
    }

    public function get infoImage():DisplayObject {
        return (this._infoImage);
    }

    public function set infoImage(_arg_1:DisplayObject):void {
        this._infoImage = _arg_1;
    }

    public function get loader():LoaderProxy {
        return (this._loader);
    }

    public function set loader(_arg_1:LoaderProxy):void {
        this._loader = _arg_1;
    }

    public function get infoImageLoader():LoaderProxy {
        return (this._infoImageLoader);
    }

    public function set infoImageLoader(_arg_1:LoaderProxy):void {
        this._infoImageLoader = _arg_1;
    }

    public function get unitsLeft():int
    {
        return this._unitsLeft;
    }

    public function set unitsLeft(_arg_1:int):void
    {
        this._unitsLeft = _arg_1;
    }

    public function get totalUnits():int
    {
        return this._totalUnits;
    }

    public function set totalUnits(_arg_1:int):void
    {
        this._totalUnits = _arg_1;
    }


}
}//package kabam.rotmg.mysterybox.model
