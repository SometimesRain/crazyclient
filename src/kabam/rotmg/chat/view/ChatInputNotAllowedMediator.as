package kabam.rotmg.chat.view {
import flash.events.MouseEvent;

import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
import kabam.rotmg.chat.model.ChatModel;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.HUDModelInitialized;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ChatInputNotAllowedMediator extends Mediator {

    [Inject]
    public var view:ChatInputNotAllowed;
    [Inject]
    public var model:ChatModel;
    [Inject]
    public var openAccountManagement:OpenAccountInfoSignal;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var hudModelInitialized:HUDModelInitialized;


    override public function initialize():void {
        this.view.setup(this.model);
        this.hudModelInitialized.add(this.onHUDModelInitialized);
    }

    private function onHUDModelInitialized():void {
        if (((this.hudModel.gameSprite) && (this.hudModel.gameSprite.evalIsNotInCombatMapArea()))) {
            this.view.addEventListener(MouseEvent.CLICK, this.onClick);
        }
        else {
            this.view.mouseEnabled = false;
            this.view.mouseChildren = false;
        }
    }

    override public function destroy():void {
        this.view.removeEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(_arg_1:MouseEvent):void {
        this.openAccountManagement.dispatch();
    }


}
}//package kabam.rotmg.chat.view
