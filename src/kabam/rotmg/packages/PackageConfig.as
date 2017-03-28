package kabam.rotmg.packages {
import kabam.lib.resizing.view.Resizable;
import kabam.lib.resizing.view.ResizableMediator;
import kabam.rotmg.packages.control.AlreadyBoughtPackageCommand;
import kabam.rotmg.packages.control.AlreadyBoughtPackageSignal;
import kabam.rotmg.packages.control.BuyPackageCommand;
import kabam.rotmg.packages.control.BuyPackageSignal;
import kabam.rotmg.packages.control.BuyPackageSuccessfulCommand;
import kabam.rotmg.packages.control.BuyPackageSuccessfulSignal;
import kabam.rotmg.packages.control.InitPackagesCommand;
import kabam.rotmg.packages.control.InitPackagesSignal;
import kabam.rotmg.packages.control.IsPackageAffordableGuard;
import kabam.rotmg.packages.control.OpenPackageCommand;
import kabam.rotmg.packages.control.OpenPackageSignal;
import kabam.rotmg.packages.control.PackageAvailableSignal;
import kabam.rotmg.packages.services.GetPackagesTask;
import kabam.rotmg.packages.services.PackageModel;
import kabam.rotmg.packages.view.PackageButton;
import kabam.rotmg.packages.view.PackageButtonMediator;
import kabam.rotmg.packages.view.PackageInfoDialog;
import kabam.rotmg.packages.view.PackageInfoMediator;
import kabam.rotmg.packages.view.PackageOfferDialog;
import kabam.rotmg.packages.view.PackageOfferDialogMediator;
import kabam.rotmg.startup.control.StartupSequence;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class PackageConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var sequence:StartupSequence;


    public function configure():void {
        this.injector.map(PackageModel).asSingleton();
        this.injector.map(PackageAvailableSignal).asSingleton();
        this.injector.map(GetPackagesTask);
        this.mediatorMap.map(PackageButton).toMediator(PackageButtonMediator);
        this.mediatorMap.map(PackageOfferDialog).toMediator(PackageOfferDialogMediator);
        this.mediatorMap.map(PackageInfoDialog).toMediator(PackageInfoMediator);
        this.mediatorMap.map(Resizable).toMediator(ResizableMediator);
        this.commandMap.map(BuyPackageSignal).toCommand(BuyPackageCommand).withGuards(IsAccountRegisteredToBuyPackageGuard, IsPackageAffordableGuard);
        this.commandMap.map(AlreadyBoughtPackageSignal).toCommand(AlreadyBoughtPackageCommand);
        this.commandMap.map(BuyPackageSuccessfulSignal).toCommand(BuyPackageSuccessfulCommand);
        this.commandMap.map(InitPackagesSignal).toCommand(InitPackagesCommand);
        this.commandMap.map(OpenPackageSignal).toCommand(OpenPackageCommand);
        this.sequence.addTask(GetPackagesTask);
    }


}
}//package kabam.rotmg.packages
