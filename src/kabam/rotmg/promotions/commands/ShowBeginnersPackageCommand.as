package kabam.rotmg.promotions.commands {
import kabam.lib.tasks.BranchingTask;
import kabam.lib.tasks.DispatchSignalTask;
import kabam.lib.tasks.Task;
import kabam.lib.tasks.TaskMonitor;
import kabam.lib.tasks.TaskSequence;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.services.GetOffersTask;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;
import kabam.rotmg.promotions.service.GetDaysRemainingTask;
import kabam.rotmg.promotions.view.AlreadyPurchasedBeginnersPackageDialog;
import kabam.rotmg.promotions.view.BeginnersPackageOfferDialog;

public class ShowBeginnersPackageCommand {

    [Inject]
    public var account:Account;
    [Inject]
    public var model:BeginnersPackageModel;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var getDaysRemaining:GetDaysRemainingTask;
    [Inject]
    public var getOffers:GetOffersTask;
    [Inject]
    public var monitor:TaskMonitor;


    public function execute():void {
        var _local_1:BranchingTask = new BranchingTask(this.getDaysRemaining, this.makeSuccessTask(), this.makeFailureTask());
        this.monitor.add(_local_1);
        _local_1.start();
    }

    private function makeSuccessTask():Task {
        var _local_1:TaskSequence = new TaskSequence();
        ((this.account.isRegistered()) && (_local_1.add(this.getOffers)));
        _local_1.add(new DispatchSignalTask(this.openDialog, new BeginnersPackageOfferDialog()));
        return (_local_1);
    }

    private function makeFailureTask():Task {
        var _local_1:TaskSequence = new TaskSequence();
        _local_1.add(new DispatchSignalTask(this.openDialog, new AlreadyPurchasedBeginnersPackageDialog()));
        return (_local_1);
    }


}
}//package kabam.rotmg.promotions.commands
