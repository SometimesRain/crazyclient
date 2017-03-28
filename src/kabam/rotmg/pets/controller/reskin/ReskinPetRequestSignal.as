package kabam.rotmg.pets.controller.reskin {
import kabam.rotmg.pets.data.ReskinPetVO;

import org.osflash.signals.Signal;

public class ReskinPetRequestSignal extends Signal {

    public function ReskinPetRequestSignal() {
        super(ReskinPetVO);
    }

}
}//package kabam.rotmg.pets.controller.reskin
