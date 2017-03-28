package kabam.rotmg.protip.view {
import com.gskinner.motion.GTween;

import flash.display.Sprite;
import flash.filters.GlowFilter;

public class ProTipView extends Sprite {

    private var text:ProTipText;

    public function ProTipView() {
        this.text = new ProTipText();
        this.text.x = 300;
        this.text.y = 125;
        addChild(this.text);
        filters = [new GlowFilter(0, 1, 3, 3, 2, 1)];
        mouseEnabled = false;
        mouseChildren = false;
    }

    public function setTip(_arg_1:String):void {
        this.text.setTip(_arg_1);
        var _local_2:GTween = new GTween(this, 5, {"alpha": 0});
        _local_2.delay = 5;
        _local_2.onComplete = this.removeSelf;
    }

    private function removeSelf(_arg_1:GTween):void {
        ((parent) && (parent.removeChild(this)));
    }


}
}//package kabam.rotmg.protip.view
