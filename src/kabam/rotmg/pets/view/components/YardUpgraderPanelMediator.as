package kabam.rotmg.pets.view.components {
import flash.events.MouseEvent;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.pets.data.PetYardEnum;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.YardUpgraderView;
import kabam.rotmg.pets.view.dialogs.CaretakerQueryDialog;

import robotlegs.bender.bundles.mvcs.Mediator;

public class YardUpgraderPanelMediator extends Mediator {

    [Inject]
    public var view:YardUpgraderPanel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var petModel:PetsModel;
    [Inject]
    public var account:Account;


    override public function initialize():void {
        this.view.init(this.doShowUpgradeButton());
        this.setEventListeners();
    }

    private function setEventListeners():void {
        if (this.view.upgradeYardButton) {
            this.view.upgradeYardButton.addEventListener(MouseEvent.CLICK, this.onButtonLeftClick);
            this.view.infoButton.addEventListener(MouseEvent.CLICK, this.onButtonRightClick);
        }
        else {
            this.view.infoButton.addEventListener(MouseEvent.CLICK, this.onButtonRightClick);
        }
    }

    private function doShowUpgradeButton():Boolean {
        var _local_1:int;
        if (!this.account.isRegistered()) {
            return (false);
        }
        _local_1 = this.petModel.getPetYardType();
        return ((_local_1 < PetYardEnum.MAX_ORDINAL));
    }

    override public function destroy():void {
        super.destroy();
    }

    protected function onButtonRightClick(_arg_1:MouseEvent):void {
        this.openDialog.dispatch(new CaretakerQueryDialog());
    }

    protected function onButtonLeftClick(_arg_1:MouseEvent):void {
        this.openDialog.dispatch(new YardUpgraderView());
    }


}
}//package kabam.rotmg.pets.view.components
