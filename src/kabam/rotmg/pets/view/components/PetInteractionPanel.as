package kabam.rotmg.pets.view.components {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.DeprecatedTextButton;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.display.Bitmap;

import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetInteractionPanel extends Panel {

    private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 16, true);

    private var icon:Bitmap;
    private var title:String = "Pets.petInteractionPanelTitle";
    private var fuseButtonString:String = "Pets.petInteractionPanelFusePetButton";
    private var feedPetText:String = "Pets.petInteractionPanelFeedPetButton";
    private var objectType:int;
    public var feedButton:DeprecatedTextButton;
    public var fuseButton:DeprecatedTextButton;

    public function PetInteractionPanel(_arg_1:GameSprite, _arg_2:int) {
        super(_arg_1);
        this.objectType = _arg_2;
        this.titleText.setStringBuilder(new LineBuilder().setParams(this.title));
        this.titleText.x = 48;
        this.titleText.y = 28;
        addChild(this.titleText);
        this.fuseButton = new DeprecatedTextButton(16, this.fuseButtonString);
        this.fuseButton.textChanged.addOnce(this.alignButton);
        addChild(this.fuseButton);
        this.feedButton = new DeprecatedTextButton(16, this.feedPetText);
        this.feedButton.textChanged.addOnce(this.alignButton);
        addChild(this.feedButton);
    }

    public function init():void {
        this.icon = PetsViewAssetFactory.returnBitmap(this.objectType);
        this.icon.x = -4;
        this.icon.y = -8;
        addChild(this.icon);
    }

    private function alignButton():void {
        this.fuseButton.x = (((WIDTH / 4) * 3) - (this.fuseButton.width / 2));
        this.fuseButton.y = ((HEIGHT - this.fuseButton.height) - 4);
        this.feedButton.x = (((WIDTH / 4) * 1) - (this.feedButton.width / 2));
        this.feedButton.y = ((HEIGHT - this.feedButton.height) - 4);
    }


}
}//package kabam.rotmg.pets.view.components
