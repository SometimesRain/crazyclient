package kabam.rotmg.pets.view.dialogs {
import flash.events.IEventDispatcher;

public interface Disableable extends IEventDispatcher {

    function disable():void;

    function isEnabled():Boolean;

}
}//package kabam.rotmg.pets.view.dialogs
