package kabam.rotmg.assets.services {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;

public class IconFactory {


    public static function makeCoin(size:int = 40):BitmapData {
        var _local_1:BitmapData = TextureRedrawer.resize(AssetLibrary.getImageFromSet("lofiObj3", 225), null, size, true, 0, 0);
        return (cropAndGlowIcon(_local_1));
    }

    public static function makeFortune():BitmapData {
        var _local_1:BitmapData = TextureRedrawer.resize(AssetLibrary.getImageFromSet("lofiCharBig", 32), null, 20, true, 0, 0);
        return (cropAndGlowIcon(_local_1));
    }

    public static function makeFame():BitmapData {
        var _local_1:BitmapData = TextureRedrawer.resize(AssetLibrary.getImageFromSet("lofiObj3", 224), null, 40, true, 0, 0);
        return (cropAndGlowIcon(_local_1));
    }

    public static function makeGuildFame():BitmapData {
        var _local_1:BitmapData = TextureRedrawer.resize(AssetLibrary.getImageFromSet("lofiObj3", 226), null, 40, true, 0, 0);
        return (cropAndGlowIcon(_local_1));
    }

    private static function cropAndGlowIcon(_arg_1:BitmapData):BitmapData {
        _arg_1 = GlowRedrawer.outlineGlow(_arg_1, 0xFFFFFFFF);
        return (BitmapUtil.cropToBitmapData(_arg_1, 10, 10, (_arg_1.width - 20), (_arg_1.height - 20)));
    }


    public function makeIconBitmap(_arg_1:int, glow:Boolean = true):Bitmap {
        var _local_2:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig", _arg_1);
        _local_2 = TextureRedrawer.redraw(_local_2, (320 / _local_2.width), glow, 0);
        return (new Bitmap(_local_2));
    }


}
}//package kabam.rotmg.assets.services
