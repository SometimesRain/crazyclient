package kabam.rotmg.game.view.components {
import com.company.ui.BaseSimpleText;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class TabTextView extends TabView {

    private var background:Sprite;
    private var text:BaseSimpleText;
    private var badgeIcon:Bitmap;

    public function TabTextView(_arg_1:int, _arg_2:Sprite, _arg_3:BaseSimpleText) {
        super(_arg_1);
        this.initBackground(_arg_2);
        if (_arg_3) {
            this.initTabText(_arg_3);
        }
    }

    public function setBadge(_arg_1:int):void {
        if (this.badgeIcon == null) {
            this.badgeIcon = new Bitmap();
            this.badgeIcon.bitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig", 14);
            this.badgeIcon.x = (this.x - 26);
            this.badgeIcon.y = 4;
            addChild(this.badgeIcon);
        }
        this.badgeIcon.visible = _arg_1 > 0;
    }

    private function initBackground(_arg_1:Sprite):void {
        this.background = _arg_1;
        addChild(_arg_1);
    }

    private function initTabText(_arg_1:BaseSimpleText):void {
        this.text = _arg_1;
        addChild(_arg_1);
    }

    override public function setSelected(_arg_1:Boolean):void {
        var _local_2:ColorTransform = this.background.transform.colorTransform;
        _local_2.color = ((_arg_1) ? TabConstants.BACKGROUND_COLOR : TabConstants.TAB_COLOR);
        this.background.transform.colorTransform = _local_2;
    }


}
}//package kabam.rotmg.game.view.components
