package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import kabam.rotmg.pets.data.PetVO;

public class PetIconFactory {

    public var outlineSize:Number = 1.4;


    public function create(_arg_1:PetVO, _arg_2:int):PetIcon {
        var _local_3:BitmapData = this.getPetSkinTexture(_arg_1, _arg_2);
        var _local_4:Bitmap = new Bitmap(_local_3);
        var _local_5:PetIcon = new PetIcon(_arg_1);
        _local_5.setBitmap(_local_4);
        return (_local_5);
    }

    public function getPetSkinTexture(_arg_1:PetVO, _arg_2:int):BitmapData {
        var _local_4:Number;
        var _local_5:BitmapData;
        var _local_3:BitmapData = ((_arg_1.getSkinMaskedImage()) ? _arg_1.getSkinMaskedImage().image_ : null);
        if (_local_3) {
            _local_4 = ((_arg_2 - TextureRedrawer.minSize) / _local_3.width);
            _local_5 = TextureRedrawer.resize(_local_3, _arg_1.getSkinMaskedImage().mask_, 100, true, 0, 0, _local_4);
            _local_5 = GlowRedrawer.outlineGlow(_local_5, 0, this.outlineSize);
            return (_local_5);
        }
        return (new BitmapDataSpy(_arg_2, _arg_2));
    }


}
}//package kabam.rotmg.pets.view.components
