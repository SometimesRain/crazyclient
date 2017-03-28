package kabam.rotmg.stage3D {
import com.company.assembleegameclient.parameters.Parameters;

import flash.display.BitmapData;
import flash.display.GraphicsBitmapFill;
import flash.display.GraphicsSolidFill;
import flash.display3D.Context3DVertexBufferFormat;
import flash.display3D.VertexBuffer3D;
import flash.geom.ColorTransform;
import flash.utils.Dictionary;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.stage3D.proxies.Context3DProxy;

public class GraphicsFillExtra {

    private static var textureOffsets:Dictionary = new Dictionary();
    private static var textureOffsetsSize:uint = 0;
    private static var waterSinks:Dictionary = new Dictionary();
    private static var waterSinksSize:uint = 0;
    private static var colorTransforms:Dictionary = new Dictionary();
    private static var colorTransformsSize:uint = 0;
    private static var vertexBuffers:Dictionary = new Dictionary();
    private static var vertexBuffersSize:uint = 0;
    private static var softwareDraw:Dictionary = new Dictionary();
    private static var softwareDrawSize:uint = 0;
    private static var softwareDrawSolid:Dictionary = new Dictionary();
    private static var softwareDrawSolidSize:uint = 0;
    private static var lastChecked:uint = 0;
    private static const DEFAULT_OFFSET:Vector.<Number> = Vector.<Number>([0, 0, 0, 0]);


    public static function setColorTransform(_arg_1:BitmapData, _arg_2:ColorTransform):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (colorTransforms[_arg_1] == null) {
            colorTransformsSize++;
        }
        colorTransforms[_arg_1] = _arg_2;
    }

    public static function getColorTransform(_arg_1:BitmapData):ColorTransform {
        var _local_2:ColorTransform;
        if ((_arg_1 in colorTransforms)) {
            _local_2 = colorTransforms[_arg_1];
            colorTransforms[_arg_1] = new ColorTransform();
        }
        else {
            _local_2 = new ColorTransform();
            colorTransforms[_arg_1] = _local_2;
            colorTransformsSize++;
        }
        return (_local_2);
    }

    public static function setOffsetUV(_arg_1:GraphicsBitmapFill, _arg_2:Number, _arg_3:Number):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        testOffsetUV(_arg_1);
        textureOffsets[_arg_1][0] = _arg_2;
        textureOffsets[_arg_1][1] = _arg_3;
    }

    public static function getOffsetUV(_arg_1:GraphicsBitmapFill):Vector.<Number> {
        if (textureOffsets[_arg_1] != null) {
            return (textureOffsets[_arg_1]);
        }
        return (DEFAULT_OFFSET);
    }

    private static function testOffsetUV(_arg_1:GraphicsBitmapFill):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (textureOffsets[_arg_1] == null) {
            textureOffsetsSize++;
            textureOffsets[_arg_1] = Vector.<Number>([0, 0, 0, 0]);
        }
    }

    public static function setSinkLevel(_arg_1:GraphicsBitmapFill, _arg_2:Number):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (waterSinks[_arg_1] == null) {
            waterSinksSize++;
        }
        waterSinks[_arg_1] = _arg_2;
    }

    public static function getSinkLevel(_arg_1:GraphicsBitmapFill):Number {
        if (((!((waterSinks[_arg_1] == null))) && ((waterSinks[_arg_1] is Number)))) {
            return (waterSinks[_arg_1]);
        }
        return (0);
    }

    public static function setVertexBuffer(_arg_1:GraphicsBitmapFill, _arg_2:Vector.<Number>):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        var _local_3:Context3DProxy = StaticInjectorContext.getInjector().getInstance(Context3DProxy);
        var _local_4:VertexBuffer3D = _local_3.GetContext3D().createVertexBuffer(4, 5);
        _local_4.uploadFromVector(_arg_2, 0, 4);
        _local_3.GetContext3D().setVertexBufferAt(0, _local_4, 0, Context3DVertexBufferFormat.FLOAT_3);
        _local_3.GetContext3D().setVertexBufferAt(1, _local_4, 3, Context3DVertexBufferFormat.FLOAT_2);
        if (vertexBuffers[_arg_1] == null) {
            vertexBuffersSize++;
        }
        vertexBuffers[_arg_1] = _local_4;
    }

    public static function getVertexBuffer(_arg_1:GraphicsBitmapFill):VertexBuffer3D {
        if (((!((vertexBuffers[_arg_1] == null))) && ((vertexBuffers[_arg_1] is VertexBuffer3D)))) {
            return (vertexBuffers[_arg_1]);
        }
        return (null);
    }

    public static function clearSink(_arg_1:GraphicsBitmapFill):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (waterSinks[_arg_1] != null) {
            waterSinksSize--;
            delete waterSinks[_arg_1];
        }
    }

    public static function setSoftwareDraw(_arg_1:GraphicsBitmapFill, _arg_2:Boolean):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (softwareDraw[_arg_1] == null) {
            softwareDrawSize++;
        }
        softwareDraw[_arg_1] = _arg_2;
    }

    public static function isSoftwareDraw(_arg_1:GraphicsBitmapFill):Boolean {
        if (((!((softwareDraw[_arg_1] == null))) && ((softwareDraw[_arg_1] is Boolean)))) {
            return (softwareDraw[_arg_1]);
        }
        return (false);
    }

    public static function setSoftwareDrawSolid(_arg_1:GraphicsSolidFill, _arg_2:Boolean):void {
        if (!Parameters.isGpuRender()) {
            return;
        }
        if (softwareDrawSolid[_arg_1] == null) {
            softwareDrawSolidSize++;
        }
        softwareDrawSolid[_arg_1] = _arg_2;
    }

    public static function isSoftwareDrawSolid(_arg_1:GraphicsSolidFill):Boolean {
        if (((!((softwareDrawSolid[_arg_1] == null))) && ((softwareDrawSolid[_arg_1] is Boolean)))) {
            return (softwareDrawSolid[_arg_1]);
        }
        return (false);
    }

    public static function dispose():void {
        textureOffsets = new Dictionary();
        waterSinks = new Dictionary();
        colorTransforms = new Dictionary();
        disposeVertexBuffers();
        softwareDraw = new Dictionary();
        softwareDrawSolid = new Dictionary();
        textureOffsetsSize = 0;
        waterSinksSize = 0;
        colorTransformsSize = 0;
        vertexBuffersSize = 0;
        softwareDrawSize = 0;
        softwareDrawSolidSize = 0;
    }

    public static function disposeVertexBuffers():void {
        var _local_1:VertexBuffer3D;
        for each (_local_1 in vertexBuffers) {
            _local_1.dispose();
        }
        vertexBuffers = new Dictionary();
    }

    public static function manageSize():void {
        if (colorTransformsSize > 2000) {
            colorTransforms = new Dictionary();
            colorTransformsSize = 0;
        }
        if (textureOffsetsSize > 2000) {
            textureOffsets = new Dictionary();
            textureOffsetsSize = 0;
        }
        if (waterSinksSize > 2000) {
            waterSinks = new Dictionary();
            waterSinksSize = 0;
        }
        if (vertexBuffersSize > 1000) {
            disposeVertexBuffers();
            vertexBuffersSize = 0;
        }
        if (softwareDrawSize > 2000) {
            softwareDraw = new Dictionary();
            softwareDrawSize = 0;
        }
        if (softwareDrawSolidSize > 2000) {
            softwareDrawSolid = new Dictionary();
            softwareDrawSolidSize = 0;
        }
    }


}
}//package kabam.rotmg.stage3D
