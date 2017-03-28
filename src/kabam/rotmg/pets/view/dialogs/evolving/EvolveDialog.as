package kabam.rotmg.pets.view.dialogs.evolving {
import com.company.assembleegameclient.ui.dialogs.CloseDialogComponent;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.dialogs.DialogCloser;

import kabam.rotmg.pets.view.dialogs.PetDialog;

import org.osflash.signals.Signal;

public class EvolveDialog extends PetDialog implements DialogCloser {

    private static const VERTICAL_SPACE:int = 6;

    private const closeDialogComponent:CloseDialogComponent = new CloseDialogComponent();

    public var evolveAnimation:EvolveAnimation;

    public function EvolveDialog(_arg_1:EvolveAnimation) {
        this.evolveAnimation = _arg_1;
        super("EvolveDialog.title", "", "ErrorDialog.ok", null, null);
        this.closeDialogComponent.add(this, Dialog.LEFT_BUTTON);
        dialogWidth = (_arg_1.width + 1);
    }

    override protected function makeUIAndAdd():void {
        box_.addChild(this.evolveAnimation);
    }

    override protected function drawAdditionalUI():void {
        this.evolveAnimation.x = ((dialogWidth - this.evolveAnimation.width) / 2);
        this.evolveAnimation.y = (titleText_.getBounds(box_).bottom + VERTICAL_SPACE);
    }

    override protected function drawGraphicsTemplate():void {
        super.drawGraphicsTemplate();
        var _local_1:Number = this.evolveAnimation.getBounds(rect_).bottom;
        petDialogStyler.drawLine(_local_1);
    }

    public function getCloseSignal():Signal {
        return (this.closeDialogComponent.getCloseSignal());
    }


}
}//package kabam.rotmg.pets.view.dialogs.evolving
