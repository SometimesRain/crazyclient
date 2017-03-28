package kabam.rotmg.messaging.impl.incoming {
import flash.display.BitmapData;
import flash.utils.ByteArray;
import flash.utils.IDataInput;

public class Pic extends IncomingMessage {

    public var bitmapData_:BitmapData = null;

    public function Pic(_arg_1:uint, _arg_2:Function) {
        super(_arg_1, _arg_2);
    }

    override public function parseFromInput(_arg_1:IDataInput):void {
        var _local_2:int = _arg_1.readInt();
        var _local_3:int = _arg_1.readInt();
        var _local_4:ByteArray = new ByteArray();
        _arg_1.readBytes(_local_4, 0, ((_local_2 * _local_3) * 4));
        this.bitmapData_ = new BitmapDataSpy(_local_2, _local_3);
        this.bitmapData_.setPixels(this.bitmapData_.rect, _local_4);
    }

    override public function toString():String {
        return (formatToString("PIC", "bitmapData_"));
    }


}
}//package kabam.rotmg.messaging.impl.incoming
