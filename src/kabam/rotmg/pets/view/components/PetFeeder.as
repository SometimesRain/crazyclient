package kabam.rotmg.pets.view.components {
import flash.display.Sprite;

import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.pets.view.components.slot.PetFeedFuseSlot;

import org.osflash.signals.Signal;

public class PetFeeder extends Sprite {

    public const openPetPicker:Signal = new Signal();
    public const acceptableMatch:Signal = new Signal(Boolean, PetVO);
    public const petLoaded:Signal = new Signal(PetVO);

    private var leftSlot:PetFeedFuseSlot;
    private var arrow:FeedFuseArrow;
    private var rightSlot:FoodFeedFuseSlot;
    private var state:PetSlotsState;

    public function PetFeeder() {
        this.leftSlot = new PetFeedFuseSlot();
        this.arrow = PetsViewAssetFactory.returnPetFeederArrow();
        this.rightSlot = PetsViewAssetFactory.returnPetFeederRightSlot();
        super();
        addChild(this.leftSlot);
        addChild(this.arrow);
        addChild(this.rightSlot);
        this.leftSlot.openPetPicker.addOnce(this.onOpenPetPicker);
        this.rightSlot.foodLoaded.add(this.onFoodLoaded);
        this.rightSlot.foodUnloaded.add(this.onFoodUnloaded);
    }

    public function initialize(_arg_1:PetSlotsState):void {
        this.state = _arg_1;
        this.setPet(this.state.leftSlotPetVO);
        this.update();
    }

    public function setPet(_arg_1:PetVO):void {
        this.leftSlot.setPet(_arg_1);
        if (_arg_1) {
            this.petLoaded.dispatch(_arg_1);
        }
    }

    public function clearFood():void {
        this.state.rightSlotItemId = -1;
        this.state.rightSlotOwnerId = -1;
        this.state.rightSlotId = -1;
        this.rightSlot.clearItem();
        this.update();
    }

    private function onFoodUnloaded():void {
        this.state.rightSlotItemId = -1;
        this.state.rightSlotOwnerId = -1;
        this.state.rightSlotId = -1;
        this.update();
    }

    private function onFoodLoaded(_arg_1:int):void {
        this.state.rightSlotItemId = _arg_1;
        this.update();
    }

    private function update():void {
        this.updateHighlights();
        this.acceptableMatch.dispatch(this.state.isAcceptableFeedState(), this.state.leftSlotPetVO);
    }

    private function onOpenPetPicker():void {
        this.openPetPicker.dispatch();
    }

    public function updateHighlights():void {
        if (this.state.isAcceptableFeedState()) {
            this.arrow.highlight(true);
            this.rightSlot.highlight(true);
            this.leftSlot.highlight(true);
        }
        else {
            this.rightSlot.highlight((this.state.rightSlotItemId == -1));
            this.leftSlot.highlight((this.state.leftSlotPetVO == null));
            this.arrow.highlight(false);
        }
    }

    public function setProcessing(_arg_1:Boolean):void {
        this.rightSlot.setProcessing(_arg_1);
        this.leftSlot.setProcessing(_arg_1);
        if (_arg_1) {
            this.arrow.highlight(false);
            this.rightSlot.highlight(false);
            this.leftSlot.highlight(false);
        }
        else {
            this.update();
        }
    }


}
}//package kabam.rotmg.pets.view.components
