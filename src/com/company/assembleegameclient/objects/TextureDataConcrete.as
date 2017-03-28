package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.appengine.RemoteTexture;
import com.company.assembleegameclient.objects.particles.EffectProperties;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;
import com.company.assembleegameclient.util.AssetLoader;
import com.company.assembleegameclient.util.MaskedImage;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.utils.Dictionary;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class TextureDataConcrete extends TextureData {

    public static var remoteTexturesUsed:Boolean = false;

    private var isUsingLocalTextures:Boolean;

    public function TextureDataConcrete(_arg_1:XML) {
        var _local_2:XML;
        super();
        this.isUsingLocalTextures = this.getWhetherToUseLocalTextures();
        if (_arg_1.hasOwnProperty("Texture")) {
            this.parse(XML(_arg_1.Texture));
        }
        else {
            if (_arg_1.hasOwnProperty("AnimatedTexture")) {
                this.parse(XML(_arg_1.AnimatedTexture));
            }
            else {
                if (_arg_1.hasOwnProperty("RemoteTexture")) {
                    this.parse(XML(_arg_1.RemoteTexture));
                }
                else {
                    if (_arg_1.hasOwnProperty("RandomTexture")) {
                        this.parse(XML(_arg_1.RandomTexture));
                    }
                    else {
                        this.parse(_arg_1);
                    }
                }
            }
        }
        for each (_local_2 in _arg_1.AltTexture) {
            this.parse(_local_2);
        }
        if (_arg_1.hasOwnProperty("Mask")) {
            this.parse(XML(_arg_1.Mask));
        }
        if (_arg_1.hasOwnProperty("Effect")) {
            this.parse(XML(_arg_1.Effect));
        }
    }

    override public function getTexture(_arg_1:int = 0):BitmapData {
        if (randomTextureData_ == null) {
            return (texture_);
        }
        var _local_2:TextureData = randomTextureData_[(_arg_1 % randomTextureData_.length)];
        return (_local_2.getTexture(_arg_1));
    }

    override public function getAltTextureData(_arg_1:int):TextureData {
        if (altTextures_ == null) {
            return (null);
        }
        return (altTextures_[_arg_1]);
    }

    private function getWhetherToUseLocalTextures():Boolean {
        var _local_1:ApplicationSetup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
        return (_local_1.useLocalTextures());
    }

    private function parse(_arg_1:XML):void {
        var _local_2:MaskedImage;
        var _local_3:RemoteTexture;
        var _local_4:XML;
        switch (_arg_1.name().toString()) {
            case "Texture":
                texture_ = AssetLibrary.getImageFromSet(String(_arg_1.File), int(_arg_1.Index));
                return;
            case "Mask":
                mask_ = AssetLibrary.getImageFromSet(String(_arg_1.File), int(_arg_1.Index));
                return;
            case "Effect":
                effectProps_ = new EffectProperties(_arg_1);
                return;
            case "AnimatedTexture":
                animatedChar_ = AnimatedChars.getAnimatedChar(String(_arg_1.File), int(_arg_1.Index));
                _local_2 = animatedChar_.imageFromAngle(0, AnimatedChar.STAND, 0);
                texture_ = _local_2.image_;
                mask_ = _local_2.mask_;
                return;
            case "RemoteTexture":
                texture_ = AssetLibrary.getImageFromSet("lofiObj3", 0xFF);
                if (this.isUsingLocalTextures) {
                    _local_3 = new RemoteTexture(_arg_1.Id, _arg_1.Instance, this.onRemoteTexture);
                    _local_3.run();
                    if (!AssetLoader.currentXmlIsTesting) {
                        remoteTexturesUsed = true;
                    }
                }
                remoteTextureDir_ = ((_arg_1.hasOwnProperty("Right")) ? AnimatedChar.RIGHT : AnimatedChar.DOWN);
                return;
            case "RandomTexture":
                randomTextureData_ = new Vector.<TextureData>();
                for each (_local_4 in _arg_1.children()) {
                    randomTextureData_.push(new TextureDataConcrete(_local_4));
                }
                return;
            case "AltTexture":
                if (altTextures_ == null) {
                    altTextures_ = new Dictionary();
                }
                altTextures_[int(_arg_1.@id)] = new TextureDataConcrete(_arg_1);
                return;
        }
    }

    private function onRemoteTexture(_arg_1:BitmapData):void {
        if (_arg_1.width > 16) {
            AnimatedChars.add("remoteTexture", _arg_1, null, (_arg_1.width / 7), _arg_1.height, _arg_1.width, _arg_1.height, remoteTextureDir_);
            animatedChar_ = AnimatedChars.getAnimatedChar("remoteTexture", 0);
            texture_ = animatedChar_.imageFromAngle(0, AnimatedChar.STAND, 0).image_;
        }
        else {
            texture_ = _arg_1;
        }
    }


}
}//package com.company.assembleegameclient.objects
