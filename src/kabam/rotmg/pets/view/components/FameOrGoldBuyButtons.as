package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.util.Currency;
import com.company.util.MoreColorUtil;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.IOnceSignal;
import org.osflash.signals.Signal;

public class FameOrGoldBuyButtons extends Sprite {

    private static const grayfilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);

    public const positioned:Signal = new Signal();
    public const goldButtonClicked:Signal = new Signal(int);
    public const fameButtonClicked:Signal = new Signal(int);
    public const clicked:IOnceSignal = new Signal();
    private const spacing:int = 7;

    public var goldButton:LegacyBuyButton;
    public var fameButton:LegacyBuyButton;
    private var prefix:TextFieldDisplayConcrete;
    private var or:TextFieldDisplayConcrete;
    private var disabled:Boolean = false;

    public function FameOrGoldBuyButtons() {
        this.goldButton = new LegacyBuyButton("", 14, 0, Currency.GOLD);
        this.fameButton = new LegacyBuyButton("", 14, 0, Currency.FAME);
        this.prefix = this.makeTextField();
        this.or = this.makeTextField().setStringBuilder(new LineBuilder().setParams(TextKey.BUTTON_BAR_OR));
        super();
        this.goldButton.addEventListener(MouseEvent.CLICK, this.onGoldClick);
        this.fameButton.addEventListener(MouseEvent.CLICK, this.onFameClick);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.fameButton.readyForPlacement.add(this.positionComponents);
        this.goldButton.readyForPlacement.add(this.positionComponents);
        this.prefix.textChanged.add(this.positionComponents);
    }

    public function setDisabled(_arg_1:Boolean):void {
        if (this.disabled != _arg_1) {
            this.disabled = _arg_1;
            this.goldButton.setEnabled(!(this.disabled));
            this.fameButton.setEnabled(!(this.disabled));
        }
    }

    public function isDisabled():Boolean {
        return (this.disabled);
    }

    public function setGoldPrice(_arg_1:int):void {
        this.goldButton.setPrice(_arg_1, Currency.GOLD);
        ((!(contains(this.goldButton))) && (addChild(this.goldButton)));
    }

    public function getGoldPrice():int {
        return (this.goldButton.getPrice());
    }

    public function setPrefix(_arg_1:String):void {
        this.prefix.setStringBuilder(new LineBuilder().setParams(_arg_1));
        ((!(contains(this.prefix))) && (addChild(this.prefix)));
    }

    public function clearFameAndGold():void {
        ((contains(this.goldButton)) && (removeChild(this.goldButton)));
        ((contains(this.fameButton)) && (removeChild(this.fameButton)));
        ((contains(this.or)) && (removeChild(this.or)));
    }

    private function positionComponents():void {
        if (contains(this.goldButton)) {
            this.goldButton.x = (this.prefix.width + this.spacing);
        }
        if (contains(this.fameButton)) {
            if (contains(this.goldButton)) {
                ((!(contains(this.or))) && (addChild(this.or)));
                this.or.textChanged.addOnce(this.positionComponents);
                this.or.x = ((this.goldButton.x + this.goldButton.width) + this.spacing);
                this.fameButton.x = ((this.or.x + this.or.width) + this.spacing);
            }
            else {
                this.fameButton.x = (this.prefix.width + this.spacing);
            }
        }
        this.positioned.dispatch();
    }

    public function setFamePrice(_arg_1:int):void {
        this.fameButton.setPrice(_arg_1, Currency.FAME);
        ((!(contains(this.fameButton))) && (addChild(this.fameButton)));
    }

    public function getFamePrice():int {
        return (this.fameButton.getPrice());
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.goldButton.removeEventListener(MouseEvent.CLICK, this.onGoldClick);
        this.fameButton.removeEventListener(MouseEvent.CLICK, this.onFameClick);
        this.fameButton.readyForPlacement.remove(this.positionComponents);
        this.goldButton.readyForPlacement.remove(this.positionComponents);
        this.prefix.textChanged.remove(this.positionComponents);
    }

    private function onFameClick(_arg_1:MouseEvent):void {
        if (!this.disabled) {
            this.fameButtonClicked.dispatch(this.fameButton.price);
            this.clicked.dispatch();
        }
        this.setDisabled(true);
    }

    private function onGoldClick(_arg_1:MouseEvent):void {
        if (!this.disabled) {
            this.goldButtonClicked.dispatch(this.goldButton.price);
            this.clicked.dispatch();
        }
        this.setDisabled(true);
    }

    private function makeTextField():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setBold(true);
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        _local_1.y = 3;
        return (_local_1);
    }


}
}//package kabam.rotmg.pets.view.components
