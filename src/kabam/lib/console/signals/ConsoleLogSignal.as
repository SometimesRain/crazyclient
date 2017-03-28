package kabam.lib.console.signals {
import kabam.lib.signals.DeferredQueueSignal;

public final class ConsoleLogSignal extends DeferredQueueSignal {

    public function ConsoleLogSignal() {
        super(String);
    }

}
}//package kabam.lib.console.signals
