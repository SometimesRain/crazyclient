package kabam.lib.console {
import kabam.lib.console.controller.AddDefaultConsoleActionsCommand;
import kabam.lib.console.controller.ListActionsCommand;
import kabam.lib.console.controller.RegisterConsoleActionCommand;
import kabam.lib.console.model.Console;
import kabam.lib.console.services.ConsoleLogTarget;
import kabam.lib.console.signals.AddDefaultConsoleActionsSignal;
import kabam.lib.console.signals.ClearConsoleSignal;
import kabam.lib.console.signals.ConsoleLogSignal;
import kabam.lib.console.signals.ConsoleUnwatchSignal;
import kabam.lib.console.signals.ConsoleWatchSignal;
import kabam.lib.console.signals.CopyConsoleTextSignal;
import kabam.lib.console.signals.HideConsoleSignal;
import kabam.lib.console.signals.ListActionsSignal;
import kabam.lib.console.signals.RegisterConsoleActionSignal;
import kabam.lib.console.signals.RemoveConsoleSignal;
import kabam.lib.console.signals.ShowConsoleSignal;
import kabam.lib.console.signals.ToggleConsoleSignal;
import kabam.lib.console.view.ConsoleInputMediator;
import kabam.lib.console.view.ConsoleInputView;
import kabam.lib.console.view.ConsoleKeyMediator;
import kabam.lib.console.view.ConsoleMediator;
import kabam.lib.console.view.ConsoleOutputMediator;
import kabam.lib.console.view.ConsoleOutputView;
import kabam.lib.console.view.ConsoleView;
import kabam.rotmg.core.view.Layers;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IContext;

public class ConsoleConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;


    [PostConstruct]
    public function setup():void {
        this.mapModel();
        this.mapCommands();
        this.mapViewSignals();
        this.mapMediators();
        this.context.lifecycle.afterInitializing(this.init);
    }

    private function mapModel():void {
        this.injector.map(Console).asSingleton();
        this.injector.map(ConsoleLogSignal).asSingleton();
        this.injector.map(ConsoleWatchSignal).asSingleton();
        this.injector.map(ConsoleUnwatchSignal).asSingleton();
        this.injector.map(RemoveConsoleSignal).asSingleton();
    }

    private function mapCommands():void {
        this.commandMap.map(RegisterConsoleActionSignal).toCommand(RegisterConsoleActionCommand);
        this.commandMap.map(ListActionsSignal).toCommand(ListActionsCommand);
        this.commandMap.map(AddDefaultConsoleActionsSignal).toCommand(AddDefaultConsoleActionsCommand);
    }

    private function mapViewSignals():void {
        this.injector.map(ClearConsoleSignal).asSingleton();
        this.injector.map(CopyConsoleTextSignal).asSingleton();
        this.injector.map(ToggleConsoleSignal).asSingleton();
        this.injector.map(ShowConsoleSignal).asSingleton();
        this.injector.map(HideConsoleSignal).asSingleton();
    }

    private function mapMediators():void {
        this.mediatorMap.map(ConsoleInputView).toMediator(ConsoleInputMediator);
        this.mediatorMap.map(ConsoleOutputView).toMediator(ConsoleOutputMediator);
        this.mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
        this.mediatorMap.map(ConsoleView).toMediator(ConsoleKeyMediator);
    }

    private function init():void {
        this.context.addLogTarget(new ConsoleLogTarget(this.context));
        this.injector.getInstance(AddDefaultConsoleActionsSignal).dispatch();
        var _local_1:Layers = this.context.injector.getInstance(Layers);
        _local_1.console.addChild(new ConsoleView());
    }


}
}//package kabam.lib.console
