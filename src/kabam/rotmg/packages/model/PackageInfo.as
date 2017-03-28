package kabam.rotmg.packages.model {
import com.company.assembleegameclient.util.TimeUtil;

import org.osflash.signals.Signal;

public class PackageInfo {

    public static const INFINITE:int = -1;

    private var _initialized:Boolean = false;
    public var dataChanged:Signal;
    public var packageIDChanged:Signal;
    public var endDateChanged:Signal;
    public var durationChanged:Signal;
    public var nameChanged:Signal;
    public var quantityChanged:Signal;
    public var maxChanged:Signal;
    public var priceChanged:Signal;
    public var imageURLChanged:Signal;
    private var _packageID:int;
    private var _endDate:Date;
    private var _name:String;
    private var _quantity:int;
    private var _max:int;
    private var _price:int;
    private var _imageURL:String;
    private var _priority:int;
    private var _numPurchased:int;

    public function PackageInfo() {
        this.dataChanged = new Signal();
        this.packageIDChanged = new Signal(int);
        this.endDateChanged = new Signal(Date);
        this.durationChanged = new Signal(int);
        this.nameChanged = new Signal(String);
        this.quantityChanged = new Signal(int);
        this.maxChanged = new Signal(int);
        this.priceChanged = new Signal(int);
        this.imageURLChanged = new Signal(String);
        super();
    }

    public function setData(_arg_1:int, _arg_2:Date, _arg_3:String, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:String, _arg_9:int):void {
        this._packageID = _arg_1;
        this._endDate = _arg_2;
        this._name = _arg_3;
        this._quantity = _arg_4;
        this._max = _arg_5;
        this._priority = _arg_6;
        this._price = _arg_7;
        this._imageURL = _arg_8;
        this._numPurchased = _arg_9;
        this._initialized = true;
        this.dataChanged.dispatch();
    }

    public function getDuration():int {
        var _local_1:Date = new Date();
        return ((this._endDate.time - _local_1.time));
    }

    public function getDaysRemaining():Number {
        return (Math.ceil(TimeUtil.secondsToDays((this.getDuration() / 1000))));
    }

    public function get quantity():int {
        return (this._quantity);
    }

    public function set quantity(_arg_1:int):void {
        this._quantity = _arg_1;
        this.quantityChanged.dispatch(_arg_1);
    }

    public function get priority():int {
        return (this._priority);
    }

    public function set priority(_arg_1:int):void {
        this._priority = _arg_1;
    }

    public function get packageID():int {
        return (this._packageID);
    }

    public function set packageID(_arg_1:int):void {
        this._packageID = _arg_1;
        this.packageIDChanged.dispatch(_arg_1);
    }

    public function get endDate():Date {
        return (this._endDate);
    }

    public function set endDate(_arg_1:Date):void {
        this._endDate = _arg_1;
        this.endDateChanged.dispatch(_arg_1);
        this.durationChanged.dispatch(this.getDuration());
    }

    public function get name():String {
        return (this._name);
    }

    public function set name(_arg_1:String):void {
        this._name = _arg_1;
        this.nameChanged.dispatch(_arg_1);
    }

    public function get max():int {
        return (this._max);
    }

    public function set max(_arg_1:int):void {
        this._max = _arg_1;
        this.maxChanged.dispatch(_arg_1);
    }

    public function get price():int {
        return (this._price);
    }

    public function set price(_arg_1:int):void {
        this._price = _arg_1;
        this.priceChanged.dispatch(_arg_1);
    }

    public function get imageURL():String {
        return (this._imageURL);
    }

    public function get numPurchased():int {
        return (this._numPurchased);
    }

    public function set numPurchased(_arg_1:int):void {
        this._numPurchased = _arg_1;
    }

    public function hasPurchased():Boolean {
        return ((this._numPurchased > 0));
    }

    public function canPurchase():Boolean {
        if (this.max == INFINITE) {
            return (true);
        }
        return ((this._numPurchased < this._max));
    }

    public function toString():String {
        return ((((("[Package name=" + this._name) + ", packageId=") + this._packageID) + "]"));
    }


}
}//package kabam.rotmg.packages.model
