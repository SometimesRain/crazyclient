package com.company.assembleegameclient.ui.dialogs {
import flash.events.IEventDispatcher;

import org.osflash.signals.Signal;

public interface DialogCloser extends IEventDispatcher {

    function getCloseSignal():Signal;

}
}//package com.company.assembleegameclient.ui.dialogs
