package kabam.rotmg.packages.control {
import kabam.rotmg.packages.model.PackageInfo;

import org.osflash.signals.Signal;

public class BuyPackageSignal extends Signal {

    public function BuyPackageSignal() {
        super(PackageInfo);
    }

}
}//package kabam.rotmg.packages.control
