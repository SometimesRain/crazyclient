package kabam.rotmg.pets.data {
public class UpgradePetYardRequestVO implements IUpgradePetRequestVO {

    public var objectID:int;
    public var paymentTransType:int;

    public function UpgradePetYardRequestVO(_arg_1:int, _arg_2:int) {
        this.objectID = _arg_1;
        this.paymentTransType = _arg_2;
    }

}
}//package kabam.rotmg.pets.data
