package kabam.rotmg.game.model {
import com.company.assembleegameclient.objects.GameObject;

public class AddSpeechBalloonVO {

    public var go:GameObject;
    public var text:String;
    public var name:String;
    public var isTrade:Boolean;
    public var isGuild:Boolean;
    public var background:uint;
    public var backgroundAlpha:Number;
    public var outline:uint;
    public var outlineAlpha:uint;
    public var textColor:uint;
    public var lifetime:int;
    public var bold:Boolean;
    public var hideable:Boolean;

    public function AddSpeechBalloonVO(_arg_1:GameObject, _arg_2:String, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean, _arg_6:uint, _arg_7:Number, _arg_8:uint, _arg_9:Number, _arg_10:uint, _arg_11:int, _arg_12:Boolean, _arg_13:Boolean) {
        this.go = _arg_1;
        this.text = _arg_2;
        this.name = _arg_3;
        this.isTrade = _arg_4;
        this.isGuild = _arg_5;
        this.background = _arg_6;
        this.backgroundAlpha = _arg_7;
        this.outline = _arg_8;
        this.outlineAlpha = _arg_9;
        this.textColor = _arg_10;
        this.lifetime = _arg_11;
        this.bold = _arg_12;
        this.hideable = _arg_13;
    }

}
}//package kabam.rotmg.game.model
