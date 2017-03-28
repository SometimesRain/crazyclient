package kabam.rotmg.util.components {
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

public class UIAssetsHelper {

    public static const LEFT_NEVIGATOR:String = "left";
    public static const RIGHT_NEVIGATOR:String = "right";


    public static function createLeftNevigatorIcon(_arg_1:String = "left", _arg_2:int = 4, _arg_3:Number = 0):Sprite {
        var _local_4:BitmapData;
        if (_arg_1 == LEFT_NEVIGATOR) {
            _local_4 = AssetLibrary.getImageFromSet("lofiInterface", 55);
        }
        else {
            _local_4 = AssetLibrary.getImageFromSet("lofiInterface", 54);
        }
        var _local_5:Bitmap = new Bitmap(_local_4);
        _local_5.scaleX = _arg_2;
        _local_5.scaleY = _arg_2;
        _local_5.rotation = _arg_3;
        var _local_6:Sprite = new Sprite();
        _local_6.addChild(_local_5);
        return (_local_6);
    }


}
}//package kabam.rotmg.util.components
