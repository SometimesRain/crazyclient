package kabam.rotmg.account.web.view {
import flash.display.Sprite;

public class ProgressBar extends Sprite {

    private static const BEVEL:int = 4;

    private var _w:Number = 100;
    private var _h:Number = 10;
    private var backbar:Sprite;
    private var fillbar:Sprite;

    public function ProgressBar(_arg_1:Number, _arg_2:Number) {
        this._w = _arg_1;
        this._h = _arg_2;
        this.backbar = new Sprite();
        this.fillbar = new Sprite();
        addChild(this.backbar);
        addChild(this.fillbar);
        this.update(0);
    }

    public function update(_arg_1:Number):void {
        this.drawRectToSprite(this.fillbar, 0xFFFFFF, ((_arg_1 * 0.01) * this._w));
        this.drawRectToSprite(this.backbar, 0, this._w);
    }

    private function drawRectToSprite(_arg_1:Sprite, _arg_2:uint, _arg_3:Number):Sprite {
        _arg_1.graphics.clear();
        _arg_1.graphics.beginFill(_arg_2);
        _arg_1.graphics.drawRect(0, 0, _arg_3, this._h);
        _arg_1.graphics.endFill();
        return (_arg_1);
    }


}
}//package kabam.rotmg.account.web.view
