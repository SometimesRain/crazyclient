package kabam.rotmg.account.web.view {
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.core.signals.LoginSignal;
import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.text.model.TextKey;

import robotlegs.bender.bundles.mvcs.Mediator;

public class WebLoginMediatorForced extends Mediator {

    [Inject]
    public var view:WebLoginDialogForced;
    [Inject]
    public var login:LoginSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var closeDialog:CloseDialogsSignal;
    [Inject]
    public var loginError:TaskErrorSignal;
    [Inject]
    public var account:Account;


    override public function initialize():void {
        this.view.signInForced.add(this.onSignIn);
        this.view.register.add(this.onRegister);
        this.view.forgot.add(this.onForgot);
        this.loginError.add(this.onLoginError);
    }

    override public function destroy():void {
        this.view.signInForced.remove(this.onSignIn);
        this.view.register.remove(this.onRegister);
        this.view.forgot.remove(this.onForgot);
        this.loginError.remove(this.onLoginError);
    }

    private function onSignIn(_arg_1:AccountData):void {
        var _local_2:AppEngineClient;
        this.view.email.clearError();
        this.view.disable();
        if (this.account.getUserId().toLowerCase() == _arg_1.username.toLowerCase()) {
            _local_2 = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
            _local_2.sendRequest("/account/verify", {
                "guid": _arg_1.username,
                "password": _arg_1.password,
                "fromResetFlow": "yes"
            });
            _local_2.complete.addOnce(this.onComplete);
        }
        else {
            this.view.email.setError(TextKey.WEBLOGINDIALOG_EMAIL_MATCH_ERROR);
            this.view.enable();
        }
    }

    private function onRegister():void {
        this.openDialog.dispatch(new WebRegisterDialog());
    }

    private function onForgot():void {
        this.openDialog.dispatch(new WebForgotPasswordDialog());
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (!_arg_1) {
            this.onLoginError(_arg_2);
        }
        else {
            this.openDialog.dispatch(new WebChangePasswordDialogForced());
        }
    }

    private function onLoginError(_arg_1:String):void {
        this.view.setError(_arg_1);
        this.view.enable();
    }


}
}//package kabam.rotmg.account.web.view
