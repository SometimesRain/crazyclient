package kabam.rotmg.util.graphics {
import flash.display.Graphics;

public class GraphicsHelper {


    public function drawBevelRect(_arg_1:int, _arg_2:int, _arg_3:BevelRect, _arg_4:Graphics):void {
        var _local_5:int = (_arg_1 + _arg_3.width);
        var _local_6:int = (_arg_2 + _arg_3.height);
        var _local_7:int = _arg_3.bevel;
        if (_arg_3.topLeftBevel) {
            _arg_4.moveTo(_arg_1, (_arg_2 + _local_7));
            _arg_4.lineTo((_arg_1 + _local_7), _arg_2);
        }
        else {
            _arg_4.moveTo(_arg_1, _arg_2);
        }
        if (_arg_3.topRightBevel) {
            _arg_4.lineTo((_local_5 - _local_7), _arg_2);
            _arg_4.lineTo(_local_5, (_arg_2 + _local_7));
        }
        else {
            _arg_4.lineTo(_local_5, _arg_2);
        }
        if (_arg_3.bottomRightBevel) {
            _arg_4.lineTo(_local_5, (_local_6 - _local_7));
            _arg_4.lineTo((_local_5 - _local_7), _local_6);
        }
        else {
            _arg_4.lineTo(_local_5, _local_6);
        }
        if (_arg_3.bottomLeftBevel) {
            _arg_4.lineTo((_arg_1 + _local_7), _local_6);
            _arg_4.lineTo(_arg_1, (_local_6 - _local_7));
        }
        else {
            _arg_4.lineTo(_arg_1, _local_6);
        }
    }


}
}//package kabam.rotmg.util.graphics
