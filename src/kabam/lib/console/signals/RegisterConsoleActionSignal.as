package kabam.lib.console.signals {
import kabam.lib.console.vo.ConsoleAction;

import org.osflash.signals.Signal;

public final class RegisterConsoleActionSignal extends Signal {

    public function RegisterConsoleActionSignal() {
        super(ConsoleAction, Signal);
    }

}
}//package kabam.lib.console.signals
