package kabam.rotmg.promotions.view {
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.promotions.view.components.TransparentButton;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class BeginnersPackageOfferDialog extends Sprite {

    public static const LANGUAGE_KEY_SINGULAR:String = "BeginnersPackageOfferDialog.dayLeft";
    public static const LANGUAGE_KEY_PLURAL:String = "BeginnersPackageOfferDialog.daysLeft";
    public static var hifiBeginnerOfferEmbed:Class = BeginnersPackageOfferDialog_hifiBeginnerOfferEmbed;

    public var close:Signal;
    public var buy:Signal;
    private var timeText:TextFieldDisplayConcrete;

    public function BeginnersPackageOfferDialog() {
        this.makeBackground();
        this.makeOfferText();
        this.makeCloseButton();
        this.makeBuyButton();
    }

    public function setTimeRemaining(_arg_1:int):void {
        var _local_2:String = (((_arg_1 > 1)) ? LANGUAGE_KEY_PLURAL : LANGUAGE_KEY_SINGULAR);
        this.timeText.setStringBuilder(new LineBuilder().setParams(_local_2, {"days": _arg_1}));
    }

    public function centerOnScreen():void {
        x = ((stage.stageWidth - width) * 0.5);
        y = ((stage.stageHeight - height) * 0.5);
    }

    private function makeBackground():void {
        addChild(new hifiBeginnerOfferEmbed());
    }

    private function makeOfferText():void {
        this.timeText = new TextFieldDisplayConcrete().setSize(14).setColor(0xE3C900);
        this.timeText.setBold(true);
        this.timeText.x = 307;
        this.timeText.y = 380;
        addChild(this.timeText);
    }

    private function makeBuyButton():void {
        var _local_1:Sprite = this.makeTransparentTargetButton(270, 400, 150, 40);
        this.buy = new NativeMappedSignal(_local_1, MouseEvent.CLICK);
    }

    private function makeCloseButton():void {
        var _local_1:Sprite = this.makeTransparentTargetButton(550, 30, 30, 30);
        this.close = new NativeMappedSignal(_local_1, MouseEvent.CLICK);
    }

    private function makeTransparentTargetButton(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):Sprite {
        var _local_5:TransparentButton = new TransparentButton(_arg_1, _arg_2, _arg_3, _arg_4);
        addChild(_local_5);
        return (_local_5);
    }


}
}//package kabam.rotmg.promotions.view
