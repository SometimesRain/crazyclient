package kabam.rotmg.promotions.view {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Rectangle;

import kabam.lib.resizing.view.Resizable;

public class AlreadyPurchasedBeginnersPackageDialog extends Sprite implements Resizable {

    public static var hifiBeginnerOfferAlreadyPurchasedEmbed:Class = AlreadyPurchasedBeginnersPackageDialog_hifiBeginnerOfferAlreadyPurchasedEmbed;

    private var closeBtn:Sprite;

    public function AlreadyPurchasedBeginnersPackageDialog() {
        this.addBackground();
        this.makeCloseButton();
    }

    private function addBackground():void {
        addChild(new hifiBeginnerOfferAlreadyPurchasedEmbed());
    }

    private function makeCloseButton():void {
        this.closeBtn = new Sprite();
        this.closeBtn.graphics.beginFill(0xFF0000, 0);
        this.closeBtn.graphics.drawRect(0, 0, 30, 30);
        this.closeBtn.graphics.endFill();
        this.closeBtn.buttonMode = true;
        this.closeBtn.x = 550;
        this.closeBtn.y = 30;
        addEventListener(MouseEvent.CLICK, this.onClose);
        addChild(this.closeBtn);
    }

    private function onClose(_arg_1:MouseEvent):void {
        parent.removeChild(this);
    }

    public function resize(_arg_1:Rectangle):void {
        x = ((_arg_1.width - width) / 2);
        y = ((_arg_1.height - height) / 2);
    }


}
}//package kabam.rotmg.promotions.view
