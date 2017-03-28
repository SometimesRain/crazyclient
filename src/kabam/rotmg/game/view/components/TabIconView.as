package kabam.rotmg.game.view.components {
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class TabIconView extends TabView {

    private var background:Sprite;
    private var icon:Bitmap;

    public function TabIconView(_arg_1:int, _arg_2:Sprite, _arg_3:Bitmap) {
        super(_arg_1);
        this.initBackground(_arg_2);
        if (_arg_3) {
            this.initIcon(_arg_3, _arg_1);
        }
    }

    private function initBackground(_arg_1:Sprite):void {
        this.background = _arg_1;
        addChild(_arg_1);
    }

    private function initIcon(_arg_1:Bitmap, backpack:int):void {
        this.icon = _arg_1;
        _arg_1.x = _arg_1.x - 11; //-5
        _arg_1.y = _arg_1.y - 13 - backpack; //-11, if bp -14
        addChild(_arg_1);
    }

    override public function setSelected(_arg_1:Boolean):void {
        var _local_2:ColorTransform = this.background.transform.colorTransform;
        _local_2.color = ((_arg_1) ? TabConstants.BACKGROUND_COLOR : TabConstants.TAB_COLOR);
        this.background.transform.colorTransform = _local_2;
    }


}
}//package kabam.rotmg.game.view.components
