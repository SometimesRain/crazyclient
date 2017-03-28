package kabam.rotmg.pets.view.components {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class DialogCloseButton extends Sprite {

    public static var CloseButtonAsset:Class = DialogCloseButton_CloseButtonAsset;
    public static var CloseButtonLargeAsset:Class = DialogCloseButton_CloseButtonLargeAsset;

    public const clicked:Signal = new Signal();

    public var disabled:Boolean = false;

    public function DialogCloseButton(_arg_1:Number = -1) {
        var _local_2:DisplayObject;
        super();
        if (_arg_1 < 0) {
            addChild(new CloseButtonAsset());
        }
        else {
            _local_2 = new CloseButtonLargeAsset();
            addChild(new CloseButtonLargeAsset());
            scaleX = (scaleX * _arg_1);
            scaleY = (scaleY * _arg_1);
        }
        buttonMode = true;
        addEventListener(MouseEvent.CLICK, this.onClicked);
    }

    public function setDisabled(_arg_1:Boolean):void {
        this.disabled = _arg_1;
        if (_arg_1) {
            removeEventListener(MouseEvent.CLICK, this.onClicked);
        }
        else {
            addEventListener(MouseEvent.CLICK, this.onClicked);
        }
    }

    public function disableLegacyCloseBehavior():void {
        this.disabled = true;
        removeEventListener(MouseEvent.CLICK, this.onClicked);
    }

    private function onClicked(_arg_1:MouseEvent):void {
        if (!this.disabled) {
            this.clicked.dispatch();
            removeEventListener(MouseEvent.CLICK, this.onClicked);
        }
    }


}
}//package kabam.rotmg.pets.view.components
