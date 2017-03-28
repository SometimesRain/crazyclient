package kabam.lib.console.view {
import flash.system.System;

import kabam.lib.console.model.Watch;
import kabam.lib.console.signals.ClearConsoleSignal;
import kabam.lib.console.signals.ConsoleLogSignal;
import kabam.lib.console.signals.ConsoleUnwatchSignal;
import kabam.lib.console.signals.ConsoleWatchSignal;
import kabam.lib.console.signals.CopyConsoleTextSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public final class ConsoleOutputMediator extends Mediator {

    [Inject]
    public var log:ConsoleLogSignal;
    [Inject]
    public var watch:ConsoleWatchSignal;
    [Inject]
    public var unwatch:ConsoleUnwatchSignal;
    [Inject]
    public var clear:ClearConsoleSignal;
    [Inject]
    public var copy:CopyConsoleTextSignal;
    [Inject]
    public var view:ConsoleOutputView;


    override public function initialize():void {
        this.log.add(this.onLog);
        this.watch.add(this.onWatch);
        this.unwatch.add(this.onUnwatch);
        this.clear.add(this.onClear);
        this.copy.add(this.onCopy);
    }

    override public function destroy():void {
        this.log.remove(this.onLog);
        this.watch.remove(this.onWatch);
        this.unwatch.remove(this.onUnwatch);
        this.clear.remove(this.onClear);
        this.copy.remove(this.onCopy);
    }

    private function onLog(_arg_1:String):void {
        this.view.log(_arg_1);
    }

    private function onWatch(_arg_1:Watch):void {
        this.view.watch(_arg_1);
    }

    private function onUnwatch(_arg_1:String):void {
        this.view.unwatch(_arg_1);
    }

    private function onClear():void {
        this.view.clear();
    }

    private function onCopy():void {
        System.setClipboard(this.view.getText());
    }


}
}//package kabam.lib.console.view
