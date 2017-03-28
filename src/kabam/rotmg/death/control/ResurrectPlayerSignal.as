package kabam.rotmg.death.control {
import kabam.rotmg.messaging.impl.incoming.Death;

import org.osflash.signals.Signal;

public class ResurrectPlayerSignal extends Signal {

    public function ResurrectPlayerSignal() {
        super(Death);
    }

}
}//package kabam.rotmg.death.control
