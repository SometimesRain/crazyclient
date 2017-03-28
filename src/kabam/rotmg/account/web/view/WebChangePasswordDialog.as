package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;

import flash.events.MouseEvent;

import kabam.rotmg.account.web.model.ChangePasswordData;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebChangePasswordDialog extends Frame {

    public var cancel:Signal;
    public var change:Signal;
    public var password_:TextInputField;
    public var newPassword_:TextInputField;
    public var retypeNewPassword_:TextInputField;

    public function WebChangePasswordDialog() {
        super(TextKey.WEB_CHANGE_PASSWORD_TITLE, TextKey.WEB_CHANGE_PASSWORD_LEFT, TextKey.WEB_CHANGE_PASSWORD_RIGHT);
        this.password_ = new TextInputField(TextKey.WEB_CHANGE_PASSWORD_PASSWORD, true);
        addTextInputField(this.password_);
        this.newPassword_ = new TextInputField(TextKey.WEB_CHANGE_PASSWORD_NEW_PASSWORD, true);
        addTextInputField(this.newPassword_);
        this.retypeNewPassword_ = new TextInputField(TextKey.WEB_CHANGE_PASSWORD_RETYPE_PASSWORD, true);
        addTextInputField(this.retypeNewPassword_);
        this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
        this.change = new NativeMappedSignal(rightButton_, MouseEvent.CLICK);
    }

    private function onChange(_arg_1:MouseEvent):void {
        var _local_2:ChangePasswordData;
        if (((((this.isCurrentPasswordValid()) && (this.isNewPasswordValid()))) && (this.isNewPasswordVerified()))) {
            disable();
            _local_2 = new ChangePasswordData();
            _local_2.currentPassword = this.password_.text();
            _local_2.newPassword = this.newPassword_.text();
            this.change.dispatch(_local_2);
        }
    }

    private function isCurrentPasswordValid():Boolean {
        var _local_1:Boolean = (this.password_.text().length >= 5);
        if (!_local_1) {
            this.password_.setError(TextKey.WEB_CHANGE_PASSWORD_INCORRECT);
        }
        return (_local_1);
    }

    private function isNewPasswordValid():Boolean {
        var _local_1:Boolean = (this.newPassword_.text().length >= 5);
        if (!_local_1) {
            this.newPassword_.setError(TextKey.LINK_WEB_ACCOUNT_SHORT);
        }
        return (_local_1);
    }

    private function isNewPasswordVerified():Boolean {
        var _local_1:Boolean = (this.newPassword_.text() == this.retypeNewPassword_.text());
        if (!_local_1) {
            this.retypeNewPassword_.setError(TextKey.PASSWORD_DOES_NOT_MATCH);
        }
        return (_local_1);
    }

    public function setError(_arg_1:String):void {
        this.password_.setError(_arg_1);
    }

    public function clearError():void {
        this.password_.clearError();
        this.retypeNewPassword_.clearError();
        this.newPassword_.clearError();
    }


}
}//package kabam.rotmg.account.web.view
