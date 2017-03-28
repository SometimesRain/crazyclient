package com.company.assembleegameclient.appengine {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;

public class SavedNewsItem {

    private static const FAME:String = "fame";

    private var iconName:String;
    public var title_:String;
    public var tagline_:String;
    public var link_:String;
    public var date_:int;

    public function SavedNewsItem(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int) {
        this.iconName = _arg_1;
        this.title_ = _arg_2;
        this.tagline_ = _arg_3;
        this.link_ = _arg_4;
        this.date_ = _arg_5;
    }

    private static function forumIcon():BitmapData {
        var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiInterface2", 4);
        return (TextureRedrawer.redraw(_local_1, 80, true, 0));
    }

    private static function fameIcon():BitmapData {
        var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 224);
        return (TextureRedrawer.redraw(_local_1, 80, true, 0));
    }


    public function getIcon():BitmapData {
        return ((((this.iconName == FAME)) ? fameIcon() : forumIcon()));
    }

    public function isCharDeath():Boolean {
        return ((this.iconName == FAME));
    }


}
}//package com.company.assembleegameclient.appengine
