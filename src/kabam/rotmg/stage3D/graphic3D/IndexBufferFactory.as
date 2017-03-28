package kabam.rotmg.stage3D.graphic3D {
import flash.utils.Dictionary;

import kabam.rotmg.stage3D.proxies.Context3DProxy;
import kabam.rotmg.stage3D.proxies.IndexBuffer3DProxy;

import org.swiftsuspenders.Injector;
import org.swiftsuspenders.dependencyproviders.DependencyProvider;

public class IndexBufferFactory implements DependencyProvider {

    private static const numVertices:int = 6;

    private var indexBuffer:IndexBuffer3DProxy;

    public function IndexBufferFactory(_arg_1:Context3DProxy):void {
        var _local_2:Vector.<uint> = Vector.<uint>([0, 1, 2, 2, 1, 3]);
        if (_arg_1 != null) {
            this.indexBuffer = _arg_1.createIndexBuffer(numVertices);
            this.indexBuffer.uploadFromVector(_local_2, 0, numVertices);
        }
    }

    public function apply(_arg_1:Class, _arg_2:Injector, _arg_3:Dictionary):Object {
        return (this.indexBuffer);
    }

    public function destroy():void {
    }


}
}//package kabam.rotmg.stage3D.graphic3D
