package kabam.rotmg.stage3D.graphic3D {
import flash.utils.Dictionary;

import kabam.rotmg.stage3D.proxies.Context3DProxy;
import kabam.rotmg.stage3D.proxies.VertexBuffer3DProxy;

import org.swiftsuspenders.Injector;
import org.swiftsuspenders.dependencyproviders.DependencyProvider;

public class VertexBufferFactory implements DependencyProvider {

    private var vertexBuffer:VertexBuffer3DProxy;

    public function VertexBufferFactory(_arg_1:Context3DProxy) {
        var _local_2:Vector.<Number> = Vector.<Number>([-0.5, 0.5, 0, 0, 0, 0.5, 0.5, 0, 1, 0, -0.5, -0.5, 0, 0, 1, 0.5, -0.5, 0, 1, 1]);
        this.vertexBuffer = _arg_1.createVertexBuffer(4, 5);
        this.vertexBuffer.uploadFromVector(_local_2, 0, 4);
    }

    public function apply(_arg_1:Class, _arg_2:Injector, _arg_3:Dictionary):Object {
        return (this.vertexBuffer);
    }

    public function destroy():void {
    }


}
}//package kabam.rotmg.stage3D.graphic3D
