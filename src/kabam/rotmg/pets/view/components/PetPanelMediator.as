package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.events.MouseEvent;

import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.pets.controller.ActivatePet;
import kabam.rotmg.pets.controller.DeactivatePet;
import kabam.rotmg.pets.controller.NotifyActivePetUpdated;
import kabam.rotmg.pets.controller.ShowPetTooltip;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.view.petPanel.ConfirmReleaseDialog;
import kabam.rotmg.pets.view.petPanel.PetPanel;

import org.swiftsuspenders.Injector;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetPanelMediator extends Mediator {

    [Inject]
    public var view:PetPanel;
    [Inject]
    public var petModel:PetsModel;
    [Inject]
    public var showPetTooltip:ShowPetTooltip;
    [Inject]
    public var showToolTip:ShowTooltipSignal;
    [Inject]
    public var deactivatePet:DeactivatePet;
    [Inject]
    public var activatePet:ActivatePet;
    [Inject]
    public var notifyActivePetUpdated:NotifyActivePetUpdated;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var injector:Injector;


    override public function initialize():void {
        this.view.setState(this.returnButtonState());
        this.view.addToolTip.add(this.onAddToolTip);
        this.view.followButton.addEventListener(MouseEvent.CLICK, this.onButtonClick);
        this.view.releaseButton.addEventListener(MouseEvent.CLICK, this.onReleaseClick);
        this.view.unFollowButton.addEventListener(MouseEvent.CLICK, this.onButtonClick);
        this.notifyActivePetUpdated.add(this.onNotifyActivePetUpdated);
    }

    override public function destroy():void {
        this.view.releaseButton.removeEventListener(MouseEvent.CLICK, this.onReleaseClick);
    }

    private function onReleaseClick(_arg_1:MouseEvent):void {
        this.injector.map(PetVO).toValue(this.view.petVO);
        this.openDialog.dispatch(this.injector.getInstance(ConfirmReleaseDialog));
    }

    private function onNotifyActivePetUpdated():void {
        var _local_1:PetVO = this.petModel.getActivePet();
        this.view.toggleButtons(!(_local_1));
    }

    private function returnButtonState():uint {
        if (this.isPanelPetSameAsActivePet()) {
            return (PetsConstants.FOLLOWING);
        }
        return (PetsConstants.INTERACTING);
    }

    protected function onButtonClick(_arg_1:MouseEvent):void {
        if (this.isPanelPetSameAsActivePet()) {
            this.deactivatePet.dispatch(this.view.petVO.getID());
        }
        else {
            this.activatePet.dispatch(this.view.petVO.getID());
        }
    }

    private function onAddToolTip(_arg_1:ToolTip):void {
        this.showToolTip.dispatch(_arg_1);
    }

    private function isPanelPetSameAsActivePet():Boolean {
        return (((this.petModel.getActivePet()) ? (this.petModel.getActivePet().getID() == this.view.petVO.getID()) : false));
    }


}
}//package kabam.rotmg.pets.view.components
