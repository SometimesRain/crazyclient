package com.company.assembleegameclient.sound {
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.StaticInjectorContext;

public class SoundEffectLibrary {

    private static var urlBase:String;
    private static const URL_PATTERN:String = "{URLBASE}/sfx/{NAME}.mp3";
    public static var nameMap_:Dictionary = new Dictionary();
    private static var activeSfxList_:Dictionary = new Dictionary(true);


    public static function load(_arg_1:String):Sound {
        return ((nameMap_[_arg_1] = ((nameMap_[_arg_1]) || (makeSound(_arg_1)))));
    }

    public static function makeSound(_arg_1:String):Sound {
        var _local_2:Sound = new Sound();
        _local_2.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        _local_2.load(makeSoundRequest(_arg_1));
        return (_local_2);
    }

    private static function getUrlBase():String {
        var setup:ApplicationSetup;
        var base:String = "";
        try {
            setup = StaticInjectorContext.getInjector().getInstance(ApplicationSetup);
            base = setup.getAppEngineUrl(true);
        }
        catch (error:Error) {
            base = "localhost";
        }
        return (base);
    }

    private static function makeSoundRequest(_arg_1:String):URLRequest {
        urlBase = ((urlBase) || (getUrlBase()));
        var _local_2:String = URL_PATTERN.replace("{URLBASE}", urlBase).replace("{NAME}", _arg_1);
        return (new URLRequest(_local_2));
    }

    public static function play(name:String, volumeMultiplier:Number = 1, isFX:Boolean = true):void {
        var actualVolume:Number;
        var trans:SoundTransform;
        var channel:SoundChannel;
        var sound:Sound = load(name);
        var volume:* = (Parameters.data_.SFXVolume * volumeMultiplier);
        try {
            actualVolume = ((((((Parameters.data_.playSFX) && (isFX))) || (((!(isFX)) && (Parameters.data_.playPewPew))))) ? volume : 0);
            trans = new SoundTransform(actualVolume);
            channel = sound.play(0, 0, trans);
            channel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete, false, 0, true);
            activeSfxList_[channel] = volume;
        }
        catch (error:Error) {
        }
    }

    private static function onSoundComplete(_arg_1:Event):void {
        var _local_2:SoundChannel = (_arg_1.target as SoundChannel);
        delete activeSfxList_[_local_2];
    }

    public static function updateVolume(_arg_1:Number):void {
        var _local_2:SoundChannel;
        var _local_3:SoundTransform;
        for each (_local_2 in activeSfxList_) {
            activeSfxList_[_local_2] = _arg_1;
            _local_3 = _local_2.soundTransform;
            _local_3.volume = ((Parameters.data_.playSFX) ? activeSfxList_[_local_2] : 0);
            _local_2.soundTransform = _local_3;
        }
    }

    public static function updateTransform():void {
        var _local_1:SoundChannel;
        var _local_2:SoundTransform;
        for each (_local_1 in activeSfxList_) {
            _local_2 = _local_1.soundTransform;
            _local_2.volume = ((Parameters.data_.playSFX) ? activeSfxList_[_local_1] : 0);
            _local_1.soundTransform = _local_2;
        }
    }

    public static function onIOError(_arg_1:IOErrorEvent):void {
    }


}
}//package com.company.assembleegameclient.sound
