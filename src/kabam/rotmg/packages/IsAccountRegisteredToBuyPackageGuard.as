package kabam.rotmg.packages {
import kabam.rotmg.account.core.control.IsAccountRegisteredGuard;

public class IsAccountRegisteredToBuyPackageGuard extends IsAccountRegisteredGuard {


    override protected function getString():String {
        return ("Dialog.registerToBuyPackage");
    }


}
}//package kabam.rotmg.packages
