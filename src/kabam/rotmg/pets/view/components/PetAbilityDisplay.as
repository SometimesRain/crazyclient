package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.ISlot;
import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeSignal;

public class PetAbilityDisplay extends Sprite {

    public const addToolTip:Signal = new Signal(ToolTip);

    public var valueTextField:TextFieldDisplayConcrete;
    private var rollOver:ISlot;
    private var labelTextField:TextFieldDisplayConcrete;
    private var vo:AbilityVO;
    private var spacing:int;
    private var textColor:int;
    private var tooltip:PetAbilityTooltip;

    public function PetAbilityDisplay(_arg_1:AbilityVO, _arg_2:int) {
        this.vo = _arg_1;
        this.spacing = _arg_2;
        this.rollOver = new NativeSignal(this, MouseEvent.MOUSE_OVER).add(this.onRollOver);
        this.textColor = ((_arg_1.getUnlocked()) ? 0xB3B3B3 : 0x666666);
        this.updateTextFields();
        this.makeBullet();
        _arg_1.updated.add(this.onUpdated);
    }

    public function destroy():void {
        this.vo.updated.remove(this.onUpdated);
    }

    private function onUpdated(_arg_1:AbilityVO):void {
        this.setLevelText();
    }

    private function onRollOver(_arg_1:MouseEvent):void {
        this.tooltip = new PetAbilityTooltip(this.vo);
        this.tooltip.attachToTarget(this);
        this.addToolTip.dispatch(this.tooltip);
    }

    private function makeBullet():void {
        graphics.beginFill(this.textColor);
        graphics.drawCircle(0, -5, 1.5);
    }

    private function updateTextFields():void {
        this.makeLabelTextfield();
        if (this.vo.getUnlocked()) {
            this.makeValueTextField();
        }
    }

    private function makeValueTextField():void {
        this.valueTextField = PetsViewAssetFactory.returnTextfield(this.textColor, 13, true);
        addChild(this.valueTextField);
        this.waitForTextChanged();
        this.setLevelText();
        (((this.vo.level >= PetsConstants.MAX_LEVEL)) && (this.valueTextField.setColor(PetsConstants.COLOR_GREEN_TEXT_HIGHLIGHT)));
    }

    private function setLevelText():void {
        if (this.valueTextField) {
            this.valueTextField.setStringBuilder(new LineBuilder().setParams(this.getLevelKey(this.vo), {"level": this.vo.level}));
        }
    }

    private function makeLabelTextfield():void {
        this.labelTextField = PetsViewAssetFactory.returnTextfield(this.textColor, 13, true);
        this.labelTextField.setStringBuilder(new LineBuilder().setParams(this.vo.name));
        this.labelTextField.x = 3;
        addChild(this.labelTextField);
    }

    private function getLevelKey(_arg_1:AbilityVO):String {
        return ((((_arg_1.level < PetsConstants.MAX_LEVEL)) ? TextKey.PET_ABILITY_LEVEL : TextKey.PET_ABILITY_LEVEL_MAX));
    }

    private function waitForTextChanged():void {
        var _local_1:SignalWaiter = new SignalWaiter();
        _local_1.push(this.valueTextField.textChanged);
        _local_1.complete.addOnce(this.positionTextField);
    }

    private function positionTextField():void {
        this.valueTextField.x = (this.spacing - this.valueTextField.width);
    }


}
}//package kabam.rotmg.pets.view.components
