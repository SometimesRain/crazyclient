package kabam.rotmg.pets.view.components {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import kabam.rotmg.pets.view.dialogs.CaretakerQueryDialog;

public class CaretakerQueryDialogCaretaker extends Sprite {

    private const speechBubble:CaretakerQuerySpeechBubble = makeSpeechBubble();
    private const detailBubble:CaretakerQueryDetailBubble = makeDetailBubble();
    private const icon:Bitmap = makeCaretakerIcon();


    private function makeSpeechBubble():CaretakerQuerySpeechBubble {
        var _local_1:CaretakerQuerySpeechBubble;
        _local_1 = new CaretakerQuerySpeechBubble(CaretakerQueryDialog.QUERY);
        _local_1.x = 60;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeDetailBubble():CaretakerQueryDetailBubble {
        var _local_1:CaretakerQueryDetailBubble;
        _local_1 = new CaretakerQueryDetailBubble();
        _local_1.y = 60;
        return (_local_1);
    }

    private function makeCaretakerIcon():Bitmap {
        var _local_1:Bitmap = new Bitmap(this.makeDebugBitmapData());
        _local_1.x = -16;
        _local_1.y = -32;
        addChild(_local_1);
        return (_local_1);
    }

    private function makeDebugBitmapData():BitmapData {
        return (new BitmapDataSpy(42, 42, true, 0xFF00FF00));
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

    public function setCaretakerIcon(_arg_1:BitmapData):void {
        this.icon.bitmapData = _arg_1;
    }


}
}//package kabam.rotmg.pets.view.components
