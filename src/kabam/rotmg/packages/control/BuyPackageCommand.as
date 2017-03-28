package kabam.rotmg.packages.control {
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.packages.services.BuyPackageTask;

public class BuyPackageCommand {

    [Inject]
    public var buyPackageTask:BuyPackageTask;
    [Inject]
    public var taskMonitor:TaskMonitor;


    public function execute():void {
        this.taskMonitor.add(this.buyPackageTask);
        this.buyPackageTask.start();
    }


}
}//package kabam.rotmg.packages.control
