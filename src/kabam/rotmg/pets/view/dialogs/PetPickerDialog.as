package kabam.rotmg.pets.view.dialogs {
import com.company.assembleegameclient.ui.LineBreakDesign;

import kabam.lib.ui.api.Size;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;

public class PetPickerDialog extends PetDialog {

    private static const padding:int = 12;
    private static const pickerHeight:int = 217;

    public var petPicker:PetPicker;
    public var closeButton:DialogCloseButton;

    public function PetPickerDialog(_arg_1:PetPicker) {
        super("PetPicker.title", "PetPicker.text", null, null, null);
        this.petPicker = _arg_1;
        this.makePetPicker();
        this.closeButton = PetsViewAssetFactory.returnCloseButton(dialogWidth);
        box_.addChild(this.closeButton);
    }

    override protected function setDialogWidth():int {
        return (330);
    }

    private function makePetPicker():void {
        this.petPicker.setSize(new Size((dialogWidth - (padding * 2)), pickerHeight));
        this.petPicker.setPadding(8);
        this.petPicker.setPetSize(48);
    }

    override protected function drawAdditionalUI():void {
        super.drawAdditionalUI();
        this.addLineBreak();
        this.addPetPicker();
    }

    private function addPetPicker():void {
        this.petPicker.x = padding;
        this.petPicker.y = this.getBoxBottomWithPadding();
        box_.addChild(this.petPicker);
    }

    private function addLineBreak():void {
        var _local_1:LineBreakDesign;
        _local_1 = new LineBreakDesign((dialogWidth - (padding * 2)), 0);
        _local_1.x = padding;
        _local_1.y = this.getBoxBottomWithPadding();
        box_.addChild(_local_1);
    }

    private function getBoxBottomWithPadding():Number {
        return ((box_.getBounds(this).bottom + padding));
    }

    override protected function getBoxHeight():Number {
        return ((super.getBoxHeight() - (this.petPicker.height - pickerHeight)));
    }


}
}//package kabam.rotmg.pets.view.dialogs
