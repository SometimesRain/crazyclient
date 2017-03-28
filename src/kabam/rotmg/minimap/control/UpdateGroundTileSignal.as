package kabam.rotmg.minimap.control {
import kabam.rotmg.minimap.model.UpdateGroundTileVO;

import org.osflash.signals.Signal;

public class UpdateGroundTileSignal extends Signal {

    public function UpdateGroundTileSignal() {
        super(UpdateGroundTileVO);
    }

}
}//package kabam.rotmg.minimap.control
