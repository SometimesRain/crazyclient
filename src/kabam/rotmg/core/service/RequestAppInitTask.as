package kabam.rotmg.core.service {
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
import kabam.lib.tasks.BaseTask;
import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.application.DynamicSettings;
import kabam.rotmg.core.signals.AppInitDataReceivedSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.framework.api.ILogger;

public class RequestAppInitTask extends BaseTask {

    [Inject]
    public var logger:ILogger;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var appInitConfigData:AppInitDataReceivedSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;

	//private const STRINGS:String = "<AppSettings><UseExternalPayments>1</UseExternalPayments><MaxStackablePotions>6</MaxStackablePotions><PotionPurchaseCooldown>400</PotionPurchaseCooldown><PotionPurchaseCostCooldown>8000</PotionPurchaseCostCooldown><PotionPurchaseCosts><cost>5</cost><cost>10</cost><cost>20</cost><cost>40</cost><cost>80</cost><cost>120</cost><cost>200</cost><cost>300</cost><cost>450</cost><cost>600</cost></PotionPurchaseCosts><DisableRegist>0</DisableRegist><MysteryBoxRefresh>600</MysteryBoxRefresh><SalesforceMobile>0</SalesforceMobile><UGDOpenSubmission>1</UGDOpenSubmission></AppSettings>";

    override protected function startTask():void {
		//onComplete(true, STRINGS);
        this.client.setMaxRetries(2);
        this.client.complete.addOnce(this.onComplete);
        this.client.sendRequest("/app/init", {"game_net": this.account.gameNetwork()});
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
		if (_arg_1) {
			var _local_3:XML = XML(_arg_2);
			appInitConfigData.dispatch(_local_3);
			this.initDynamicSettingsClass(_local_3);
		}
		else {
            onPolicyError();
		}
        completeTask(_arg_1, _arg_2);
    }

    private function initDynamicSettingsClass(_arg_1:XML):void {
        if (_arg_1 != null) {
            DynamicSettings.xml = _arg_1;
        }
    }
	
    private function onPolicyError():void {
        var _local_1:ErrorDialog = new ErrorDialog("Use \"LangFix.exe\" provided with the client to fix this issue.");
        openDialog.dispatch(_local_1);
		completeTask(false);
    }
}
}//package kabam.rotmg.core.service
