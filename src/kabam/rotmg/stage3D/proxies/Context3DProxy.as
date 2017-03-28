package kabam.rotmg.stage3D.proxies {
import flash.display3D.Context3D;
import flash.geom.Matrix3D;

public class Context3DProxy {

    private var context3D:Context3D;

    public function Context3DProxy(_arg_1:Context3D) {
        this.context3D = _arg_1;
    }

    public function GetContext3D():Context3D {
        return (this.context3D);
    }

    public function configureBackBuffer(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean = true):void {
        this.context3D.configureBackBuffer(_arg_1, _arg_2, _arg_3, _arg_4);
    }

    public function createProgram():Program3DProxy {
        return (new Program3DProxy(this.context3D.createProgram()));
    }

    public function clear():void {
        this.context3D.clear(0.05, 0.05, 0.05);
    }

    public function present():void {
        this.context3D.present();
    }

    public function createIndexBuffer(_arg_1:int):IndexBuffer3DProxy {
        return (new IndexBuffer3DProxy(this.context3D.createIndexBuffer(_arg_1)));
    }

    public function createVertexBuffer(_arg_1:int, _arg_2:int):VertexBuffer3DProxy {
        return (new VertexBuffer3DProxy(this.context3D.createVertexBuffer(_arg_1, _arg_2)));
    }

    public function setVertexBufferAt(_arg_1:int, _arg_2:VertexBuffer3DProxy, _arg_3:int, _arg_4:String = "float4"):void {
        this.context3D.setVertexBufferAt(_arg_1, _arg_2.getVertexBuffer3D(), _arg_3, _arg_4);
    }

    public function setProgramConstantsFromMatrix(_arg_1:String, _arg_2:int, _arg_3:Matrix3D, _arg_4:Boolean = false):void {
        this.context3D.setProgramConstantsFromMatrix(_arg_1, _arg_2, _arg_3, _arg_4);
    }

    public function setProgramConstantsFromVector(_arg_1:String, _arg_2:int, _arg_3:Vector.<Number>, _arg_4:int = -1):void {
        this.context3D.setProgramConstantsFromVector(_arg_1, _arg_2, _arg_3, _arg_4);
    }

    public function createTexture(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean):TextureProxy {
        return (new TextureProxy(this.context3D.createTexture(_arg_1, _arg_2, _arg_3, _arg_4)));
    }

    public function setTextureAt(_arg_1:int, _arg_2:TextureProxy):void {
        this.context3D.setTextureAt(_arg_1, _arg_2.getTexture());
    }

    public function setProgram(_arg_1:Program3DProxy):void {
        this.context3D.setProgram(_arg_1.getProgram3D());
    }

    public function drawTriangles(_arg_1:IndexBuffer3DProxy):void {
        this.context3D.drawTriangles(_arg_1.getIndexBuffer3D());
    }

    public function setBlendFactors(_arg_1:String, _arg_2:String):void {
        this.context3D.setBlendFactors(_arg_1, _arg_2);
    }

    public function setDepthTest(_arg_1:Boolean, _arg_2:String):void {
        this.context3D.setDepthTest(_arg_1, _arg_2);
    }


}
}//package kabam.rotmg.stage3D.proxies
