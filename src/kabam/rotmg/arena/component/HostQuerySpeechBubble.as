package kabam.rotmg.arena.component {
import flash.display.Shape;
import flash.display.Sprite;
import flash.text.TextFieldAutoSize;

import flashx.textLayout.formats.VerticalAlign;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.graphics.BevelRect;
import kabam.rotmg.util.graphics.GraphicsHelper;

public class HostQuerySpeechBubble extends Sprite {

    private const WIDTH:int = 174;
    private const HEIGHT:int = 225;
    private const BEVEL:int = 4;
    private const POINT:int = 6;
    private const PADDING:int = 8;

    public function HostQuerySpeechBubble(_arg_1:String) {
        addChild(this.makeBubble());
        addChild(this.makeText(_arg_1));
    }

    private function makeBubble():Shape {
        var _local_1:Shape = new Shape();
        this.drawBubble(_local_1);
        return (_local_1);
    }

    private function drawBubble(_arg_1:Shape):void {
        var _local_2:GraphicsHelper = new GraphicsHelper();
        var _local_3:BevelRect = new BevelRect(this.WIDTH, this.HEIGHT, this.BEVEL);
        var _local_4:int = 21;
        _arg_1.graphics.beginFill(0xE0E0E0);
        _local_2.drawBevelRect(0, 0, _local_3, _arg_1.graphics);
        _arg_1.graphics.endFill();
        _arg_1.graphics.beginFill(0xE0E0E0);
        _arg_1.graphics.moveTo(0, (_local_4 - this.POINT));
        _arg_1.graphics.lineTo(-(this.POINT), _local_4);
        _arg_1.graphics.lineTo(0, (_local_4 + this.POINT));
        _arg_1.graphics.endFill();
    }

    private function makeText(_arg_1:String):TextFieldDisplayConcrete {
        var _local_2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setLeading(3).setAutoSize(TextFieldAutoSize.LEFT).setVerticalAlign(VerticalAlign.TOP).setMultiLine(true).setWordWrap(true).setPosition(this.PADDING, this.PADDING).setTextWidth((this.WIDTH - (2 * this.PADDING))).setTextHeight((this.HEIGHT - (2 * this.PADDING)));
        _local_2.setStringBuilder(new LineBuilder().setParams(_arg_1));
        return (_local_2);
    }


}
}//package kabam.rotmg.arena.component
