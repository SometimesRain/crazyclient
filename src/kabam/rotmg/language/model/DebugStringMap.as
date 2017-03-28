package kabam.rotmg.language.model {
import kabam.rotmg.text.model.DebugTextInfo;

public class DebugStringMap implements StringMap {

    [Inject]
    public var delegate:StringMap;
    [Inject]
    public var languageModel:LanguageModel;
    public var debugTextInfos:Vector.<DebugTextInfo>;

    public function DebugStringMap() {
        this.debugTextInfos = new Vector.<DebugTextInfo>();
        super();
    }

    public function hasKey(_arg_1:String):Boolean {
        return (true);
    }

    public function getValue(_arg_1:String):String {
        if (((!((_arg_1 == ""))) && (this.isInvalid(_arg_1)))) {
            return (_arg_1);
        }
        return (this.delegate.getValue(_arg_1));
    }

    private function isInvalid(_arg_1:String):Boolean {
        return (((this.hasNo(_arg_1)) || (this.hasWrongLanguage(_arg_1))));
    }

    private function hasNo(_arg_1:String):Boolean {
        return (!(this.delegate.hasKey(_arg_1)));
    }

    private function pushDebugInfo(_arg_1:String):void {
        var _local_2:String = this.getLanguageFamily(_arg_1);
        var _local_3:DebugTextInfo = new DebugTextInfo();
        _local_3.key = _arg_1;
        _local_3.hasKey = this.delegate.hasKey(_arg_1);
        _local_3.languageFamily = _local_2;
        _local_3.value = this.delegate.getValue(_arg_1);
        this.debugTextInfos.push(_local_3);
    }

    private function hasWrongLanguage(_arg_1:String):Boolean {
        return (!((this.getLanguageFamily(_arg_1) == this.languageModel.getLanguage())));
    }

    public function clear():void {
    }

    public function setValue(_arg_1:String, _arg_2:String, _arg_3:String):void {
        this.delegate.setValue(_arg_1, _arg_2, _arg_3);
    }

    public function getLanguageFamily(_arg_1:String):String {
        return (this.delegate.getLanguageFamily(_arg_1));
    }


}
}//package kabam.rotmg.language.model
