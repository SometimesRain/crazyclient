package com.company.assembleegameclient.ui.panels.itemgrids {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.objects.Container;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.EquipmentTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.events.MouseEvent;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class ItemGrid extends Panel {

    private static const NO_CUT:Array = [0, 0, 0, 0];
    private static const CutsByNum:Object = {
        "1": [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0]], //equipment
        "2": [[1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]], //inventory
        "3": [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0], [1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]], //both
        "4": [[1, 0, 0, 1], NO_CUT, NO_CUT, [0, 1, 1, 0], [1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0], [1, 0, 0, 0], NO_CUT, NO_CUT, [0, 1, 0, 0], [0, 0, 0, 1], NO_CUT, NO_CUT, [0, 0, 1, 0]] //equips+inv+bp
    };

    private const padding:uint = 4;
    private const rowLength:uint = 4;
    public const addToolTip:Signal = new Signal(ToolTip);

    public var owner:GameObject;
    private var tooltip:ToolTip;
    private var tooltipFocusTile:ItemTile;
    public var curPlayer:Player;
    protected var indexOffset:int;
    public var interactive:Boolean;

    public function ItemGrid(_arg_1:GameObject, _arg_2:Player, _arg_3:int) {
        super(null);
        this.owner = _arg_1;
        this.curPlayer = _arg_2;
        this.indexOffset = _arg_3;
        var _local_4:Container = (_arg_1 as Container);
        if ((((_arg_1 == _arg_2)) || (_local_4))) {
            this.interactive = true;
        }
    }

    public function hideTooltip():void {
        if (this.tooltip) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.tooltipFocusTile = null;
        }
    }

    public function refreshTooltip():void {
        if (((((!(stage)) || (!(this.tooltip)))) || (!(this.tooltip.stage)))) {
            return;
        }
        if (this.tooltipFocusTile) {
            this.tooltip.detachFromTarget();
            this.tooltip = null;
            this.addToolTipToTile(this.tooltipFocusTile);
        }
    }

    private function onTileHover(_arg_1:MouseEvent):void {
        if (!stage) {
            return;
        }
        var _local_2:ItemTile = (_arg_1.currentTarget as ItemTile);
        this.addToolTipToTile(_local_2);
        this.tooltipFocusTile = _local_2;
    }

    private function addToolTipToTile(_arg_1:ItemTile):void {
        var _local_2:String;
        if (_arg_1.itemSprite.itemId > 0) {
            this.tooltip = new EquipmentToolTip(_arg_1.itemSprite.itemId, this.curPlayer, ((this.owner) ? this.owner.objectType_ : -1), this.getCharacterType());
        }
        else {
            if ((_arg_1 is EquipmentTile)) {
                _local_2 = ItemConstants.itemTypeToName((_arg_1 as EquipmentTile).itemType);
            }
            else {
                _local_2 = TextKey.ITEM;
            }
            this.tooltip = new TextToolTip(0x363636, 0x9B9B9B, null, TextKey.ITEM_EMPTY_SLOT, 200, {"itemType": TextKey.wrapForTokenResolution(_local_2)});
        }
        this.tooltip.attachToTarget(_arg_1);
        this.addToolTip.dispatch(this.tooltip);
    }

    private function getCharacterType():String {
        if (this.owner == this.curPlayer) {
            return (InventoryOwnerTypes.CURRENT_PLAYER);
        }
        if ((this.owner is Player)) {
            return (InventoryOwnerTypes.OTHER_PLAYER);
        }
        return (InventoryOwnerTypes.NPC);
    }

    protected function addToGrid(_arg_1:ItemTile, _arg_2:uint, _arg_3:uint):void {
        _arg_1.drawBackground(CutsByNum[_arg_2][_arg_3]);
        _arg_1.addEventListener(MouseEvent.ROLL_OVER, this.onTileHover);
        _arg_1.x = (int((_arg_3 % this.rowLength)) * (ItemTile.WIDTH + this.padding));
        _arg_1.y = (int((_arg_3 / this.rowLength)) * (ItemTile.HEIGHT + this.padding));
        addChild(_arg_1);
    }

    public function setItems(_arg_1:Vector.<int>, _arg_2:int = 0):void {
    }

    public function enableInteraction(_arg_1:Boolean):void {
        mouseEnabled = _arg_1;
    }

    override public function draw():void {
        this.setItems(this.owner.equipment_, this.indexOffset);
    }


}
}//package com.company.assembleegameclient.ui.panels.itemgrids
