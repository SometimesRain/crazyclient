package kabam.rotmg.pets.view {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.messaging.impl.PetUpgradeRequest;
import kabam.rotmg.pets.controller.UpgradePetSignal;
import kabam.rotmg.pets.data.FusePetRequestVO;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.view.dialogs.PetPickerDialog;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class FusePetMediator extends Mediator {

    private const ERROR_DIALOG_STRING:String = "Pets.fuseError";

    [Inject]
    public var view:FusePetView;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var petSlotsState:PetSlotsState;
    [Inject]
    public var upgradePet:UpgradePetSignal;
    [Inject]
    public var injector:Injector;


    override public function initialize():void {
        this.view.init(this.petSlotsState);
        this.view.openPetPicker.add(this.onOpenPetPicker);
        this.view.goldPurchase.add(this.onGoldPurchase);
        this.view.famePurchase.add(this.onFamePurchase);
        this.view.closed.addOnce(this.onClosed);
    }

    override public function destroy():void {
        this.view.openPetPicker.remove(this.onOpenPetPicker);
        this.view.goldPurchase.remove(this.onGoldPurchase);
        this.view.famePurchase.remove(this.onFamePurchase);
    }

    private function onOpenPetPicker(_arg_1:String):void {
        this.petSlotsState.caller = FusePetView;
        this.petSlotsState.selected = _arg_1;
        this.openDialog.dispatch(this.injector.getInstance(PetPickerDialog));
    }

    private function onFamePurchase(_arg_1:int):void {
        var _local_2:FusePetRequestVO;
        if (this.petSlotsState.isAcceptableFuseState()) {
            _local_2 = new FusePetRequestVO(this.petSlotsState.leftSlotPetVO.getID(), this.petSlotsState.rightSlotPetVO.getID(), PetUpgradeRequest.FAME_PAYMENT_TYPE);
            this.onClosed();
            this.upgradePet.dispatch(_local_2);
        }
        else {
            this.openDialog.dispatch(new ErrorDialog(this.ERROR_DIALOG_STRING));
        }
    }

    private function onGoldPurchase(_arg_1:int):void {
        var _local_2:FusePetRequestVO;
        if (this.petSlotsState.isAcceptableFuseState()) {
            _local_2 = new FusePetRequestVO(this.petSlotsState.leftSlotPetVO.getID(), this.petSlotsState.rightSlotPetVO.getID(), PetUpgradeRequest.GOLD_PAYMENT_TYPE);
            this.onClosed();
            this.upgradePet.dispatch(_local_2);
        }
        else {
            this.openDialog.dispatch(new ErrorDialog(this.ERROR_DIALOG_STRING));
        }
    }

    private function onClosed():void {
        this.petSlotsState.clear();
    }


}
}//package kabam.rotmg.pets.view
