package com.company.assembleegameclient.ui.panels.mediators {
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.Container;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.OneWayContainer;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileEvent;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.DisplayHierarchy;
import kabam.rotmg.ui.view.CooldownTimer;
import kabam.rotmg.ui.view.PotionInventoryView;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.pets.controller.reskin.ReskinPetFlowStartSignal;
import kabam.rotmg.pets.data.PetFormModel;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.data.PetsModel;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.questrewards.view.QuestRewardsView;
import kabam.rotmg.ui.model.HUDModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ItemGridMediator extends Mediator {

    [Inject]
    public var view:ItemGrid;
    [Inject]
    public var mapModel:MapModel;
    [Inject]
    public var playerModel:PlayerModel;
    [Inject]
    public var potionInventoryModel:PotionInventoryModel;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var showToolTip:ShowTooltipSignal;
    [Inject]
    public var petSlotsState:PetSlotsState;
    [Inject]
    public var reskinPetFlowStart:ReskinPetFlowStartSignal;
    [Inject]
    public var reskinPetModel:PetFormModel;
    [Inject]
    public var petsModel:PetsModel;
    [Inject]
    public var addTextLine:AddTextLineSignal;


    override public function initialize():void {
        this.view.addEventListener(ItemTileEvent.ITEM_MOVE, this.onTileMove);
        this.view.addEventListener(ItemTileEvent.ITEM_SHIFT_CLICK, this.onShiftClick);
        this.view.addEventListener(ItemTileEvent.ITEM_DOUBLE_CLICK, this.onDoubleClick);
        this.view.addEventListener(ItemTileEvent.ITEM_CTRL_CLICK, this.onCtrlClick);
        this.view.addToolTip.add(this.onAddToolTip);
    }

    private function onAddToolTip(_arg_1:ToolTip):void {
        this.showToolTip.dispatch(_arg_1);
    }

    override public function destroy():void {
        super.destroy();
    }

    private function onTileMove(_arg_1:ItemTileEvent):void {
        var _local_4:InteractiveItemTile;
        var _local_6:int;
        var _local_7:FoodFeedFuseSlot;
        var _local_8:int;
        var _local_2:InteractiveItemTile = _arg_1.tile;
        var _local_3:* = DisplayHierarchy.getParentWithTypeArray(_local_2.getDropTarget(), InteractiveItemTile, FoodFeedFuseSlot, QuestRewardsView, Map, CooldownTimer);
        if (_local_2.getItemId() == PotionInventoryModel.HEALTH_POTION_ID || (_local_2.getItemId() == PotionInventoryModel.MAGIC_POTION_ID && !Boolean(_local_3 as FoodFeedFuseSlot))) {
            this.onPotionMove(_arg_1);
            return;
        }
        if ((_local_3 is InteractiveItemTile)) {
            _local_4 = (_local_3 as InteractiveItemTile);
            if (this.canSwapItems(_local_2, _local_4)) {
                this.swapItemTiles(_local_2, _local_4);
            }
        }
        else {
			if (_local_3 is FoodFeedFuseSlot) {
                _local_7 = (_local_3 as FoodFeedFuseSlot);
                if (!_local_7.processing) {
                    this.petSlotsState.rightSlotId = _local_2.tileId;
                    this.petSlotsState.rightSlotOwnerId = _local_2.ownerGrid.owner.objectId_;
                    _local_8 = _local_2.getItemId();
                    _local_7.setItem(_local_8, _local_2.tileId, _local_2.ownerGrid.owner.objectId_, this.petFoodCancel(_local_2));
                    _local_2.setItem(ItemConstants.NO_ITEM);
                    _local_2.blockingItemUpdates = true;
                    _local_2.updateUseability(this.view.curPlayer);
                    _local_7.setItemPart2(_local_8);
                    }
            }
            else if (_local_3 is Map || this.hudModel.gameSprite.map.mouseX < 300) {
                this.dropItem(_local_2);
            }
			else if (_local_3 is CooldownTimer) {
				var draggedXML:XML = ObjectLibrary.xmlLibrary_[_local_2.itemSprite.itemId];
				var abilXML:XML = ObjectLibrary.xmlLibrary_[view.curPlayer.equipment_[1]];
				if (draggedXML.SlotType == abilXML.SlotType) {
					GameServerConnection.instance.invSwap(this.view.curPlayer, _local_2.ownerGrid.owner, _local_2.tileId, _local_2.itemSprite.itemId, this.view.curPlayer, 1, this.view.curPlayer.equipment_[1]);
				}
			}
        }
        _local_2.resetItemPosition();
    }

    private function petFoodCancel(itemSlot:InteractiveItemTile):Function {
        return (function ():void {
            itemSlot.blockingItemUpdates = false;
        });
    }

    private function onPotionMove(_arg_1:ItemTileEvent):void {
        var _local_2:InteractiveItemTile = _arg_1.tile;
        var _local_3:* = DisplayHierarchy.getParentWithTypeArray(_local_2.getDropTarget(), PotionInventoryView, Map);
        if (_local_3 is PotionInventoryView) {
            this.addToPotionStack(_local_2);
        }
        else if (_local_3 is Map || this.hudModel.gameSprite.map.mouseX < 300) {
            this.dropItem(_local_2);
        }
        _local_2.resetItemPosition();
    }

    private function addToPotionStack(_arg_1:InteractiveItemTile):void {
        if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg_1)))) || ((this.potionInventoryModel.getPotionModel(_arg_1.getItemId()).maxPotionCount <= this.hudModel.gameSprite.map.player_.getPotionCount(_arg_1.getItemId()))))) {
            return;
        }
        GameServerConnection.instance.invSwapPotion(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, this.view.curPlayer, PotionInventoryModel.getPotionSlot(_arg_1.getItemId()), ItemConstants.NO_ITEM);
        _arg_1.setItem(ItemConstants.NO_ITEM);
        _arg_1.updateUseability(this.view.curPlayer);
    }

    private function canSwapItems(_arg_1:InteractiveItemTile, _arg_2:InteractiveItemTile):Boolean {
        if (!_arg_1.canHoldItem(_arg_2.getItemId())) {
            return (false);
        }
        if (!_arg_2.canHoldItem(_arg_1.getItemId())) {
            return (false);
        }
        if ((ItemGrid(_arg_2.parent).owner is OneWayContainer)) {
            return (false);
        }
        if (((_arg_1.blockingItemUpdates) || (_arg_2.blockingItemUpdates))) {
            return (false);
        }
        return (true);
    }

    private function dropItem(_arg_1:InteractiveItemTile):void {
        var _local_4:Container;
        var _local_5:Vector.<int>;
        var _local_6:int;
        var _local_7:int;
        var _local_2:Boolean = ObjectLibrary.isSoulbound(_arg_1.itemSprite.itemId);
        var _local_3:Container = (this.view.owner as Container);
        if ((((this.view.owner == this.view.curPlayer)) || (((((_local_3) && ((_local_3.ownerId_ == this.view.curPlayer.accountId_)))) && (!(_local_2)))))) {
            _local_4 = (this.mapModel.currentInteractiveTarget as Container);
            if (_local_4) {
                _local_5 = _local_4.equipment_;
                _local_6 = _local_5.length;
                _local_7 = 0;
                while (_local_7 < _local_6) {
                    if (_local_5[_local_7] < 0) break;
                    _local_7++;
                }
                if (_local_7 < _local_6) {
                    this.dropWithoutDestTile(_arg_1, _local_4, _local_7);
                }
                else {
                    GameServerConnection.instance.invDrop(this.view.owner, _arg_1.tileId, _arg_1.getItemId());
                }
            }
            else {
                GameServerConnection.instance.invDrop(this.view.owner, _arg_1.tileId, _arg_1.getItemId());
            }
        }
        _arg_1.setItem(-1);
    }

    private function swapItemTiles(_arg_1:ItemTile, _arg_2:ItemTile):Boolean {
        if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg_1)))) || (!(_arg_2)))) {
            return (false);
        }
        GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, _arg_2.ownerGrid.owner, _arg_2.tileId, _arg_2.itemSprite.itemId);
        var _local_3:int = _arg_1.getItemId();
        _arg_1.setItem(_arg_2.getItemId());
        _arg_2.setItem(_local_3);
        _arg_1.updateUseability(this.view.curPlayer);
        _arg_2.updateUseability(this.view.curPlayer);
        return (true);
    }

    private function dropWithoutDestTile(_arg_1:ItemTile, _arg_2:Container, _arg_3:int):void {
        if (((((((!(GameServerConnection.instance)) || (!(this.view.interactive)))) || (!(_arg_1)))) || (!(_arg_2)))) {
            return;
        }
        GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, _arg_2, _arg_3, -1);
        _arg_1.setItem(ItemConstants.NO_ITEM);
    }

    private function onShiftClick(_arg_1:ItemTileEvent):void {
        var _local_2:InteractiveItemTile = _arg_1.tile;
        if (_local_2.ownerGrid is InventoryGrid || _local_2.ownerGrid is ContainerGrid) {
            GameServerConnection.instance.useItem_new(_local_2.ownerGrid.owner, _local_2.tileId);
        }
    }

    private function onCtrlClick(_arg_1:ItemTileEvent):void {
        var _local_2:InteractiveItemTile;
        var _local_3:int;
        if (Parameters.data_.inventorySwap) {
            _local_2 = _arg_1.tile;
			trace(_local_2.tileId);
            if (_local_2.ownerGrid is InventoryGrid || _local_2.ownerGrid is ContainerGrid) {
                _local_3 = _local_2.ownerGrid.curPlayer.swapInventoryIndex(_local_2.tileId);
				trace(_local_3);
                if (_local_3 != -1) {
                    GameServerConnection.instance.invSwap(this.view.curPlayer, _local_2.ownerGrid.owner, _local_2.tileId, _local_2.itemSprite.itemId, this.view.curPlayer, _local_3, ItemConstants.NO_ITEM);
                    _local_2.setItem(ItemConstants.NO_ITEM);
                    _local_2.updateUseability(this.view.curPlayer);
                }
            }
        }
    }

    private function onDoubleClick(_arg_1:ItemTileEvent):void {
        var _local_2:InteractiveItemTile = _arg_1.tile;
        if (this.isPetFormStone(_local_2)) {
            this.handlePetFormStone(_local_2);
        }
        else {
            if (this.isStackablePotion(_local_2)) {
                this.addToPotionStack(_local_2);
            }
            else {
                if ((_local_2.ownerGrid is ContainerGrid)) {
                    this.equipOrUseContainer(_local_2);
                }
                else {
                    this.equipOrUseInventory(_local_2);
                }
            }
        }
        this.view.refreshTooltip();
    }

    private function handlePetFormStone(_arg_1:InteractiveItemTile):void {
        if ((_arg_1.ownerGrid is ContainerGrid)) {
            this.pickUpItem(_arg_1);
        }
        else {
            if (this.petsModel.isMapNameYardName(this.hudModel.gameSprite.map)) {
                this.reskinPetModel.setSlotObject(_arg_1);
                this.reskinPetFlowStart.dispatch();
            }
            else {
                this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "server.use_in_petyard"));
            }
        }
    }

    private function isPetFormStone(_arg_1:InteractiveItemTile):Boolean {
        return ((_arg_1.getItemId() == 3321));
    }

    private function isStackablePotion(_arg_1:InteractiveItemTile):Boolean {
        return ((((_arg_1.getItemId() == PotionInventoryModel.HEALTH_POTION_ID)) || ((_arg_1.getItemId() == PotionInventoryModel.MAGIC_POTION_ID))));
    }

    private function pickUpItem(_arg_1:InteractiveItemTile):void {
        var _local_2:int = this.view.curPlayer.nextAvailableInventorySlot();
        if (_local_2 != -1) {
            GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, this.view.curPlayer, _local_2, ItemConstants.NO_ITEM);
        }
    }

    private function equipOrUseContainer(_arg_1:InteractiveItemTile):void {
        var _local_2:GameObject = _arg_1.ownerGrid.owner;
        var _local_3:Player = this.view.curPlayer;
        var _local_4:int = this.view.curPlayer.nextAvailableInventorySlot();
        if (_local_4 != -1) {
            GameServerConnection.instance.invSwap(_local_3, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, this.view.curPlayer, _local_4, ItemConstants.NO_ITEM);
        }
        else {
            GameServerConnection.instance.useItem_new(_local_2, _arg_1.tileId);
        }
    }

    private function equipOrUseInventory(_arg_1:InteractiveItemTile):void {
        var _local_2:GameObject = _arg_1.ownerGrid.owner;
        var _local_3:Player = this.view.curPlayer;
        var _local_4:int = ObjectLibrary.getMatchingSlotIndex(_arg_1.getItemId(), _local_3);
        if (_local_4 != -1) {
            GameServerConnection.instance.invSwap(_local_3, _local_2, _arg_1.tileId, _arg_1.getItemId(), _local_3, _local_4, _local_3.equipment_[_local_4]);
        }
        else {
            GameServerConnection.instance.useItem_new(_local_2, _arg_1.tileId);
        }
    }


}
}//package com.company.assembleegameclient.ui.panels.mediators
