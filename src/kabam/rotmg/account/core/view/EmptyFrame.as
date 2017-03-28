package kabam.rotmg.account.core.view {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;

public class EmptyFrame extends Sprite {

    public static const TEXT_MARGIN:int = 20;

    public var register:Signal;
    public var cancel:Signal;
    protected var modalWidth:Number;
    protected var modalHeight:Number;
    protected var closeButton:DialogCloseButton;
    protected var background:Sprite;
    protected var backgroundContainer:Sprite;
    protected var title:TextFieldDisplayConcrete;
    protected var desc:TextFieldDisplayConcrete;

    public function EmptyFrame(_arg_1:int = 288, _arg_2:int = 150, _arg_3:String = "") {
        this.modalWidth = _arg_1;
        this.modalHeight = _arg_2;
        x = ((WebMain.STAGE.stageWidth / 2) - (this.modalWidth / 2));
        y = ((WebMain.STAGE.stageHeight / 2) - (this.modalHeight / 2));
        if (_arg_3 != "") {
            this.setTitle(_arg_3, true);
        }
        if (this.background == null) {
            this.backgroundContainer = new Sprite();
            this.background = this.makeModalBackground();
            this.backgroundContainer.addChild(this.background);
            addChild(this.backgroundContainer);
        }
        if (_arg_3 != "") {
            this.setTitle(_arg_3, true);
        }
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        if (this.closeButton != null) {
            this.closeButton.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
        }
    }

    public function setWidth(_arg_1:Number):void {
        this.modalWidth = _arg_1;
        x = ((WebMain.STAGE.stageWidth / 2) - (this.modalWidth / 2));
        this.refreshBackground();
    }

    public function setHeight(_arg_1:Number):void {
        this.modalHeight = _arg_1;
        y = ((WebMain.STAGE.stageHeight / 2) - (this.modalHeight / 2));
        this.refreshBackground();
    }

    public function setTitle(_arg_1:String, _arg_2:Boolean):void {
        if (((!((this.title == null))) && (!((this.title.parent == null))))) {
            removeChild(this.title);
        }
        if (_arg_1 != null) {
            this.title = this.getText(_arg_1, TEXT_MARGIN, 5, _arg_2);
            addChild(this.title);
        }
        else {
            this.title = null;
        }
    }

    public function setDesc(_arg_1:String, _arg_2:Boolean):void {
        if (_arg_1 != null) {
            if (((!((this.desc == null))) && (!((this.desc.parent == null))))) {
                removeChild(this.desc);
            }
            this.desc = this.getText(_arg_1, TEXT_MARGIN, 50, _arg_2);
            addChild(this.desc);
        }
    }

    public function setCloseButton(_arg_1:Boolean):void {
        if ((((this.closeButton == null)) && (_arg_1))) {
            this.closeButton = PetsViewAssetFactory.returnCloseButton(this.modalWidth);
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseClick);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            addChild(this.closeButton);
        }
        else {
            if (((!((this.closeButton == null))) && (!(_arg_1)))) {
                removeChild(this.closeButton);
                this.closeButton = null;
            }
        }
    }

    protected function getText(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean):TextFieldDisplayConcrete {
        var _local_5:TextFieldDisplayConcrete;
        _local_5 = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth((this.modalWidth - (TEXT_MARGIN * 2)));
        _local_5.setBold(true);
        if (_arg_4) {
            _local_5.setStringBuilder(new StaticStringBuilder(_arg_1));
        }
        else {
            _local_5.setStringBuilder(new LineBuilder().setParams(_arg_1));
        }
        _local_5.setWordWrap(true);
        _local_5.setMultiLine(true);
        _local_5.setAutoSize(TextFieldAutoSize.CENTER);
        _local_5.setHorizontalAlign(TextFormatAlign.CENTER);
        _local_5.filters = [new DropShadowFilter(0, 0, 0)];
        _local_5.x = _arg_2;
        _local_5.y = _arg_3;
        return (_local_5);
    }

    protected function makeModalBackground():Sprite {
        x = ((WebMain.STAGE.stageWidth / 2) - (this.modalWidth / 2));
        y = ((WebMain.STAGE.stageHeight / 2) - (this.modalHeight / 2));
        var _local_1:PopupWindowBackground = new PopupWindowBackground();
        _local_1.draw(this.modalWidth, this.modalHeight, PopupWindowBackground.TYPE_DEFAULT_GREY);
        if (this.title != null) {
            _local_1.divide(PopupWindowBackground.HORIZONTAL_DIVISION, 30);
        }
        return (_local_1);
    }

    public function alignAssets():void {
        this.desc.setTextWidth((this.modalWidth - (TEXT_MARGIN * 2)));
        this.title.setTextWidth((this.modalWidth - (TEXT_MARGIN * 2)));
    }

    protected function refreshBackground():void {
        this.backgroundContainer.removeChild(this.background);
        this.background = this.makeModalBackground();
        this.backgroundContainer.addChild(this.background);
    }

    public function onCloseClick(_arg_1:MouseEvent):void {
    }


}
}//package kabam.rotmg.account.core.view
