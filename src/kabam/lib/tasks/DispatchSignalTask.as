package kabam.lib.tasks {
import org.osflash.signals.Signal;

public class DispatchSignalTask extends BaseTask {

    private var signal:Signal;
    private var params:Array;

    public function DispatchSignalTask(_arg_1:Signal, ... rest) {
        this.signal = _arg_1;
        this.params = rest;
    }

    override protected function startTask():void {
        this.signal.dispatch.apply(null, this.params);
        completeTask(true);
    }


}
}//package kabam.lib.tasks
