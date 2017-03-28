package kabam.rotmg.pets.view.components.slot {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.DisplayHierarchy;
import com.company.util.MoreColorUtil;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.geom.ColorTransform;

import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.pets.view.FeedPetView;
import kabam.rotmg.pets.view.FusePetView;
import kabam.rotmg.questrewards.components.ModalItemSlot;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class FoodFeedFuseSlot extends FeedFuseSlot {

    public const foodLoaded:Signal = new Signal(int);
    public const foodUnloaded:Signal = new Signal();

    public var processing:Boolean = false;
    private var cancelCallback:Function;
    protected var grayscaleMatrix:ColorMatrixFilter;
    public var empty:Boolean = true;

    public function FoodFeedFuseSlot() {
        this.grayscaleMatrix = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
        super();
        itemSprite.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.updateTitle();
    }

    public function setProcessing(_arg_1:Boolean):void {
        var _local_2:ColorTransform;
        if (this.processing != _arg_1) {
            this.processing = _arg_1;
            itemSprite.filters = ((_arg_1) ? [this.grayscaleMatrix] : []);
            _local_2 = ((_arg_1) ? MoreColorUtil.darkCT : new ColorTransform());
            itemSprite.transform.colorTransform = _local_2;
        }
    }

    override protected function onRemovedFromStage(_arg_1:Event):void {
        super.onRemovedFromStage(_arg_1);
        this.clearAndCallCancel();
    }

    public function setItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Function):void {
        if (this.itemId != _arg_1) {
            this.clearAndCallCancel();
            this.itemId = _arg_1;
            this.slotId = _arg_2;
            this.objectId = _arg_3;
            itemBitmap.bitmapData = ObjectLibrary.getRedrawnTextureFromType(_arg_1, 80, true);
            alignBitmapInBox();
            this.updateTitle();
            this.cancelCallback = _arg_4;
        }
    }

    public function setItemPart2(_arg_1:int):void {
        this.foodLoaded.dispatch(_arg_1);
    }

    public function updateTitle():void {
        var _local_1:XML;
        var _local_2:String;
        if (((itemId) && (!((itemId == -1))))) {
            setTitle(TextKey.PETORFOODSLOT_ITEM_POWER, {});
            _local_1 = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(itemId));
            _local_2 = ((_local_1.hasOwnProperty("feedPower")) ? _local_1.feedPower : "0");
            setSubtitle(TextKey.BLANK, {"data": _local_2});
        }
        else {
            setTitle(TextKey.PETORFOODSLOT_PLACE_ITEM, {});
            setSubtitle(TextKey.BLANK, {"data": ""});
        }
    }

    public function setCancelCallback(_arg_1:Function):void {
        this.cancelCallback = _arg_1;
    }

    public function clearItem():void {
        this.clearAndCallCancel();
        itemId = ItemConstants.NO_ITEM;
        itemBitmap.bitmapData = null;
        slotId = -1;
        objectId = -1;
        this.updateTitle();
    }

    private function clearAndCallCancel():void {
        ((this.cancelCallback) && (this.cancelCallback()));
        this.cancelCallback = null;
    }

    private function alignBitmapOnMouse(_arg_1:int, _arg_2:int):void {
        itemBitmap.x = (-(itemBitmap.width) / 2);
        itemBitmap.y = (-(itemBitmap.height) / 2);
        itemSprite.x = _arg_1;
        itemSprite.y = _arg_2;
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        if (!this.processing) {
            this.alignBitmapOnMouse(_arg_1.stageX, _arg_1.stageY);
            itemSprite.startDrag(true);
            itemSprite.addEventListener(MouseEvent.MOUSE_UP, this.endDrag);
            if (((!((itemSprite.parent == null))) && (!((itemSprite.parent == stage))))) {
                removeChild(itemSprite);
                stage.addChild(itemSprite);
            }
        }
    }

    private function endDrag(_arg_1:MouseEvent):void {
        itemSprite.stopDrag();
        itemSprite.removeEventListener(MouseEvent.MOUSE_UP, this.endDrag);
        stage.removeChild(itemSprite);
        addChild(itemSprite);
        alignBitmapInBox();
        var _local_2:* = DisplayHierarchy.getParentWithTypeArray(itemSprite.dropTarget, FeedPetView, FusePetView, ModalItemSlot);
        if (((((!((_local_2 is FeedPetView))) && (!((_local_2 is FusePetView))))) && (!((((_local_2 is ModalItemSlot)) && (((_local_2 as ModalItemSlot).interactable == true))))))) {
            this.empty = true;
            itemId = ItemConstants.NO_ITEM;
            itemBitmap.bitmapData = null;
            this.clearAndCallCancel();
            this.foodUnloaded.dispatch();
            this.updateTitle();
        }
    }


}
}//package kabam.rotmg.pets.view.components.slot
