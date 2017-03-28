package kabam.rotmg.pets.controller {
import org.osflash.signals.Signal;

public class DeletePetSignal extends Signal {

    public var petID:int;

    public function DeletePetSignal() {
        super(int);
    }

}
}//package kabam.rotmg.pets.controller
