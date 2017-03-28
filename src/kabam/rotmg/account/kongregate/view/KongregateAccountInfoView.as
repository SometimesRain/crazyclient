package kabam.rotmg.account.kongregate.view {
import com.company.assembleegameclient.screens.TitleMenuOption;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.core.view.AccountInfoView;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class KongregateAccountInfoView extends Sprite implements AccountInfoView {

    private static const REGISTER:String = TextKey.KONGREGATEACCOUNTINFOVIEW_REGISTER;//"KongregateAccountInfoView.register"
    private static const FONT_SIZE:int = 18;

    private var _register:NativeMappedSignal;
    private var accountText:TextFieldDisplayConcrete;
    private var registerButton:TitleMenuOption;
    private var userName:String = "";
    private var isRegistered:Boolean;

    public function KongregateAccountInfoView() {
        this.makeAccountText();
        this.makeActionButton();
    }

    private function makeAccountText():void {
        this.accountText = new TextFieldDisplayConcrete().setSize(FONT_SIZE).setColor(0xB3B3B3);
        this.accountText.setAutoSize(TextFieldAutoSize.RIGHT);
        this.accountText.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4)];
        addChild(this.accountText);
    }

    private function makeActionButton():void {
        this.registerButton = new TitleMenuOption(REGISTER, FONT_SIZE, false);
        this.registerButton.setAutoSize(TextFieldAutoSize.RIGHT);
        this._register = new NativeMappedSignal(this.registerButton, MouseEvent.CLICK);
    }

    public function setInfo(_arg_1:String, _arg_2:Boolean):void {
        this.userName = _arg_1;
        this.isRegistered = _arg_2;
        this.updateUI();
    }

    private function updateUI():void {
        this.removeUIElements();
        if (this.isRegistered) {
            this.refreshRegisteredAccount();
        }
        else {
            this.refreshUnregisteredAccount();
        }
    }

    private function removeUIElements():void {
        while (numChildren) {
            removeChildAt(0);
        }
    }

    public function get register():Signal {
        return (this._register);
    }

    private function refreshRegisteredAccount():void {
        this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.KONGREGATEACCOUNTINFOVIEW_LOGGEDIN, {"userName": this.userName}));
        this.addElements(this.accountText);
    }

    private function refreshUnregisteredAccount():void {
        this.accountText.setStringBuilder(new LineBuilder().setParams(TextKey.KONGREGATEACCOUNTINFOVIEW_GUEST));
        this.addElements(this.accountText, this.registerButton);
        this.accountText.x = this.registerButton.getBounds(this).left;
    }

    private function addElements(... rest):void {
        var _local_3:DisplayObject;
        var _local_2:int = rest.length;
        while (_local_2--) {
            _local_3 = rest[_local_2];
            addChild(_local_3);
        }
    }


}
}//package kabam.rotmg.account.kongregate.view
