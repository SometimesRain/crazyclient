package kabam.rotmg.classes.view {
import com.company.assembleegameclient.screens.NewCharacterScreen;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.game.model.GameInitData;
import kabam.rotmg.game.signals.PlayGameSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CharacterSkinMediator extends Mediator {

    [Inject]
    public var view:CharacterSkinView;
    [Inject]
    public var model:PlayerModel;
    [Inject]
    public var setScreen:SetScreenSignal;
    [Inject]
    public var play:PlayGameSignal;


    override public function initialize():void {
        var _local_1:Boolean = this.model.hasAvailableCharSlot();
        this.view.setPlayButtonEnabled(_local_1);
        if (_local_1) {
            this.view.play.addOnce(this.onPlay);
        }
        this.view.back.addOnce(this.onBack);
    }

    override public function destroy():void {
        this.view.back.remove(this.onBack);
        this.view.play.remove(this.onPlay);
    }

    private function onBack():void {
        this.setScreen.dispatch(new NewCharacterScreen());
    }

    private function onPlay():void {
        var _local_1:GameInitData = new GameInitData();
        _local_1.createCharacter = true;
        _local_1.charId = this.model.getNextCharId();
        _local_1.keyTime = -1;
        _local_1.isNewGame = true;
        this.play.dispatch(_local_1);
    }


}
}//package kabam.rotmg.classes.view
