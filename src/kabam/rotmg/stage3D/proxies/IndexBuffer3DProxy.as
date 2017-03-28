package kabam.rotmg.stage3D.proxies {
import flash.display3D.IndexBuffer3D;

public class IndexBuffer3DProxy {

    private var indexBuffer:IndexBuffer3D;

    public function IndexBuffer3DProxy(_arg_1:IndexBuffer3D) {
        this.indexBuffer = _arg_1;
    }

    public function uploadFromVector(_arg_1:Vector.<uint>, _arg_2:int, _arg_3:int):void {
        this.indexBuffer.uploadFromVector(_arg_1, _arg_2, _arg_3);
    }

    public function getIndexBuffer3D():IndexBuffer3D {
        return (this.indexBuffer);
    }


}
}//package kabam.rotmg.stage3D.proxies
