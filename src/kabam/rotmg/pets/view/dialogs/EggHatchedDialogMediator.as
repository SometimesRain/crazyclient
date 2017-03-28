package kabam.rotmg.pets.view.dialogs {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;

import flash.display.Bitmap;
import flash.display.BitmapData;

import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.pets.data.PetsModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class EggHatchedDialogMediator extends Mediator {

    [Inject]
    public var view:EggHatchedDialog;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var closeDialog:CloseDialogsSignal;


    override public function initialize():void {
        var _local_1:Bitmap = this.getTypeBitmap();
        this.view.init(_local_1);
        this.view.closed.add(this.onClosed);
    }

    private function onClosed():void {
        this.closeDialog.dispatch();
    }

    private function getTypeBitmap():Bitmap {
        var _local_1:String = ObjectLibrary.getIdFromType(this.view.skinType);
        var _local_2:XML = ObjectLibrary.getXMLfromId(_local_1);
        var _local_3:String = _local_2.AnimatedTexture.File;
        var _local_4:int = _local_2.AnimatedTexture.Index;
        var _local_5:AnimatedChar = AnimatedChars.getAnimatedChar(_local_3, _local_4);
        var _local_6:MaskedImage = _local_5.imageFromAngle(0, AnimatedChar.STAND, 0);
        var _local_7:BitmapData = TextureRedrawer.resize(_local_6.image_, _local_6.mask_, 160, true, 0, 0);
        _local_7 = GlowRedrawer.outlineGlow(_local_7, 0, 6);
        return (new Bitmap(_local_7));
    }


}
}//package kabam.rotmg.pets.view.dialogs
