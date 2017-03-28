package kabam.rotmg.account.kongregate.view {
import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.ui.DeprecatedClickableText;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class KongregateAccountDetailDialog extends Sprite {

    public var done:Signal;
    public var register:Signal;
    public var link:Signal;
    private var loginText_:TextFieldDisplayConcrete;
    private var usernameText_:TextFieldDisplayConcrete;
    private var webLoginText_:TextFieldDisplayConcrete;
    private var emailText_:TextFieldDisplayConcrete;
    private var register_:DeprecatedClickableText;

    public function KongregateAccountDetailDialog() {
        this.done = new Signal();
        this.register = new Signal();
    }

    public function setInfo(_arg_1:String, _arg_2:String, _arg_3:Boolean):void {
        var _local_4:Frame;
        _local_4 = new Frame(TextKey.KONGREGATEACCOUNTDETAILDIALOG_TITLE, "", TextKey.KONGREGATEACCOUNTDETAILDIALOG_RIGHTBUTTON);
        addChild(_local_4);
        this.loginText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xB3B3B3);
        this.loginText_.setBold(true);
        this.loginText_.setStringBuilder(new LineBuilder().setParams(TextKey.KONGREGATEACCOUNTDETAILDIALOG_TITLE));
        this.loginText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.loginText_.y = (_local_4.h_ - 60);
        this.loginText_.x = 17;
        _local_4.addChild(this.loginText_);
        this.usernameText_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setTextWidth(238).setTextHeight(30);
        this.usernameText_.setStringBuilder(new StaticStringBuilder(_arg_1));
        this.usernameText_.y = (_local_4.h_ - 30);
        this.usernameText_.x = 17;
        _local_4.addChild(this.usernameText_);
        _local_4.h_ = (_local_4.h_ + 88);
        if (_arg_3) {
            _local_4.h_ = (_local_4.h_ - 20);
            this.webLoginText_ = new TextFieldDisplayConcrete().setSize(18).setColor(0xB3B3B3);
            this.webLoginText_.setBold(true);
            this.webLoginText_.setStringBuilder(new LineBuilder().setParams(TextKey.KONGREGATEACCOUNTDETAILDIALOG_LINKWEB));
            this.webLoginText_.filters = [new DropShadowFilter(0, 0, 0)];
            this.webLoginText_.y = (_local_4.h_ - 60);
            this.webLoginText_.x = 17;
            _local_4.addChild(this.webLoginText_);
            this.emailText_ = new TextFieldDisplayConcrete().setSize(16).setColor(0xB3B3B3).setTextWidth(238).setTextHeight(30);
            this.emailText_.setStringBuilder(new StaticStringBuilder(_arg_2));
            this.emailText_.y = (_local_4.h_ - 30);
            this.emailText_.x = 17;
            _local_4.addChild(this.emailText_);
            _local_4.h_ = (_local_4.h_ + 88);
        }
        else {
            this.register_ = new DeprecatedClickableText(12, false, TextKey.KONGREGATEACCOUNTDETAILDIALOG_REGISTER);
            this.register_.addEventListener(MouseEvent.CLICK, this.onRegister);
        }
        _local_4.rightButton_.addEventListener(MouseEvent.CLICK, this.onContinue);
    }

    private function onContinue(_arg_1:MouseEvent):void {
        this.done.dispatch();
    }

    public function onRegister(_arg_1:MouseEvent):void {
        this.register.dispatch();
    }


}
}//package kabam.rotmg.account.kongregate.view
