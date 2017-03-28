package com.company.assembleegameclient.ui {
import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class DeprecatedClickableText extends ClickableTextBase {

    public function DeprecatedClickableText(_arg_1:int, _arg_2:Boolean, _arg_3:String) {
        super(_arg_1, _arg_2, _arg_3);
    }

    override protected function makeText():TextFieldDisplayConcrete {
        return (new TextFieldDisplayConcrete());
    }


}
}//package com.company.assembleegameclient.ui
