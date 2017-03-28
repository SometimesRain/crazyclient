package com.company.assembleegameclient.util {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.rotmg.graphics.StarGraphic;
import com.company.util.AssetLibrary;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;

public class FameUtil {

    public static const STARS:Vector.<int> = new <int>[20, 150, 400, 800, 2000];
    private static const lightBlueCT:ColorTransform = new ColorTransform((138 / 0xFF), (152 / 0xFF), (222 / 0xFF));
    private static const darkBlueCT:ColorTransform = new ColorTransform((49 / 0xFF), (77 / 0xFF), (219 / 0xFF));
    private static const redCT:ColorTransform = new ColorTransform((193 / 0xFF), (39 / 0xFF), (45 / 0xFF));
    private static const orangeCT:ColorTransform = new ColorTransform((247 / 0xFF), (147 / 0xFF), (30 / 0xFF));
    private static const yellowCT:ColorTransform = new ColorTransform((0xFF / 0xFF), (0xFF / 0xFF), (0 / 0xFF));
    public static const COLORS:Vector.<ColorTransform> = new <ColorTransform>[lightBlueCT, darkBlueCT, redCT, orangeCT, yellowCT];


    public static function maxStars():int {
        return ((ObjectLibrary.playerChars_.length * STARS.length));
    }

    public static function numStars(_arg_1:int):int {
        var _local_2:int;
        while ((((_local_2 < STARS.length)) && ((_arg_1 >= STARS[_local_2])))) {
            _local_2++;
        }
        return (_local_2);
    }

    public static function nextStarFame(_arg_1:int, _arg_2:int):int {
        var _local_3:int = Math.max(_arg_1, _arg_2);
        var _local_4:int;
        while (_local_4 < STARS.length) {
            if (STARS[_local_4] > _local_3) {
                return (STARS[_local_4]);
            }
            _local_4++;
        }
        return (-1);
    }

    public static function numAllTimeStars(_arg_1:int, _arg_2:int, _arg_3:XML):int {
        var _local_6:XML;
        var _local_4:int;
        var _local_5:int;
        for each (_local_6 in _arg_3.ClassStats) {
            if (_arg_1 == int(_local_6.@objectType)) {
                _local_5 = int(_local_6.BestFame);
            }
            else {
                _local_4 = (_local_4 + FameUtil.numStars(_local_6.BestFame));
            }
        }
        _local_4 = (_local_4 + FameUtil.numStars(Math.max(_local_5, _arg_2)));
        return (_local_4);
    }

    public static function numStarsToBigImage(_arg_1:int):Sprite {
        var _local_2:Sprite = numStarsToImage(_arg_1);
        _local_2.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        _local_2.scaleX = 1.4;
        _local_2.scaleY = 1.4;
        return (_local_2);
    }

    public static function numStarsToImage(_arg_1:int):Sprite {
        var _local_2:Sprite = new StarGraphic();
        if (_arg_1 < ObjectLibrary.playerChars_.length) {
            _local_2.transform.colorTransform = lightBlueCT;
        }
        else {
            if (_arg_1 < (ObjectLibrary.playerChars_.length * 2)) {
                _local_2.transform.colorTransform = darkBlueCT;
            }
            else {
                if (_arg_1 < (ObjectLibrary.playerChars_.length * 3)) {
                    _local_2.transform.colorTransform = redCT;
                }
                else {
                    if (_arg_1 < (ObjectLibrary.playerChars_.length * 4)) {
                        _local_2.transform.colorTransform = orangeCT;
                    }
                    else {
                        if (_arg_1 < (ObjectLibrary.playerChars_.length * 5)) {
                            _local_2.transform.colorTransform = yellowCT;
                        }
                    }
                }
            }
        }
        return (_local_2);
    }

    public static function numStarsToIcon(_arg_1:int):Sprite {
        var _local_2:Sprite;
        var _local_3:Sprite;
        _local_2 = numStarsToImage(_arg_1);
        _local_3 = new Sprite();
        _local_3.graphics.beginFill(0, 0.4);
        var _local_4:int = ((_local_2.width / 2) + 2);
        var _local_5:int = ((_local_2.height / 2) + 2);
        _local_3.graphics.drawCircle(_local_4, _local_5, _local_4);
        _local_2.x = 2;
        _local_2.y = 1;
        _local_3.addChild(_local_2);
        _local_3.filters = [new DropShadowFilter(0, 0, 0, 0.5, 6, 6, 1)];
        return (_local_3);
    }

    public static function getFameIcon():BitmapData {
        var _local_1:BitmapData = AssetLibrary.getImageFromSet("lofiObj3", 224);
        return (TextureRedrawer.redraw(_local_1, 40, true, 0));
    }


}
}//package com.company.assembleegameclient.util
