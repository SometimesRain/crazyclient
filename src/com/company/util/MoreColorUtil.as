package com.company.util {
import flash.geom.ColorTransform;

public class MoreColorUtil {

    public static const greyscaleFilterMatrix:Array = [0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
    public static const redFilterMatrix:Array = [0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0];
    public static const identity:ColorTransform = new ColorTransform();
    public static const invisible:ColorTransform = new ColorTransform(1, 1, 1, 0, 0, 0, 0, 0);
    public static const transparentCT:ColorTransform = new ColorTransform(1, 1, 1, 0.3, 0, 0, 0, 0);
    public static const slightlyTransparentCT:ColorTransform = new ColorTransform(1, 1, 1, 0.7, 0, 0, 0, 0);
    public static const greenCT:ColorTransform = new ColorTransform(0.6, 1, 0.6, 1, 0, 0, 0, 0);
    public static const lightGreenCT:ColorTransform = new ColorTransform(0.8, 1, 0.8, 1, 0, 0, 0, 0);
    public static const veryGreenCT:ColorTransform = new ColorTransform(0.2, 1, 0.2, 1, 0, 100, 0, 0);
    public static const transparentGreenCT:ColorTransform = new ColorTransform(0.5, 1, 0.5, 0.3, 0, 0, 0, 0);
    public static const transparentVeryGreenCT:ColorTransform = new ColorTransform(0.3, 1, 0.3, 0.5, 0, 0, 0, 0);
    public static const redCT:ColorTransform = new ColorTransform(1, 0.5, 0.5, 1, 0, 0, 0, 0);
    public static const lightRedCT:ColorTransform = new ColorTransform(1, 0.7, 0.7, 1, 0, 0, 0, 0);
    public static const veryRedCT:ColorTransform = new ColorTransform(1, 0.2, 0.2, 1, 100, 0, 0, 0);
    public static const transparentRedCT:ColorTransform = new ColorTransform(1, 0.5, 0.5, 0.3, 0, 0, 0, 0);
    public static const transparentVeryRedCT:ColorTransform = new ColorTransform(1, 0.3, 0.3, 0.5, 0, 0, 0, 0);
    public static const blueCT:ColorTransform = new ColorTransform(0.5, 0.5, 1, 1, 0, 0, 0, 0);
    public static const lightBlueCT:ColorTransform = new ColorTransform(0.7, 0.7, 1, 1, 0, 0, 100, 0);
    public static const veryBlueCT:ColorTransform = new ColorTransform(0.3, 0.3, 1, 1, 0, 0, 100, 0);
    public static const transparentBlueCT:ColorTransform = new ColorTransform(0.5, 0.5, 1, 0.3, 0, 0, 0, 0);
    public static const transparentVeryBlueCT:ColorTransform = new ColorTransform(0.3, 0.3, 1, 0.5, 0, 0, 0, 0);
    public static const purpleCT:ColorTransform = new ColorTransform(1, 0.5, 1, 1, 0, 0, 0, 0);
    public static const veryPurpleCT:ColorTransform = new ColorTransform(1, 0.2, 1, 1, 100, 0, 100, 0);
    public static const darkCT:ColorTransform = new ColorTransform(0.6, 0.6, 0.6, 1, 0, 0, 0, 0);
    public static const veryDarkCT:ColorTransform = new ColorTransform(0.4, 0.4, 0.4, 1, 0, 0, 0, 0);
    public static const makeWhiteCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0);

    public function MoreColorUtil(_arg_1:StaticEnforcer) {
    }

    public static function hsvToRgb(_arg_1:Number, _arg_2:Number, _arg_3:Number):int {
        var _local_9:Number;
        var _local_10:Number;
        var _local_11:Number;
        var _local_4:int = (int((_arg_1 / 60)) % 6);
        var _local_5:Number = ((_arg_1 / 60) - Math.floor((_arg_1 / 60)));
        var _local_6:Number = (_arg_3 * (1 - _arg_2));
        var _local_7:Number = (_arg_3 * (1 - (_local_5 * _arg_2)));
        var _local_8:Number = (_arg_3 * (1 - ((1 - _local_5) * _arg_2)));
        switch (_local_4) {
            case 0:
                _local_9 = _arg_3;
                _local_10 = _local_8;
                _local_11 = _local_6;
                break;
            case 1:
                _local_9 = _local_7;
                _local_10 = _arg_3;
                _local_11 = _local_6;
                break;
            case 2:
                _local_9 = _local_6;
                _local_10 = _arg_3;
                _local_11 = _local_8;
                break;
            case 3:
                _local_9 = _local_6;
                _local_10 = _local_7;
                _local_11 = _arg_3;
                break;
            case 4:
                _local_9 = _local_8;
                _local_10 = _local_6;
                _local_11 = _arg_3;
                break;
            case 5:
                _local_9 = _arg_3;
                _local_10 = _local_6;
                _local_11 = _local_7;
                break;
        }
        return ((((int(Math.min(0xFF, Math.floor((_local_9 * 0xFF)))) << 16) | (int(Math.min(0xFF, Math.floor((_local_10 * 0xFF)))) << 8)) | int(Math.min(0xFF, Math.floor((_local_11 * 0xFF))))));
    }

    public static function randomColor():uint {
        return (uint((0xFFFFFF * Math.random())));
    }

    public static function randomColor32():uint {
        return ((uint((0xFFFFFF * Math.random())) | 0xFF000000));
    }

    public static function transformColor(_arg_1:ColorTransform, _arg_2:uint):uint {
        var _local_3:int = ((((_arg_2 & 0xFF0000) >> 16) * _arg_1.redMultiplier) + _arg_1.redOffset);
        _local_3 = (((_local_3 < 0)) ? 0 : (((_local_3 > 0xFF)) ? 0xFF : _local_3));
        var _local_4:int = ((((_arg_2 & 0xFF00) >> 8) * _arg_1.greenMultiplier) + _arg_1.greenOffset);
        _local_4 = (((_local_4 < 0)) ? 0 : (((_local_4 > 0xFF)) ? 0xFF : _local_4));
        var _local_5:int = (((_arg_2 & 0xFF) * _arg_1.blueMultiplier) + _arg_1.blueOffset);
        _local_5 = (((_local_5 < 0)) ? 0 : (((_local_5 > 0xFF)) ? 0xFF : _local_5));
        return ((((_local_3 << 16) | (_local_4 << 8)) | _local_5));
    }

    public static function copyColorTransform(_arg_1:ColorTransform):ColorTransform {
        return (new ColorTransform(_arg_1.redMultiplier, _arg_1.greenMultiplier, _arg_1.blueMultiplier, _arg_1.alphaMultiplier, _arg_1.redOffset, _arg_1.greenOffset, _arg_1.blueOffset, _arg_1.alphaOffset));
    }

    public static function lerpColorTransform(_arg_1:ColorTransform, _arg_2:ColorTransform, _arg_3:Number):ColorTransform {
        if (_arg_1 == null) {
            _arg_1 = identity;
        }
        if (_arg_2 == null) {
            _arg_2 = identity;
        }
        var _local_4:Number = (1 - _arg_3);
        var _local_5:ColorTransform = new ColorTransform(((_arg_1.redMultiplier * _local_4) + (_arg_2.redMultiplier * _arg_3)), ((_arg_1.greenMultiplier * _local_4) + (_arg_2.greenMultiplier * _arg_3)), ((_arg_1.blueMultiplier * _local_4) + (_arg_2.blueMultiplier * _arg_3)), ((_arg_1.alphaMultiplier * _local_4) + (_arg_2.alphaMultiplier * _arg_3)), ((_arg_1.redOffset * _local_4) + (_arg_2.redOffset * _arg_3)), ((_arg_1.greenOffset * _local_4) + (_arg_2.greenOffset * _arg_3)), ((_arg_1.blueOffset * _local_4) + (_arg_2.blueOffset * _arg_3)), ((_arg_1.alphaOffset * _local_4) + (_arg_2.alphaOffset * _arg_3)));
        return (_local_5);
    }

    public static function lerpColor(_arg_1:uint, _arg_2:uint, _arg_3:Number):uint {
        var _local_4:Number = (1 - _arg_3);
        var _local_5:uint = ((_arg_1 >> 24) & 0xFF);
        var _local_6:uint = ((_arg_1 >> 16) & 0xFF);
        var _local_7:uint = ((_arg_1 >> 8) & 0xFF);
        var _local_8:uint = (_arg_1 & 0xFF);
        var _local_9:uint = ((_arg_2 >> 24) & 0xFF);
        var _local_10:uint = ((_arg_2 >> 16) & 0xFF);
        var _local_11:uint = ((_arg_2 >> 8) & 0xFF);
        var _local_12:uint = (_arg_2 & 0xFF);
        var _local_13:uint = ((_local_5 * _local_4) + (_local_9 * _arg_3));
        var _local_14:uint = ((_local_6 * _local_4) + (_local_10 * _arg_3));
        var _local_15:uint = ((_local_7 * _local_4) + (_local_11 * _arg_3));
        var _local_16:uint = ((_local_8 * _local_4) + (_local_12 * _arg_3));
        var _local_17:uint = ((((_local_13 << 24) | (_local_14 << 16)) | (_local_15 << 8)) | _local_16);
        return (_local_17);
    }

    public static function transformAlpha(_arg_1:ColorTransform, _arg_2:Number):Number {
        var _local_3:uint = (_arg_2 * 0xFF);
        var _local_4:uint = ((_local_3 * _arg_1.alphaMultiplier) + _arg_1.alphaOffset);
        _local_4 = (((_local_4 < 0)) ? 0 : (((_local_4 > 0xFF)) ? 0xFF : _local_4));
        return ((_local_4 / 0xFF));
    }

    public static function multiplyColor(_arg_1:uint, _arg_2:Number):uint {
        var _local_3:int = (((_arg_1 & 0xFF0000) >> 16) * _arg_2);
        _local_3 = (((_local_3 < 0)) ? 0 : (((_local_3 > 0xFF)) ? 0xFF : _local_3));
        var _local_4:int = (((_arg_1 & 0xFF00) >> 8) * _arg_2);
        _local_4 = (((_local_4 < 0)) ? 0 : (((_local_4 > 0xFF)) ? 0xFF : _local_4));
        var _local_5:int = ((_arg_1 & 0xFF) * _arg_2);
        _local_5 = (((_local_5 < 0)) ? 0 : (((_local_5 > 0xFF)) ? 0xFF : _local_5));
        return ((((_local_3 << 16) | (_local_4 << 8)) | _local_5));
    }

    public static function adjustBrightness(_arg_1:uint, _arg_2:Number):uint {
        var _local_3:uint = (_arg_1 & 0xFF000000);
        var _local_4:int = (((_arg_1 & 0xFF0000) >> 16) + (_arg_2 * 0xFF));
        _local_4 = (((_local_4 < 0)) ? 0 : (((_local_4 > 0xFF)) ? 0xFF : _local_4));
        var _local_5:int = (((_arg_1 & 0xFF00) >> 8) + (_arg_2 * 0xFF));
        _local_5 = (((_local_5 < 0)) ? 0 : (((_local_5 > 0xFF)) ? 0xFF : _local_5));
        var _local_6:int = ((_arg_1 & 0xFF) + (_arg_2 * 0xFF));
        _local_6 = (((_local_6 < 0)) ? 0 : (((_local_6 > 0xFF)) ? 0xFF : _local_6));
        return ((((_local_3 | (_local_4 << 16)) | (_local_5 << 8)) | _local_6));
    }

    public static function colorToShaderParameter(_arg_1:uint):Array {
        var _local_2:Number = (((_arg_1 >> 24) & 0xFF) / 0x0100);
        return ([(_local_2 * (((_arg_1 >> 16) & 0xFF) / 0x0100)), (_local_2 * (((_arg_1 >> 8) & 0xFF) / 0x0100)), (_local_2 * ((_arg_1 & 0xFF) / 0x0100)), _local_2]);
    }

    public static function rgbToGreyscale(_arg_1:uint):uint {
        var _local_2:uint = (((((_arg_1 & 0xFF0000) >> 16) * 0.3) + (((_arg_1 & 0xFF00) >> 8) * 0.59)) + ((_arg_1 & 0xFF) * 0.11));
        return ((((((_arg_1) && (0xFF000000)) | (_local_2 << 16)) | (_local_2 << 8)) | _local_2));
    }

    public static function singleColorFilterMatrix(_arg_1:uint):Array {
        return ([0, 0, 0, 0, ((_arg_1 & 0xFF0000) >> 16), 0, 0, 0, 0, ((_arg_1 & 0xFF00) >> 8), 0, 0, 0, 0, (_arg_1 & 0xFF), 0, 0, 0, 1, 0]);
    }


}
}//package com.company.util

class StaticEnforcer {


}
