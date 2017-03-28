package kabam.rotmg.util {
public class GeometricSeries {

    private var a:Number;
    private var r:Number;

    public function GeometricSeries(_arg_1:Number, _arg_2:Number) {
        this.a = _arg_1;
        this.r = _arg_2;
    }

    public function getSummation(_arg_1:int):Number {
        return (((this.a * (1 - Math.pow(this.r, _arg_1))) / (1 - this.r)));
    }

    public function getTerm(_arg_1:int):Number {
        return ((this.a * Math.pow(this.r, _arg_1)));
    }


}
}//package kabam.rotmg.util
