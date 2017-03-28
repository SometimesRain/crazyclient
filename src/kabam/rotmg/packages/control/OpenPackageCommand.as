package kabam.rotmg.packages.control {
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.packages.model.PackageInfo;
import kabam.rotmg.packages.services.PackageModel;
import kabam.rotmg.packages.view.PackageOfferDialog;
import com.company.assembleegameclient.parameters.Parameters;

import robotlegs.bender.bundles.mvcs.Command;

public class OpenPackageCommand extends Command {

    [Inject]
    public var openDialogSignal:OpenDialogSignal;
    [Inject]
    public var packageModel:PackageModel;
    [Inject]
    public var packageId:int;
    [Inject]
    public var alreadyBoughtPackage:AlreadyBoughtPackageSignal;

    override public function execute():void {
        var _local_1:PackageInfo;
        if (this.packageModel.canPurchasePackage(this.packageId)) {
            _local_1 = this.packageModel.getPackageById(this.packageId);
			this.openDialogSignal.dispatch(new PackageOfferDialog().setPackage(_local_1));
        }
        else {
            this.alreadyBoughtPackage.dispatch();
        }
    }


}
}//package kabam.rotmg.packages.control
