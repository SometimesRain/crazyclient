package com.company.util {
import flash.display.BitmapData;
import flash.media.Sound;
import flash.media.SoundTransform;
import flash.utils.Dictionary;

public class AssetLibrary {

    private static var images_:Dictionary = new Dictionary();
    private static var imageSets_:Dictionary = new Dictionary();
    private static var sounds_:Dictionary = new Dictionary();
    private static var imageLookup_:Dictionary = new Dictionary();

    public function AssetLibrary(_arg_1:StaticEnforcer) {
    }

    public static function addImage(_arg_1:String, _arg_2:BitmapData):void {
        images_[_arg_1] = _arg_2;
        imageLookup_[_arg_2] = _arg_1;
    }

    public static function addImageSet(_arg_1:String, _arg_2:BitmapData, _arg_3:int, _arg_4:int):void {
        images_[_arg_1] = _arg_2;
        var _local_5:ImageSet = new ImageSet();
        _local_5.addFromBitmapData(_arg_2, _arg_3, _arg_4);
        imageSets_[_arg_1] = _local_5;
        var _local_6:int;
        while (_local_6 < _local_5.images_.length) {
            imageLookup_[_local_5.images_[_local_6]] = [_arg_1, _local_6];
            _local_6++;
        }
    }

    public static function addToImageSet(_arg_1:String, _arg_2:BitmapData):void {
        var _local_3:ImageSet = imageSets_[_arg_1];
        if (_local_3 == null) {
            _local_3 = new ImageSet();
            imageSets_[_arg_1] = _local_3;
        }
        _local_3.add(_arg_2);
        var _local_4:int = (_local_3.images_.length - 1);
        imageLookup_[_local_3.images_[_local_4]] = [_arg_1, _local_4];
    }

    public static function addSound(_arg_1:String, _arg_2:Class):void {
        var _local_3:Array = sounds_[_arg_1];
        if (_local_3 == null) {
            sounds_[_arg_1] = [];
        }
        sounds_[_arg_1].push(_arg_2);
    }

    public static function lookupImage(_arg_1:BitmapData):Object {
        return (imageLookup_[_arg_1]);
    }

    public static function getImage(_arg_1:String):BitmapData {
        return (images_[_arg_1]);
    }

    public static function getImageSet(_arg_1:String):ImageSet {
        return (imageSets_[_arg_1]);
    }

    public static function getImageFromSet(_arg_1:String, _arg_2:int):BitmapData {
        var _local_3:ImageSet = imageSets_[_arg_1];
        return (_local_3.images_[_arg_2]);
    }

    public static function getSound(_arg_1:String):Sound {
        var _local_2:Array = sounds_[_arg_1];
        var _local_3:int = (Math.random() * _local_2.length);
        return (new (sounds_[_arg_1][_local_3])());
    }

    public static function playSound(_arg_1:String, _arg_2:Number = 1):void {
        var _local_3:Array = sounds_[_arg_1];
        var _local_4:int = (Math.random() * _local_3.length);
        var _local_5:Sound = new (sounds_[_arg_1][_local_4])();
        var _local_6:SoundTransform;
        if (_arg_2 != 1) {
            _local_6 = new SoundTransform(_arg_2);
        }
        _local_5.play(0, 0, _local_6);
    }


}
}//package com.company.util

class StaticEnforcer {


}
