package kabam.rotmg.fortune.services {
import kabam.rotmg.fortune.model.FortuneInfo;

import org.osflash.signals.Signal;

public class FortuneModel {

    public static var HAS_FORTUNES:Boolean = false;

    private var fortune:FortuneInfo;
    private var initialized:Boolean = false;
    private var _isNew:Boolean = false;
    public var initializedSignal:Signal;

    public function FortuneModel() {
        this.initializedSignal = new Signal();
        super();
    }

    public function getFortune():FortuneInfo {
        return (this.fortune);
    }

    public function setFortune(_arg_1:FortuneInfo):void {
        this.fortune = _arg_1;
        this.initialized = true;
        HAS_FORTUNES = true;
        this.initializedSignal.dispatch();
    }

    public function isInitialized():Boolean {
        return (this.initialized);
    }

    public function setInitialized(_arg_1:Boolean):void {
        this.initialized = _arg_1;
    }

    public function get isNew():Boolean {
        return (this._isNew);
    }

    public function set isNew(_arg_1:Boolean):void {
        this._isNew = _arg_1;
    }


}
}//package kabam.rotmg.fortune.services
