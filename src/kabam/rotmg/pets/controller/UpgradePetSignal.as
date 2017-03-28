package kabam.rotmg.pets.controller {
import kabam.rotmg.pets.data.IUpgradePetRequestVO;

import org.osflash.signals.Signal;

public class UpgradePetSignal extends Signal {

    public function UpgradePetSignal() {
        super(IUpgradePetRequestVO);
    }

}
}//package kabam.rotmg.pets.controller
