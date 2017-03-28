package kabam.rotmg.game.signals {
import kabam.rotmg.game.model.GameInitData;

import org.osflash.signals.Signal;

public class PlayGameSignal extends Signal {

    public function PlayGameSignal() {
        super(GameInitData);
    }

}
}//package kabam.rotmg.game.signals
