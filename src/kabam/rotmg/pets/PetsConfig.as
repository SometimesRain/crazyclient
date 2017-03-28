package kabam.rotmg.pets {
import com.company.assembleegameclient.ui.dialogs.DialogCloser;
import com.company.assembleegameclient.ui.dialogs.DialogCloserMediator;

import kabam.rotmg.pets.controller.ActivatePet;
import kabam.rotmg.pets.controller.ActivatePetCommand;
import kabam.rotmg.pets.controller.AddPetsConsoleActionsCommand;
import kabam.rotmg.pets.controller.AddPetsConsoleActionsSignal;
import kabam.rotmg.pets.controller.DeactivatePet;
import kabam.rotmg.pets.controller.DeactivatePetCommand;
import kabam.rotmg.pets.controller.DeletePetCommand;
import kabam.rotmg.pets.controller.DeletePetSignal;
import kabam.rotmg.pets.controller.EvolvePetCommand;
import kabam.rotmg.pets.controller.EvolvePetSignal;
import kabam.rotmg.pets.controller.HatchPetCommand;
import kabam.rotmg.pets.controller.HatchPetSignal;
import kabam.rotmg.pets.controller.NewAbilityCommand;
import kabam.rotmg.pets.controller.NewAbilitySignal;
import kabam.rotmg.pets.controller.NotifyActivePetUpdated;
import kabam.rotmg.pets.controller.OpenCaretakerQueryDialogCommand;
import kabam.rotmg.pets.controller.OpenCaretakerQueryDialogSignal;
import kabam.rotmg.pets.controller.PetFeedResultSignal;
import kabam.rotmg.pets.controller.ReleasePetCommand;
import kabam.rotmg.pets.controller.ShowPetTooltip;
import kabam.rotmg.pets.controller.UpdateActivePet;
import kabam.rotmg.pets.controller.UpdateActivePetCommand;
import kabam.rotmg.pets.controller.UpdatePetYardCommand;
import kabam.rotmg.pets.controller.UpdatePetYardSignal;
import kabam.rotmg.pets.controller.UpgradePetCommand;
import kabam.rotmg.pets.controller.UpgradePetSignal;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartCommand;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartSignal;
import kabam.rotmg.pets.controller.reskin.ReskinPetRequestCommand;
import kabam.rotmg.pets.controller.reskin.ReskinPetRequestSignal;
import kabam.rotmg.pets.controller.reskin.UpdateSelectedPetForm;
import kabam.rotmg.pets.data.PetFormModel;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.util.FeedFuseCostModel;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.AvailablePetsMediator;
import kabam.rotmg.pets.view.AvailablePetsView;
import kabam.rotmg.pets.view.CaretakerQueryDialogMediator;
import kabam.rotmg.pets.view.ClearsPetSlotsMediator;
import kabam.rotmg.pets.view.FeedPetMediator;
import kabam.rotmg.pets.view.FeedPetView;
import kabam.rotmg.pets.view.FusePetMediator;
import kabam.rotmg.pets.view.FusePetView;
import kabam.rotmg.pets.view.PetFormMediator;
import kabam.rotmg.pets.view.PetFormView;
import kabam.rotmg.pets.view.PetSkinGroup;
import kabam.rotmg.pets.view.PetSkinGroupMediator;
import kabam.rotmg.pets.view.YardUpgraderMediator;
import kabam.rotmg.pets.view.YardUpgraderView;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.DialogCloseButtonMediator;
import kabam.rotmg.pets.view.components.FusionStrength;
import kabam.rotmg.pets.view.components.FusionStrengthMediator;
import kabam.rotmg.pets.view.components.PetAbilityDisplay;
import kabam.rotmg.pets.view.components.PetAbilityDisplayMediator;
import kabam.rotmg.pets.view.components.PetFeeder;
import kabam.rotmg.pets.view.components.PetFeederMediator;
import kabam.rotmg.pets.view.components.PetFuser;
import kabam.rotmg.pets.view.components.PetFuserMediator;
import kabam.rotmg.pets.view.components.PetInteractionPanel;
import kabam.rotmg.pets.view.components.PetInteractionPanelMediator;
import kabam.rotmg.pets.view.components.PetPanelMediator;
import kabam.rotmg.pets.view.components.PetTooltip;
import kabam.rotmg.pets.view.components.PetTooltipMediator;
import kabam.rotmg.pets.view.components.PetsTabContentMediator;
import kabam.rotmg.pets.view.components.PetsTabContentView;
import kabam.rotmg.pets.view.components.YardUpgraderPanel;
import kabam.rotmg.pets.view.components.YardUpgraderPanelMediator;
import kabam.rotmg.pets.view.dialogs.CaretakerQueryDialog;
import kabam.rotmg.pets.view.dialogs.ClearsPetSlots;
import kabam.rotmg.pets.view.dialogs.EggHatchedDialog;
import kabam.rotmg.pets.view.dialogs.EggHatchedDialogMediator;
import kabam.rotmg.pets.view.dialogs.PetPicker;
import kabam.rotmg.pets.view.dialogs.PetPickerDialog;
import kabam.rotmg.pets.view.dialogs.PetPickerDialogMediator;
import kabam.rotmg.pets.view.dialogs.PetPickerMediator;
import kabam.rotmg.pets.view.petPanel.PetPanel;
import kabam.rotmg.pets.view.petPanel.ReleasePetSignal;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.commandCenter.api.ICommandCenter;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class PetsConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var commandCenter:ICommandCenter;


    public function configure():void {
        this.injector.map(ShowPetTooltip).asSingleton();
        this.injector.map(PetsModel).asSingleton();
        this.injector.map(NotifyActivePetUpdated).asSingleton();
        this.injector.map(PetsViewAssetFactory).asSingleton();
        this.injector.map(PetSlotsState).asSingleton();
        this.injector.map(PetFeedResultSignal).asSingleton();
        this.injector.map(FeedFuseCostModel).asSingleton();
        this.injector.map(PetFormModel).asSingleton();
        this.injector.map(UpdateSelectedPetForm).asSingleton();
        this.mediatorMap.map(PetSkinGroup).toMediator(PetSkinGroupMediator);
        this.mediatorMap.map(AvailablePetsView).toMediator(AvailablePetsMediator);
        this.mediatorMap.map(FeedPetView).toMediator(FeedPetMediator);
        this.mediatorMap.map(FusePetView).toMediator(FusePetMediator);
        this.mediatorMap.map(PetsTabContentView).toMediator(PetsTabContentMediator);
        this.mediatorMap.map(PetPanel).toMediator(PetPanelMediator);
        this.mediatorMap.map(PetInteractionPanel).toMediator(PetInteractionPanelMediator);
        this.mediatorMap.map(YardUpgraderPanel).toMediator(YardUpgraderPanelMediator);
        this.mediatorMap.map(PetPicker).toMediator(PetPickerMediator);
        this.mediatorMap.map(PetFeeder).toMediator(PetFeederMediator);
        this.mediatorMap.map(PetFuser).toMediator(PetFuserMediator);
        this.mediatorMap.map(DialogCloseButton).toMediator(DialogCloseButtonMediator);
        this.mediatorMap.map(PetTooltip).toMediator(PetTooltipMediator);
        this.mediatorMap.map(PetAbilityDisplay).toMediator(PetAbilityDisplayMediator);
        this.mediatorMap.map(YardUpgraderView).toMediator(YardUpgraderMediator);
        this.mediatorMap.map(CaretakerQueryDialog).toMediator(CaretakerQueryDialogMediator);
        this.mediatorMap.map(FusionStrength).toMediator(FusionStrengthMediator);
        this.mediatorMap.map(PetPickerDialog).toMediator(PetPickerDialogMediator);
        this.mediatorMap.map(EggHatchedDialog).toMediator(EggHatchedDialogMediator);
        this.mediatorMap.map(DialogCloser).toMediator(DialogCloserMediator);
        this.mediatorMap.map(ClearsPetSlots).toMediator(ClearsPetSlotsMediator);
        this.mediatorMap.map(PetFormView).toMediator(PetFormMediator);
        this.commandMap.map(ReskinPetRequestSignal).toCommand(ReskinPetRequestCommand);
        this.commandMap.map(UpdateActivePet).toCommand(UpdateActivePetCommand);
        this.commandMap.map(UpdatePetYardSignal).toCommand(UpdatePetYardCommand);
        this.commandMap.map(UpgradePetSignal).toCommand(UpgradePetCommand);
        this.commandMap.map(DeactivatePet).toCommand(DeactivatePetCommand);
        this.commandMap.map(ActivatePet).toCommand(ActivatePetCommand);
        this.commandMap.map(AddPetsConsoleActionsSignal).toCommand(AddPetsConsoleActionsCommand);
        this.commandMap.map(OpenCaretakerQueryDialogSignal).toCommand(OpenCaretakerQueryDialogCommand);
        this.commandMap.map(EvolvePetSignal).toCommand(EvolvePetCommand);
        this.commandMap.map(NewAbilitySignal).toCommand(NewAbilityCommand);
        this.commandMap.map(DeletePetSignal).toCommand(DeletePetCommand);
        this.commandMap.map(HatchPetSignal).toCommand(HatchPetCommand);
        this.commandMap.map(ReleasePetSignal).toCommand(ReleasePetCommand);
        this.commandMap.map(ReskinPetFlowStartSignal).toCommand(ReskinPetFlowStartCommand);
        this.injector.getInstance(AddPetsConsoleActionsSignal).dispatch();
    }


}
}//package kabam.rotmg.pets
