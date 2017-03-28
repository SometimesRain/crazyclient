package kabam.rotmg.account.web.view {
import com.company.assembleegameclient.screens.TitleMenuOption;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.view.AccountInfoView;
import kabam.rotmg.build.api.BuildData;
import kabam.rotmg.build.api.BuildEnvironment;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class WebAccountInfoView extends Sprite implements AccountInfoView {

    private static const FONT_SIZE:int = 18;

    private var _login:Signal;
    private var _register:Signal;
    private var _reset:Signal;
    private var userName:String = "";
    private var isRegistered:Boolean;
    private var accountText:TextFieldDisplayConcrete;
    private var registerButton:TitleMenuOption;
    private var loginButton:TitleMenuOption;
    private var resetButton:TitleMenuOption;

    public function WebAccountInfoView() {
        this.makeUIElements();
        this.makeSignals();
    }

    public function get login():Signal {
        return (this._login);
    }

    public function get register():Signal {
        return (this._register);
    }

    public function get reset():Signal
    {
        return this._reset;
    }

    private function makeUIElements():void {
        this.makeAccountText();
        this.makeLoginButton();
        this.makeRegisterButton();
        this.makeResetButton();
    }

    private function makeSignals():void {
        this._login = new NativeMappedSignal(this.loginButton, MouseEvent.CLICK);
        this._register = new NativeMappedSignal(this.registerButton, MouseEvent.CLICK);
        this._reset = new NativeMappedSignal(this.resetButton, MouseEvent.CLICK);
    }

    private function makeAccountText():void {
        this.accountText = this.makeTextFieldConcrete();
        this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.GUEST_ACCOUNT));
    }

    private function makeTextFieldConcrete():TextFieldDisplayConcrete {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_1.setAutoSize(TextFieldAutoSize.RIGHT);
        _local_1.setSize(FONT_SIZE).setColor(0xB3B3B3);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        return (_local_1);
    }

    private function makeLoginButton():void {
        this.loginButton = new TitleMenuOption(TextKey.LOG_IN, FONT_SIZE, false);
        this.loginButton.setAutoSize(TextFieldAutoSize.RIGHT);
    }

    private function makeResetButton():void
    {
        this.resetButton = new TitleMenuOption("reset", FONT_SIZE, false);
        this.resetButton.setAutoSize(TextFieldAutoSize.RIGHT);
    }

    private function makeRegisterButton():void {
        this.registerButton = new TitleMenuOption(TextKey.REGISTER, FONT_SIZE, false);
        this.registerButton.setAutoSize(TextFieldAutoSize.RIGHT);
    }

    private function makeDividerText():DisplayObject {
        var _local_1:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_1.setColor(0xB3B3B3).setAutoSize(TextFieldAutoSize.RIGHT).setSize(FONT_SIZE);
        _local_1.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        _local_1.setStringBuilder(new StaticStringBuilder(" - "));
        return (_local_1);
    }

    public function setInfo(_arg_1:String, _arg_2:Boolean):void {
        this.userName = _arg_1;
        this.isRegistered = _arg_2;
        this.updateUI();
    }

    private function updateUI():void {
        this.removeUIElements();
        if (this.isRegistered) {
            this.showUIForRegisteredAccount();
        }
        else {
            this.showUIForGuestAccount();
        }
    }

    private function removeUIElements():void {
        while (numChildren) {
            removeChildAt(0);
        }
    }

    private function showUIForRegisteredAccount():void {
        this.accountText.setStringBuilder(new LineBuilder().setParams("logged in", ""));
        var _local_1:BuildData = StaticInjectorContext.getInjector().getInstance(BuildData);
        this.loginButton.setTextKey(TextKey.LOG_OUT);
        if(_local_1.getEnvironment() == BuildEnvironment.TESTING || _local_1.getEnvironment() == BuildEnvironment.LOCALHOST)
        {
            this.addAndAlignHorizontally(this.accountText, this.makeDividerText(), this.resetButton, this.makeDividerText(), this.loginButton);
        }
        else
        {
            this.addAndAlignHorizontally(this.accountText, this.loginButton);
        }
    }

    private function showUIForGuestAccount():void {
        this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.GUEST_ACCOUNT, {"userName": this.userName}));
        var _local_1:BuildData = StaticInjectorContext.getInjector().getInstance(BuildData);
        this.loginButton.setTextKey(TextKey.LOG_IN);
        this.addAndAlignHorizontally(this.accountText, this.makeDividerText(), this.registerButton, this.makeDividerText(), this.loginButton);
    }

    private function addAndAlignHorizontally(... rest):void {
        var _local_2:DisplayObject;
        var _local_3:int;
        var _local_4:int;
        var _local_5:DisplayObject;
        for each (_local_2 in rest) {
            addChild(_local_2);
        }
        _local_3 = 0;
        _local_4 = rest.length;
        while (_local_4--) {
            _local_5 = rest[_local_4];
            _local_5.x = _local_3;
            _local_3 = (_local_3 - _local_5.width);
        }
    }


}
}//package kabam.rotmg.account.web.view
