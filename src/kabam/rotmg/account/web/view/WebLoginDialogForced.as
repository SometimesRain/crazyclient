package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.account.ui.TextInputField;
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.util.KeyCodes;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.account.web.model.AccountData;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebLoginDialogForced extends Frame {

    public var signInForced:Signal;
    public var forgot:Signal;
    public var register:Signal;
    public var email:TextInputField;
    private var password:TextInputField;
    private var forgotText:DeprecatedClickableText;
    private var registerText:DeprecatedClickableText;

    public function WebLoginDialogForced(_arg_1:Boolean = false) {
        super(TextKey.WEB_LOGIN_DIALOG_TITLE, "", TextKey.WEB_LOGIN_DIALOG_RIGHT);
        this.makeUI();
        if (_arg_1) {
            addChild(this.getText("Attention!", -165, -85).setColor(0xFF0000));
            addChild(this.getText("A new password was sent to your Sign In Email Address.", -165, -65));
            addChild(this.getText("Please use the new password to Sign In.", -165, -45));
        }
        this.forgot = new NativeMappedSignal(this.forgotText, MouseEvent.CLICK);
        this.register = new NativeMappedSignal(this.registerText, MouseEvent.CLICK);
        this.signInForced = new Signal(AccountData);
    }

    private function makeUI():void {
        this.email = new TextInputField(TextKey.WEB_LOGIN_DIALOG_EMAIL, false);
        addTextInputField(this.email);
        this.password = new TextInputField(TextKey.WEB_LOGIN_DIALOG_PASSWORD, true);
        addTextInputField(this.password);
        this.forgotText = new DeprecatedClickableText(12, false, TextKey.WEB_LOGIN_DIALOG_FORGOT);
        addNavigationText(this.forgotText);
        this.registerText = new DeprecatedClickableText(12, false, TextKey.WEB_LOGIN_DIALOG_REGISTER);
        addNavigationText(this.registerText);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onSignIn);
        addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if (_arg_1.keyCode == KeyCodes.ENTER) {
            this.onSignInSub();
        }
    }

    private function onSignIn(_arg_1:MouseEvent):void {
        this.onSignInSub();
    }

    private function onSignInSub():void {
        var _local_1:AccountData;
        if (((this.isEmailValid()) && (this.isPasswordValid()))) {
            _local_1 = new AccountData();
            _local_1.username = this.email.text();
            _local_1.password = this.password.text();
            this.signInForced.dispatch(_local_1);
        }
    }

    private function isPasswordValid():Boolean {
        var _local_1:Boolean = !((this.password.text() == ""));
        if (!_local_1) {
            this.password.setError(TextKey.WEB_LOGIN_DIALOG_PASSWORD_ERROR);
        }
        return (_local_1);
    }

    private function isEmailValid():Boolean {
        var _local_1:Boolean = !((this.email.text() == ""));
        if (!_local_1) {
            this.email.setError(TextKey.WEBLOGINDIALOG_EMAIL_ERROR);
        }
        return (_local_1);
    }

    public function setError(_arg_1:String):void {
        this.password.setError(_arg_1);
    }

    public function getText(_arg_1:String, _arg_2:int, _arg_3:int):TextFieldDisplayConcrete {
        var _local_4:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth(600);
        _local_4.setBold(true);
        _local_4.setStringBuilder(new StaticStringBuilder(_arg_1));
        _local_4.setSize(16).setColor(0xFFFFFF);
        _local_4.setWordWrap(true);
        _local_4.setMultiLine(true);
        _local_4.setAutoSize(TextFieldAutoSize.CENTER);
        _local_4.setHorizontalAlign(TextFormatAlign.CENTER);
        _local_4.filters = [new DropShadowFilter(0, 0, 0)];
        _local_4.x = _arg_2;
        _local_4.y = _arg_3;
        return (_local_4);
    }


}
}//package kabam.rotmg.account.web.view
