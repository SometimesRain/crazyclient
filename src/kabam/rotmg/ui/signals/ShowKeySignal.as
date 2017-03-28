package kabam.rotmg.ui.signals {
import kabam.rotmg.ui.model.Key;

import org.osflash.signals.Signal;

public class ShowKeySignal extends Signal {

    public static var instance:ShowKeySignal;

    public function ShowKeySignal() {
        super(Key);
        instance = this;
    }

}
}//package kabam.rotmg.ui.signals
