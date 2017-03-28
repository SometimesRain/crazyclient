package kabam.rotmg.characters.deletion.view {
import com.company.assembleegameclient.appengine.SavedCharacter;

import kabam.rotmg.characters.deletion.control.DeleteCharacterSignal;
import kabam.rotmg.characters.model.CharacterModel;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ConfirmDeleteCharacterMediator extends Mediator {

    [Inject]
    public var view:ConfirmDeleteCharacterDialog;
    [Inject]
    public var model:CharacterModel;
    [Inject]
    public var deleteCharacter:DeleteCharacterSignal;
    [Inject]
    public var closeDialogs:CloseDialogsSignal;
    private var character:SavedCharacter;


    override public function initialize():void {
        this.view.deleteCharacter.add(this.onDeleteCharacter);
        this.view.cancel.add(this.closeDialog);
        this.character = this.model.getSelected();
        this.view.setText(this.character.name(), this.character.displayId());
    }

    override public function destroy():void {
        this.view.deleteCharacter.remove(this.onDeleteCharacter);
        this.view.cancel.remove(this.closeDialog);
    }

    private function onDeleteCharacter():void {
        this.deleteCharacter.dispatch(this.character);
    }

    private function closeDialog():void {
        this.closeDialogs.dispatch();
    }


}
}//package kabam.rotmg.characters.deletion.view
