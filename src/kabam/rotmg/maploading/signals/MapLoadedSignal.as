package kabam.rotmg.maploading.signals {
import kabam.rotmg.messaging.impl.incoming.MapInfo;

import org.osflash.signals.Signal;

public class MapLoadedSignal extends Signal {

    public function MapLoadedSignal() {
        super(MapInfo);
    }

}
}//package kabam.rotmg.maploading.signals
