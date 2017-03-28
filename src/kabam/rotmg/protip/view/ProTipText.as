package kabam.rotmg.protip.view {
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextFormatAlign;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ProTipText extends Sprite {

    private var text:TextFieldDisplayConcrete;


    public function setTip(_arg_1:String):void {
        this.text = new TextFieldDisplayConcrete().setSize(18).setColor(0xFFFFFF).setWordWrap(true).setMultiLine(true).setTextWidth(580).setTextHeight(100).setHorizontalAlign(TextFormatAlign.CENTER);
        this.text.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        this.text.setStringBuilder(new LineBuilder().setParams(TextKey.PROTIPTEXT_TEXT, {"tip": _arg_1}));
        this.text.x = -290;
        mouseEnabled = false;
        mouseChildren = false;
        addChild(this.text);
    }


}
}//package kabam.rotmg.protip.view
