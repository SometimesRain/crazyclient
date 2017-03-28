package kabam.rotmg.characters.deletion.control {
import com.company.assembleegameclient.appengine.SavedCharacter;

import org.osflash.signals.Signal;

public class DeleteCharacterSignal extends Signal {

    public function DeleteCharacterSignal() {
        super(SavedCharacter);
    }

}
}//package kabam.rotmg.characters.deletion.control
