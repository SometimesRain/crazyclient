package kabam.rotmg.editor.view {
import com.company.assembleegameclient.ui.TextButtonBase;

import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class StaticTextButton extends TextButtonBase {

    public function StaticTextButton(_arg_1:int, _arg_2:String, _arg_3:int = 0) {
        super(_arg_3);
        addText(_arg_1);
        text_.setStringBuilder(new LineBuilder().setParams(_arg_2));
        initText();
    }

    override protected function makeText():TextFieldDisplayConcrete {
        return (new StaticTextDisplay());
    }


}
}//package kabam.rotmg.editor.view
