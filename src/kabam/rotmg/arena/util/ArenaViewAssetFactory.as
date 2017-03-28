package kabam.rotmg.arena.util {
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.display.Bitmap;
import flash.filters.DropShadowFilter;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;

public class ArenaViewAssetFactory {


    public static function returnTextfield(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean = false):TextFieldDisplayConcrete {
        var _local_5:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
        _local_5.setSize(_arg_2).setColor(_arg_1).setBold(_arg_3);
        _local_5.setVerticalAlign(TextFieldDisplayConcrete.BOTTOM);
        _local_5.filters = ((_arg_4) ? [new DropShadowFilter(0, 0, 0)] : []);
        return (_local_5);
    }

    public static function returnHostBitmap(_arg_1:uint):Bitmap {
        return (new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_arg_1, 80, true)));
    }


}
}//package kabam.rotmg.arena.util
