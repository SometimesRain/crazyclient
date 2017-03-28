package kabam.lib.tasks {
public class BranchingTask extends BaseTask {

    private var task:Task;
    private var success:Task;
    private var failure:Task;

    public function BranchingTask(_arg_1:Task, _arg_2:Task = null, _arg_3:Task = null) {
        this.task = _arg_1;
        this.success = _arg_2;
        this.failure = _arg_3;
    }

    public function addSuccessTask(_arg_1:Task):void {
        this.success = _arg_1;
    }

    public function addFailureTask(_arg_1:Task):void {
        this.failure = _arg_1;
    }

    override protected function startTask():void {
        this.task.finished.addOnce(this.onTaskFinished);
        this.task.start();
    }

    private function onTaskFinished(_arg_1:Task, _arg_2:Boolean, _arg_3:String = ""):void {
        if (_arg_2) {
            this.handleBranchTask(this.success);
        }
        else {
            this.handleBranchTask(this.failure);
        }
    }

    private function handleBranchTask(_arg_1:Task):void {
        if (_arg_1) {
            _arg_1.finished.addOnce(this.onBranchComplete);
            _arg_1.start();
        }
        else {
            completeTask(true);
        }
    }

    private function onBranchComplete(_arg_1:Task, _arg_2:Boolean, _arg_3:String = ""):void {
        completeTask(_arg_2, _arg_3);
    }


}
}//package kabam.lib.tasks
