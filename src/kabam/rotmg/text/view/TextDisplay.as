package kabam.rotmg.text.view {
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.text.model.TextAndMapProvider;

public class TextDisplay extends TextFieldDisplayConcrete {

    public var text:TextFieldDisplayConcrete;

    public function TextDisplay(_arg_1:FontModel, _arg_2:TextAndMapProvider) {
        setFont(_arg_1.getFont());
        setTextField(_arg_2.getTextField());
        setStringMap(_arg_2.getStringMap());
    }

}
}//package kabam.rotmg.text.view
