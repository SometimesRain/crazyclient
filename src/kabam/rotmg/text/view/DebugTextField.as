package kabam.rotmg.text.view {
import flash.text.TextField;

import kabam.rotmg.language.model.DebugStringMap;
import kabam.rotmg.text.model.DebugTextInfo;

public class DebugTextField extends TextField {

    public static const WRONG_LANGUAGE_COLOR:uint = 977663;
    public static const INVALID_KEY_COLOR:uint = 15874138;

    public var debugStringMap:DebugStringMap;


    override public function set text(_arg_1:String):void {
        super.text = this.getText(_arg_1);
    }

    override public function set htmlText(_arg_1:String):void {
        super.htmlText = this.getText(_arg_1);
    }

    public function getText(_arg_1:String):String {
        var _local_2:DebugTextInfo;
        if (this.debugStringMap.debugTextInfos.length) {
            _local_2 = this.debugStringMap.debugTextInfos[0];
            if (_local_2.hasKey) {
                this.setBackground(WRONG_LANGUAGE_COLOR);
            }
            else {
                this.setBackground(INVALID_KEY_COLOR);
            }
            return (_local_2.key);
        }
        return (_arg_1);
    }

    private function setBackground(_arg_1:uint):void {
        background = true;
        backgroundColor = _arg_1;
    }


}
}//package kabam.rotmg.text.view
