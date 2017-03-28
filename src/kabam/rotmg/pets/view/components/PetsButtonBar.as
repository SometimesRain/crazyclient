package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.natives.NativeSignal;

public class PetsButtonBar extends Sprite {

    public var buttonOne:DeprecatedTextButton;
    public var buttonTwo:DeprecatedTextButton;
    public var buttonOneSignal:NativeSignal;
    public var buttonTwoSignal:NativeSignal;

    public function PetsButtonBar() {
        this.buttonOne = new DeprecatedTextButton(14, "buttonOne", 70);
        this.buttonTwo = new DeprecatedTextButton(14, "buttonTwo", 70);
        this.buttonOneSignal = new NativeSignal(this.buttonOne, MouseEvent.CLICK);
        this.buttonTwoSignal = new NativeSignal(this.buttonTwo, MouseEvent.CLICK);
        super();
        this.addTextChangedWaiter();
        this.addButtons();
    }

    private function addButtons():void {
        addChild(this.buttonOne);
        addChild(this.buttonTwo);
    }

    private function addTextChangedWaiter():void {
        var _local_3:DeprecatedTextButton;
        var _local_1:Array = [this.buttonOne, this.buttonTwo];
        var _local_2:SignalWaiter = new SignalWaiter();
        for each (_local_3 in _local_1) {
            _local_2.push(_local_3.textChanged);
        }
        _local_2.complete.addOnce(this.positionButtons);
    }

    private function positionButtons():void {
        this.buttonOne.x = PetsConstants.BUTTON_BAR_SPACING;
        this.buttonTwo.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.buttonTwo.width) - PetsConstants.BUTTON_BAR_SPACING);
    }


}
}//package kabam.rotmg.pets.view.components
