package kabam.lib.console.model {
public class Watch {

    public var name:String;
    public var data:String;

    public function Watch(_arg_1:String, _arg_2:String = "") {
        this.name = _arg_1;
        this.data = _arg_2;
    }

    public function toString():String {
        return (this.data);
    }


}
}//package kabam.lib.console.model
