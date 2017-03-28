package kabam.rotmg.death.control {
import kabam.rotmg.messaging.impl.incoming.Death;

import org.osflash.signals.Signal;

public class HandleNormalDeathSignal extends Signal {

    public function HandleNormalDeathSignal() {
        super(Death);
    }

}
}//package kabam.rotmg.death.control
