package kabam.rotmg.questrewards.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.DeprecatedTextButtonStatic;
import com.company.assembleegameclient.ui.panels.Panel;

import flash.display.Bitmap;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.messaging.impl.incoming.QuestFetchResponse;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.questrewards.controller.QuestFetchCompleteSignal;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.ui.model.HUDModel;

public class QuestRewardsPanel extends Panel {

    private static var questDataExists:Boolean = false;

    private const titleText:TextFieldDisplayConcrete = PetsViewAssetFactory.returnTextfield(0xFFFFFF, 18, true);

    private var icon:Bitmap;
    private var title:String = "The Tinkerer";
    private var feedPetText:String = "See Offers";
    private var checkBackLaterText:String = "Check Back Later";
    private var objectType:int;
    public var feedButton:DeprecatedTextButtonStatic;

    public function QuestRewardsPanel(_arg_1:GameSprite) {
        super(_arg_1);
        this.icon = PetsViewAssetFactory.returnBitmap(5972);
        this.icon.x = -4;
        this.icon.y = -8;
        addChild(this.icon);
        this.objectType = 5972;
        this.titleText.setStringBuilder(new StaticStringBuilder(this.title));
		this.titleText.x = 58;
        this.titleText.y = 28;
        addChild(this.titleText);
        if (hasQuests()) {
            this.addSeeOffersButton();
        }
        else {
            this.addCheckBackLaterButton();
        }
    }

    public static function checkQuests():void {
        var _local_1:HUDModel = StaticInjectorContext.getInjector().getInstance(HUDModel);
        var _local_2:QuestFetchCompleteSignal = StaticInjectorContext.getInjector().getInstance(QuestFetchCompleteSignal);
        if (((((!((_local_1 == null))) && (!((_local_1.gameSprite == null))))) && (!((_local_1.gameSprite.gsc_ == null))))) {
            _local_2.add(onCheckQuestsComplete);
            _local_1.gameSprite.gsc_.questFetch();
        }
    }

    public static function onCheckQuestsComplete(_arg_1:QuestFetchResponse):void {
        var _local_2:int = _arg_1.tier;
        if (_local_2 > 0) {
            questDataExists = true;
        }
        else {
            questDataExists = false;
        }
    }

    public static function hasQuests():Boolean {
        if (((questDataExists) || (((!((QuestRewardsMediator.questsCompletedDayUTC == -1))) && ((QuestRewardsMediator.questsCompletedDayUTC == new Date().dayUTC)))))) {
            return (true);
        }
        return (false);
    }


    public function addSeeOffersButton():void {
        this.feedButton = new DeprecatedTextButtonStatic(16, this.feedPetText);
        this.feedButton.textChanged.addOnce(this.alignButton);
        addChild(this.feedButton);
    }

    public function addCheckBackLaterButton():void {
        this.feedButton = new DeprecatedTextButtonStatic(16, this.checkBackLaterText);
        this.feedButton.textChanged.addOnce(this.alignButton);
        addChild(this.feedButton);
    }

    public function init():void {
    }

    private function alignButton():void {
        this.feedButton.x = ((WIDTH / 2) - (this.feedButton.width / 2));
        this.feedButton.y = ((HEIGHT - this.feedButton.height) - 4);
    }


}
}//package kabam.rotmg.questrewards.view
