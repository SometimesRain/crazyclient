package kabam.rotmg.friends.controller {
import kabam.rotmg.friends.model.FriendRequestVO;

import org.osflash.signals.Signal;

public class FriendActionSignal extends Signal {

    public function FriendActionSignal() {
        super(FriendRequestVO);
    }

}
}//package kabam.rotmg.friends.controller
