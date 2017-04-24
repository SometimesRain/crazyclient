package kabam.rotmg.mysterybox.components {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormatAlign;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
import kabam.rotmg.mysterybox.services.MysteryBoxModel;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.DialogCloseButton;
import kabam.rotmg.pets.view.components.PopupWindowBackground;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

import org.swiftsuspenders.Injector;

public class MysteryBoxSelectModal extends Sprite {

    public static var modalWidth:int;
    public static var modalHeight:int;
    public static var aMysteryBoxHeight:int;
    public static const TEXT_MARGIN:int = 20;
    public static var open:Boolean;
    public static var backgroundImageEmbed:Class = MysteryBoxSelectModal_backgroundImageEmbed;

    private var closeButton:DialogCloseButton;
    private var box_:Sprite;
    private var mysteryData:Object;
    private var titleString:String = "MysteryBoxSelectModal.titleString";
    private var selectEntries:Vector.<MysteryBoxSelectEntry>;


    public function MysteryBoxSelectModal():void {
        this.box_ = new Sprite();
        super();
        modalWidth = 385;
        modalHeight = 60;
        aMysteryBoxHeight = 77;
        this.selectEntries = new Vector.<MysteryBoxSelectEntry>();
        var _local_1:Injector = StaticInjectorContext.getInjector();
        var _local_2:MysteryBoxModel = _local_1.getInstance(MysteryBoxModel);
        this.mysteryData = _local_2.getBoxesOrderByWeight();
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
        addChild(this.box_);
        this.addBoxChildren();
        this.positionAndStuff();
        open = true;
    }

    public static function getRightBorderX():int {
        return ((300 + (modalWidth / 2)));
    }

    private static function makeModalBackground(_arg_1:int, _arg_2:int):PopupWindowBackground {
        var _local_3:PopupWindowBackground = new PopupWindowBackground();
        _local_3.draw(_arg_1, _arg_2, PopupWindowBackground.TYPE_TRANSPARENT_WITH_HEADER);
        return (_local_3);
    }


    public function getText(_arg_1:String, _arg_2:int, _arg_3:int):TextFieldDisplayConcrete {
        var _local_4:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(0xFFFFFF).setTextWidth((modalWidth - (TEXT_MARGIN * 2)));
        _local_4.setBold(true);
        _local_4.setStringBuilder(new LineBuilder().setParams(_arg_1));
        _local_4.setWordWrap(true);
        _local_4.setMultiLine(true);
        _local_4.setAutoSize(TextFieldAutoSize.CENTER);
        _local_4.setHorizontalAlign(TextFormatAlign.CENTER);
        _local_4.filters = [new DropShadowFilter(0, 0, 0)];
        _local_4.x = _arg_2;
        _local_4.y = _arg_3;
        return (_local_4);
    }

    private function positionAndStuff():void {
        this.box_.x = ((600 / 2) - (modalWidth / 2));
        this.box_.y = ((WebMain.STAGE.stageHeight / 2) - (modalHeight / 2));
    }

    private function addBoxChildren():void {
        var _local_1:MysteryBoxInfo;
        var _local_2:DisplayObject;
        var _local_4:Number;
        var _local_5:int;
        var _local_6:MysteryBoxSelectEntry;
        for each (_local_1 in this.mysteryData) {
            modalHeight = (modalHeight + aMysteryBoxHeight);
        }
        _local_2 = new backgroundImageEmbed();
        _local_2.width = (modalWidth + 1);
        _local_2.height = (modalHeight - 25);
        _local_2.y = 27;
        _local_2.alpha = 0.95;
        this.box_.addChild(_local_2);
        this.box_.addChild(makeModalBackground(modalWidth, modalHeight));
        this.closeButton = PetsViewAssetFactory.returnCloseButton(modalWidth);
        this.box_.addChild(this.closeButton);
        this.box_.addChild(this.getText(this.titleString, TEXT_MARGIN, 6).setSize(18));
        var _local_3:Number = 20;
        _local_4 = 50;
        _local_5 = 0;
        for each (_local_1 in this.mysteryData) {
            if (_local_5 == 6) break;
            _local_6 = new MysteryBoxSelectEntry(_local_1);
            _local_6.x = (x + _local_3);
            _local_6.y = (y + _local_4);
            _local_4 = (_local_4 + aMysteryBoxHeight);
            this.box_.addChild(_local_6);
            this.selectEntries.push(_local_6);
            _local_5++;
        }
    }

    public function updateContent():void
    {
        var _local_1:MysteryBoxSelectEntry;
        for each(_local_1 in this.selectEntries)
        {
            _local_1.updateContent();
        }
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        open = false;
    }


}
}//package kabam.rotmg.mysterybox.components
