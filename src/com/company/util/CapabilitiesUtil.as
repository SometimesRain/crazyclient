package com.company.util {
import flash.system.Capabilities;

public class CapabilitiesUtil {


    public static function getHumanReadable():String {
        return ((((((((((((((((((((((((((getHumanReadableLine("avHardwareDisable") + getHumanReadableLine("hasAccessibility")) + getHumanReadableLine("hasAudio")) + getHumanReadableLine("hasAudioEncoder")) + getHumanReadableLine("hasEmbeddedVideo")) + getHumanReadableLine("hasIME")) + getHumanReadableLine("hasMP3")) + getHumanReadableLine("hasPrinting")) + getHumanReadableLine("hasScreenBroadcast")) + getHumanReadableLine("hasScreenPlayback")) + getHumanReadableLine("hasStreamingAudio")) + getHumanReadableLine("hasStreamingVideo")) + getHumanReadableLine("hasTLS")) + getHumanReadableLine("hasVideoEncoder")) + getHumanReadableLine("isDebugger")) + getHumanReadableLine("language")) + getHumanReadableLine("localFileReadDisable")) + getHumanReadableLine("manufacturer")) + getHumanReadableLine("os")) + getHumanReadableLine("pixelAspectRatio")) + getHumanReadableLine("playerType")) + getHumanReadableLine("screenColor")) + getHumanReadableLine("screenDPI")) + getHumanReadableLine("screenResolutionX")) + getHumanReadableLine("screenResolutionY")) + getHumanReadableLine("version")));
    }

    private static function getHumanReadableLine(_arg_1:String):String {
        return ((((_arg_1 + ": ") + Capabilities[_arg_1]) + "\n"));
    }


}
}//package com.company.util
