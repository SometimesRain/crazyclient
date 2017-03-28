package kabam.rotmg.pets.data {
import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class FeedPetRequestVO implements IUpgradePetRequestVO {

    public var petInstanceId:int;
    public var slotObject:SlotObjectData;
    public var paymentTransType:int;

    public function FeedPetRequestVO(_arg_1:int, _arg_2:SlotObjectData, _arg_3:int) {
        this.petInstanceId = _arg_1;
        this.slotObject = _arg_2;
        this.paymentTransType = _arg_3;
    }

}
}//package kabam.rotmg.pets.data
