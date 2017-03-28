package kabam.rotmg.pets.data {
public class PetSlotsState {

    public static const LEFT:String = "leftSide";
    public static const RIGHT:String = "rightSide";

    public var leftSlotPetVO:PetVO;
    public var rightSlotItemId:int = -1;
    public var rightSlotPetVO:PetVO;
    public var rightSlotOwnerId:int = -1;
    public var rightSlotId:int = -1;
    public var caller:Class;
    public var selected:String;


    public function clear():void {
        this.caller = null;
        this.leftSlotPetVO = null;
        this.rightSlotItemId = -1;
        this.rightSlotPetVO = null;
        this.rightSlotOwnerId = -1;
        this.rightSlotId = -1;
    }

    public function isAcceptableFeedState():Boolean {
        return (((((((!((this.rightSlotId == -1))) && (!((this.rightSlotOwnerId == -1))))) && (!((this.rightSlotItemId == -1))))) && (!((this.leftSlotPetVO == null)))));
    }

    public function isAcceptableFuseState():Boolean {
        return (((!((this.rightSlotPetVO == null))) && (!((this.leftSlotPetVO == null)))));
    }


}
}//package kabam.rotmg.pets.data
