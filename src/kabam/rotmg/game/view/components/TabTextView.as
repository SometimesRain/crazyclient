package kabam.rotmg.game.view.components {
import com.company.ui.BaseSimpleText;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class TabTextView extends TabView {

    private var background:Sprite;
    private var text:BaseSimpleText;
    private var badgeBG:Bitmap;
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
            this.badgeIcon.bitmapData = AssetLibrary.getImageFromSet("lofiInterface", 110);
            this.badgeIcon.x = (this.x - 10);
            this.badgeIcon.y = 5;
            this.badgeIcon.scaleX = (this.badgeIcon.scaleY = 1.5);
            addChild(this.badgeIcon);
            this.badgeBG = new Bitmap();
            this.badgeBG.bitmapData = AssetLibrary.getImageFromSet("lofiInterface", 110);
            this.badgeBG.x = (this.x - 12);
            this.badgeBG.y = 3;
            this.badgeBG.scaleX = (this.badgeBG.scaleY = 2);
            addChild(this.badgeBG);
        }
        this.badgeIcon.visible = (this.badgeBG.visible = (_arg_1 > 0));
    }

    private function initBackground(_arg_1:Sprite):void {
        this.background = _arg_1;
        addChild(_arg_1);
    }

    private function initTabText(_arg_1:BaseSimpleText):void {
        this.text = _arg_1;
        _arg_1.x = 5;
        addChild(_arg_1);
    }

    override public function setSelected(_arg_1:Boolean):void {
        var _local_2:ColorTransform = this.background.transform.colorTransform;
        _local_2.color = ((_arg_1) ? TabConstants.BACKGROUND_COLOR : TabConstants.TAB_COLOR);
        this.background.transform.colorTransform = _local_2;
    }


}
}//package kabam.rotmg.game.view.components
