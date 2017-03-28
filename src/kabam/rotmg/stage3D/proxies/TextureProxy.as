package kabam.rotmg.stage3D.proxies {
import flash.display.BitmapData;
import flash.display3D.textures.Texture;
import flash.display3D.textures.TextureBase;

public class TextureProxy {

    private var texture:Texture;
    protected var width:int;
    protected var height:int;

    public function TextureProxy(_arg_1:Texture) {
        this.texture = _arg_1;
    }

    public function uploadFromBitmapData(_arg_1:BitmapData):void {
        this.width = _arg_1.width;
        this.height = _arg_1.height;
        this.texture.uploadFromBitmapData(_arg_1);
    }

    public function getTexture():TextureBase {
        return (this.texture);
    }

    public function getWidth():int {
        return (this.width);
    }

    public function getHeight():int {
        return (this.height);
    }

    public function dispose():void {
        this.texture.dispose();
    }


}
}//package kabam.rotmg.stage3D.proxies
