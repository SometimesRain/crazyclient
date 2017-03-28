package kabam.rotmg.stage3D.graphic3D {
import kabam.rotmg.stage3D.proxies.IndexBuffer3DProxy;
import kabam.rotmg.stage3D.proxies.VertexBuffer3DProxy;

import org.swiftsuspenders.Injector;

public class Graphic3DHelper {


    public static function map(_arg_1:Injector):void {
        injectSingletonIndexBuffer(_arg_1);
        injectSingletonVertexBuffer(_arg_1);
    }

    private static function injectSingletonIndexBuffer(_arg_1:Injector):void {
        var _local_2:IndexBufferFactory = _arg_1.getInstance(IndexBufferFactory);
        _arg_1.map(IndexBuffer3DProxy).toProvider(_local_2);
    }

    private static function injectSingletonVertexBuffer(_arg_1:Injector):void {
        var _local_2:VertexBufferFactory = _arg_1.getInstance(VertexBufferFactory);
        _arg_1.map(VertexBuffer3DProxy).toProvider(_local_2);
    }


}
}//package kabam.rotmg.stage3D.graphic3D
