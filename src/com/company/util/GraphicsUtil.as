package com.company.util {
import flash.display.CapsStyle;
import flash.display.GraphicsEndFill;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.geom.Matrix;

public class GraphicsUtil {

    public static const END_FILL:GraphicsEndFill = new GraphicsEndFill();
    public static const QUAD_COMMANDS:Vector.<int> = new <int>[GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO];
    public static const DEBUG_STROKE:GraphicsStroke = new GraphicsStroke(1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, new GraphicsSolidFill(0xFF0000));
    public static const END_STROKE:GraphicsStroke = new GraphicsStroke();
    private static const TWO_PI:Number = (2 * Math.PI);//6.28318530717959
    public static const ALL_CUTS:Array = [true, true, true, true];


    public static function clearPath(_arg_1:GraphicsPath):void {
        _arg_1.commands.length = 0;
        _arg_1.data.length = 0;
    }

    public static function getRectPath(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):GraphicsPath {
        return (new GraphicsPath(QUAD_COMMANDS, new <Number>[_arg_1, _arg_2, (_arg_1 + _arg_3), _arg_2, (_arg_1 + _arg_3), (_arg_2 + _arg_4), _arg_1, (_arg_2 + _arg_4)]));
    }

    public static function getGradientMatrix(_arg_1:Number, _arg_2:Number, _arg_3:Number = 0, _arg_4:Number = 0, _arg_5:Number = 0):Matrix {
        var _local_6:Matrix = new Matrix();
        _local_6.createGradientBox(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        return (_local_6);
    }

    public static function drawRect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:GraphicsPath):void {
        _arg_5.moveTo(_arg_1, _arg_2);
        _arg_5.lineTo((_arg_1 + _arg_3), _arg_2);
        _arg_5.lineTo((_arg_1 + _arg_3), (_arg_2 + _arg_4));
        _arg_5.lineTo(_arg_1, (_arg_2 + _arg_4));
    }

    public static function drawCircle(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:GraphicsPath, _arg_5:int = 8):void {
        var _local_8:Number;
        var _local_9:Number;
        var _local_10:Number;
        var _local_11:Number;
        var _local_12:Number;
        var _local_13:Number;
        var _local_6:Number = (1 + (1 / (_arg_5 * 1.75)));
        _arg_4.moveTo((_arg_1 + _arg_3), _arg_2);
        var _local_7:int = 1;
        while (_local_7 <= _arg_5) {
            _local_8 = ((TWO_PI * _local_7) / _arg_5);
            _local_9 = ((TWO_PI * (_local_7 - 0.5)) / _arg_5);
            _local_10 = (_arg_1 + (_arg_3 * Math.cos(_local_8)));
            _local_11 = (_arg_2 + (_arg_3 * Math.sin(_local_8)));
            _local_12 = (_arg_1 + ((_arg_3 * _local_6) * Math.cos(_local_9)));
            _local_13 = (_arg_2 + ((_arg_3 * _local_6) * Math.sin(_local_9)));
            _arg_4.curveTo(_local_12, _local_13, _local_10, _local_11);
            _local_7++;
        }
    }

    public static function drawCutEdgeRect(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:Array, _arg_7:GraphicsPath):void {
        if (_arg_6[0] != 0) {
            _arg_7.moveTo(_arg_1, (_arg_2 + _arg_5));
            _arg_7.lineTo((_arg_1 + _arg_5), _arg_2);
        }
        else {
            _arg_7.moveTo(_arg_1, _arg_2);
        }
        if (_arg_6[1] != 0) {
            _arg_7.lineTo(((_arg_1 + _arg_3) - _arg_5), _arg_2);
            _arg_7.lineTo((_arg_1 + _arg_3), (_arg_2 + _arg_5));
        }
        else {
            _arg_7.lineTo((_arg_1 + _arg_3), _arg_2);
        }
        if (_arg_6[2] != 0) {
            _arg_7.lineTo((_arg_1 + _arg_3), ((_arg_2 + _arg_4) - _arg_5));
            _arg_7.lineTo(((_arg_1 + _arg_3) - _arg_5), (_arg_2 + _arg_4));
        }
        else {
            _arg_7.lineTo((_arg_1 + _arg_3), (_arg_2 + _arg_4));
        }
        if (_arg_6[3] != 0) {
            _arg_7.lineTo((_arg_1 + _arg_5), (_arg_2 + _arg_4));
            _arg_7.lineTo(_arg_1, ((_arg_2 + _arg_4) - _arg_5));
        }
        else {
            _arg_7.lineTo(_arg_1, (_arg_2 + _arg_4));
        }
        if (_arg_6[0] != 0) {
            _arg_7.lineTo(_arg_1, (_arg_2 + _arg_5));
        }
        else {
            _arg_7.lineTo(_arg_1, _arg_2);
        }
    }

    public static function drawDiamond(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:GraphicsPath):void {
        _arg_4.moveTo(_arg_1, (_arg_2 - _arg_3));
        _arg_4.lineTo((_arg_1 + _arg_3), _arg_2);
        _arg_4.lineTo(_arg_1, (_arg_2 + _arg_3));
        _arg_4.lineTo((_arg_1 - _arg_3), _arg_2);
    }


}
}//package com.company.util
