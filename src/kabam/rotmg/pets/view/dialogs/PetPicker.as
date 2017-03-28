package kabam.rotmg.pets.view.dialogs {
import flash.display.DisplayObject;
import flash.events.MouseEvent;

import kabam.rotmg.pets.data.PetVO;

import org.osflash.signals.Signal;

public class PetPicker extends GridList implements ClearsPetSlots {

    [Inject]
    public var petIconFactory:PetItemFactory;
    public var petPicked:Signal;
    private var petItems:Vector.<PetItem>;
    private var petSize:int;
    private var items:Vector.<PetItem>;
    public var doDisableUsed:Boolean = true;

    public function PetPicker() {
        this.petPicked = new PetVOSignal();
        this.items = new Vector.<PetItem>();
        super();
    }

    private static function sortByFirstAbilityPoints(_arg_1:PetItem, _arg_2:PetItem):int {
        var _local_3:int = _arg_1.getPetVO().abilityList[0].points;
        var _local_4:int = _arg_2.getPetVO().abilityList[0].points;
        return ((_local_4 - _local_3));
    }


    public function setPets(_arg_1:Vector.<PetVO>):void {
        this.makePetItems(_arg_1);
        this.addToGridList();
        setItems(this.items);
        this.setCorners();
    }

    private function addToGridList():void {
        var _local_1:PetItem;
        for each (_local_1 in this.petItems) {
            this.items.push(_local_1);
        }
    }

    private function makePetItems(_arg_1:Vector.<PetVO>):void {
        var _local_2:PetVO;
        this.petItems = new Vector.<PetItem>();
        for each (_local_2 in _arg_1) {
            this.addPet(_local_2);
        }
        this.petItems.sort(sortByFirstAbilityPoints);
    }

    private function setCorners():void {
        this.setPetItemState(getTopLeft(), PetItem.TOP_LEFT);
        this.setPetItemState(getTopRight(), PetItem.TOP_RIGHT);
        this.setPetItemState(getBottomLeft(), PetItem.BOTTOM_LEFT);
        this.setPetItemState(getBottomRight(), PetItem.BOTTOM_RIGHT);
    }

    private function setPetItemState(_arg_1:DisplayObject, _arg_2:String):void {
        if (_arg_1) {
            PetItem(_arg_1).setBackground(_arg_2);
        }
    }

    public function setPetSize(_arg_1:int):void {
        this.petSize = _arg_1;
    }

    public function getPets():Vector.<PetItem> {
        return (this.petItems);
    }

    public function getPet(_arg_1:int):PetItem {
        return (this.petItems[_arg_1]);
    }

    public function filterFusible(_arg_1:PetVO):void {
        var _local_3:PetVO;
        var _local_2:int;
        while (_local_2 < this.petItems.length) {
            _local_3 = this.petItems[_local_2].getPetVO();
            if (!this.isFusible(_arg_1, _local_3)) {
                this.petItems[_local_2].disable();
            }
            _local_2++;
        }
    }

    public function filterUsedPetVO(_arg_1:PetVO):void {
        var _local_3:PetVO;
        var _local_2:int;
        while (_local_2 < this.petItems.length) {
            _local_3 = this.petItems[_local_2].getPetVO();
            if (_local_3.getID() == _arg_1.getID()) {
                this.petItems[_local_2].disable();
            }
            _local_2++;
        }
    }

    private function isFusible(_arg_1:PetVO, _arg_2:PetVO):Boolean {
        return _arg_1.getRarity() == _arg_2.getRarity() && (_arg_1.getFamily() == "Unknown" || _arg_1.getFamily() == _arg_2.getFamily());
    }

    private function addPet(petVO:PetVO):void {
        var pet:Disableable;
        var pet_clickHandler:Function;
        pet_clickHandler = function (_arg_1:MouseEvent):void {
            if (pet.isEnabled()) {
                petPicked.dispatch(petVO);
            }
        };
        pet = this.petIconFactory.create(petVO, this.petSize);
        this.petItems.push(pet);
        pet.addEventListener(MouseEvent.CLICK, pet_clickHandler);
    }


}
}//package kabam.rotmg.pets.view.dialogs
