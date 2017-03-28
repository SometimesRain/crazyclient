package kabam.lib.tasks {
public class TaskSequence extends BaseTask {

    private var tasks:Vector.<Task>;
    private var index:int;
    private var continueOnFail:Boolean;

    public function TaskSequence() {
        this.tasks = new Vector.<Task>();
    }

    public function getContinueOnFail():Boolean {
        return (this.continueOnFail);
    }

    public function setContinueOnFail(_arg_1:Boolean):void {
        this.continueOnFail = _arg_1;
    }

    public function add(_arg_1:Task):void {
        this.tasks.push(_arg_1);
    }

    override protected function startTask():void {
        this.index = 0;
        this.doNextTaskOrComplete();
    }

    override protected function onReset():void {
        var _local_1:Task;
        for each (_local_1 in this.tasks) {
            _local_1.reset();
        }
    }

    private function doNextTaskOrComplete():void {
        if (this.isAnotherTask()) {
            this.doNextTask();
        }
        else {
            completeTask(true);
        }
    }

    private function isAnotherTask():Boolean {
        return ((this.index < this.tasks.length));
    }

    private function doNextTask():void {
        var _local_1:Task = this.tasks[this.index++];
        _local_1.lastly.addOnce(this.onTaskFinished);
        _local_1.start();
    }

    private function onTaskFinished(_arg_1:Task, _arg_2:Boolean, _arg_3:String):void {
        if (((_arg_2) || (this.continueOnFail))) {
            this.doNextTaskOrComplete();
        }
        else {
            completeTask(false, _arg_3);
        }
    }


}
}//package kabam.lib.tasks
