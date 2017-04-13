package kabam.rotmg.ui {
import com.company.assembleegameclient.account.ui.ChooseNameFrame;
import com.company.assembleegameclient.account.ui.ChooseNameFrameMediator;
import com.company.assembleegameclient.account.ui.CreateGuildFrame;
import com.company.assembleegameclient.account.ui.NewChooseNameFrame;
import com.company.assembleegameclient.account.ui.NewChooseNameFrameMediator;
import com.company.assembleegameclient.account.ui.components.CreateGuildFrameMediator;
import com.company.assembleegameclient.map.partyoverlay.GameObjectArrow;
import com.company.assembleegameclient.mapeditor.MapEditor;
import com.company.assembleegameclient.objects.ImageFactory;
import com.company.assembleegameclient.screens.AccountScreen;
import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
import com.company.assembleegameclient.screens.CreditsScreen;
import com.company.assembleegameclient.screens.GraveyardLine;
import com.company.assembleegameclient.screens.LoadingScreen;
import com.company.assembleegameclient.screens.NewCharacterScreen;
import com.company.assembleegameclient.screens.ServersScreen;
import com.company.assembleegameclient.screens.charrects.CharacterRectList;
import com.company.assembleegameclient.screens.charrects.CurrentCharacterRect;
import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
import com.company.assembleegameclient.ui.icons.IconButtonFactory;
import com.company.assembleegameclient.ui.language.LanguageOptionOverlay;
import com.company.assembleegameclient.ui.language.LanguageOptionOverlayMediator;
import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
import com.company.assembleegameclient.ui.panels.ArenaPortalPanel;
import com.company.assembleegameclient.ui.panels.GuildRegisterPanel;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.ui.panels.mediators.ArenaPortalPanelMediator;
import com.company.assembleegameclient.ui.panels.mediators.GuildRegisterPanelMediator;
import com.company.assembleegameclient.ui.panels.mediators.InteractPanelMediator;
import com.company.assembleegameclient.ui.panels.mediators.ItemGridMediator;
import kabam.rotmg.ui.view.CooldownTimer;
import kabam.rotmg.ui.view.CooldownTimerMediator;

import kabam.rotmg.account.core.services.GetCharListTask;
import kabam.rotmg.account.core.services.LoadAccountTask;
import kabam.rotmg.account.core.view.AccountInfoMediator;
import kabam.rotmg.account.core.view.AccountInfoView;
import kabam.rotmg.account.core.view.RegisterPromptDialog;
import kabam.rotmg.account.core.view.RegisterPromptDialogMediator;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.death.view.ResurrectionView;
import kabam.rotmg.death.view.ResurrectionViewMediator;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.view.NameChangerPanel;
import kabam.rotmg.game.view.NameChangerPanelMediator;
import kabam.rotmg.game.view.TextPanel;
import kabam.rotmg.game.view.TextPanelMediator;
import kabam.rotmg.game.view.components.StatsTabHotKeyInputSignal;
import kabam.rotmg.game.view.components.StatsUndockedSignal;
import kabam.rotmg.startup.control.StartupSequence;
import kabam.rotmg.ui.commands.ChooseNameCommand;
import kabam.rotmg.ui.commands.EnterGameCommand;
import kabam.rotmg.ui.commands.HUDInitCommand;
import kabam.rotmg.ui.commands.RefreshScreenAfterLoginCommand;
import kabam.rotmg.ui.commands.ShowHideKeyUICommand;
import kabam.rotmg.ui.commands.ShowLoadingUICommand;
import kabam.rotmg.ui.commands.ShowTitleUICommand;
import kabam.rotmg.ui.controller.GameObjectArrowMediator;
import kabam.rotmg.ui.controller.UnFocusAbleMediator;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.noservers.NoServersDialogFactory;
import kabam.rotmg.ui.noservers.ProductionNoServersDialogFactory;
import kabam.rotmg.ui.noservers.TestingNoServersDialogFactory;
import kabam.rotmg.ui.signals.ChooseNameSignal;
import kabam.rotmg.ui.signals.EnterGameSignal;
import kabam.rotmg.ui.signals.HUDModelInitialized;
import kabam.rotmg.ui.signals.HUDSetupStarted;
import kabam.rotmg.ui.signals.HideKeySignal;
import kabam.rotmg.ui.signals.NameChangedSignal;
import kabam.rotmg.ui.signals.RefreshScreenAfterLoginSignal;
import kabam.rotmg.ui.signals.ShowHideKeyUISignal;
import kabam.rotmg.ui.signals.ShowKeySignal;
import kabam.rotmg.ui.signals.ShowLoadingUISignal;
import kabam.rotmg.ui.signals.ShowTitleUISignal;
import kabam.rotmg.ui.signals.UpdateBackpackTabSignal;
import kabam.rotmg.ui.signals.UpdateHUDSignal;
import kabam.rotmg.ui.signals.UpdatePotionInventorySignal;
import kabam.rotmg.ui.view.AccountScreenMediator;
import kabam.rotmg.ui.view.AgeVerificationDialog;
import kabam.rotmg.ui.view.AgeVerificationMediator;
import kabam.rotmg.ui.view.CharacterDetailsMediator;
import kabam.rotmg.ui.view.CharacterDetailsView;
import kabam.rotmg.ui.view.CharacterRectListMediator;
import kabam.rotmg.ui.view.CharacterSlotNeedGoldDialog;
import kabam.rotmg.ui.view.CharacterSlotNeedGoldMediator;
import kabam.rotmg.ui.view.CharacterSlotRegisterDialog;
import kabam.rotmg.ui.view.CharacterSlotRegisterMediator;
import kabam.rotmg.ui.view.ChooseNameRegisterDialog;
import kabam.rotmg.ui.view.ChooseNameRegisterMediator;
import kabam.rotmg.ui.view.CreditsMediator;
import kabam.rotmg.ui.view.CurrentCharacterMediator;
import kabam.rotmg.ui.view.CurrentCharacterRectMediator;
import kabam.rotmg.ui.view.ErrorDialogMediator;
import kabam.rotmg.ui.view.HUDMediator;
import kabam.rotmg.ui.view.HUDView;
import kabam.rotmg.ui.view.KeysMediator;
import kabam.rotmg.ui.view.KeysView;
import kabam.rotmg.ui.view.LoadingMediator;
import kabam.rotmg.ui.view.MapEditorMediator;
import kabam.rotmg.ui.view.NewCharacterMediator;
import kabam.rotmg.ui.view.NewsLineMediator;
import kabam.rotmg.ui.view.NotEnoughGoldDialog;
import kabam.rotmg.ui.view.NotEnoughGoldMediator;
import kabam.rotmg.ui.view.ServersMediator;
import kabam.rotmg.ui.view.StatMetersMediator;
//import kabam.rotmg.ui.view.QuestHealthBarMediator;
import kabam.rotmg.ui.view.StatMetersView;
//import kabam.rotmg.ui.view.QuestHealthBar;
import kabam.rotmg.ui.view.StatsDockedSignal;
import kabam.rotmg.ui.view.TitleMediator;
import kabam.rotmg.ui.view.TitleView;
import kabam.rotmg.ui.view.UnFocusAble;
import kabam.rotmg.ui.view.components.PotionSlotMediator;
import kabam.rotmg.ui.view.components.PotionSlotView;
import kabam.rotmg.dailyLogin.tasks.FetchPlayerCalendarTask;
import kabam.rotmg.news.services.GetInGameNewsTask;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;

public class UIConfig implements IConfig {

    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var setup:ApplicationSetup;
    [Inject]
    public var startup:StartupSequence;


    public function configure():void {
        this.injector.map(NameChangedSignal).asSingleton();
        this.injector.map(PotionInventoryModel).asSingleton();
        this.injector.map(UpdatePotionInventorySignal).asSingleton();
        this.injector.map(UpdateBackpackTabSignal).asSingleton();
        this.injector.map(StatsUndockedSignal).asSingleton();
        this.injector.map(StatsDockedSignal).asSingleton();
        this.injector.map(StatsTabHotKeyInputSignal).asSingleton();
        this.injector.map(IconButtonFactory).asSingleton();
        this.injector.map(ImageFactory).asSingleton();
        this.commandMap.map(ShowLoadingUISignal).toCommand(ShowLoadingUICommand);
        this.commandMap.map(ShowTitleUISignal).toCommand(ShowTitleUICommand);
        this.commandMap.map(ChooseNameSignal).toCommand(ChooseNameCommand);
        this.commandMap.map(EnterGameSignal).toCommand(EnterGameCommand);
        this.mediatorMap.map(LoadingScreen).toMediator(LoadingMediator);
        this.mediatorMap.map(ServersScreen).toMediator(ServersMediator);
        this.mediatorMap.map(CreditsScreen).toMediator(CreditsMediator);
        this.mediatorMap.map(CharacterSelectionAndNewsScreen).toMediator(CurrentCharacterMediator);
        this.mediatorMap.map(AccountInfoView).toMediator(AccountInfoMediator);
        this.mediatorMap.map(AccountScreen).toMediator(AccountScreenMediator);
        this.mediatorMap.map(TitleView).toMediator(TitleMediator);
        this.mediatorMap.map(NewCharacterScreen).toMediator(NewCharacterMediator);
        this.mediatorMap.map(MapEditor).toMediator(MapEditorMediator);
        this.mediatorMap.map(CurrentCharacterRect).toMediator(CurrentCharacterRectMediator);
        this.mediatorMap.map(CharacterRectList).toMediator(CharacterRectListMediator);
        this.mediatorMap.map(ErrorDialog).toMediator(ErrorDialogMediator);
        this.mediatorMap.map(GraveyardLine).toMediator(NewsLineMediator);
        this.mediatorMap.map(NotEnoughGoldDialog).toMediator(NotEnoughGoldMediator);
        this.mediatorMap.map(InteractPanel).toMediator(InteractPanelMediator);
        this.mediatorMap.map(TextPanel).toMediator(TextPanelMediator);
        this.mediatorMap.map(ItemGrid).toMediator(ItemGridMediator);
        this.mediatorMap.map(ChooseNameRegisterDialog).toMediator(ChooseNameRegisterMediator);
        this.mediatorMap.map(CharacterSlotRegisterDialog).toMediator(CharacterSlotRegisterMediator);
        this.mediatorMap.map(RegisterPromptDialog).toMediator(RegisterPromptDialogMediator);
        this.mediatorMap.map(CharacterSlotNeedGoldDialog).toMediator(CharacterSlotNeedGoldMediator);
        this.mediatorMap.map(NameChangerPanel).toMediator(NameChangerPanelMediator);
        this.mediatorMap.map(GuildRegisterPanel).toMediator(GuildRegisterPanelMediator);
        this.mediatorMap.map(ChooseNameFrame).toMediator(ChooseNameFrameMediator);
        this.mediatorMap.map(CreateGuildFrame).toMediator(CreateGuildFrameMediator);
        this.mediatorMap.map(NewChooseNameFrame).toMediator(NewChooseNameFrameMediator);
        this.mediatorMap.map(PlayerGroupMenu).toMediator(PlayerGroupMenuMediator);
        this.mediatorMap.map(AgeVerificationDialog).toMediator(AgeVerificationMediator);
        this.mediatorMap.map(LanguageOptionOverlay).toMediator(LanguageOptionOverlayMediator);
        this.mediatorMap.map(ArenaPortalPanel).toMediator(ArenaPortalPanelMediator);
        this.mediatorMap.map(StatMetersView).toMediator(StatMetersMediator);
		//
        //this.mediatorMap.map(QuestHealthBar).toMediator(QuestHealthBarMediator);
        this.mediatorMap.map(CooldownTimer).toMediator(CooldownTimerMediator);
		//
        this.mediatorMap.map(HUDView).toMediator(HUDMediator);
        this.mediatorMap.map(PotionSlotView).toMediator(PotionSlotMediator);
        this.mediatorMap.map(ResurrectionView).toMediator(ResurrectionViewMediator);
        this.mediatorMap.map(GameObjectArrow).toMediator(GameObjectArrowMediator);
        this.mediatorMap.map(UnFocusAble).toMediator(UnFocusAbleMediator);
        this.setupKeyUI();
        this.mapNoServersDialogFactory();
        this.setupCharacterWindow();
        this.startup.addSignal(ShowLoadingUISignal, -1);
        this.startup.addTask(LoadAccountTask);
        this.startup.addTask(GetCharListTask);
		this.startup.addTask(FetchPlayerCalendarTask);
		this.startup.addTask(GetInGameNewsTask);
        this.startup.addSignal(ShowTitleUISignal, StartupSequence.LAST);
    }

    private function setupKeyUI():void {
        this.injector.map(ShowKeySignal).toValue(new ShowKeySignal());
        this.injector.map(HideKeySignal).toValue(new HideKeySignal());
        this.commandMap.map(ShowHideKeyUISignal).toCommand(ShowHideKeyUICommand);
        this.commandMap.map(RefreshScreenAfterLoginSignal).toCommand(RefreshScreenAfterLoginCommand);
        this.mediatorMap.map(KeysView).toMediator(KeysMediator);
    }

    private function mapNoServersDialogFactory():void {
        if (this.setup.useProductionDialogs()) {
            this.injector.map(NoServersDialogFactory).toSingleton(ProductionNoServersDialogFactory);
        }
        else {
            this.injector.map(NoServersDialogFactory).toSingleton(TestingNoServersDialogFactory);
        }
    }

    private function setupCharacterWindow():void {
        this.injector.map(HUDModel).asSingleton();
        this.injector.map(UpdateHUDSignal).asSingleton();
        this.injector.map(HUDModelInitialized).asSingleton();
        this.commandMap.map(HUDSetupStarted).toCommand(HUDInitCommand);
        this.mediatorMap.map(CharacterDetailsView).toMediator(CharacterDetailsMediator);
    }


}
}//package kabam.rotmg.ui
