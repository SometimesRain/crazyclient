package kabam.rotmg.game.signals {
import kabam.rotmg.game.model.AddSpeechBalloonVO;

import org.osflash.signals.Signal;

public class AddSpeechBalloonSignal extends Signal {

    public function AddSpeechBalloonSignal() {
        super(AddSpeechBalloonVO);
    }

}
}//package kabam.rotmg.game.signals
