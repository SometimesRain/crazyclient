package kabam.rotmg.account.core.services {
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.MoreObjectUtil;

import flash.events.TimerEvent;
import flash.utils.Timer;

import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.account.web.WebAccount;
import kabam.rotmg.account.web.view.MigrationDialog;
import kabam.rotmg.account.web.view.WebLoginDialog;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetLoadingMessageSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.fortune.components.TimerCallback;
import kabam.rotmg.text.model.TextKey;

import robotlegs.bender.framework.api.ILogger;

public class GetCharListTask extends BaseTask {

    private static const ONE_SECOND_IN_MS:int = 1000;
    private static const MAX_RETRIES:int = 7;

    [Inject]
    public var account:Account;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var setLoadingMessage:SetLoadingMessageSignal;
    [Inject]
    public var charListData:CharListDataSignal;
    [Inject]
    public var logger:ILogger;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;

    private var requestData:Object;
    private var retryTimer:Timer;
    private var numRetries:int = 0;
    private var fromMigration:Boolean = false;


    override protected function startTask():void {
        this.logger.info("GetUserDataTask start");
        this.requestData = this.makeRequestData();
        this.sendRequest();
        Parameters.sendLogin_ = false;
    }

    private function sendRequest():void {
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/char/list", this.requestData);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.onListComplete(_arg_2);
        }
        else {
            this.onTextError(_arg_2);
        }
    }

    public function makeRequestData():Object {
        var _local_1:Object = {};
        _local_1.game_net_user_id = this.account.gameNetworkUserId();
        _local_1.game_net = this.account.gameNetwork();
        _local_1.play_platform = this.account.playPlatform();
        _local_1.do_login = Parameters.sendLogin_;
        MoreObjectUtil.addToObject(_local_1, this.account.getCredentials());
        return (_local_1);
    }

    private function onListComplete(_arg_1:String):void {
		//trace(_arg_1);
        var _local_3:Number;
        var _local_4:MigrationDialog;
        var _local_5:XML;
        var _local_2:XML = new XML(_arg_1);
        if (_local_2.hasOwnProperty("MigrateStatus")) {
            _local_3 = _local_2.MigrateStatus;
            if (_local_3 == 5) {
                this.sendRequest();
            }
            _local_4 = new MigrationDialog(this.account, _local_3);
            this.fromMigration = true;
            _local_4.done.addOnce(this.sendRequest);
            _local_4.cancel.addOnce(this.clearAccountAndReloadCharacters);
            this.openDialog.dispatch(_local_4);
        }
        else {
            if (_local_2.hasOwnProperty("Account")) {
                if ((this.account is WebAccount)) {
                    WebAccount(this.account).userDisplayName = _local_2.Account[0].Name;
                    WebAccount(this.account).paymentProvider = _local_2.Account[0].PaymentProvider;
                    if(_local_2.Account[0].hasOwnProperty("PaymentData"))
                    {
                        WebAccount(this.account).paymentData = _local_2.Account[0].PaymentData;
                    }
                }
            }
            this.charListData.dispatch(XML(_arg_1));
            completeTask(true);
        }
        if (this.retryTimer != null) {
            this.stopRetryTimer();
        }
    }

    private function onTextError(_arg_1:String):void {
        var _local_2:WebLoginDialog;
        this.setLoadingMessage.dispatch("error.loadError");
        if (_arg_1 == "Account credentials not valid") {
            if (this.fromMigration) {
                _local_2 = new WebLoginDialog();
                _local_2.setError(TextKey.WEB_LOGIN_DIALOG_PASSWORD_INVALID);
                _local_2.setEmail(this.account.getUserId());
                StaticInjectorContext.getInjector().getInstance(OpenDialogSignal).dispatch(_local_2);
            }
            this.clearAccountAndReloadCharacters();
        }
        else {
            if (_arg_1 == "Account is under maintenance") {
                this.setLoadingMessage.dispatch("This account has been banned");
                new TimerCallback(5, this.clearAccountAndReloadCharacters);
            }
            else {
                this.waitForASecondThenRetryRequest();
            }
        }
    }

    private function clearAccountAndReloadCharacters():void {
        this.logger.info("GetUserDataTask invalid credentials");
        this.account.clear();
        this.client.complete.addOnce(this.onComplete);
        this.requestData = this.makeRequestData();
        this.client.sendRequest("/char/list", this.requestData);
    }

    private function waitForASecondThenRetryRequest():void {
        this.logger.info("GetUserDataTask error - retrying");
        this.retryTimer = new Timer(ONE_SECOND_IN_MS, 1);
        this.retryTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onRetryTimer);
        this.retryTimer.start();
    }

    private function stopRetryTimer():void {
        this.retryTimer.stop();
        this.retryTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onRetryTimer);
        this.retryTimer = null;
    }

    private function onRetryTimer(_arg_1:TimerEvent):void {
        this.stopRetryTimer();
        if (this.numRetries < MAX_RETRIES) {
            this.sendRequest();
            this.numRetries++;
        }
        else {
            this.clearAccountAndReloadCharacters();
            this.setLoadingMessage.dispatch("LoginError.tooManyFails");
        }
    }


}
}//package kabam.rotmg.account.core.services
