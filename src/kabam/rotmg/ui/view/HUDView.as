package kabam.rotmg.ui.view {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.MapUserInput;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.BoostPanelButton;
import com.company.assembleegameclient.ui.TradePanel;
import com.company.assembleegameclient.ui.board.HelpBoard;
import com.company.assembleegameclient.ui.icons.SimpleIconButton;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;
import com.company.util.SpriteUtil;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.StageScaleMode;
import flash.events.MouseEvent;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.friends.view.FriendListView;
import kabam.rotmg.game.view.components.StatsView;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.components.PetsTabContentView;
import org.swiftsuspenders.Injector;

import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import kabam.rotmg.messaging.impl.incoming.TradeAccepted;
import kabam.rotmg.messaging.impl.incoming.TradeChanged;
import kabam.rotmg.messaging.impl.incoming.TradeStart;
import kabam.rotmg.minimap.view.MiniMapImp;
import flash.utils.getTimer;

public class HUDView extends Sprite implements UnFocusAble {

	//other
    public var characterDetails:CharacterDetailsView; //name, class icon, options, nexus, boost icons
    public var background:CharacterWindowBackground; //gray bg, private
    private var miniMap:MiniMapImp; //minimap
	private var pet:PetsTabContentView; //pet
    private var dropBoost:BoostPanelButton; //drop boost
	//equips and bars
    private var equippedGrid:EquippedGrid; //equips
	private var inventory:InventoryGrid; //inv
	private var backpack:InventoryGrid; //backpack
	private var potions:PotionInventoryView; //pots
    private var statMeters:StatMetersView; //hp, mp, fame
	//bottom panel
    public var interactPanel:InteractPanel;
    public var tradePanel:TradePanel;
	
	private var optButton:SimpleIconButton;
	private var frButton:SimpleIconButton;
	private var helpButton:SimpleIconButton;
	private var showButton:SimpleIconButton;
	private var upArrow:BitmapData;
	private var downArrow:BitmapData;
	
    private var stats:StatsView;
    private var cdtimer:CooldownTimer;
	private var mainView:Boolean = true;
	
    private var petModel:PetsModel;
	private var openDialog:OpenDialogSignal;
    private var player:Player;
	private var gs_:GameSprite;

    public function HUDView() {
		var injector:Injector = StaticInjectorContext.getInjector();
        this.petModel = injector.getInstance(PetsModel);
        this.openDialog = injector.getInstance(OpenDialogSignal);
        this.createAssets();
        this.addAssets();
        this.positionAssets();
		upArrow = AssetLibrary.getImageFromSet("lofiInterface", 54);
		downArrow = AssetLibrary.getImageFromSet("lofiInterface", 55);
		this.createButtons(); //must come after minimap
    }

    private function createAssets():void {
        this.background = new CharacterWindowBackground();
        this.miniMap = new MiniMapImp(192, 192);
		this.potions = new PotionInventoryView();
		this.stats = new StatsView();
        this.cdtimer = new CooldownTimer();
    }

    private function addAssets():void {
        addChild(this.background);
        addChild(this.miniMap);
        addChild(this.potions);
		addChild(this.stats);
    }

    private function positionAssets():void {
        this.miniMap.x = 4;
        this.miniMap.y = 4;
        this.potions.x = 14;
        this.potions.y = 480;
		this.stats.x = 14;
		this.stats.y = 294; //298
		this.stats.visible = false;
        this.cdtimer.x = 58;
        this.cdtimer.y = 200;
		this.cdtimer.mouseEnabled = false;
		this.cdtimer.mouseChildren = false;
    }

    public function setPlayerDependentAssets(_arg_1:GameSprite):void { //equipment
        this.player = _arg_1.map.player_;
		this.gs_ = _arg_1;
        this.createEquippedGrid(); //equipment
        this.createPetWindow(); //pet
        this.createInventories(); //inventory, backpack, potions
        this.createInteractPanel(_arg_1); //nearby players
        this.createCooldownTimer(); //custom
    }
	
	private function createButtons():void {
        optButton = new SimpleIconButton(AssetLibrary.getImageFromSet("lofiInterfaceBig", 5));
        optButton.x = 176;
        optButton.y = 160;
		optButton.visible = false;
        optButton.addEventListener(MouseEvent.CLICK, openOptions);
        addChild(optButton);
        frButton = new SimpleIconButton(AssetLibrary.getImageFromSet("lofiInterfaceBig", 13));
        frButton.x = 176;
        frButton.y = 140;
		frButton.visible = false;
        frButton.addEventListener(MouseEvent.CLICK, openFriends);
        addChild(frButton);
        helpButton = new SimpleIconButton(AssetLibrary.getImageFromSet("lofiInterfaceBig", 15));
        helpButton.x = 176;
        helpButton.y = 120;
		helpButton.visible = false;
        helpButton.addEventListener(MouseEvent.CLICK, openHelp);
        addChild(helpButton);
        showButton = new SimpleIconButton(upArrow);
        showButton.x = 176;
        showButton.y = 176;
        showButton.scaleX = 2;
        showButton.scaleY = 2;
        showButton.addEventListener(MouseEvent.CLICK, toggleIcons);
        addChild(showButton);
	}
	
	private function toggleIcons(e:MouseEvent):void {
		optButton.visible = !optButton.visible;
		frButton.visible = !frButton.visible;
		helpButton.visible = !helpButton.visible;
		showButton.changeIcon(showButton.iconBitmapData_ == upArrow ? downArrow : upArrow);
	}
	
	private function openOptions(e:MouseEvent):void {
		toggleIcons(e);
		gs_.mui_.openOptions();
	}
	
	private function openFriends(e:MouseEvent):void {
		toggleIcons(e);
		openDialog.dispatch(new FriendListView());
	}
	
	private function openHelp(e:MouseEvent):void {
		toggleIcons(e);
		openDialog.dispatch(new HelpBoard());
	}

    private function createPetWindow():void {
		if (petModel.getActivePet()) {
			pet = new PetsTabContentView();
			this.pet.x = 5;
			this.pet.y = 354;
			this.pet.visible = false;
			addChild(this.pet);
		}
	}
	
	public function toggleStats():void { //hasBP: inv -> stats. bp -> pet, noBP: inv -> pet
		mainView = !mainView;
		if (player.hasBackpack_) {
			inventory.visible = mainView;
			stats.visible = !mainView;
			if (pet != null) {
				backpack.visible = mainView;
				pet.visible = !mainView;
			}
		}
		else if (pet != null) {
			equippedGrid.visible = mainView;
			inventory.visible = mainView;
			pet.visible = !mainView;
		}
	}

    private function createInventories():void {
		this.inventory = new InventoryGrid(player,player,4);
		this.inventory.x = 14;
		this.inventory.y = 392;
		if (player.hasBackpack_) {
			this.backpack = new InventoryGrid(player,player,12);
			this.statMeters = new StatMetersView();
			this.inventory.x = 14;
			this.inventory.y = 304;
			this.backpack.x = 14;
			this.backpack.y = 392;
			this.stats.y = 310;
			this.statMeters.y = 244;
			addChild(this.backpack);
			if (player.tierBoost || player.dropBoost) {
				this.dropBoost = new BoostPanelButton(player);
				this.dropBoost.x = -2;
				this.dropBoost.y = 214;
				addChild(this.dropBoost);
			}
		}
		else {
			this.stats.visible = true;
			this.statMeters = new StatMetersView();
			this.characterDetails = new CharacterDetailsView();
			this.equippedGrid.y = 348;
			this.cdtimer.y = 348;
			this.statMeters.y = 228;
			this.characterDetails.y = 198;
			addChild(this.characterDetails); //class and name
		}
        this.statMeters.x = 12;
        addChild(this.inventory);
        addChild(this.statMeters); //fame, health, mana
    }
	
	private function createCooldownTimer():void {
		addChild(cdtimer);
	}

    private function createInteractPanel(_arg_1:GameSprite):void {
        this.interactPanel = new InteractPanel(_arg_1, this.player, 200, 100);
        this.interactPanel.y = 500;
        addChild(this.interactPanel);
    }

    private function createEquippedGrid():void {
        this.equippedGrid = new EquippedGrid(this.player, this.player.slotTypes_, this.player);
        this.equippedGrid.x = 14;
        this.equippedGrid.y = 200;
        addChild(this.equippedGrid);
    }

    public function draw():void {
        if (this.equippedGrid) {
            this.equippedGrid.draw();
        }
        if (this.interactPanel) {
            this.interactPanel.draw();
        }
    }

    public function startTrade(_arg_1:AGameSprite, _arg_2:TradeStart):void {
        if (!this.tradePanel) {
            this.tradePanel = new TradePanel(_arg_1, _arg_2);
            this.tradePanel.y = 200;
            this.tradePanel.addEventListener(Event.CANCEL, this.onTradeCancel);
            addChild(this.tradePanel);
            this.setNonTradePanelAssetsVisible(false);
        }
    }

    private function setNonTradePanelAssetsVisible(_arg_1:Boolean):void {
        this.statMeters.visible = _arg_1;
        this.equippedGrid.visible = _arg_1;
        this.interactPanel.visible = _arg_1;
        this.cdtimer.visible = _arg_1;
		this.inventory.visible = _arg_1;
		this.potions.visible = _arg_1;
		this.stats.visible = _arg_1;
		if (player.hasBackpack_) {
			this.stats.visible = false;
		}
		if (pet != null) {
			this.pet.visible = false;
		}
		mainView = true;
		
		if (backpack != null)
			this.backpack.visible = _arg_1;
		if (dropBoost != null)
			this.dropBoost.visible = _arg_1;
		if (characterDetails != null)
			this.characterDetails.visible = _arg_1;
    }

    public function tradeDone():void {
        this.removeTradePanel();
    }

    public function tradeChanged(_arg_1:TradeChanged):void {
        if (this.tradePanel) {
            this.tradePanel.setYourOffer(_arg_1.offer_);
        }
    }

    public function tradeAccepted(_arg_1:TradeAccepted):void {
        if (this.tradePanel) {
            this.tradePanel.youAccepted(_arg_1.myOffer_, _arg_1.yourOffer_);
        }
    }

    private function onTradeCancel(_arg_1:Event):void {
        this.removeTradePanel();
    }

    private function removeTradePanel():void {
        if (this.tradePanel) {
            SpriteUtil.safeRemoveChild(this, this.tradePanel);
            this.tradePanel.removeEventListener(Event.CANCEL, this.onTradeCancel);
            this.tradePanel = null;
            this.setNonTradePanelAssetsVisible(true);
        }
    }


}
}//package kabam.rotmg.ui.view
