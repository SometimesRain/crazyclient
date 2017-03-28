package kabam.rotmg.pets.view {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.pets.controller.UpgradePetSignal;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.data.UpgradePetYardRequestVO;
import kabam.rotmg.pets.data.YardUpgraderVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class YardUpgraderMediator extends Mediator {

    [Inject]
    public var view:YardUpgraderView;
    [Inject]
    public var petModel:PetsModel;
    [Inject]
    public var upgradePet:UpgradePetSignal;
    [Inject]
    public var account:Account;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;


    override public function initialize():void {
        var _local_1:YardUpgraderVO = new YardUpgraderVO();
        var _local_2:int = this.petModel.getPetYardRarity();
        var _local_3:int = (((_local_2 < PetRarityEnum.DIVINE.ordinal)) ? PetRarityEnum.selectByOrdinal((_local_2 + 1)).ordinal : PetRarityEnum.DIVINE.ordinal);
        _local_1.currentRarityLevel = PetRarityEnum.selectByOrdinal(_local_2).value;
        _local_1.nextRarityLevel = PetRarityEnum.selectByOrdinal(_local_3).value;
        _local_1.famePrice = this.petModel.getPetYardUpgradeFamePrice();
        _local_1.goldPrice = this.petModel.getPetYardUpgradeGoldPrice();
        this.view.init(_local_1);
        this.view.famePurchase.add(this.onFamePurchase);
        this.view.goldPurchase.add(this.onGoldPurchase);
    }

    private function onGoldPurchase(_arg_1:int):void {
        this.purchaseUpgrade(0);
    }

    private function onFamePurchase(_arg_1:int):void {
        this.purchaseUpgrade(1);
    }

    private function purchaseUpgrade(_arg_1:uint):void {
        var _local_2:int = this.petModel.getPetYardObjectID();
        var _local_3:UpgradePetYardRequestVO = new UpgradePetYardRequestVO(_local_2, _arg_1);
        this.closeDialog.dispatch();
        this.upgradePet.dispatch(_local_3);
    }


}
}//package kabam.rotmg.pets.view
