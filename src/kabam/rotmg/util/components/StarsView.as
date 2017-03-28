package kabam.rotmg.util.components {
import com.company.rotmg.graphics.StarGraphic;

import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.ColorTransform;

public class StarsView extends Sprite {

    private static const TOTAL:int = 5;
    private static const MARGIN:int = 4;
    private static const CORNER:int = 15;
    private static const BACKGROUND_COLOR:uint = 0x252525;
    private static const EMPTY_STAR_COLOR:uint = 0x838383;
    private static const FILLED_STAR_COLOR:uint = 0xFFFFFF;

    private const stars:Vector.<StarGraphic> = makeStars();
    private const background:Sprite = makeBackground();


    private function makeStars():Vector.<StarGraphic> {
        var _local_1:Vector.<StarGraphic> = this.makeStarList();
        this.layoutStars(_local_1);
        return (_local_1);
    }

    private function makeStarList():Vector.<StarGraphic> {
        var _local_1:Vector.<StarGraphic> = new Vector.<StarGraphic>(TOTAL, true);
        var _local_2:int;
        while (_local_2 < TOTAL) {
            _local_1[_local_2] = new StarGraphic();
            addChild(_local_1[_local_2]);
            _local_2++;
        }
        return (_local_1);
    }

    private function layoutStars(_arg_1:Vector.<StarGraphic>):void {
        var _local_2:int;
        while (_local_2 < TOTAL) {
            _arg_1[_local_2].x = (MARGIN + (_arg_1[0].width * _local_2));
            _arg_1[_local_2].y = MARGIN;
            _local_2++;
        }
    }

    private function makeBackground():Sprite {
        var _local_1:Sprite = new Sprite();
        this.drawBackground(_local_1.graphics);
        addChildAt(_local_1, 0);
        return (_local_1);
    }

    private function drawBackground(_arg_1:Graphics):void {
        var _local_2:StarGraphic = this.stars[0];
        var _local_3:int = ((_local_2.width * TOTAL) + (2 * MARGIN));
        var _local_4:int = (_local_2.height + (2 * MARGIN));
        _arg_1.clear();
        _arg_1.beginFill(BACKGROUND_COLOR);
        _arg_1.drawRoundRect(0, 0, _local_3, _local_4, CORNER, CORNER);
        _arg_1.endFill();
    }

    public function setStars(_arg_1:int):void {
        var _local_2:int;
        while (_local_2 < TOTAL) {
            this.updateStar(_local_2, _arg_1);
            _local_2++;
        }
    }

    private function updateStar(_arg_1:int, _arg_2:int):void {
        var _local_3:StarGraphic = this.stars[_arg_1];
        var _local_4:ColorTransform = _local_3.transform.colorTransform;
        _local_4.color = (((_arg_1 < _arg_2)) ? FILLED_STAR_COLOR : EMPTY_STAR_COLOR);
        _local_3.transform.colorTransform = _local_4;
    }


}
}//package kabam.rotmg.util.components
