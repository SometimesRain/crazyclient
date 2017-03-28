package kabam.rotmg.core.signals {
import kabam.lib.tasks.Task;

import org.osflash.signals.Signal;

public class TaskErrorSignal extends Signal {

    public function TaskErrorSignal() {
        super(Task);
    }

}
}//package kabam.rotmg.core.signals
