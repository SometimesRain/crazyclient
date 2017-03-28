package kabam.rotmg.errors.control {
import flash.events.ErrorEvent;

import org.osflash.signals.Signal;

public class ErrorSignal extends Signal {

    public function ErrorSignal() {
        super(ErrorEvent);
    }

}
}//package kabam.rotmg.errors.control
