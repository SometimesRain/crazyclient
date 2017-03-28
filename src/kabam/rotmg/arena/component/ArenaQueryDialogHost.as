package kabam.rotmg.arena.component {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import kabam.rotmg.arena.view.HostQueryDialog;

public class ArenaQueryDialogHost extends Sprite {

    private const speechBubble:HostQuerySpeechBubble = makeSpeechBubble();
    private const detailBubble:HostQueryDetailBubble = makeDetailBubble();
    private const icon:Bitmap = makeHostIcon();


    private function makeSpeechBubble():HostQuerySpeechBubble {
        var _local_1:HostQuerySpeechBubble;
        _local_1 = new HostQuerySpeechBubble(HostQueryDialog.QUERY);
        _local_1.x = 60;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeDetailBubble():HostQueryDetailBubble {
        var _local_1:HostQueryDetailBubble;
        _local_1 = new HostQueryDetailBubble();
        _local_1.y = 60;
        return (_local_1);
    }

    private function makeHostIcon():Bitmap {
        var _local_1:Bitmap = new Bitmap(this.makeDebugBitmapData());
        _local_1.x = 0;
        _local_1.y = 0;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeDebugBitmapData():BitmapData {
        return (new BitmapData(42, 42, true, 0xFF00FF00));
    }

    public function showDetail(_arg_1:String):void {
        this.detailBubble.setText(_arg_1);
        removeChild(this.speechBubble);
        addChild(this.detailBubble);
    }

    public function showSpeech():void {
        removeChild(this.detailBubble);
        addChild(this.speechBubble);
    }

    public function setHostIcon(_arg_1:BitmapData):void {
        this.icon.bitmapData = _arg_1;
    }


}
}//package kabam.rotmg.arena.component
