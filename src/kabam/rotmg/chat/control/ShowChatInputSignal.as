package kabam.rotmg.chat.control {
import org.osflash.signals.Signal;

public class ShowChatInputSignal extends Signal {

    public function ShowChatInputSignal() {
        super(Boolean, String);
    }

}
}//package kabam.rotmg.chat.control
