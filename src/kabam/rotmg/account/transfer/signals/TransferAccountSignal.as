package kabam.rotmg.account.transfer.signals {
import kabam.rotmg.account.transfer.model.TransferAccountData;

import org.osflash.signals.Signal;

public class TransferAccountSignal extends Signal {

    public function TransferAccountSignal() {
        super(TransferAccountData);
    }

}
}//package kabam.rotmg.account.transfer.signals
