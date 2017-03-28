package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.ui.dialogs.ConfirmDialog;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.LoginSignal;
import kabam.rotmg.account.core.signals.LogoutSignal;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.build.api.BuildEnvironment;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class WebAccountInfoMediator extends Mediator {

    [Inject]
    public var view:WebAccountInfoView;
    [Inject]
    public var account:Account;
    [Inject]
    public var env:BuildEnvironment;
    [Inject]
    public var logout:LogoutSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var client:AppEngineClient;
    [Inject]
    public var login:LoginSignal;

    private var email:String;
    private var pass:String;


    override public function initialize():void {
        this.view.login.add(this.onLoginToggle);
        this.view.register.add(this.onRegister);
        this.view.reset.add(this.onResetPhase1);
    }

    override public function destroy():void {
        this.view.login.remove(this.onLoginToggle);
        this.view.register.remove(this.onRegister);
        this.view.reset.remove(this.onResetPhase1);
    }

    private function onRegister():void {
        this.openDialog.dispatch(new WebRegisterDialog());
    }

    private function onLoginToggle():void {
        if (this.account.isRegistered()) {
            this.onLogOut();
        }
        else {
            this.openDialog.dispatch(new WebLoginDialog());
        }
    }

    private function onLogOut():void {
        this.logout.dispatch();
        this.view.setInfo("", false);
    }

    private function onResetComplete(_arg_1:Boolean, _arg_2:String):void
    {
        var _local_3:AccountData = null;
        if(_arg_1)
        {
            _local_3 = new AccountData();
            _local_3.username = this.email;
            _local_3.password = this.pass;
            this.login.dispatch(_local_3);
        }
    }

    private function onResetPhase1():void
    {
        var _local_1:ConfirmDialog = new ConfirmDialog("ResetAccount", "Are you sure you want to reset your account back to realmofthemadgod.com values?", this.onResetPhase2);
        this.openDialog.dispatch(_local_1);
    }

    private function onResetPhase2():void
    {
        var _local_1:Object = this.account.getCredentials();
        this.email = this.account.getUserId();
        this.pass = this.account.getPassword();
        this.logout.dispatch();
        this.client.complete.addOnce(this.onResetComplete);
        this.client.sendRequest("/migrate/userAccountReset", _local_1);
    }


}
}//package kabam.rotmg.account.web.view
