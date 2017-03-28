package kabam.rotmg.text.view {
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

public class TextFieldConcreteBuilder {

    private var _containerWidth:int = -1;
    private var _containerMargin:int = -1;


    public function getLocalizedTextObject(_arg_1:String, _arg_2:int = -1, _arg_3:int = -1, _arg_4:int = 16, _arg_5:int = 0xFFFFFF, _arg_6:int = -1, _arg_7:int = -1):TextFieldDisplayConcrete {
        var _local_8:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_8.setStringBuilder(new LineBuilder().setParams(_arg_1));
        return (this.defaultFormatTFDC(_local_8, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
    }

    public function getLiteralTextObject(_arg_1:String, _arg_2:int = -1, _arg_3:int = -1, _arg_4:int = 16, _arg_5:int = 0xFFFFFF, _arg_6:int = -1, _arg_7:int = -1):TextFieldDisplayConcrete {
        var _local_8:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_8.setStringBuilder(new StaticStringBuilder(_arg_1));
        return (this.defaultFormatTFDC(_local_8, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
    }

    public function getBlankFormattedTextObject(_arg_1:String, _arg_2:int = -1, _arg_3:int = -1, _arg_4:int = 16, _arg_5:int = 0xFFFFFF, _arg_6:int = -1, _arg_7:int = -1):TextFieldDisplayConcrete {
        var _local_8:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        return (this.defaultFormatTFDC(_local_8, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
    }

    public function formatExistingTextObject(_arg_1:TextFieldDisplayConcrete, _arg_2:int = -1, _arg_3:int = -1, _arg_4:int = 16, _arg_5:int = 0xFFFFFF, _arg_6:int = -1, _arg_7:int = -1):TextFieldDisplayConcrete {
        return (this.defaultFormatTFDC(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7));
    }

    private function defaultFormatTFDC(_arg_1:TextFieldDisplayConcrete, _arg_2:int = -1, _arg_3:int = -1, _arg_4:int = 16, _arg_5:int = 0xFFFFFF, _arg_6:int = -1, _arg_7:int = -1):TextFieldDisplayConcrete {
        _arg_1.setSize(_arg_4).setColor(_arg_5);
        if (((!((_arg_6 == -1))) && (!((_arg_7 == -1))))) {
            _arg_1.setTextWidth((_arg_6 - (_arg_7 * 2)));
        }
        else {
            if (((!((this.containerWidth == -1))) && (!((this.containerMargin == -1))))) {
                _arg_1.setTextWidth((this.containerWidth - (this.containerMargin * 2)));
            }
        }
        _arg_1.setBold(true);
        _arg_1.setWordWrap(true);
        _arg_1.setMultiLine(true);
        _arg_1.setAutoSize(TextFieldAutoSize.CENTER);
        _arg_1.setHorizontalAlign(TextFormatAlign.CENTER);
        _arg_1.filters = [new DropShadowFilter(0, 0, 0)];
        if (_arg_2 != -1) {
            _arg_1.x = _arg_2;
        }
        if (_arg_3 != -1) {
            _arg_1.y = _arg_3;
        }
        return (_arg_1);
    }

    public function get containerWidth():int {
        return (this._containerWidth);
    }

    public function set containerWidth(_arg_1:int):void {
        this._containerWidth = _arg_1;
    }

    public function get containerMargin():int {
        return (this._containerMargin);
    }

    public function set containerMargin(_arg_1:int):void {
        this._containerMargin = _arg_1;
    }


}
}//package kabam.rotmg.text.view
