package kabam.lib.util {
import flash.display.DisplayObject;
import flash.events.Event;

import org.osflash.signals.Signal;

public class StageLifecycleUtil {

    private var target:DisplayObject;
    private var _addedToStage:Signal;
    private var _removedFromStage:Signal;

    public function StageLifecycleUtil(_arg_1:DisplayObject) {
        this.target = _arg_1;
        _arg_1.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
    }

    private function handleAddedToStage(_arg_1:Event):void {
        this.target.removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
        this.target.addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage);
        ((this._addedToStage) && (this._addedToStage.dispatch()));
    }

    private function handleRemovedFromStage(_arg_1:Event):void {
        this.target.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
        this.target.removeEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage);
        ((this._removedFromStage) && (this._removedFromStage.dispatch()));
    }

    public function get addedToStage():Signal {
        return ((this._addedToStage = ((this._addedToStage) || (new Signal()))));
    }

    public function get removedFromStage():Signal {
        return ((this._removedFromStage = ((this._removedFromStage) || (new Signal()))));
    }


}
}//package kabam.lib.util
