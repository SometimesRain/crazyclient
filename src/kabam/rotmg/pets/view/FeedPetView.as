package kabam.rotmg.pets.view {
import com.company.assembleegameclient.ui.LineBreakDesign;

import flash.events.Event;

import kabam.rotmg.pets.data.AbilityVO;
import kabam.rotmg.pets.data.PetRarityEnum;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.FeedFuseCostModel;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.FameOrGoldBuyButtons;
import kabam.rotmg.pets.view.components.PetAbilityMeter;
import kabam.rotmg.pets.view.components.PetFeeder;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class FeedPetView extends PetInteractionView {

    private const background:PopupWindowBackground = PetsViewAssetFactory.returnWindowBackground(PetsConstants.WINDOW_BACKGROUND_WIDTH, PetsConstants.WINDOW_BACKGROUND_HEIGHT);
    private const titleTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTopAlignedTextfield(0xB3B3B3, 18, true);
    private const buttonBar:FameOrGoldBuyButtons = PetsViewAssetFactory.returnFameOrGoldButtonBar(TextKey.PET_FEEDER_BUTTON_BAR_PREFIX, (PetsConstants.WINDOW_BACKGROUND_HEIGHT - 35));
    private const petFeeder:PetFeeder = PetsViewAssetFactory.returnPetFeeder();
    private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(PetsConstants.WINDOW_BACKGROUND_WIDTH);
    private const abilityMeters:Vector.<PetAbilityMeter> = PetsViewAssetFactory.returnAbilityMeters();
    private const abilityMeterAnimating:Vector.<Boolean> = Vector.<Boolean>([false, false, false]);
    private const lineBreakDesign:LineBreakDesign = new LineBreakDesign((PetsConstants.WINDOW_BACKGROUND_WIDTH - 25), 0);
    public const openPetPicker:Signal = new Signal();
    public const closed:Signal = new Signal();

    public var famePurchase:Signal;
    public var goldPurchase:Signal;


    public function init():void {
        this.titleTextfield.setStringBuilder(new LineBuilder().setParams(TextKey.PET_FEEDER_TITLE));
        this.petFeeder.openPetPicker.addOnce(this.onOpenPetPicker);
        this.famePurchase = this.buttonBar.fameButtonClicked;
        this.goldPurchase = this.buttonBar.goldButtonClicked;
        this.closeButton.clicked.add(this.onClosed);
        this.petFeeder.acceptableMatch.add(this.onAcceptableMatch);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        this.waitForTextChanged();
        this.addChildren();
        this.positionAssets();
    }

    public function resetFeed():void {
        this.petFeeder.clearFood();
        this.petFeeder.updateHighlights();
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        this.petFeeder.acceptableMatch.remove(this.onAcceptableMatch);
        this.closeButton.clicked.remove(this.onClosed);
    }

    private function onAcceptableMatch(_arg_1:Boolean, _arg_2:PetVO):void {
        var _local_3:PetRarityEnum;
        this.buttonBar.setDisabled(!(_arg_1));
        if (_arg_2) {
            if (!_arg_2.maxedAllAbilities()) {
                this.buttonBar.setPrefix(TextKey.PET_FEEDER_BUTTON_BAR_PREFIX);
                _local_3 = PetRarityEnum.selectByValue(_arg_2.getRarity());
                this.buttonBar.setGoldPrice(FeedFuseCostModel.getFeedGoldCost(_local_3));
                this.buttonBar.setFamePrice(FeedFuseCostModel.getFeedFameCost(_local_3));
            }
            else {
                this.buttonBar.clearFameAndGold();
                this.buttonBar.setPrefix(TextKey.PET_FULLY_MAXED);
            }
        }
        else {
            this.buttonBar.setPrefix(TextKey.PET_SELECT_PET);
        }
    }

    private function onClosed():void {
        this.closed.dispatch();
    }

    private function onOpenPetPicker():void {
        this.openPetPicker.dispatch();
    }

    public function destroy():void {
        var _local_1:PetAbilityMeter;
        for each (_local_1 in this.abilityMeters) {
            _local_1.animating.remove(this.onAnimating);
        }
        this.buttonBar.positioned.remove(this.positionButtonBar);
    }

    public function setAbilityMeterLabels(_arg_1:Array, _arg_2:int):void {
        var _local_4:AbilityVO;
        var _local_5:PetAbilityMeter;
        var _local_6:PetAbilityMeter;
        var _local_3:int;
        if (_arg_1 == null) {
            for each (_local_5 in this.abilityMeters) {
                _local_5.visible = false;
            }
        }
        for each (_local_4 in _arg_1) {
            if (_local_3 < this.abilityMeters.length) {
                _local_6 = this.abilityMeters[_local_3];
                _local_6.index = _local_3;
                _local_6.max = _arg_2;
                _local_6.visible = true;
                _local_6.initializeData(_local_4);
                _local_6.animating.add(this.onAnimating);
                _local_3++;
            }
        }
    }

    private function onAnimating(_arg_1:PetAbilityMeter, _arg_2:Boolean):void {
        this.abilityMeterAnimating[_arg_1.index] = _arg_2;
        var _local_3:Boolean = this.hasAnimatingBars();
        this.buttonBar.setDisabled(_local_3);
        this.petFeeder.setProcessing(_local_3);
        ((!(_local_3)) && (this.petFeeder.clearFood()));
    }

    private function hasAnimatingBars():Boolean {
        var _local_2:Boolean;
        var _local_1:Boolean;
        for each (_local_2 in this.abilityMeterAnimating) {
            if (_local_2) {
                _local_1 = true;
                break;
            }
        }
        return (_local_1);
    }

    private function addChildren():void {
        var _local_1:PetAbilityMeter;
        addChild(this.background);
        addChild(this.titleTextfield);
        addChild(this.buttonBar);
        addChild(this.petFeeder);
        addChild(this.closeButton);
        addChild(this.lineBreakDesign);
        for each (_local_1 in this.abilityMeters) {
            _local_1.visible = false;
            addChild(_local_1);
        }
    }

    private function positionAssets():void {
        positionThis();
        this.positionLinebreak();
        this.positionPetFeeder();
    }

    private function positionPetFeeder():void {
        this.petFeeder.x = Math.round(((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.petFeeder.width) * 0.5));
    }

    private function waitForTextChanged():void {
        var _local_2:PetAbilityMeter;
        this.titleTextfield.textChanged.addOnce(this.positionTextField);
        var _local_1:SignalWaiter = new SignalWaiter();
        for each (_local_2 in this.abilityMeters) {
            _local_1.push(_local_2.positioned);
        }
        _local_1.complete.addOnce(this.positionMeters);
        this.buttonBar.positioned.add(this.positionButtonBar);
    }

    private function positionTextField():void {
        this.titleTextfield.y = 5;
        this.titleTextfield.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.titleTextfield.width) * 0.5);
    }

    private function positionMeters():void {
        var _local_2:PetAbilityMeter;
        var _local_1:int = (this.lineBreakDesign.y + 14);
        for each (_local_2 in this.abilityMeters) {
            _local_2.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - 227) * 0.5);
            _local_2.y = _local_1;
            _local_1 = (_local_1 + (_local_2.height + 10));
        }
    }

    private function positionLinebreak():void {
        this.lineBreakDesign.x = (((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.lineBreakDesign.width) + 8) * 0.5);
        this.lineBreakDesign.y = 152;
    }

    private function positionButtonBar():void {
        this.buttonBar.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.buttonBar.width) / 2);
    }


}
}//package kabam.rotmg.pets.view
