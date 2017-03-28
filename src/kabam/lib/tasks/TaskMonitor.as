package kabam.lib.tasks {
public class TaskMonitor {

    private var tasks:Vector.<Task>;

    public function TaskMonitor() {
        this.tasks = new Vector.<Task>(0);
    }

    public function add(_arg_1:Task):void {
        this.tasks.push(_arg_1);
        _arg_1.finished.addOnce(this.onTaskFinished);
    }

    public function has(_arg_1:Task):Boolean {
        return (!((this.tasks.indexOf(_arg_1) == -1)));
    }

    private function onTaskFinished(_arg_1:Task, _arg_2:Boolean, _arg_3:String = ""):void {
        this.tasks.splice(this.tasks.indexOf(_arg_1), 1);
    }


}
}//package kabam.lib.tasks
