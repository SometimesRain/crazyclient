package {
import flash.display.BitmapData;

public class BitmapDataSpy extends BitmapData {

    public function BitmapDataSpy(_arg_1:int, _arg_2:int, _arg_3:Boolean = true, _arg_4:uint = 0) {
        super(_arg_1, _arg_2, _arg_3, _arg_4);
    }

    override public function clone():BitmapData {
        return (super.clone());
    }


}
}//package 
