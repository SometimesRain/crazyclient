package kabam.rotmg.messaging.impl.data {
import flash.utils.IDataInput;

public class GroundTileData {

    public var x_:int;
    public var y_:int;
    public var type_:uint;


    public function parseFromInput(_arg_1:IDataInput):void {
        this.x_ = _arg_1.readShort();
        this.y_ = _arg_1.readShort();
        this.type_ = _arg_1.readUnsignedShort();
    }

    public function toString():String {
        return (((((("x_: " + this.x_) + " y_: ") + this.y_) + " type_:") + this.type_));
    }


}
}//package kabam.rotmg.messaging.impl.data
