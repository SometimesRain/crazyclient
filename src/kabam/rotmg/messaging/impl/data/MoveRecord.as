package kabam.rotmg.messaging.impl.data {
import flash.utils.IDataOutput;

public class MoveRecord {

    public var time_:int;
    public var x_:Number;
    public var y_:Number;

    public function MoveRecord(_arg_1:int, _arg_2:Number, _arg_3:Number) {
        this.time_ = _arg_1;
        this.x_ = _arg_2;
        this.y_ = _arg_3;
    }

    public function writeToOutput(_arg_1:IDataOutput):void {
        _arg_1.writeInt(this.time_);
        _arg_1.writeFloat(this.x_);
        _arg_1.writeFloat(this.y_);
    }

    public function toString():String {
        return (((((("time_: " + this.time_) + " x_: ") + this.x_) + " y_: ") + this.y_));
    }


}
}//package kabam.rotmg.messaging.impl.data
