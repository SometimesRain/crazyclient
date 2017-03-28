package kabam.rotmg.pets.data {
import com.company.assembleegameclient.objects.ObjectLibrary;

public class PetAbilityDisplayIDGetter {


    public function getID(_arg_1:int):String {
        return (ObjectLibrary.getPetDataXMLByType(_arg_1).DisplayId);
    }


}
}//package kabam.rotmg.pets.data
