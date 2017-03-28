package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.map.mapoverlay.CharacterStatusText;
import com.company.assembleegameclient.objects.GameObject;

import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class QueuedStatusText extends CharacterStatusText {

    public var list:QueuedStatusTextList;
    public var next:QueuedStatusText;
    public var stringBuilder:StringBuilder;

    public function QueuedStatusText(_arg_1:GameObject, _arg_2:StringBuilder, _arg_3:uint, _arg_4:int, _arg_5:int = 0) {
        this.stringBuilder = _arg_2;
        super(_arg_1, _arg_3, _arg_4, _arg_5);
        setStringBuilder(_arg_2);
    }

    /*override public function dispose():void {
        this.list.shift();
    }*/


}
}//package kabam.rotmg.game.view.components
