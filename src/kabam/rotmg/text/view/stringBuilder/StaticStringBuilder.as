package kabam.rotmg.text.view.stringBuilder {
import kabam.rotmg.language.model.StringMap;

public class StaticStringBuilder implements StringBuilder {

    private var string:String;
    private var prefix:String;
    private var postfix:String;

    public function StaticStringBuilder(_arg_1:String = "") {
        this.string = _arg_1;
        this.prefix = "";
        this.postfix = "";
    }

    public function setString(_arg_1:String):StaticStringBuilder {
        this.string = _arg_1;
        return (this);
    }

    public function setPrefix(_arg_1:String):StaticStringBuilder {
        this.prefix = _arg_1;
        return (this);
    }

    public function setPostfix(_arg_1:String):StaticStringBuilder {
        this.postfix = _arg_1;
        return (this);
    }

    public function setStringMap(_arg_1:StringMap):void {
    }

    public function getString():String {
        return (((this.prefix + this.string) + this.postfix));
    }


}
}//package kabam.rotmg.text.view.stringBuilder
