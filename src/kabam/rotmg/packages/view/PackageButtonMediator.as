package kabam.rotmg.packages.view {
import kabam.rotmg.packages.control.OpenPackageSignal;
import kabam.rotmg.packages.model.PackageInfo;
import kabam.rotmg.packages.services.GetPackagesTask;
import kabam.rotmg.packages.services.PackageModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PackageButtonMediator extends Mediator {

    [Inject]
    public var getPackageTask:GetPackagesTask;
    [Inject]
    public var view:PackageButton;
    [Inject]
    public var packageModel:PackageModel;
    [Inject]
    public var openPackageSignal:OpenPackageSignal;
    private var packageInfo:PackageInfo;
    private var dataSet:Boolean;


    override public function initialize():void {
        this.packageModel.dataChanged.add(this.onDataChanged);
        this.view.clicked.add(this.onClicked);
        this.view.init();
        if (this.packageModel.getInitialized()) {
            this.setData();
        }
        else {
            this.view.visible = false;
            this.getPackageTask.start();
        }
    }

    override public function destroy():void {
        this.view.clicked.remove(this.onClicked);
        if (this.dataSet) {
            this.packageInfo.quantityChanged.remove(this.onUpdateQuantity);
            this.packageInfo.durationChanged.remove(this.onUpdateDuration);
            this.packageInfo.dataChanged.remove(this.onDataChanged);
        }
    }

    private function onUpdateDuration(_arg_1:int):void {
        this.view.setDuration(_arg_1);
    }

    private function onUpdateQuantity(_arg_1:int):void {
        if (_arg_1 <= 0) {
            this.view.visible = false;
        }
        else {
            this.view.setQuantity(_arg_1);
        }
    }

    private function onDataChanged():void {
        this.view.visible = true;
        this.setData();
    }

    private function setData():void {
        this.packageInfo = this.packageModel.getPriorityPackage();
        this.dataSet = true;
        this.packageInfo.quantityChanged.add(this.onUpdateQuantity);
        this.packageInfo.durationChanged.add(this.onUpdateDuration);
        this.view.setDuration(this.packageInfo.getDuration());
        this.view.setQuantity(this.packageInfo.quantity);
    }

    private function onClicked():void {
        this.openPackageSignal.dispatch(this.packageModel.getPriorityPackage().packageID);
    }


}
}//package kabam.rotmg.packages.view
