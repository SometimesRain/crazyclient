package kabam.rotmg.account.core.commands {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;

import flash.external.ExternalInterface;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.navigateToURL;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.model.JSInitializedModel;
import kabam.rotmg.account.core.model.MoneyConfig;
import kabam.rotmg.account.web.WebAccount;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.promotions.model.BeginnersPackageModel;

import robotlegs.bender.framework.api.ILogger;

public class ExternalOpenMoneyWindowCommand {

    private const TESTING_ERROR_MESSAGE:String = "You cannot purchase gold on the testing server";
    private const REGISTRATION_ERROR_MESSAGE:String = "You must be registered to buy gold";

    [Inject]
    public var moneyWindowModel:JSInitializedModel;
    [Inject]
    public var account:Account;
    [Inject]
    public var moneyConfig:MoneyConfig;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var buildData:BuildData;
    [Inject]
    public var openDialogSignal:OpenDialogSignal;
    [Inject]
    public var applicationSetup:ApplicationSetup;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var beginnersPackageModel:BeginnersPackageModel;


    public function execute():void {
        if (((this.isGoldPurchaseEnabled()) && (this.account.isRegistered()))) {
            this.handleValidMoneyWindowRequest();
        }
        else {
            this.handleInvalidMoneyWindowRequest();
        }
    }

    private function handleInvalidMoneyWindowRequest():void {
        if (!this.isGoldPurchaseEnabled()) {
            this.openDialogSignal.dispatch(new ErrorDialog(this.TESTING_ERROR_MESSAGE));
        }
        else {
            if (!this.account.isRegistered()) {
                this.openDialogSignal.dispatch(new ErrorDialog(this.REGISTRATION_ERROR_MESSAGE));
            }
        }
    }

    private function handleValidMoneyWindowRequest():void {
        if(this.account is WebAccount && WebAccount(this.account).paymentProvider == "paymentwall")
        {
            try
            {
                this.openPaymentwallMoneyWindowFromBrowser(WebAccount(account).paymentData);
            }
            catch(e:Error)
            {
                openPaymentwallMoneyWindowFromStandalonePlayer(WebAccount(account).paymentData);
            }
        }
        else
        {
            try
            {
                this.openKabamMoneyWindowFromBrowser();
            }
            catch(e:Error)
            {
                openKabamMoneyWindowFromStandalonePlayer();
            }
        }
    }

    private function openKabamMoneyWindowFromStandalonePlayer():void {
        var _local_1:String = this.applicationSetup.getAppEngineUrl(true);
        var _local_2:URLVariables = new URLVariables();
        var _local_3:URLRequest = new URLRequest();
        _local_2.naid = this.account.getMoneyUserId();
        _local_2.signedRequest = this.account.getMoneyAccessToken();
        if (this.beginnersPackageModel.isBeginnerAvailable()) {
            _local_2.createdat = this.beginnersPackageModel.getUserCreatedAt();
        }
        else {
            _local_2.createdat = 0;
        }
        _local_3.url = (_local_1 + "/credits/kabamadd");
        _local_3.method = URLRequestMethod.POST;
        _local_3.data = _local_2;
        navigateToURL(_local_3, "_blank");
        this.logger.debug("Opening window from standalone player");
    }

    private function openPaymentwallMoneyWindowFromStandalonePlayer(_arg_1:String):void {
        var _local_1:String = this.applicationSetup.getAppEngineUrl(true);
        var _local_2:URLVariables = new URLVariables();
        var _local_3:URLRequest = new URLRequest();
        _local_2.iframeUrl = _arg_1;
        _local_3.url = _local_1 + "/credits/pwpurchase";
        _local_3.method = URLRequestMethod.POST;
        _local_3.data = _local_2;
        navigateToURL(_local_3, "_blank");
        this.logger.debug("Opening window from standalone player");
    }

    private function initializeMoneyWindow():void {
        var _local_1:Number;
        if (!this.moneyWindowModel.isInitialized) {
            if (this.beginnersPackageModel.isBeginnerAvailable()) {
                _local_1 = this.beginnersPackageModel.getUserCreatedAt();
            }
            else {
                _local_1 = 0;
            }
            ExternalInterface.call(this.moneyConfig.jsInitializeFunction(), this.account.getMoneyUserId(), this.account.getMoneyAccessToken(), _local_1);
            this.moneyWindowModel.isInitialized = true;
        }
    }

    private function openKabamMoneyWindowFromBrowser():void
    {
        this.initializeMoneyWindow();
        this.logger.debug("Attempting External Payments");
        ExternalInterface.call("rotmg.KabamPayment.displayPaymentWall");
    }

    private function openPaymentwallMoneyWindowFromBrowser(_arg_1:String):void
    {
        this.logger.debug("Attempting External Payments via Paymentwall");
        ExternalInterface.call("rotmg.Paymentwall.showPaymentwall", _arg_1);
    }

    private function isGoldPurchaseEnabled():Boolean {
        return (((!((this.buildData.getEnvironment() == BuildEnvironment.TESTING))) || (this.playerModel.isAdmin())));
    }


}
}//package kabam.rotmg.account.core.commands
