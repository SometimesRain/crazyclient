package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.ui.DeprecatedClickableText;

import flash.events.MouseEvent;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebForgotPasswordDialog extends Frame {

    public var cancel:Signal;
    public var submit:Signal;
    public var register:Signal;
    private var emailInput:TextInputField;
    private var registerText:DeprecatedClickableText;

    public function WebForgotPasswordDialog() {
        super("WebForgotPasswordDialog.title", "WebForgotPasswordDialog.leftButton", "WebForgotPasswordDialog.rightButton");
        this.emailInput = new TextInputField("WebForgotPasswordDialog.email", false);
        addTextInputField(this.emailInput);
        this.registerText = new DeprecatedClickableText(12, false, "WebForgotPasswordDialog.register");
        addNavigationText(this.registerText);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onSubmit);
        this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
        this.register = new NativeMappedSignal(this.registerText, MouseEvent.CLICK);
        this.submit = new Signal(String);
    }

    private function onSubmit(_arg_1:MouseEvent):void {
        if (this.isEmailValid()) {
            disable();
            this.submit.dispatch(this.emailInput.text());
        }
    }

    private function isEmailValid():Boolean {
        var _local_1:Boolean = !((this.emailInput.text() == ""));
        if (!_local_1) {
            this.emailInput.setError("Not a valid email address");
        }
        return (_local_1);
    }

    public function showError(_arg_1:String):void {
        this.emailInput.setError(_arg_1);
    }


}
}//package kabam.rotmg.account.web.view
