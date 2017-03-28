package kabam.rotmg.account.transfer.view {
import com.company.assembleegameclient.account.ui.CheckBoxField;
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.EmailValidator;

import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.account.transfer.model.TransferAccountData;
import kabam.rotmg.account.ui.components.DateField;
import kabam.rotmg.account.web.view.LabeledField;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class TransferAccountView extends Frame {

    private const errors:Array = [];

    public var transfer:Signal;
    public var cancel:Signal;
    private var kbmEmail:String = "";
    private var kbmPassword:String = "";
    private var newEmailInput:LabeledField;
    private var newPasswordInput:LabeledField;
    private var retypePasswordInput:LabeledField;
    private var checkbox:CheckBoxField;
    private var ageVerificationInput:DateField;
    private var signInText:TextFieldDisplayConcrete;
    private var tosText:TextFieldDisplayConcrete;
    private var headerText:TextFieldDisplayConcrete;
    private var headerText2:TextFieldDisplayConcrete;
    private var endLink:String = "</a></font>";

    public function TransferAccountView(_arg_1:String, _arg_2:String) {
        super("Register your account on realmofthemadgod.com", "RegisterWebAccountDialog.leftButton", "RegisterWebAccountDialog.rightButton", 326);
        this.kbmEmail = _arg_1;
        this.kbmPassword = _arg_2;
        this.makeUIElements();
        this.makeSignals();
    }

    private function makeUIElements():void {
        this.headerText = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.headerText.setStringBuilder(new StaticStringBuilder("This will be used for future logins."));
        this.headerText.filters = [new DropShadowFilter(0, 0, 0)];
        this.headerText.x = 5;
        this.headerText.y = 3;
        this.headerText.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(this.headerText);
        positionText(this.headerText);
        this.headerText2 = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.headerText2.setStringBuilder(new StaticStringBuilder("Your account data is safe and will remain the same."));
        this.headerText2.filters = [new DropShadowFilter(0, 0, 0)];
        this.headerText2.x = 5;
        this.headerText2.y = 3;
        this.headerText2.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(this.headerText2);
        positionText(this.headerText2);
        this.newEmailInput = new LabeledField("New Email (must be valid)", false, 275);
        this.newPasswordInput = new LabeledField(TextKey.TRANSFER_ACCOUNT_NEW_PWD, true, 275);
        this.retypePasswordInput = new LabeledField(TextKey.WEB_CHANGE_PASSWORD_RETYPE_PASSWORD, true, 275);
        addLabeledField(this.newEmailInput);
        addLabeledField(this.newPasswordInput);
        addLabeledField(this.retypePasswordInput);
        addSpace(15);
        this.makeTosText();
        addSpace(15);
    }

    public function makeTosText():void {
        this.tosText = new TextFieldDisplayConcrete();
        var _local_1:String = (('<font color="#7777EE"><a href="' + Parameters.TERMS_OF_USE_URL) + '" target="_blank">');
        var _local_2:String = (('<font color="#7777EE"><a href="' + Parameters.PRIVACY_POLICY_URL) + '" target="_blank">');
        this.tosText.setStringBuilder(new LineBuilder().setParams(TextKey.TOS_TEXT, {
            "tou": _local_1,
            "_tou": this.endLink,
            "policy": _local_2,
            "_policy": this.endLink
        }));
        this.configureTextAndAdd(this.tosText);
    }

    public function configureTextAndAdd(_arg_1:TextFieldDisplayConcrete):void {
        _arg_1.setSize(12).setColor(0xB3B3B3).setBold(true);
        _arg_1.setTextWidth(275);
        _arg_1.setMultiLine(true).setWordWrap(true).setHTML(true);
        _arg_1.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(_arg_1);
        positionText(_arg_1);
    }

    private function makeSignals():void {
        this.cancel = new NativeMappedSignal(leftButton_, MouseEvent.CLICK);
        this.transfer = new Signal(TransferAccountData);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onTransfer);
    }

    private function onTransfer(_arg_1:MouseEvent):void {
        var _local_2:Boolean = this.areInputsValid();
        this.displayErrors();
        if (_local_2) {
            this.sendData();
        }
    }

    private function areInputsValid():Boolean {
        this.errors.length = 0;
        var _local_1:Boolean = true;
        _local_1 = ((this.isEmailValid(this.newEmailInput)) && (_local_1));
        _local_1 = ((this.isPasswordValid(this.newPasswordInput)) && (_local_1));
        return (((this.isPasswordVerified()) && (_local_1)));
    }

    public function displayErrors():void {
        if (this.errors.length == 0) {
            this.clearErrors();
        }
        else {
            this.displayErrorText((((this.errors.length == 1)) ? this.errors[0] : TextKey.MULTIPLE_ERRORS_MESSAGE));
        }
    }

    public function displayServerError(_arg_1:String):void {
        this.displayErrorText(_arg_1);
    }

    private function clearErrors():void {
        titleText_.setStringBuilder(new LineBuilder().setParams(TextKey.REGISTER_IMPERATIVE));
        titleText_.setColor(0xB3B3B3);
    }

    private function displayErrorText(_arg_1:String):void {
        titleText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        titleText_.setColor(16549442);
    }

    private function isEmailValid(_arg_1:LabeledField):Boolean {
        var _local_2:Boolean = EmailValidator.isValidEmail(_arg_1.text());
        _arg_1.setErrorHighlight(!(_local_2));
        if (!_local_2) {
            this.errors.push(TextKey.INVALID_EMAIL_ADDRESS);
        }
        return (_local_2);
    }

    private function isPasswordValid(_arg_1:LabeledField):Boolean {
        var _local_2:Boolean = (_arg_1.text().length >= 5);
        _arg_1.setErrorHighlight(!(_local_2));
        if (!_local_2) {
            this.errors.push(TextKey.PASSWORD_TOO_SHORT);
        }
        return (_local_2);
    }

    private function isPasswordVerified():Boolean {
        var _local_1:Boolean = (this.newPasswordInput.text() == this.retypePasswordInput.text());
        this.retypePasswordInput.setErrorHighlight(!(_local_1));
        if (!_local_1) {
            this.errors.push(TextKey.PASSWORDS_DONT_MATCH);
        }
        return (_local_1);
    }

    private function sendData():void {
        var _local_1:TransferAccountData = new TransferAccountData();
        _local_1.currentEmail = this.kbmEmail;
        _local_1.currentPassword = this.kbmPassword;
        _local_1.newEmail = this.newEmailInput.text();
        _local_1.newPassword = this.newPasswordInput.text();
        this.transfer.dispatch(_local_1);
    }


}
}//package kabam.rotmg.account.transfer.view
