package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Sprite;

import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetAbilityTooltip extends ToolTip {

    private const abilityContent:Sprite = new Sprite();
    private const titleTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(0xFFFFFF, 16, true, true);
    private const descriptionTextField:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(0xFFFFFF, 14, false, true);

    private var abilityVO:AbilityVO;

    public function PetAbilityTooltip(_arg_1:AbilityVO) {
        super(0x363636, 1, 0xFFFFFF, 1, true);
        this.descriptionTextField.setTextWidth(200).setWordWrap(true);
        this.abilityVO = _arg_1;
        this.addChildren();
        this.updateTextFields();
    }

    private function updateTextFields():void {
        waiter.push(this.titleTextField.textChanged);
        waiter.push(this.descriptionTextField.textChanged);
        this.titleTextField.setStringBuilder(new LineBuilder().setParams(this.abilityVO.name));
        this.descriptionTextField.setStringBuilder(new LineBuilder().setParams(this.abilityVO.description));
    }

    private function addChildren():void {
        this.abilityContent.addChild(this.titleTextField);
        this.abilityContent.addChild(this.descriptionTextField);
        addChild(this.abilityContent);
    }

    override protected function alignUI():void {
        this.titleTextField.x = PetsConstants.ABILITY_TOOLTIP_TITLE_POSITION_X;
        this.titleTextField.y = PetsConstants.ABILITY_TOOLTIP_TITLE_POSITION_Y;
        this.descriptionTextField.x = PetsConstants.ABILITY_TOOLTIP_TITLE_POSITION_X;
        this.descriptionTextField.y = (this.titleTextField.y + this.titleTextField.height);
    }


}
}//package kabam.rotmg.pets.view.components
