package kabam.rotmg.game.view {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.panels.ButtonPanel;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class MoneyChangerPanel extends ButtonPanel {

    public var triggered:Signal;

    public function MoneyChangerPanel(_arg_1:GameSprite) {
        super(_arg_1, TextKey.MONEY_CHANGER_TITLE, TextKey.MONEY_CHANGER_BUTTON);
        this.triggered = new Signal();
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onAddedToStage(_arg_1:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    override protected function onButtonClick(_arg_1:MouseEvent):void {
        this.triggered.dispatch();
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if ((((_arg_1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.triggered.dispatch();
        }
    }


}
}//package kabam.rotmg.game.view
