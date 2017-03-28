package kabam.rotmg.account.web.view {
import com.company.ui.BaseSimpleText;

import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.osflash.signals.Signal;

public class LabeledField extends FormField {

    public var nameText_:TextFieldDisplayConcrete;
    public var inputText_:BaseSimpleText;
    public var isHighlighted:Boolean;

    public function LabeledField(_arg_1:String, _arg_2:Boolean, _arg_3:uint = 238, _arg_4:uint = 30) {
        this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(TEXT_COLOR);
        this.nameText_.setBold(true);
        this.nameText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.inputText_ = new BaseSimpleText(20, TEXT_COLOR, true, _arg_3, _arg_4);
        this.inputText_.y = 30;
        this.inputText_.x = 6;
        this.inputText_.border = false;
        this.inputText_.displayAsPassword = _arg_2;
        this.inputText_.updateMetrics();
        addChild(this.inputText_);
        this.setErrorHighlight(false);
    }

    public function text():String {
        return (this.inputText_.text);
    }

    override public function getHeight():Number {
        return (68);
    }

    public function textChanged():Signal {
        return (this.nameText_.textChanged);
    }

    public function setErrorHighlight(_arg_1:Boolean):void {
        this.isHighlighted = _arg_1;
        drawSimpleTextBackground(this.inputText_, 0, 0, _arg_1);
    }


}
}//package kabam.rotmg.account.web.view
