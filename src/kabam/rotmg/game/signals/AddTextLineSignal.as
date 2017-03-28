package kabam.rotmg.game.signals {
import kabam.lib.signals.DeferredQueueSignal;
import kabam.rotmg.chat.model.ChatMessage;

public class AddTextLineSignal extends DeferredQueueSignal {

    public function AddTextLineSignal() {
        super(ChatMessage);
    }

}
}//package kabam.rotmg.game.signals
