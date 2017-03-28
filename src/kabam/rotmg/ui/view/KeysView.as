package kabam.rotmg.ui.view {
import flash.display.Sprite;

import kabam.rotmg.ui.model.Key;

import mx.core.BitmapAsset;

public class KeysView extends Sprite {

    private static var keyBackgroundPng:Class = KeysView_keyBackgroundPng;
    private static var greenKeyPng:Class = KeysView_greenKeyPng;
    private static var redKeyPng:Class = KeysView_redKeyPng;
    private static var yellowKeyPng:Class = KeysView_yellowKeyPng;
    private static var purpleKeyPng:Class = KeysView_purpleKeyPng;

    private var base:BitmapAsset;
    private var keys:Vector.<BitmapAsset>;

    public function KeysView() {
        this.base = new keyBackgroundPng();
        addChild(this.base);
        this.keys = new Vector.<BitmapAsset>(4, true);
        this.keys[0] = new purpleKeyPng();
        this.keys[1] = new greenKeyPng();
        this.keys[2] = new redKeyPng();
        this.keys[3] = new yellowKeyPng();
        var _local_1:int;
        while (_local_1 < 4) {
            this.keys[_local_1].x = (12 + (40 * _local_1));
            this.keys[_local_1].y = 12;
            _local_1++;
        }
    }

    public function showKey(_arg_1:Key):void {
        var _local_2:BitmapAsset = this.keys[_arg_1.position];
        if (!contains(_local_2)) {
            addChild(_local_2);
        }
    }

    public function hideKey(_arg_1:Key):void {
        var _local_2:BitmapAsset = this.keys[_arg_1.position];
        if (contains(_local_2)) {
            removeChild(_local_2);
        }
    }


}
}//package kabam.rotmg.ui.view
