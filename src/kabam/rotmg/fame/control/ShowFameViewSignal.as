package kabam.rotmg.fame.control {
import kabam.rotmg.fame.model.FameVO;

import org.osflash.signals.Signal;

public class ShowFameViewSignal extends Signal {

    public function ShowFameViewSignal() {
        super(FameVO);
    }

}
}//package kabam.rotmg.fame.control
