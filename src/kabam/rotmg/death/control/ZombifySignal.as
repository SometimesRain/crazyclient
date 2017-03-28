package kabam.rotmg.death.control {
import kabam.rotmg.messaging.impl.incoming.Death;

import org.osflash.signals.Signal;

public class ZombifySignal extends Signal {

    public function ZombifySignal() {
        super(Death);
    }

}
}//package kabam.rotmg.death.control
