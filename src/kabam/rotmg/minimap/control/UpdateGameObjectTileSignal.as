package kabam.rotmg.minimap.control {
import kabam.rotmg.ui.model.UpdateGameObjectTileVO;

import org.osflash.signals.Signal;

public class UpdateGameObjectTileSignal extends Signal {

    public function UpdateGameObjectTileSignal() {
        super(UpdateGameObjectTileVO);
    }

}
}//package kabam.rotmg.minimap.control
