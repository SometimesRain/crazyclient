package kabam.rotmg.util.graphics {
public class BevelRect {

    public var topLeftBevel:Boolean = true;
    public var topRightBevel:Boolean = true;
    public var bottomLeftBevel:Boolean = true;
    public var bottomRightBevel:Boolean = true;
    public var width:int;
    public var height:int;
    public var bevel:int;

    public function BevelRect(_arg_1:int, _arg_2:int, _arg_3:int) {
        this.width = _arg_1;
        this.height = _arg_2;
        this.bevel = _arg_3;
    }

}
}//package kabam.rotmg.util.graphics
