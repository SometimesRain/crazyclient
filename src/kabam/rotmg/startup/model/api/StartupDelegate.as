package kabam.rotmg.startup.model.api {
import kabam.lib.tasks.Task;

public interface StartupDelegate {

    function getPriority():int;

    function make():Task;

}
}//package kabam.rotmg.startup.model.api
