package kabam.rotmg.minimap.control {
import kabam.rotmg.minimap.model.UpdateLootBagVO;

import org.osflash.signals.Signal;

public class UpdateLootBagSignal extends Signal {

    public function UpdateLootBagSignal() {
        super(UpdateLootBagVO);
    }

}
}//package kabam.rotmg.minimap.control
