package kabam.rotmg.pets.view.dialogs {
import com.company.assembleegameclient.ui.DeprecatedTextButton;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class EggHatchedDialog extends Sprite {

    private const background:PopupWindowBackground = PetsViewAssetFactory.returnEggHatchWindowBackground(289, 279);
    private const titleTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 18, true);
    private const typeTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(16777103, 16, true);
    private const eggHatchImage:DisplayObject = new EggHatchedDialog_EggHatchImage();
    private const sendToYardButton:DeprecatedTextButton = new DeprecatedTextButton(16, "Pets.sendToYard", 120);
    public const closed:Signal = new Signal();

    public var skinType:int;
    private var petBitmap:Bitmap;
    private var petName:String;

    public function EggHatchedDialog(_arg_1:String, _arg_2:int) {
        super();
        this.petName = _arg_1;
        this.skinType = _arg_2;
        this.sendToYardButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onSendToYard);
    }

    private function onSendToYard(_arg_1:MouseEvent):void {
        this.closed.dispatch();
    }

    public function init(_arg_1:Bitmap):void {
        this.petBitmap = _arg_1;
        this.setTextValues();
        this.waitForTextChanged();
        this.addChildren();
        this.positionAssets();
    }

    private function setTextValues():void {
        this.titleTextfield.setStringBuilder(new LineBuilder().setParams(TextKey.PET_EGG_HATCHED));
        this.typeTextfield.setStringBuilder(new LineBuilder().setParams(this.petName));
    }

    private function onClosed():void {
        this.closed.dispatch();
    }

    private function addChildren():void {
        this.eggHatchImage.y = 31;
        addChild(this.background);
        addChild(this.titleTextfield);
        addChild(this.typeTextfield);
        addChild(this.eggHatchImage);
        addChild(this.sendToYardButton);
        addChild(this.petBitmap);
    }

    private function positionAssets():void {
        this.positionThis();
        this.petBitmap.x = ((287 - this.petBitmap.width) * 0.5);
        this.eggHatchImage.x = 1;
        this.eggHatchImage.y = 32;
        this.petBitmap.x = (this.petBitmap.x - 5);
        this.petBitmap.y = 41;
    }

    private function positionThis():void {
        this.x = ((stage.stageWidth - this.width) * 0.5);
        this.y = ((stage.stageHeight - this.height) * 0.5);
    }

    private function waitForTextChanged():void {
        var _local_1:SignalWaiter = new SignalWaiter();
        _local_1.push(this.titleTextfield.textChanged);
        _local_1.push(this.typeTextfield.textChanged);
        _local_1.complete.addOnce(this.positionTextField);
        this.sendToYardButton.textChanged.add(this.positionButtonBar);
    }

    private function positionButtonBar():void {
        this.sendToYardButton.x = ((287 - this.sendToYardButton.width) * 0.5);
        this.sendToYardButton.y = 240;
    }

    private function positionTextField():void {
        this.titleTextfield.x = ((287 - this.titleTextfield.width) * 0.5);
        this.titleTextfield.y = 23;
        this.typeTextfield.x = ((287 - this.typeTextfield.width) * 0.5);
        this.typeTextfield.y = 230;
    }


}
}//package kabam.rotmg.pets.view.dialogs
