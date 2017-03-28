package com.company.assembleegameclient.game.events {
import org.osflash.signals.Signal;
import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;

public class KeyInfoResponseSignal extends Signal {

    public function KeyInfoResponseSignal() {
        super(KeyInfoResponse)
    }

}
}
