package kabam.rotmg.pets.view {
import flash.display.Sprite;

import kabam.rotmg.pets.data.PetVO;
import kabam.rotmg.pets.util.PetsConstants;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PetsButtonBar;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

import org.osflash.signals.Signal;

public class AvailablePetsView extends Sprite {

    private const background:PopupWindowBackground = PetsViewAssetFactory.returnWindowBackground(PetsConstants.WINDOW_BACKGROUND_WIDTH, PetsConstants.WINDOW_BACKGROUND_HEIGHT);
    private const titleTextfield:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 18, true);
    private const buttonBar:PetsButtonBar = PetsViewAssetFactory.returnButtonBar();
    private const closeButton:DialogCloseButton = PetsViewAssetFactory.returnCloseButton(PetsConstants.WINDOW_BACKGROUND_WIDTH);

    public var petSelected:Signal;

    public function AvailablePetsView() {
        this.petSelected = new Signal(PetVO);
        super();
    }

    public function init():void {
        this.waitForTextChanged();
        this.addChildren();
        this.titleTextfield.setStringBuilder(new LineBuilder().setParams("Available Pets"));
        this.buttonBar.buttonOne.setText("SELECT PET");
        this.positionThis();
    }

    private function addChildren():void {
        addChild(this.background);
        addChild(this.titleTextfield);
        addChild(this.buttonBar);
        addChild(this.closeButton);
    }

    private function positionThis():void {
        this.x = ((stage.width - this.width) / 2);
        this.y = ((stage.height - this.height) / 2);
    }

    private function waitForTextChanged():void {
        var _local_1:SignalWaiter = new SignalWaiter();
        _local_1.push(this.titleTextfield.textChanged);
        _local_1.complete.addOnce(this.positionTextField);
    }

    private function positionTextField():void {
        this.titleTextfield.x = ((PetsConstants.WINDOW_BACKGROUND_WIDTH - this.titleTextfield.width) / 2);
    }


}
}//package kabam.rotmg.pets.view
