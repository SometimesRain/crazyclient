package kabam.rotmg.pets.view.dialogs {
import com.company.assembleegameclient.ui.dialogs.Dialog;

public class PetDialog extends Dialog {

    protected var petDialogStyler:PetDialogStyler;

    public function PetDialog(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String) {
        this.petDialogStyler = new PetDialogStyler(this);
        super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        this.petDialogStyler.stylizePetDialog();
    }

    override protected function drawAdditionalUI():void {
        this.petDialogStyler.positionText();
    }

    override protected function drawGraphicsTemplate():void {
        this.petDialogStyler.drawGraphics();
    }


}
}//package kabam.rotmg.pets.view.dialogs
