package kabam.lib.console.view {
import kabam.lib.console.signals.HideConsoleSignal;
import kabam.lib.console.signals.RemoveConsoleSignal;
import kabam.lib.console.signals.ShowConsoleSignal;
import kabam.lib.console.signals.ToggleConsoleSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ConsoleMediator extends Mediator {

    [Inject]
    public var view:ConsoleView;
    [Inject]
    public var toggle:ToggleConsoleSignal;
    [Inject]
    public var show:ShowConsoleSignal;
    [Inject]
    public var hide:HideConsoleSignal;
    [Inject]
    public var remove:RemoveConsoleSignal;


    override public function initialize():void {
        this.remove.add(this.onRemoveConsole);
        this.toggle.add(this.onToggleConsole);
        this.show.add(this.onShowConsole);
        this.hide.add(this.onHideConsole);
        this.view.visible = false;
    }

    override public function destroy():void {
        this.remove.remove(this.onRemoveConsole);
        this.toggle.remove(this.onToggleConsole);
        this.show.remove(this.onShowConsole);
        this.hide.remove(this.onHideConsole);
    }

    private function onRemoveConsole():void {
        this.view.parent.removeChild(this.view);
    }

    private function onToggleConsole():void {
        this.view.visible = !(this.view.visible);
    }

    private function onShowConsole():void {
        this.view.visible = true;
    }

    private function onHideConsole():void {
        this.view.visible = false;
    }


}
}//package kabam.lib.console.view
