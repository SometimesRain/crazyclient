package kabam.rotmg.questrewards.controller {
import kabam.rotmg.messaging.impl.incoming.QuestFetchResponse;

import org.osflash.signals.Signal;

public class QuestFetchCompleteSignal extends Signal {

    public function QuestFetchCompleteSignal() {
        super(QuestFetchResponse);
    }

}
}//package kabam.rotmg.questrewards.controller
