package kabam.rotmg.account.transfer.signals {
import kabam.rotmg.account.transfer.model.TransferAccountData;

import org.osflash.signals.Signal;

public class CheckKabamAccountSignal extends Signal {

    public function CheckKabamAccountSignal() {
        super(TransferAccountData);
    }

}
}//package kabam.rotmg.account.transfer.signals
