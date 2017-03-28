package kabam.lib.tasks {
public class TaskGroup extends BaseTask {

    private var tasks:Vector.<BaseTask>;
    private var pending:int;

    public function TaskGroup() {
        this.tasks = new Vector.<BaseTask>();
    }

    public function add(_arg_1:BaseTask):void {
        this.tasks.push(_arg_1);
    }

    override protected function startTask():void {
        this.pending = this.tasks.length;
        if (this.pending > 0) {
            this.startAllTasks();
        }
        else {
            completeTask(true);
        }
    }

    override protected function onReset():void {
        var _local_1:BaseTask;
        for each (_local_1 in this.tasks) {
            _local_1.reset();
        }
    }

    private function startAllTasks():void {
        var _local_1:int = this.pending;
        while (_local_1--) {
            this.tasks[_local_1].lastly.addOnce(this.onTaskFinished);
            this.tasks[_local_1].start();
        }
    }

    private function onTaskFinished(_arg_1:BaseTask, _arg_2:Boolean, _arg_3:String):void {
        if (_arg_2) {
            if (--this.pending == 0) {
                completeTask(true);
            }
        }
        else {
            completeTask(false, _arg_3);
        }
    }

    public function toString():String {
        return ((("[TaskGroup(" + this.tasks.join(",")) + ")]"));
    }


}
}//package kabam.lib.tasks
