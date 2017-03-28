package kabam.rotmg.chat.view {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class ChatInputNotAllowed extends Sprite {

    public static const IMAGE_NAME:String = "lofiInterfaceBig";
    public static const IMADE_ID:int = 21;

    public function ChatInputNotAllowed() {
        this.makeTextField();
        this.makeSpeechBubble();
    }

    public function setup(_arg_1:ChatModel):void {
        x = 0;
        y = (_arg_1.bounds.height - _arg_1.lineHeight);
    }

    private function makeTextField():TextFieldDisplayConcrete {
        var _local_2:TextFieldDisplayConcrete;
        var _local_1:LineBuilder = new LineBuilder().setParams(TextKey.CHAT_REGISTER_TO_CHAT);
        _local_2 = new TextFieldDisplayConcrete();
        _local_2.setStringBuilder(_local_1);
        _local_2.x = 29;
        addChild(_local_2);
        return (_local_2);
    }

    private function makeSpeechBubble():Bitmap {
        var _local_2:Bitmap;
        var _local_1:BitmapData = AssetLibrary.getImageFromSet(IMAGE_NAME, IMADE_ID);
        _local_1 = TextureRedrawer.redraw(_local_1, 20, true, 0, false);
        _local_2 = new Bitmap(_local_1);
        _local_2.x = -5;
        _local_2.y = -10;
        addChild(_local_2);
        return (_local_2);
    }


}
}//package kabam.rotmg.chat.view
