package kabam.rotmg.death.view {
import com.company.assembleegameclient.ui.dialogs.Dialog;

import flash.display.Sprite;
import flash.events.Event;

import org.osflash.signals.Signal;

public class ZombifyDialog extends Sprite {

    public static const TITLE:String = "ZombifyDialog.title";
    public static const BODY:String = "ZombifyDialog.body";
    public static const BUTTON:String = "ZombifyDialog.button";

    public const closed:Signal = new Signal();

    private var dialog:Dialog;

    public function ZombifyDialog() {
        this.dialog = new Dialog(TITLE, BODY, BUTTON, null, null);
        this.dialog.offsetX = -100;
        this.dialog.offsetY = 200;
        this.dialog.addEventListener(Dialog.LEFT_BUTTON, this.onButtonClick);
        addChild(this.dialog);
    }

    private function onButtonClick(_arg_1:Event):void {
        this.closed.dispatch();
    }


}
}//package kabam.rotmg.death.view
