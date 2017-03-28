package kabam.rotmg.editor.view.components.savedialog {
import com.company.ui.BaseSimpleText;

import flash.display.CapsStyle;
import flash.display.JointStyle;

import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.FocusEvent;

import flash.filters.DropShadowFilter;

public class TagsInputField extends Sprite {

    public static const HEIGHT:int = 88;
    public var nameText_:BaseSimpleText;
    public var inputText_:BaseSimpleText;
    public var instructionsText_:BaseSimpleText;

    public function TagsInputField(_arg_1:String, _arg_2:int = 260, _arg_3:int = 100, _arg_4:Boolean = false)
    {
        this.nameText_ = new BaseSimpleText(18, 11776947, false, 0, 0);
        this.nameText_.setBold(true);
        this.nameText_.text = "Tags: ";
        this.nameText_.updateMetrics();
        this.nameText_.filters = [new DropShadowFilter(0, 0, 0)];
        addChild(this.nameText_);
        this.inputText_ = new BaseSimpleText(16, 11776947, true, _arg_2, _arg_3);
        this.inputText_.x = _arg_4 ? Number(0) : Number(80);
        this.inputText_.y = _arg_4 ? Number(30) : Number(0);
        this.inputText_.border = false;
        this.inputText_.maxChars = 256;
        this.inputText_.multiline = true;
        this.inputText_.wordWrap = true;
        this.inputText_.restrict = "a-z0-9 , ";
        this.inputText_.updateMetrics();
        this.inputText_.text = _arg_1;
        addChild(this.inputText_);
        graphics.lineStyle(2, 4539717, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND, JointStyle.ROUND);
        graphics.beginFill(3355443, 1);
        graphics.drawRect(this.inputText_.x, this.inputText_.y, _arg_2, _arg_3);
        graphics.endFill();
        graphics.lineStyle();
        this.inputText_.addEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
        this.inputText_.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
        this.instructionsText_ = new BaseSimpleText(14, 9671571, false, 260, 0);
        this.instructionsText_.htmlText = "<p align=\"center\">comma-separated list of tags\n" + "(e.g. \"elf, wizard, abyss of demons, \ncrunchy\")" + "</p>";
        this.instructionsText_.updateMetrics();
        this.instructionsText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8, 1)];
        this.instructionsText_.x = this.inputText_.x;
        this.instructionsText_.y = this.inputText_.y;
        if(this.inputText_.text == "")
        {
            addChild(this.instructionsText_);
        }
    }

    public function text():String
    {
        return this.inputText_.text;
    }

    private function onFocusIn(_arg_1:FocusEvent):void
    {
        if(contains(this.instructionsText_))
        {
            removeChild(this.instructionsText_);
        }
    }

    private function onFocusOut(_arg_1:FocusEvent):void
    {
        if(!contains(this.instructionsText_) && this.inputText_.text == "")
        {
            addChild(this.instructionsText_);
        }
    }

}
}
