package kabam.rotmg.packages.services {
import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.packages.model.PackageInfo;

import robotlegs.bender.framework.api.ILogger;

public class GetPackagesTask extends BaseTask {

    private static const HOUR:int = ((1000 * 60) * 60);//3600000

    public var timer:Timer;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var packageModel:PackageModel;
    [Inject]
    public var account:Account;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var languageModel:LanguageModel;

    public function GetPackagesTask() {
        this.timer = new Timer(HOUR);
        super();
    }

    override protected function startTask():void {
        var _local_1:Object = this.account.getCredentials();
        _local_1.language = this.languageModel.getLanguage();
        this.client.sendRequest("/package/getPackages", _local_1);
        this.client.complete.addOnce(this.onComplete);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.handleOkay(_arg_2);
        }
        else {
            this.logger.warn("GetPackageTask.onComplete: Request failed.");
            completeTask(false);
        }
    }

    private function handleOkay(_arg_1:*):void {
        var _local_2:XML;
        if (this.hasNoPackage(_arg_1)) {
            this.logger.info("GetPackageTask.onComplete: No package available, retrying in 1 hour.");
            this.timer.addEventListener(TimerEvent.TIMER, this.timer_timerHandler);
            this.timer.start();
            this.packageModel.setPackages([]);
        }
        else {
            _local_2 = XML(_arg_1);
            this.parse(_local_2);
        }
        completeTask(true);
    }

    private function hasNoPackage(_arg_1:*):Boolean {
        var _local_2:XMLList = XML(_arg_1).Packages;
        return ((_local_2.length() == 0));
    }

    private function parse(_arg_1:XML):void {
        var _local_3:XML;
        var _local_4:int;
        var _local_5:String;
        var _local_6:int;
        var _local_7:int;
        var _local_8:int;
        var _local_9:int;
        var _local_10:Date;
        var _local_11:String;
        var _local_12:int;
        var _local_13:PackageInfo;
        var _local_2:Array = [];
        for each (_local_3 in _arg_1.Packages.Package) {
            _local_4 = int(_local_3.@id);
            _local_5 = String(_local_3.Name);
            _local_6 = int(_local_3.Price);
            _local_7 = int(_local_3.Quantity);
            _local_8 = int(_local_3.MaxPurchase);
            _local_9 = int(_local_3.Weight);
            _local_10 = new Date(String(_local_3.EndDate));
            _local_11 = String(_local_3.BgURL);
            _local_12 = this.getNumPurchased(_arg_1, _local_4);
            _local_13 = new PackageInfo();
            _local_13.setData(_local_4, _local_10, _local_5, _local_7, _local_8, _local_9, _local_6, _local_11, _local_12);
            _local_2.push(_local_13);
        }
        this.packageModel.setPackages(_local_2);
    }

    private function getNumPurchased(packagesXML:XML, packageID:int):int {
        var packageHistory:XMLList;
        var numPurchased:int;
        var history:XMLList = packagesXML.History;
        if (history) {
            packageHistory = history.Package.(@id == packageID);
            if (packageHistory) {
                numPurchased = int(packageHistory.Count);
            }
        }
        return (numPurchased);
    }

    private function timer_timerHandler(_arg_1:TimerEvent):void {
        this.timer.removeEventListener(TimerEvent.TIMER, this.timer_timerHandler);
        this.timer.stop();
        this.startTask();
    }


}
}//package kabam.rotmg.packages.services
