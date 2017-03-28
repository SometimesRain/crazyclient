package kabam.rotmg.pets.controller {
import com.company.assembleegameclient.editor.Command;

import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.pets.data.PetAbilityDisplayIDGetter;
import kabam.rotmg.pets.view.dialogs.NewAbility;

public class NewAbilityCommand extends Command {

    [Inject]
    public var openDialog:OpenDialogSignal;
    [Inject]
    public var displayIDGetter:PetAbilityDisplayIDGetter;
    [Inject]
    public var abilityID:int;


    override public function execute():void {
        var _local_1:NewAbility = new NewAbility(this.displayIDGetter.getID(this.abilityID));
        this.openDialog.dispatch(_local_1);
    }


}
}//package kabam.rotmg.pets.controller
