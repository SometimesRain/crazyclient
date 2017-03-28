package kabam.rotmg.questrewards.controller {
import kabam.rotmg.messaging.impl.incoming.QuestRedeemResponse;

import org.osflash.signals.Signal;

public class QuestRedeemCompleteSignal extends Signal {

    public function QuestRedeemCompleteSignal() {
        super(QuestRedeemResponse);
    }

}
}//package kabam.rotmg.questrewards.controller
