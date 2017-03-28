package kabam.rotmg.ui.controller {
import com.company.assembleegameclient.util.StageProxy;

import flash.events.MouseEvent;

import kabam.rotmg.ui.view.UnFocusAble;

import robotlegs.bender.bundles.mvcs.Mediator;

public class UnFocusAbleMediator extends Mediator {

    [Inject]
    public var unFocusAble:UnFocusAble;
    [Inject]
    public var stageProxy:StageProxy;


    override public function initialize():void {
        this.unFocusAble.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }

    private function onMouseUp(_arg_1:MouseEvent):void {
        this.stageProxy.setFocus(null);
    }

    override public function destroy():void {
        this.unFocusAble.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
    }


}
}//package kabam.rotmg.ui.controller
