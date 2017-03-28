package kabam.rotmg.promotions.view {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.packages.view.BasePackageButton;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.UIUtils;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class BeginnersPackageButton extends BasePackageButton {

    private static const FONT_SIZE:int = 16;

    public var clicked:Signal;
    private var timeLeftText:TextFieldDisplayConcrete;
    private var lootIcon:DisplayObject;
    private var daysRemaining:int = -1;
    private var clickArea:Sprite;

    public function BeginnersPackageButton() {
        this.clickArea = UIUtils.makeStaticHUDBackground();
        this.clicked = new NativeMappedSignal(this, MouseEvent.CLICK);
        tabChildren = false;
        tabEnabled = false;
        this.makeUI();
    }

    public function setDaysRemaining(_arg_1:int):void {
        if (this.daysRemaining != _arg_1) {
            this.daysRemaining = _arg_1;
            this.updateTimeLeftPosition();
        }
    }

    public function destroy():void {
        parent.removeChild(this);
    }

    private function makeUI():void {
        addChild(this.clickArea);
        this.lootIcon = makeIcon();
        addChild(this.lootIcon);
        this.makeTimeLeftText();
        this.setDaysRemaining(0);
    }

    private function makeTimeLeftText():void {
        this.timeLeftText = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(0xFFFFFF);
        this.timeLeftText.filters = [new DropShadowFilter(0, 0, 0)];
        this.updateTimeLeftPosition();
        addChild(this.timeLeftText);
    }

    private function updateTimeLeftPosition():void {
        this.timeLeftText.textChanged.addOnce(this.onTextChanged);
        this.timeLeftText.setStringBuilder(new StaticStringBuilder(((this.daysRemaining.toString() + " day") + (((this.daysRemaining) > 1) ? "s" : ""))));
    }

    private function onTextChanged():void {
        positionText(this.lootIcon, this.timeLeftText);
    }


}
}//package kabam.rotmg.promotions.view
