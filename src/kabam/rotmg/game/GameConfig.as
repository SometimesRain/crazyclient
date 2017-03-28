package kabam.rotmg.game {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.GiftStatusModel;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.MapMediator;
import com.company.assembleegameclient.map.QueueStatusTextSignal;
import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
import com.company.assembleegameclient.ui.TradeSlot;
import com.company.assembleegameclient.ui.TradeSlotMediator;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.PartyPanel;
import com.company.assembleegameclient.ui.panels.PortalPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileSprite;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileSpriteMediator;
import com.company.assembleegameclient.ui.panels.mediators.InteractPanelMediator;
import com.company.assembleegameclient.ui.panels.mediators.InventoryGridMediator;
import com.company.assembleegameclient.ui.panels.mediators.ItemGridMediator;
import com.company.assembleegameclient.ui.panels.mediators.PartyPanelMediator;
import kabam.rotmg.ui.view.QuestHealthBar;
import kabam.rotmg.ui.view.QuestHealthBarMediator;

import kabam.lib.net.impl.SocketServerModel;
import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.chat.ChatConfig;
import kabam.rotmg.core.signals.AppInitDataReceivedSignal;
import kabam.rotmg.game.commands.GiftStatusUpdateCommand;
import kabam.rotmg.game.commands.ParsePotionDataCommand;
import kabam.rotmg.game.commands.PlayGameCommand;
import kabam.rotmg.game.commands.TextPanelMessageUpdateCommand;
import kabam.rotmg.game.commands.TransitionFromGameToMenuCommand;
import kabam.rotmg.game.commands.UseBuyPotionCommand;
import kabam.rotmg.game.focus.GameFocusConfig;
import kabam.rotmg.game.logging.LoopMonitor;
import kabam.rotmg.game.logging.NullLoopMonitor;
import kabam.rotmg.game.logging.RollingMeanLoopMonitor;
import kabam.rotmg.game.model.ChatFilter;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.game.model.TextPanelData;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
import kabam.rotmg.game.signals.ExitGameSignal;
import kabam.rotmg.game.signals.GameClosedSignal;
import kabam.rotmg.game.signals.GiftStatusUpdateSignal;
import kabam.rotmg.game.signals.PlayGameSignal;
import kabam.rotmg.game.signals.SetTextBoxVisibilitySignal;
import kabam.rotmg.game.signals.SetWorldInteractionSignal;
import kabam.rotmg.game.signals.TextPanelMessageUpdateSignal;
import kabam.rotmg.game.signals.UpdateGiftStatusDisplaySignal;
import kabam.rotmg.game.signals.UseBuyPotionSignal;
import kabam.rotmg.game.view.CreditDisplay;
import kabam.rotmg.game.view.CreditDisplayMediator;
import kabam.rotmg.game.view.GameSpriteMediator;
import kabam.rotmg.game.view.GiftStatusDisplay;
import kabam.rotmg.game.view.GiftStatusDisplayMediator;
import kabam.rotmg.game.view.MapOverlayMediator;
import kabam.rotmg.game.view.MoneyChangerPanel;
import kabam.rotmg.game.view.MoneyChangerPanelMediator;
import kabam.rotmg.game.view.PortalPanelMediator;
import kabam.rotmg.game.view.SellableObjectPanel;
import kabam.rotmg.game.view.SellableObjectPanelMediator;
import kabam.rotmg.game.view.TextPanel;
import kabam.rotmg.game.view.TextPanelMediator;
import kabam.rotmg.game.view.components.StatMediator;
import kabam.rotmg.game.view.components.StatView;
import kabam.rotmg.game.view.components.StatsMediator;
import kabam.rotmg.game.view.components.StatsView;

import org.swiftsuspenders.Injector;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;

public class GameConfig implements IConfig {

    [Inject]
    public var context:IContext;
    [Inject]
    public var injector:Injector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var commandMap:ISignalCommandMap;
    [Inject]
    public var setup:ApplicationSetup;


    private function generalGameConfiguration():void {
        this.injector.map(UpdateGiftStatusDisplaySignal).asSingleton();
        this.injector.map(SetWorldInteractionSignal).asSingleton();
        this.injector.map(SetTextBoxVisibilitySignal).asSingleton();
        this.injector.map(AddSpeechBalloonSignal).asSingleton();
        this.injector.map(ChatFilter).asSingleton();
        this.injector.map(GiftStatusModel).asSingleton();
        this.injector.map(ExitGameSignal).asSingleton();
        this.injector.map(QueueStatusTextSignal).asSingleton();
        this.injector.map(SocketServerModel).asSingleton();
        this.makeTextPanelMappings();
        this.makeGiftStatusDisplayMappings();
        this.mediatorMap.map(PortalPanel).toMediator(PortalPanelMediator);
        this.mediatorMap.map(PartyPanel).toMediator(PartyPanelMediator);
        this.mediatorMap.map(InteractPanel).toMediator(InteractPanelMediator);
        this.mediatorMap.map(ItemGrid).toMediator(ItemGridMediator);
        this.mediatorMap.map(InventoryGrid).toMediator(InventoryGridMediator);
        this.mediatorMap.map(ItemTileSprite).toMediator(ItemTileSpriteMediator);
        this.mediatorMap.map(TradeSlot).toMediator(TradeSlotMediator);
        this.mediatorMap.map(MapOverlay).toMediator(MapOverlayMediator);
        this.mediatorMap.map(Map).toMediator(MapMediator);
        this.mediatorMap.map(StatView).toMediator(StatMediator);
        this.mediatorMap.map(StatsView).toMediator(StatsMediator);
        this.commandMap.map(AppInitDataReceivedSignal).toCommand(ParsePotionDataCommand);
        this.commandMap.map(GiftStatusUpdateSignal).toCommand(GiftStatusUpdateCommand);
        this.commandMap.map(UseBuyPotionSignal).toCommand(UseBuyPotionCommand);
        this.commandMap.map(GameClosedSignal).toCommand(TransitionFromGameToMenuCommand);
        this.commandMap.map(PlayGameSignal).toCommand(PlayGameCommand);
        this.mapLoopMonitor();
    }

    public function configure():void {
        this.context.configure(GameFocusConfig);
        this.injector.map(GameModel).asSingleton();
        this.generalGameConfiguration();
        this.context.configure(ChatConfig);
    }

    private function makeTextPanelMappings():void {
        this.injector.map(TextPanelData).asSingleton();
        this.commandMap.map(TextPanelMessageUpdateSignal, true).toCommand(TextPanelMessageUpdateCommand);
        this.mediatorMap.map(TextPanel).toMediator(TextPanelMediator);
    }

    private function makeGiftStatusDisplayMappings():void {
        this.mediatorMap.map(GiftStatusDisplay).toMediator(GiftStatusDisplayMediator);
        this.mediatorMap.map(GameSprite).toMediator(GameSpriteMediator);
        this.mediatorMap.map(CreditDisplay).toMediator(CreditDisplayMediator);
        this.mediatorMap.map(MoneyChangerPanel).toMediator(MoneyChangerPanelMediator);
        this.mediatorMap.map(SellableObjectPanel).toMediator(SellableObjectPanelMediator);
		this.mediatorMap.map(QuestHealthBar).toMediator(QuestHealthBarMediator);
    }

    private function mapLoopMonitor():void {
        if (this.setup.isGameLoopMonitored()) {
            this.injector.map(LoopMonitor).toType(RollingMeanLoopMonitor);
        }
        else {
            this.injector.map(LoopMonitor).toType(NullLoopMonitor);
        }
    }


}
}//package kabam.rotmg.game
