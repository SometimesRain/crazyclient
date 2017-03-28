package com.company.assembleegameclient.map.mapoverlay {
import com.company.assembleegameclient.map.Camera;

import flash.display.Sprite;

import kabam.rotmg.game.view.components.QueuedStatusText;
import kabam.rotmg.game.view.components.QueuedStatusTextList;

public class MapOverlay extends Sprite {

    private const speechBalloons:Object = {};
    private const queuedText:Object = {};

    public function MapOverlay() {
        mouseEnabled = true;
        mouseChildren = true;
    }

    public function addSpeechBalloon(_arg_1:SpeechBalloon):void {
        var _local_2:int = _arg_1.go_.objectId_;
        var _local_3:SpeechBalloon = this.speechBalloons[_local_2];
        if (((_local_3) && (contains(_local_3)))) {
            removeChild(_local_3);
        }
        this.speechBalloons[_local_2] = _arg_1;
        addChild(_arg_1);
    }

    public function addStatusText(_arg_1:CharacterStatusText):void {
        addChild(_arg_1);
    }

    public function addQueuedText(_arg_1:QueuedStatusText):void {
        addStatusText(_arg_1 as CharacterStatusText);
        //var _local_2:int = _arg_1.go_.objectId_;
        //var _local_3:QueuedStatusTextList = (this.queuedText[_local_2] = this.makeQueuedStatusTextList()); //simplify?
        //var _local_3:QueuedStatusTextList = (this.queuedText[_local_2] = ((this.queuedText[_local_2]) || (this.makeQueuedStatusTextList()))); //original
        //_local_3.append(_arg_1);
    }

    private function makeQueuedStatusTextList():QueuedStatusTextList {
        var _local_1:QueuedStatusTextList = new QueuedStatusTextList();
        _local_1.target = this;
        return (_local_1);
    }

    public function draw(_arg_1:Camera, _arg_2:int):void {
        var _local_4:IMapOverlayElement;
        var _local_3:int;
        while (_local_3 < numChildren) {
            _local_4 = (getChildAt(_local_3) as IMapOverlayElement);
            if (((!(_local_4)) || (_local_4.draw(_arg_1, _arg_2)))) {
                _local_3++;
            }
            else {
                _local_4.dispose();
            }
        }
    }


}
}//package com.company.assembleegameclient.map.mapoverlay
