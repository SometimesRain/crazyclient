package kabam.rotmg.account.web.view {
import kabam.lib.tasks.Task;
import kabam.rotmg.account.core.signals.SendPasswordReminderSignal;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class WebForgotPasswordMediator extends Mediator {

    [Inject]
    public var view:WebForgotPasswordDialog;
    [Inject]
    public var sendPasswordReminder:SendPasswordReminderSignal;
    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var failedToSend:TaskErrorSignal;


    override public function initialize():void {
        this.view.submit.add(this.onSubmit);
        this.view.register.add(this.onRegister);
        this.view.cancel.add(this.onCancel);
        this.failedToSend.add(this.onFailedToSend);
    }

    override public function destroy():void {
        this.view.submit.remove(this.onSubmit);
        this.view.register.remove(this.onRegister);
        this.view.cancel.remove(this.onCancel);
        this.failedToSend.add(this.onFailedToSend);
    }

    private function onEnable():void {
        this.view.enable();
    }

    private function onClose():void {
        this.view.parent.removeChild(this.view);
    }

    private function onSubmit(_arg_1:String):void {
        this.sendPasswordReminder.dispatch(_arg_1);
    }

    private function onRegister():void {
        this.openDialog.dispatch(new WebRegisterDialog());
    }

    private function onCancel():void {
        this.openDialog.dispatch(new WebLoginDialog());
    }

    private function onFailedToSend(_arg_1:Task):void {
        this.view.showError(_arg_1.error);
        this.view.enable();
    }


}
}//package kabam.rotmg.account.web.view
