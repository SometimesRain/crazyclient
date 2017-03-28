package com.company.assembleegameclient.ui.options {
import flash.display.Sprite;

import org.osflash.signals.Signal;

public class Option extends Sprite {

    public var textChanged:Signal;

    public function Option() {
        this.textChanged = new Signal();
        super();
    }

}
}//package com.company.assembleegameclient.ui.options
