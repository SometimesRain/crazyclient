package kabam.rotmg.messaging.impl.data {
import flash.geom.Point;
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class WorldPosData {

    public var x_:Number;
    public var y_:Number;


    public function toPoint():Point {
        return (new Point(this.x_, this.y_));
    }

    public function parseFromInput(_arg_1:IDataInput):void {
        this.x_ = _arg_1.readFloat();
        this.y_ = _arg_1.readFloat();
    }

    public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeFloat(this.x_);
        _arg_1.writeFloat(this.y_);
    }

    public function toString():String {
        return (((("x_: " + this.x_) + " y_: ") + this.y_));
    }


}
}//package kabam.rotmg.messaging.impl.data
