package kabam.rotmg.death.control {
import kabam.rotmg.messaging.impl.incoming.Death;

import org.osflash.signals.Signal;

public class HandleDeathSignal extends Signal {

    public function HandleDeathSignal() {
        super(Death);
    }

}
}//package kabam.rotmg.death.control
