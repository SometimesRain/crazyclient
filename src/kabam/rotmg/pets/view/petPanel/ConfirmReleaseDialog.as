package kabam.rotmg.pets.view.petPanel {
import com.company.assembleegameclient.ui.dialogs.CloseDialogComponent;
import com.company.assembleegameclient.ui.dialogs.Dialog;
import com.company.assembleegameclient.ui.dialogs.DialogCloser;

import flash.events.Event;

import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.dialogs.PetDialog;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class ConfirmReleaseDialog extends PetDialog implements DialogCloser {

    private const closeDialogComponent:CloseDialogComponent = new CloseDialogComponent();

    [Inject]
    public var release:ReleasePetSignal;
    private var petVO:PetVO;

    public function ConfirmReleaseDialog(_arg_1:PetVO) {
        super(TextKey.PET_PANEL_CONFIRM_TITLE, TextKey.PET_PANEL_CONFIRM__SUBTEXT, TextKey.RELEASE, TextKey.FRAME_CANCEL, null);
        this.petVO = _arg_1;
        this.addButtonBehavior();
    }

    override protected function setDialogWidth():int {
        return (400);
    }

    private function addButtonBehavior():void {
        this.closeDialogComponent.add(this, Dialog.RIGHT_BUTTON);
        this.closeDialogComponent.add(this, Dialog.LEFT_BUTTON);
        addEventListener(Dialog.LEFT_BUTTON, this.onLeftButton);
    }

    private function onLeftButton(_arg_1:Event):void {
        removeEventListener(Dialog.LEFT_BUTTON, this.onLeftButton);
        this.release.dispatch(this.petVO.getID());
    }

    public function getCloseSignal():Signal {
        return (this.closeDialogComponent.getCloseSignal());
    }

    public function getPetVO():PetVO {
        return (this.petVO);
    }


}
}//package kabam.rotmg.pets.view.petPanel
