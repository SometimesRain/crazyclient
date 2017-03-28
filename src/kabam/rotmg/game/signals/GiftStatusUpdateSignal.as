package kabam.rotmg.game.signals {
import org.osflash.signals.Signal;

public class GiftStatusUpdateSignal extends Signal {

    public static const HAS_GIFT:Boolean = true;
    public static const HAS_NO_GIFT:Boolean = false;

    public function GiftStatusUpdateSignal() {
        super(Boolean);
    }

}
}//package kabam.rotmg.game.signals
