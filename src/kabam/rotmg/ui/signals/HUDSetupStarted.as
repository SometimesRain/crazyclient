package kabam.rotmg.ui.signals {
import com.company.assembleegameclient.game.GameSprite;

import org.osflash.signals.Signal;

public class HUDSetupStarted extends Signal {

    public function HUDSetupStarted() {
        super(GameSprite);
    }

}
}//package kabam.rotmg.ui.signals
