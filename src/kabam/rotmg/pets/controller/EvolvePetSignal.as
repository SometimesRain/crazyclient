package kabam.rotmg.pets.controller {
import kabam.rotmg.messaging.impl.EvolvePetInfo;

import org.osflash.signals.Signal;

public class EvolvePetSignal extends Signal {

    public function EvolvePetSignal() {
        super(EvolvePetInfo);
    }

}
}//package kabam.rotmg.pets.controller
