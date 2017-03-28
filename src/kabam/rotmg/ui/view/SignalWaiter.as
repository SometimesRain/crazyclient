package kabam.rotmg.ui.view {
import com.adobe.utils.DictionaryUtil;

import flash.utils.Dictionary;

import org.osflash.signals.Signal;

public class SignalWaiter {

    public var complete:Signal;
    private var texts:Dictionary;

    public function SignalWaiter() {
        this.complete = new Signal();
        this.texts = new Dictionary();
        super();
    }

    public function push(_arg_1:Signal):SignalWaiter {
        this.texts[_arg_1] = true;
        this.listenTo(_arg_1);
        return (this);
    }

    public function pushArgs(... rest):SignalWaiter {
        var _local_2:Signal;
        for each (_local_2 in rest) {
            this.push(_local_2);
        }
        return (this);
    }

    private function listenTo(value:Signal):void {
        var onTextChanged:Function;
        onTextChanged = function ():void {
            delete texts[value];
            checkEmpty();
        };
        value.addOnce(onTextChanged);
    }

    private function checkEmpty():void {
        if (this.isEmpty()) {
            this.complete.dispatch();
        }
    }

    public function isEmpty():Boolean {
        return ((DictionaryUtil.getKeys(this.texts).length == 0));
    }


}
}//package kabam.rotmg.ui.view
