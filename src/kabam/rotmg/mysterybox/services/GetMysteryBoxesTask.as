package kabam.rotmg.mysterybox.services {
import com.company.assembleegameclient.util.TimeUtil;

import flash.utils.getTimer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.model.FortuneInfo;
import kabam.rotmg.fortune.services.FortuneModel;
import kabam.rotmg.language.model.LanguageModel;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;

import robotlegs.bender.framework.api.ILogger;

public class GetMysteryBoxesTask extends BaseTask {

    private static const TEN_MINUTES:int = 600;
    private static var version:String = "0";

    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var mysteryBoxModel:MysteryBoxModel;
    [Inject]
    public var fortuneModel:FortuneModel;
    [Inject]
    public var account:Account;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var languageModel:LanguageModel;
    [Inject]
    public var openDialogSignal:OpenDialogSignal;
    public var lastRan:uint = 0;


    override protected function startTask():void {
        var _local_1:Number;
        var _local_2:Object;
        if (DynamicSettings.settingExists("MysteryBoxRefresh")) {
            _local_1 = DynamicSettings.getSettingValue("MysteryBoxRefresh");
        }
        else {
            _local_1 = TEN_MINUTES;
        }
        if ((((this.lastRan == 0)) || (((this.lastRan + _local_1) < (getTimer() / 1000))))) {
            this.lastRan = (getTimer() / 1000);
            completeTask(true);
            _local_2 = this.account.getCredentials();
            _local_2.language = this.languageModel.getLanguage();
            _local_2.version = version;
            this.client.sendRequest("/mysterybox/getBoxes", _local_2);
            this.client.complete.addOnce(this.onComplete);
        }
        else {
            completeTask(true);
            reset();
        }
    }

    public function clearLastRanBlock():void {
        this.lastRan = 0;
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        reset();
        if (_arg_1) {
            this.handleOkay(_arg_2);
        }
        else {
            this.logger.warn("GetPackageTask.onComplete: Request failed.");
            completeTask(false);
        }
    }

    private function handleOkay(_arg_1:*):void {
        var _local_2:XMLList;
        var _local_3:XMLList;
        if (this.hasNoBoxes(_arg_1)) {
            if (this.mysteryBoxModel.isInitialized()) {
                return;
            }
            this.mysteryBoxModel.setInitialized(false);
        }
        else {
            version = XML(_arg_1).attribute("version").toString();
            _local_2 = XML(_arg_1).child("MysteryBox");
            this.parse(_local_2);
            _local_3 = XML(_arg_1).child("FortuneGame");
            if (_local_3.length() > 0) {
                this.parseFortune(_local_3);
            }
        }
        completeTask(true);
    }

    private function hasNoBoxes(_arg_1:*):Boolean {
        var _local_2:XMLList = XML(_arg_1).children();
        return ((_local_2.length() == 0));
    }

    private function parseFortune(_arg_1:XMLList):void {
        var _local_2:FortuneInfo = new FortuneInfo();
        _local_2.id = _arg_1.attribute("id").toString();
        _local_2.title = _arg_1.attribute("title").toString();
        _local_2.weight = _arg_1.attribute("weight").toString();
        _local_2.description = _arg_1.Description.toString();
        _local_2.contents = _arg_1.Contents.toString();
        _local_2.priceFirstInGold = _arg_1.Price.attribute("firstInGold").toString();
        _local_2.priceFirstInToken = _arg_1.Price.attribute("firstInToken").toString();
        _local_2.priceSecondInGold = _arg_1.Price.attribute("secondInGold").toString();
        _local_2.iconImageUrl = _arg_1.Icon.toString();
        _local_2.infoImageUrl = _arg_1.Image.toString();
        _local_2.startTime = TimeUtil.parseUTCDate(_arg_1.StartTime.toString());
        _local_2.endTime = TimeUtil.parseUTCDate(_arg_1.EndTime.toString());
        _local_2.parseContents();
        this.fortuneModel.setFortune(_local_2);
    }

    private function parse(_arg_1:XMLList):void {
        var _local_4:XML;
        var _local_5:MysteryBoxInfo;
        var _local_2:Array = [];
        var _local_3:Boolean;
        for each (_local_4 in _arg_1) {
            _local_5 = new MysteryBoxInfo();
            _local_5.id = _local_4.attribute("id").toString();
            _local_5.title = _local_4.attribute("title").toString();
            _local_5.weight = _local_4.attribute("weight").toString();
            _local_5.description = _local_4.Description.toString();
            _local_5.contents = _local_4.Contents.toString();
            _local_5.priceAmount = _local_4.Price.attribute("amount").toString();
            _local_5.priceCurrency = _local_4.Price.attribute("currency").toString();
            if (_local_4.hasOwnProperty("Sale")) {
                _local_5.saleAmount = _local_4.Sale.attribute("price").toString();
                _local_5.saleCurrency = _local_4.Sale.attribute("currency").toString();
                _local_5.saleEnd = TimeUtil.parseUTCDate(_local_4.Sale.End.toString());
            }
            if(_local_4.hasOwnProperty("Left"))
            {
                _local_5.unitsLeft = _local_4.Left;
            }
            if(_local_4.hasOwnProperty("Total"))
            {
                _local_5.totalUnits = _local_4.Total;
            }
            _local_5.iconImageUrl = _local_4.Icon.toString();
            _local_5.infoImageUrl = _local_4.Image.toString();
            _local_5.startTime = TimeUtil.parseUTCDate(_local_4.StartTime.toString());
            _local_5.parseContents();
            if (((!(_local_3)) && (((_local_5.isNew()) || (_local_5.isOnSale()))))) {
                _local_3 = true;
            }
            _local_2.push(_local_5);
        }
        this.mysteryBoxModel.setMysetryBoxes(_local_2);
        this.mysteryBoxModel.isNew = _local_3;
    }


}
}//package kabam.rotmg.mysterybox.services
