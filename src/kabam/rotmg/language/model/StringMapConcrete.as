package kabam.rotmg.language.model {
public class StringMapConcrete implements StringMap {

    private var valueMap:Object;
    private var languageFamilyMap:Object;

    public function StringMapConcrete() {
        this.valueMap = {};
        this.languageFamilyMap = {};
        super();
    }

    public function clear():void {
        this.valueMap = {};
        this.languageFamilyMap = {};
    }

    public function setValue(_arg_1:String, _arg_2:String, _arg_3:String):void {
        this.valueMap[_arg_1] = _arg_2;
        this.languageFamilyMap[_arg_1] = _arg_3;
    }

    public function hasKey(_arg_1:String):Boolean {
        return (!((this.valueMap[_arg_1] == null)));
    }

    public function getValue(_arg_1:String):String {
        return (this.valueMap[_arg_1]);
    }

    public function getLanguageFamily(_arg_1:String):String {
        return (this.languageFamilyMap[_arg_1]);
    }


}
}//package kabam.rotmg.language.model
