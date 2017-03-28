package kabam.rotmg.ui.view {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.BoostPanelButton;
import com.company.assembleegameclient.ui.TradePanel;
import com.company.assembleegameclient.ui.panels.InteractPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.EquippedGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.util.GraphicsUtil;
import com.company.util.SpriteUtil;
import flash.display.StageScaleMode;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.view.components.StatsView;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.components.PetsTabContentView;

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

    private const BG_POSITION:Point = new Point(0, 0);
    private const MAP_POSITION:Point = new Point(4, 4);
    private const CHARACTER_DETAIL_PANEL_POSITION:Point = new Point(0, 198);
    private const STAT_METERS_POSITION:Point = new Point(12, 244);
    private const EQUIPMENT_INVENTORY_POSITION:Point = new Point(14, 200);
    private const INTERACT_PANEL_POSITION:Point = new Point(0, 500);
	
    private const INV_POS:Point = new Point(14, 304);
    private const BP_POS:Point = new Point(14, 392);
    private const POT_POS:Point = new Point(14, 480);
	
    //private const QUEST_BAR_POS:Point = new Point(-596, 16);
    private const STATS_POS:Point = new Point(14, 298);
    private const PET_POS:Point = new Point(5, 354);
    private const CD_POS:Point = new Point(58, 200);
	
    public var petModel:PetsModel;
    private var player:Player;

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
	
	//private var questBar:QuestHealthBar;
    private var stats:StatsView;
    private var cdtimer:CooldownTimer;
	private var mainView:Boolean = true;

    public function HUDView() {
        this.petModel = StaticInjectorContext.getInjector().getInstance(PetsModel);
        this.createAssets();
        this.addAssets();
        this.positionAssets();
    }

    private function createAssets():void {
        this.background = new CharacterWindowBackground();
        this.miniMap = new MiniMapImp(192, 192);
		this.potions = new PotionInventoryView();
		this.stats = new StatsView();
		
        //this.questBar = new QuestHealthBar();
        this.cdtimer = new CooldownTimer();
    }

    private function addAssets():void {
        addChild(this.background);
        addChild(this.miniMap);
        addChild(this.potions);
		addChild(this.stats);
		
        //addChild(this.questBar);
    }

    private function positionAssets():void {
        this.background.x = this.BG_POSITION.x;
        this.background.y = this.BG_POSITION.y;
        this.miniMap.x = this.MAP_POSITION.x;
        this.miniMap.y = this.MAP_POSITION.y;
        this.potions.x = this.POT_POS.x;
        this.potions.y = this.POT_POS.y;
		this.stats.x = this.STATS_POS.x;
		this.stats.y = this.STATS_POS.y;
		this.stats.visible = false;
		
        //this.questBar.x = this.QUEST_BAR_POS.x; //-596 -> -1396
        //this.questBar.y = this.QUEST_BAR_POS.y;
		//winw 800 -> -596 winw 1680 -> -974
		/*if (Parameters.data_.stageScale == StageScaleMode.NO_SCALE) { //fs = on
			var _loc12_:Number = 800 / WebMain.sWidth; //1680 -> 0.47619047619047619048
			var _loc13_:Number = 600 / WebMain.sHeight; //977 -> 0.61412487205731832139
			//0.77539682539682539683
			if (Parameters.data_.uiscale) {
				this.questBar.x = this.QUEST_BAR_POS.x * (_loc13_ / _loc12_);
			}
			else {
				//this.hudView.scaleX = _loc12_;
				//this.hudView.scaleY = _loc13_;
				//this.hudView.y = 300 * (1 - _loc13_);
			}
		}*/
        this.cdtimer.x = this.CD_POS.x;
        this.cdtimer.y = this.CD_POS.y;
		this.cdtimer.mouseEnabled = false;
		this.cdtimer.mouseChildren = false;
    }

    public function setPlayerDependentAssets(_arg_1:GameSprite):void { //equipment
        this.player = _arg_1.map.player_;
        this.createEquippedGrid(); //equipment
        this.createPetWindow(); //pet
        this.createInventories(); //inventory, backpack, potions
        this.createInteractPanel(_arg_1); //nearby players
        this.createCooldownTimer(); //custom
    }

    private function createPetWindow():void {
		if (petModel.getActivePet()) {
			pet = new PetsTabContentView();
			this.pet.x = this.PET_POS.x;
			this.pet.y = this.PET_POS.y;
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
		this.inventory.x = this.BP_POS.x;
		this.inventory.y = this.BP_POS.y;
		if (player.hasBackpack_) {
			this.backpack = new InventoryGrid(player,player,12);
			this.statMeters = new StatMetersView(4, true);
			this.inventory.x = this.INV_POS.x;
			this.inventory.y = this.INV_POS.y;
			this.backpack.x = this.BP_POS.x;
			this.backpack.y = this.BP_POS.y;
			this.stats.y = this.INV_POS.y + 6;
			this.statMeters.y = this.STAT_METERS_POSITION.y;
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
			this.statMeters = new StatMetersView(8, true);
			this.characterDetails = new CharacterDetailsView();
			this.equippedGrid.y = this.EQUIPMENT_INVENTORY_POSITION.y + 148;
			this.cdtimer.y = this.CD_POS.y + 148;
			this.statMeters.y = this.STAT_METERS_POSITION.y - 16;
			this.characterDetails.x = this.CHARACTER_DETAIL_PANEL_POSITION.x;
			this.characterDetails.y = this.CHARACTER_DETAIL_PANEL_POSITION.y;
			addChild(this.characterDetails); //class and name
		}
        this.statMeters.x = this.STAT_METERS_POSITION.x;
        addChild(this.inventory);
        addChild(this.statMeters); //fame, health, mana
    }
	
	private function createCooldownTimer():void {
		addChild(cdtimer);
	}

    private function createInteractPanel(_arg_1:GameSprite):void {
        this.interactPanel = new InteractPanel(_arg_1, this.player, 200, 100);
        this.interactPanel.x = this.INTERACT_PANEL_POSITION.x;
        this.interactPanel.y = this.INTERACT_PANEL_POSITION.y;
        addChild(this.interactPanel);
    }

    private function createEquippedGrid():void {
        this.equippedGrid = new EquippedGrid(this.player, this.player.slotTypes_, this.player);
        this.equippedGrid.x = this.EQUIPMENT_INVENTORY_POSITION.x;
        this.equippedGrid.y = this.EQUIPMENT_INVENTORY_POSITION.y;
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
