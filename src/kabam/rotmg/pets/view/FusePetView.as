package kabam.rotmg.pets.view {
import com.company.assembleegameclient.ui.dialogs.DialogCloser;

import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.util.FeedFuseCostModel;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.FameOrGoldBuyButtons;
import kabam.rotmg.pets.view.components.FusionStrength;
import kabam.rotmg.pets.view.components.PetFuser;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class FusePetView extends PetInteractionView implements DialogCloser {

    private static const closeDialogSignal:Signal = new Signal();

    public const buttonBar:FameOrGoldBuyButtons = PetsViewAssetFactory.returnFameOrGoldButtonBar(TextKey.PET_FUSER_BUTTON_BAR_PREFIX, (PetsConstants.FUSER_WINDOW_BACKGROUND_HEIGHT - 39));
    private const background:PopupWindowBackground = PetsViewAssetFactory.returnFuserWindowBackground();
    private const titleTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(0xB3B3B3, 18, true);
    private const descriptionTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnFuseDescriptionTextfield();
    private const petFuser:PetFuser = PetsViewAssetFactory.returnPetFuser();
    private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(PetsConstants.WINDOW_BACKGROUND_WIDTH);
    private const fusionStrength:FusionStrength = PetsViewAssetFactory.returnFusionStrength();
    public const closed:Signal = new Signal();

    public var openPetPicker:Signal;
    public var goldPurchase:Signal;
    public var famePurchase:Signal;

    public function FusePetView() {
        this.buttonBar.clicked.addOnce(this.onFameOrGoldClicked);
    }

    public function init(_arg_1:PetSlotsState):void {
        this.titleTextfield.setStringBuilder(new LineBuilder().setParams(TextKey.PET_FUSER_TITLE));
        this.openPetPicker = this.petFuser.openPetPicker;
        this.goldPurchase = this.buttonBar.goldButtonClicked;
        this.famePurchase = this.buttonBar.fameButtonClicked;
        this.buttonBar.setDisabled(!(_arg_1.isAcceptableFuseState()));
        this.buttonBar.setPrefix(((_arg_1.isAcceptableFuseState()) ? TextKey.PET_FUSER_BUTTON_BAR_PREFIX : TextKey.PET_SELECT_PET));
        if (_arg_1.isAcceptableFuseState()) {
            this.buttonBar.setGoldPrice(FeedFuseCostModel.getFuseGoldCost(PetRarityEnum.selectByValue(_arg_1.leftSlotPetVO.getRarity())));
            this.buttonBar.setFamePrice(FeedFuseCostModel.getFuseFameCost(PetRarityEnum.selectByValue(_arg_1.leftSlotPetVO.getRarity())));
        }
        this.closeButton.clicked.add(this.onClose);
        this.waitForTextChanged();
        this.addChildren();
        this.positionAssets();
    }

    private function onFameOrGoldClicked():void {
        closeDialogSignal.dispatch();
    }

    public function destroy():void {
        this.buttonBar.positioned.remove(this.positionButtonBar);
    }

    private function addChildren():void {
        addChild(this.background);
        addChild(this.titleTextfield);
        addChild(this.descriptionTextfield);
        addChild(this.buttonBar);
        addChild(this.petFuser);
        addChild(this.fusionStrength);
        addChild(this.closeButton);
    }

    private function positionAssets():void {
        positionThis();
        this.positionPetFeeder();
    }

    private function positionPetFeeder():void {
        this.petFuser.x = Math.round(((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.petFuser.width) * 0.5));
    }

    private function waitForTextChanged():void {
        var _local_1:SignalWaiter = new SignalWaiter();
        _local_1.push(this.titleTextfield.textChanged);
        _local_1.push(this.descriptionTextfield.textChanged);
        _local_1.complete.addOnce(this.positionTextField);
        this.buttonBar.positioned.add(this.positionButtonBar);
    }

    private function positionTextField():void {
        this.titleTextfield.y = 5;
        this.titleTextfield.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.titleTextfield.width) * 0.5);
        this.descriptionTextfield.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.descriptionTextfield.width) * 0.5);
    }

    private function positionButtonBar():void {
        this.buttonBar.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.buttonBar.width) / 2);
    }

    private function onClose():void {
        this.closed.dispatch();
    }

    public function getCloseSignal():Signal {
        return (closeDialogSignal);
    }


}
}//package kabam.rotmg.pets.view
