//Created by Action Script Viewer - http://www.buraks.com/asv
package kabam.rotmg.core {
import flash.display.DisplayObjectContainer;

import kabam.lib.json.JsonParser;
import kabam.lib.json.SoftwareJsonParser;
import kabam.lib.tasks.TaskMonitor;
import kabam.rotmg.account.core.signals.CharListDataSignal;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.core.commands.ConfigurePaymentsWindowCommand;
import kabam.rotmg.core.commands.InvalidateDataCommand;
import kabam.rotmg.core.commands.PurchaseCharacterCommand;
import kabam.rotmg.core.commands.SetScreenWithValidDataCommand;
import kabam.rotmg.core.commands.SetupDomainSecurityCommand;
import kabam.rotmg.core.commands.UpdatePetsModelCommand;
import kabam.rotmg.core.commands.UpdatePlayerModelCommand;
import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.model.ScreenModel;
import kabam.rotmg.core.service.PurchaseCharacterClassTask;
import kabam.rotmg.core.service.PurchaseCharacterErrorTask;
import kabam.rotmg.core.service.RequestAppInitTask;
import kabam.rotmg.core.signals.AppInitDataReceivedSignal;
import kabam.rotmg.core.signals.BuyCharacterPendingSignal;
import kabam.rotmg.core.signals.GotoPreviousScreenSignal;
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.InvalidateDataSignal;
import kabam.rotmg.core.signals.LaunchGameSignal;
import kabam.rotmg.core.signals.PurchaseCharacterSignal;
import kabam.rotmg.core.signals.SetLoadingMessageSignal;
import kabam.rotmg.core.signals.SetScreenSignal;
import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
import kabam.rotmg.core.signals.SetupDomainSecuritySignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.core.signals.UpdateNewCharacterScreenSignal;
import kabam.rotmg.core.view.Layers;
import kabam.rotmg.core.view.ScreensMediator;
import kabam.rotmg.core.view.ScreensView;
import kabam.rotmg.startup.control.StartupSequence;
import kabam.rotmg.tooltips.TooltipAble;
import kabam.rotmg.tooltips.controller.TooltipAbleMediator;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class CoreConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var setup:ApplicationSetup;
    [Inject]
    public var contextView:DisplayObjectContainer;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var startup:StartupSequence;
    private var layers:Layers;


    public function configure():void {
        this.configureModel();
        this.configureCommands();
        this.configureServices();
        this.configureSignals();
        this.configureViews();
        this.startup.addSignal(SetupDomainSecuritySignal, -1000);
        this.startup.addTask(RequestAppInitTask);
        this.context.lifecycle.afterInitializing(this.init);
    }

    private function configureModel():void {
        this.injector.map(PlayerModel).asSingleton();
        this.injector.map(MapModel).asSingleton();
        this.injector.map(ScreenModel).asSingleton();
    }

    private function configureCommands():void {
        this.commandMap.map(SetupDomainSecuritySignal).toCommand(SetupDomainSecurityCommand);
        this.commandMap.map(InvalidateDataSignal).toCommand(InvalidateDataCommand);
        this.commandMap.map(SetScreenWithValidDataSignal).toCommand(SetScreenWithValidDataCommand);
        this.commandMap.map(PurchaseCharacterSignal).toCommand(PurchaseCharacterCommand);
        this.commandMap.map(AppInitDataReceivedSignal).toCommand(ConfigurePaymentsWindowCommand);
        this.commandMap.map(CharListDataSignal).toCommand(UpdatePlayerModelCommand);
        this.commandMap.map(CharListDataSignal).toCommand(UpdatePetsModelCommand);
    }

    private function configureServices():void {
        this.injector.map(JsonParser).toSingleton(SoftwareJsonParser);
        this.injector.map(TaskMonitor).asSingleton();
        this.injector.map(PurchaseCharacterClassTask);
        this.injector.map(PurchaseCharacterErrorTask);
        this.injector.map(RequestAppInitTask);
    }

    private function configureSignals():void {
        this.injector.map(SetScreenSignal).asSingleton();
        this.injector.map(GotoPreviousScreenSignal).asSingleton();
        this.injector.map(LaunchGameSignal).asSingleton();
        this.injector.map(ShowTooltipSignal).asSingleton();
        this.injector.map(HideTooltipsSignal).asSingleton();
        this.injector.map(SetLoadingMessageSignal).asSingleton();
        this.injector.map(UpdateNewCharacterScreenSignal).asSingleton();
        this.injector.map(BuyCharacterPendingSignal).asSingleton();
    }

    private function configureViews():void {
        this.mediatorMap.map(ScreensView).toMediator(ScreensMediator);
        this.mediatorMap.map(TooltipAble).toMediator(TooltipAbleMediator);
    }

    private function init():void {
        this.mediatorMap.mediate(this.contextView);
        this.layers = new Layers();
        this.injector.map(Layers).toValue(this.layers);
        this.contextView.addChild(this.layers);
    }


}
}//package kabam.rotmg.core
