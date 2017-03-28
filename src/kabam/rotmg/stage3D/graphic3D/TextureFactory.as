package kabam.rotmg.stage3D.graphic3D {
import flash.display.BitmapData;
import flash.display3D.Context3DTextureFormat;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.utils.Dictionary;

import kabam.rotmg.stage3D.proxies.Context3DProxy;
import kabam.rotmg.stage3D.proxies.TextureProxy;

public class TextureFactory {

    private static var textures:Dictionary = new Dictionary();
    private static var flippedTextures:Dictionary = new Dictionary();
    private static var count:int = 0;

    [Inject]
    public var context3D:Context3DProxy;


    public static function GetFlippedBitmapData(_arg_1:BitmapData):BitmapData {
        var _local_2:BitmapData;
        if ((_arg_1 in flippedTextures)) {
            return (flippedTextures[_arg_1]);
        }
        _local_2 = flipBitmapData(_arg_1, "y");
        flippedTextures[_arg_1] = _local_2;
        return (_local_2);
    }

    private static function flipBitmapData(_arg_1:BitmapData, _arg_2:String = "x"):BitmapData {
        var _local_4:Matrix;
        var _local_3:BitmapData = new BitmapData(_arg_1.width, _arg_1.height, true, 0);
        if (_arg_2 == "x") {
            _local_4 = new Matrix(-1, 0, 0, 1, _arg_1.width, 0);
        }
        else {
            _local_4 = new Matrix(1, 0, 0, -1, 0, _arg_1.height);
        }
        _local_3.draw(_arg_1, _local_4, null, null, null, true);
        return (_local_3);
    }

    private static function getNextPowerOf2(_arg_1:int):Number {
        _arg_1--;
        _arg_1 = (_arg_1 | (_arg_1 >> 1));
        _arg_1 = (_arg_1 | (_arg_1 >> 2));
        _arg_1 = (_arg_1 | (_arg_1 >> 4));
        _arg_1 = (_arg_1 | (_arg_1 >> 8));
        _arg_1 = (_arg_1 | (_arg_1 >> 16));
        return (++_arg_1);
    }

    public static function disposeTextures():void {
        var _local_1:TextureProxy;
        var _local_2:BitmapData;
        for each (_local_1 in textures) {
            _local_1.dispose();
        }
        textures = new Dictionary();
        for each (_local_2 in flippedTextures) {
            _local_2.dispose();
        }
        flippedTextures = new Dictionary();
        count = 0;
    }

    public static function disposeNormalTextures():void {
        var _local_1:TextureProxy;
        for each (_local_1 in textures) {
            _local_1.dispose();
        }
        textures = new Dictionary();
    }


    public function make(_arg_1:BitmapData):TextureProxy {
        var _local_2:int;
        var _local_3:int;
        var _local_4:TextureProxy;
        var _local_5:BitmapData;
        if (_arg_1 == null) {
            return (null);
        }
        if ((_arg_1 in textures)) {
            return (textures[_arg_1]);
        }
        _local_2 = getNextPowerOf2(_arg_1.width);
        _local_3 = getNextPowerOf2(_arg_1.height);
        _local_4 = this.context3D.createTexture(_local_2, _local_3, Context3DTextureFormat.BGRA, false);
        _local_5 = new BitmapData(_local_2, _local_3, true, 0);
        _local_5.copyPixels(_arg_1, _arg_1.rect, new Point(0, 0));
        _local_4.uploadFromBitmapData(_local_5);
        if (count > 1000) {
            disposeNormalTextures();
            count = 0;
        }
        textures[_arg_1] = _local_4;
        count++;
        return (_local_4);
    }


}
}//package kabam.rotmg.stage3D.graphic3D
