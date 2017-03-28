package com.company.assembleegameclient.ui {
import com.adobe.images.PNGEncoder;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.net.FileReference;

public class PicView extends Sprite {

    private var bitmap_:Bitmap;
    private var saveButton_:DeprecatedTextButton;
    private var closeButton_:DeprecatedTextButton;

    public function PicView(_arg_1:BitmapData) {
        this.bitmap_ = new Bitmap(_arg_1);
        addChild(this.bitmap_);
        this.saveButton_ = new DeprecatedTextButton(16, "Save");
        addChild(this.saveButton_);
        this.closeButton_ = new DeprecatedTextButton(16, "Close");
        addChild(this.closeButton_);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private function onAddedToStage(_arg_1:Event):void {
        this.saveButton_.addEventListener(MouseEvent.CLICK, this.onSave);
        this.closeButton_.addEventListener(MouseEvent.CLICK, this.onClose);
        this.bitmap_.x = ((stage.stageHeight / 2) - (this.bitmap_.width / 2));
        this.bitmap_.y = ((stage.stageHeight / 2) - (this.bitmap_.height / 2));
        this.closeButton_.x = ((this.bitmap_.x + this.bitmap_.width) - this.closeButton_.width);
        this.closeButton_.y = ((this.bitmap_.y + this.bitmap_.height) + 10);
        this.saveButton_.x = ((this.closeButton_.x - this.saveButton_.width) - 10);
        this.saveButton_.y = ((this.bitmap_.y + this.bitmap_.height) + 10);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        this.saveButton_.removeEventListener(MouseEvent.CLICK, this.onSave);
        this.closeButton_.removeEventListener(MouseEvent.CLICK, this.onClose);
    }

    private function onSave(_arg_1:Event):void {
        new FileReference().save(PNGEncoder.encode(this.bitmap_.bitmapData), "map.png");
    }

    private function onClose(_arg_1:Event):void {
        if (parent != null) {
            parent.removeChild(this);
        }
    }


}
}//package com.company.assembleegameclient.ui
