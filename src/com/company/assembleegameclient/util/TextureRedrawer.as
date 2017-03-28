package com.company.assembleegameclient.util {
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.display.Shader;
import flash.filters.BitmapFilterQuality;
import flash.filters.GlowFilter;
import flash.filters.ShaderFilter;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

public class TextureRedrawer {

    public static const magic:int = 12;
    public static const minSize:int = (2 * magic);//24
    private static const BORDER:int = 4;
    public static const OUTLINE_FILTER:GlowFilter = new GlowFilter(0, 0.8, 1.4, 1.4, 0xFF, BitmapFilterQuality.LOW, false, false);
    private static var cache_:Dictionary = new Dictionary();
    private static var faceCache_:Dictionary = new Dictionary();
    private static var redrawCaches:Dictionary = new Dictionary();
    public static var sharedTexture_:BitmapData = null;
    private static var textureShaderEmbed_:Class = TextureRedrawer_textureShaderEmbed_;
    private static var textureShaderData_:ByteArray = (new textureShaderEmbed_() as ByteArray);
    private static var colorTexture1:BitmapData = new BitmapDataSpy(1, 1, false);
    private static var colorTexture2:BitmapData = new BitmapDataSpy(1, 1, false);


    public static function redraw(_arg_1:BitmapData, _arg_2:int, _arg_3:Boolean, _arg_4:uint, _arg_5:Boolean = true, _arg_6:Number = 5):BitmapData {
        var _local_7:String = getHash(_arg_2, _arg_3, _arg_4, _arg_6);
        if (((_arg_5) && (isCached(_arg_1, _local_7)))) {
            return (redrawCaches[_arg_1][_local_7]);
        }
        var _local_8:BitmapData = resize(_arg_1, null, _arg_2, _arg_3, 0, 0, _arg_6);
        _local_8 = GlowRedrawer.outlineGlow(_local_8, _arg_4, 1.4, _arg_5);
        if (_arg_5) {
            cache(_arg_1, _local_7, _local_8);
        }
        return (_local_8);
    }

    private static function getHash(_arg_1:int, _arg_2:Boolean, _arg_3:uint, _arg_4:Number):String {
        return (((((((_arg_1.toString() + ",") + _arg_3.toString()) + ",") + _arg_2) + ",") + _arg_4));
    }

    private static function cache(_arg_1:BitmapData, _arg_2:String, _arg_3:BitmapData):void {
        if (!(_arg_1 in redrawCaches)) {
            redrawCaches[_arg_1] = {};
        }
        redrawCaches[_arg_1][_arg_2] = _arg_3;
    }

    private static function isCached(_arg_1:BitmapData, _arg_2:String):Boolean {
        if ((_arg_1 in redrawCaches)) {
            if ((_arg_2 in redrawCaches[_arg_1])) {
                return (true);
            }
        }
        return (false);
    }

    public static function resize(_arg_1:BitmapData, _arg_2:BitmapData, _arg_3:int, _arg_4:Boolean, _arg_5:int, _arg_6:int, _arg_7:Number = 5):BitmapData {
        if (((!((_arg_2 == null))) && (((!((_arg_5 == 0))) || (!((_arg_6 == 0))))))) {
            _arg_1 = retexture(_arg_1, _arg_2, _arg_5, _arg_6);
            _arg_3 = (_arg_3 / 5);
        }
        var _local_8:int = ((_arg_7 * (_arg_3 / 100)) * _arg_1.width);
        var _local_9:int = ((_arg_7 * (_arg_3 / 100)) * _arg_1.height);
        var _local_10:Matrix = new Matrix();
        _local_10.scale((_local_8 / _arg_1.width), (_local_9 / _arg_1.height));
        _local_10.translate(magic, magic);
        var _local_11:BitmapData = new BitmapDataSpy((_local_8 + minSize), ((_local_9 + ((_arg_4) ? magic : 1)) + magic), true, 0);
        _local_11.draw(_arg_1, _local_10);
        return (_local_11);
    }

    public static function redrawSolidSquare(_arg_1:uint, _arg_2:int):BitmapData {
        var _local_3:Dictionary = cache_[_arg_2];
        if (_local_3 == null) {
            _local_3 = new Dictionary();
            cache_[_arg_2] = _local_3;
        }
        var _local_4:BitmapData = _local_3[_arg_1];
        if (_local_4 != null) {
            return (_local_4);
        }
        _local_4 = new BitmapDataSpy(((_arg_2 + 4) + 4), ((_arg_2 + 4) + 4), true, 0);
        _local_4.fillRect(new Rectangle(4, 4, _arg_2, _arg_2), (0xFF000000 | _arg_1));
        _local_4.applyFilter(_local_4, _local_4.rect, PointUtil.ORIGIN, OUTLINE_FILTER);
        _local_3[_arg_1] = _local_4;
        return (_local_4);
    }

    public static function clearCache():void {
        var _local_1:BitmapData;
        var _local_2:Dictionary;
        var _local_3:Dictionary;
        for each (_local_2 in cache_) {
            for each (_local_1 in _local_2) {
                _local_1.dispose();
            }
        }
        cache_ = new Dictionary();
        for each (_local_3 in faceCache_) {
            for each (_local_1 in _local_3) {
                _local_1.dispose();
            }
        }
        faceCache_ = new Dictionary();
    }

    public static function redrawFace(_arg_1:BitmapData, _arg_2:Number):BitmapData {
        if (_arg_2 == 1) {
            return (_arg_1);
        }
		if (_arg_1 == null) {
			return new BitmapData(1, 1, true, 0xFF000000);
		}
        var _local_3:Dictionary = faceCache_[_arg_2];
        if (_local_3 == null) {
            _local_3 = new Dictionary();
            faceCache_[_arg_2] = _local_3;
        }
        var _local_4:BitmapData = _local_3[_arg_1];
        if (_local_4 != null) {
            return (_local_4);
        }
        _local_4 = _arg_1.clone();
        _local_4.colorTransform(_local_4.rect, new ColorTransform(_arg_2, _arg_2, _arg_2));
        _local_3[_arg_1] = _local_4;
        return (_local_4);
    }

    private static function getTexture(_arg_1:int, _arg_2:BitmapData):BitmapData {
        var _local_3:BitmapData;
        var _local_4:int = ((_arg_1 >> 24) & 0xFF);
        var _local_5:int = (_arg_1 & 0xFFFFFF);
        switch (_local_4) {
            case 0:
                _local_3 = _arg_2;
                break;
            case 1:
                _arg_2.setPixel(0, 0, _local_5);
                _local_3 = _arg_2;
                break;
            case 4:
                _local_3 = AssetLibrary.getImageFromSet("textile4x4", _local_5);
                break;
            case 5:
                _local_3 = AssetLibrary.getImageFromSet("textile5x5", _local_5);
                break;
            case 9:
                _local_3 = AssetLibrary.getImageFromSet("textile9x9", _local_5);
                break;
            case 10:
                _local_3 = AssetLibrary.getImageFromSet("textile10x10", _local_5);
                break;
            case 0xFF:
                _local_3 = sharedTexture_;
                break;
            default:
                _local_3 = _arg_2;
        }
        return (_local_3);
    }

    private static function retexture(_arg_1:BitmapData, _arg_2:BitmapData, _arg_3:int, _arg_4:int):BitmapData {
        var _local_5:Matrix = new Matrix();
        _local_5.scale(5, 5);
        var _local_6:BitmapData = new BitmapDataSpy((_arg_1.width * 5), (_arg_1.height * 5), true, 0);
        _local_6.draw(_arg_1, _local_5);
        var _local_7:BitmapData = getTexture(_arg_3, colorTexture1);
        var _local_8:BitmapData = getTexture(_arg_4, colorTexture2);
        var _local_9:Shader = new Shader(textureShaderData_);
        _local_9.data.src.input = _local_6;
        _local_9.data.mask.input = _arg_2;
        _local_9.data.texture1.input = _local_7;
        _local_9.data.texture2.input = _local_8;
        _local_9.data.texture1Size.value = [(((_arg_3 == 0)) ? 0 : _local_7.width)];
        _local_9.data.texture2Size.value = [(((_arg_4 == 0)) ? 0 : _local_8.width)];
        _local_6.applyFilter(_local_6, _local_6.rect, PointUtil.ORIGIN, new ShaderFilter(_local_9));
        return (_local_6);
    }

    private static function getDrawMatrix():Matrix {
        var _local_1:Matrix = new Matrix();
        _local_1.scale(8, 8);
        _local_1.translate(BORDER, BORDER);
        return (_local_1);
    }


}
}//package com.company.assembleegameclient.util
