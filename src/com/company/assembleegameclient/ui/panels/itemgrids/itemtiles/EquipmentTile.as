package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.util.AssetLibrary;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.filters.ColorMatrixFilter;

import kabam.rotmg.constants.ItemConstants;

public class EquipmentTile extends InteractiveItemTile {

    private static const greyColorFilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(0x363636));

    public var backgroundDetail:Bitmap;
    public var itemType:int;
    private var minManaUsage:int;

    public function EquipmentTile(_arg_1:int, _arg_2:ItemGrid, _arg_3:Boolean) {
        super(_arg_1, _arg_2, _arg_3);
    }

    override public function canHoldItem(_arg_1:int):Boolean {
        return ((((_arg_1 <= 0)) || ((this.itemType == ObjectLibrary.getSlotTypeFromType(_arg_1)))));
    }

    public function setType(_arg_1:int):void {
        var _local_2:BitmapData;
        var _local_3:int;
        var _local_4:int;
        switch (_arg_1) {
            case ItemConstants.ALL_TYPE:
                break;
            case ItemConstants.SWORD_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 48);
                break;
            case ItemConstants.DAGGER_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 96);
                break;
            case ItemConstants.BOW_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 80);
                break;
            case ItemConstants.TOME_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 80);
                break;
            case ItemConstants.SHIELD_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 112);
                break;
            case ItemConstants.LEATHER_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 0);
                break;
            case ItemConstants.PLATE_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 32);
                break;
            case ItemConstants.WAND_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 64);
                break;
            case ItemConstants.RING_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj", 44);
                break;
            case ItemConstants.SPELL_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 64);
                break;
            case ItemConstants.SEAL_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 160);
                break;
            case ItemConstants.CLOAK_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 32);
                break;
            case ItemConstants.ROBE_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 16);
                break;
            case ItemConstants.QUIVER_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 48);
                break;
            case ItemConstants.HELM_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 96);
                break;
            case ItemConstants.STAFF_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj5", 112);
                break;
            case ItemConstants.POISON_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 128);
                break;
            case ItemConstants.SKULL_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 0);
                break;
            case ItemConstants.TRAP_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 16);
                break;
            case ItemConstants.ORB_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 144);
                break;
            case ItemConstants.PRISM_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 176);
                break;
            case ItemConstants.SCEPTER_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj6", 192);
                break;
            case ItemConstants.KATANA_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj3", 540);
                break;
            case ItemConstants.SHURIKEN_TYPE:
                _local_2 = AssetLibrary.getImageFromSet("lofiObj3", 555);
                break;
        }
        if (_local_2 != null) {
            this.backgroundDetail = new Bitmap(_local_2);
            this.backgroundDetail.x = BORDER;
            this.backgroundDetail.y = BORDER;
            this.backgroundDetail.scaleX = 4;
            this.backgroundDetail.scaleY = 4;
            this.backgroundDetail.filters = [greyColorFilter];
            addChildAt(this.backgroundDetail, 0);
        }
        this.itemType = _arg_1;
    }

    override public function setItem(_arg_1:int):Boolean {
        var _local_2:Boolean = super.setItem(_arg_1);
        if (_local_2) {
			if (backgroundDetail != null) {
				this.backgroundDetail.visible = (itemSprite.itemId <= 0); //ngdetail = null, ERROR
			}
            this.updateMinMana();
        }
        return (_local_2);
    }

    private function updateMinMana():void {
        var _local_1:XML;
        this.minManaUsage = 0;
        if (itemSprite.itemId > 0) {
            _local_1 = ObjectLibrary.xmlLibrary_[itemSprite.itemId];
            if (((_local_1) && (_local_1.hasOwnProperty("Usable")))) {
                if (_local_1.hasOwnProperty("MultiPhase")) {
                    this.minManaUsage = _local_1.MpEndCost;
                }
                else {
                    this.minManaUsage = _local_1.MpCost;
                }
            }
        }
    }

    public function updateDim(_arg_1:Player):void {
        itemSprite.setDim(((_arg_1) && ((_arg_1.mp_ < this.minManaUsage))));
    }

    override protected function beginDragCallback():void {
        this.backgroundDetail.visible = true;
    }

    override protected function endDragCallback():void {
        this.backgroundDetail.visible = (itemSprite.itemId <= 0);
    }

    override protected function getBackgroundColor():int {
        //return 0x454545;
        return 0x545454;
    }


}
}//package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles
