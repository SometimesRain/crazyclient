package kabam.rotmg.pets.view.dialogs {
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.view.components.PetIcon;
import kabam.rotmg.pets.view.components.PetIconFactory;

public class PetItemFactory {

    [Inject]
    public var petIconFactory:PetIconFactory;


    public function create(_arg_1:PetVO, _arg_2:int):PetItem {
        var _local_3:PetItem = new PetItem();
        var _local_4:PetIcon = this.petIconFactory.create(_arg_1, _arg_2);
        _local_3.setPetIcon(_local_4);
        _local_3.setSize(_arg_2);
        _local_3.setBackground(PetItem.REGULAR);
        return (_local_3);
    }


}
}//package kabam.rotmg.pets.view.dialogs
