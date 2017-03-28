package com.company.assembleegameclient.screens {
import com.company.ui.BaseSimpleText;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.net.URLRequest;
import flash.net.navigateToURL;

import org.osflash.signals.Signal;

public class GraveyardLine extends Sprite {

    public static const WIDTH:int = 415;
    public static const HEIGHT:int = 52;
    public static const COLOR:uint = 0xB3B3B3;
    public static const OVER_COLOR:uint = 0xFFC800;

    public var viewCharacterFame:Signal;
    public var icon_:Bitmap;
    public var titleText_:BaseSimpleText;
    public var taglineText_:BaseSimpleText;
    public var dtText_:BaseSimpleText;
    public var link:String;
    public var accountId:String;

    public function GraveyardLine(_arg_1:BitmapData, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:String) {
        this.viewCharacterFame = new Signal(int);
        super();
        this.link = _arg_4;
        this.accountId = _arg_6;
        buttonMode = true;
        useHandCursor = true;
        tabEnabled = false;
        this.icon_ = new Bitmap();
        this.icon_.bitmapData = _arg_1;
        this.icon_.x = 12;
        this.icon_.y = (((HEIGHT / 2) - (_arg_1.height / 2)) - 3);
        addChild(this.icon_);
        this.titleText_ = new BaseSimpleText(18, COLOR, false, 0, 0);
        this.titleText_.text = _arg_2;
        this.titleText_.updateMetrics();
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.titleText_.x = 73;
        addChild(this.titleText_);
        this.taglineText_ = new BaseSimpleText(14, COLOR, false, 0, 0);
        this.taglineText_.text = _arg_3;
        this.taglineText_.updateMetrics();
        this.taglineText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.taglineText_.x = 73;
        this.taglineText_.y = 24;
        addChild(this.taglineText_);
        this.dtText_ = new BaseSimpleText(16, COLOR, false, 0, 0);
        this.dtText_.text = this.getTimeDiff(_arg_5);
        this.dtText_.updateMetrics();
        this.dtText_.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        this.dtText_.x = (WIDTH - this.dtText_.width);
        addChild(this.dtText_);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
    }

    protected function onMouseOver(_arg_1:MouseEvent):void {
        this.titleText_.setColor(OVER_COLOR);
        this.taglineText_.setColor(OVER_COLOR);
        this.dtText_.setColor(OVER_COLOR);
    }

    protected function onRollOut(_arg_1:MouseEvent):void {
        this.titleText_.setColor(COLOR);
        this.taglineText_.setColor(COLOR);
        this.dtText_.setColor(COLOR);
    }

    protected function onMouseDown(_arg_1:MouseEvent):void {
        var _local_2:Array = this.link.split(":", 2);
        switch (_local_2[0]) {
            case "fame":
                this.viewCharacterFame.dispatch(int(_local_2[1]));
                return;
            case "http":
            case "https":
            default:
                navigateToURL(new URLRequest(this.link), "_blank");
        }
    }

    private function getTimeDiff(_arg_1:int):String {
        var _local_2:Number = (new Date().getTime() / 1000);
        var _local_3:int = (_local_2 - _arg_1);
        if (_local_3 <= 0) {
            return ("now");
        }
        if (_local_3 < 60) {
            return ((_local_3 + " secs"));
        }
        if (_local_3 < (60 * 60)) {
            return ((int((_local_3 / 60)) + " mins"));
        }
        if (_local_3 < ((60 * 60) * 24)) {
            return ((int((_local_3 / (60 * 60))) + " hours"));
        }
        return ((int((_local_3 / ((60 * 60) * 24))) + " days"));
    }


}
}//package com.company.assembleegameclient.screens
