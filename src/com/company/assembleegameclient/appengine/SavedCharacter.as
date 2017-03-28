package com.company.assembleegameclient.appengine {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
import com.company.util.CachingColorTransformer;

import flash.display.BitmapData;
import flash.geom.ColorTransform;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.data.PetsModel;

public class SavedCharacter {

    public var charXML_:XML;
    public var name_:String = null;
    private var pet:PetVO;

    public function SavedCharacter(_arg_1:XML, _arg_2:String) {
        var _local_3:XML;
        var _local_4:int;
        var _local_5:PetVO;
        super();
        this.charXML_ = _arg_1;
        this.name_ = _arg_2;
        if (this.charXML_.hasOwnProperty("Pet")) {
            _local_3 = new XML(this.charXML_.Pet);
            _local_4 = int(_local_3.@instanceId);
            _local_5 = StaticInjectorContext.getInjector().getInstance(PetsModel).getPetVO(_local_4);
            _local_5.apply(_local_3);
            this.setPetVO(_local_5);
        }
    }

    public static function getImage(_arg_1:SavedCharacter, _arg_2:XML, _arg_3:int, _arg_4:int, _arg_5:Number, _arg_6:Boolean, _arg_7:Boolean):BitmapData {
        var _local_8:AnimatedChar = AnimatedChars.getAnimatedChar(String(_arg_2.AnimatedTexture.File), int(_arg_2.AnimatedTexture.Index));
        var _local_9:MaskedImage = _local_8.imageFromDir(_arg_3, _arg_4, _arg_5);
        var _local_10:int = (((_arg_1) != null) ? _arg_1.tex1() : null);
        var _local_11:int = (((_arg_1) != null) ? _arg_1.tex2() : null);
        var _local_12:BitmapData = TextureRedrawer.resize(_local_9.image_, _local_9.mask_, 100, false, _local_10, _local_11);
        _local_12 = GlowRedrawer.outlineGlow(_local_12, 0);
        if (!_arg_6) {
            _local_12 = CachingColorTransformer.transformBitmapData(_local_12, new ColorTransform(0, 0, 0, 0.5, 0, 0, 0, 0));
        }
        else {
            if (!_arg_7) {
                _local_12 = CachingColorTransformer.transformBitmapData(_local_12, new ColorTransform(0.75, 0.75, 0.75, 1, 0, 0, 0, 0));
            }
        }
        return (_local_12);
    }

    public static function compare(_arg_1:SavedCharacter, _arg_2:SavedCharacter):Number {
        var _local_3:Number = ((Parameters.data_.charIdUseMap.hasOwnProperty(_arg_1.charId())) ? Parameters.data_.charIdUseMap[_arg_1.charId()] : 0);
        var _local_4:Number = ((Parameters.data_.charIdUseMap.hasOwnProperty(_arg_2.charId())) ? Parameters.data_.charIdUseMap[_arg_2.charId()] : 0);
        if (_local_3 != _local_4) {
            return ((_local_4 - _local_3));
        }
        return ((_arg_2.xp() - _arg_1.xp()));
    }


    public function charId():int {
        return (int(this.charXML_.@id));
    }

    public function name():String {
        return (this.name_);
    }

    public function objectType():int {
        return (int(this.charXML_.ObjectType));
    }

    public function skinType():int {
        return (int(this.charXML_.Texture));
    }

    public function level():int {
        return (int(this.charXML_.Level));
    }

    public function tex1():int {
        return (int(this.charXML_.Tex1));
    }

    public function tex2():int {
        return (int(this.charXML_.Tex2));
    }

    public function xp():int {
        return (int(this.charXML_.Exp));
    }

    public function fame():int {
        return (int(this.charXML_.CurrentFame));
    }

    public function displayId():String {
        return (ObjectLibrary.typeToDisplayId_[this.objectType()]);
    }

    public function getPetVO():PetVO {
        return (this.pet);
    }

    public function setPetVO(_arg_1:PetVO):void {
        this.pet = _arg_1;
    }


}
}//package com.company.assembleegameclient.appengine
