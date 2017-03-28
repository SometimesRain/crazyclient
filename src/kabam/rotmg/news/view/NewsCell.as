package kabam.rotmg.news.view {
import flash.display.Loader;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.net.URLRequest;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.news.model.NewsCellVO;
import kabam.rotmg.text.view.TextDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;
import org.swiftsuspenders.Injector;

public class NewsCell extends Sprite {

    private static var DefaultGraphicLarge:Class = NewsCell_DefaultGraphicLarge;
    private static var DefaultGraphicSmall:Class = NewsCell_DefaultGraphicSmall;
    private static const BOX_HEIGHT:uint = 30;
    private static const LARGE:String = "LARGE";
    private static const SMALL:String = "SMALL";

    private var imageContainer:Sprite;
    private var maskShape:Shape;
    private var boxShape:Shape;
    private var textField:TextFieldDisplayConcrete;
    private var size:String;
    private var w:Number;
    private var h:Number;
    private var _vo:NewsCellVO;
    private var _loader:Loader;
    private var textSize:uint = 18;
    public var clickSignal:Signal;
    private var injector:Injector;

    public function NewsCell(_arg_1:Number, _arg_2:Number) {
        this.clickSignal = new Signal(NewsCellVO);
        super();
        this.injector = StaticInjectorContext.getInjector();
        this.setSize(_arg_1, _arg_2);
        this.initImageContainer();
        this.initMask();
        this.initBox();
    }

    private function setSize(_arg_1:Number, _arg_2:Number):void {
        this.w = _arg_1;
        this.h = _arg_2;
        if ((((_arg_1 == 306)) && ((_arg_2 == 194)))) {
            this.size = LARGE;
        }
        else {
            if ((((_arg_1 == 151)) && ((_arg_2 == 189)))) {
                this.size = SMALL;
            }
        }
    }

    public function init(_arg_1:NewsCellVO):void {
        this._vo = _arg_1;
        this.updateTextField();
        addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        buttonMode = true;
    }

    private function addDisplayAssets():void {
        addChild((this.maskShape = new Shape()));
        addChild((this.boxShape = new Shape()));
    }

    private function initImageContainer():void {
        this.imageContainer = new Sprite();
        addChild(this.imageContainer);
    }

    private function initMask():void {
        this.maskShape = new Shape();
        this.maskShape.graphics.beginFill(0xFF00FF);
        this.maskShape.graphics.drawRect(0, 0, this.w, this.h);
        this.imageContainer.mask = this.maskShape;
        addChild(this.maskShape);
    }

    private function initBox():void {
        this.boxShape = new Shape();
        this.boxShape.graphics.beginFill(0, 0.8);
        this.boxShape.graphics.drawRect(0, (this.h - BOX_HEIGHT), this.w, BOX_HEIGHT);
        addChild(this.boxShape);
    }

    private function updateTextField():void {
        this.textField = this.injector.getInstance(TextDisplay).setSize(this.textSize).setColor(0xFFFFFF);
        addChild(this.textField);
        this.textField.setBold(true).setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.textField.setStringBuilder(new StaticStringBuilder(this._vo.headline));
        this.resizeTextField();
        this.textField.x = (this.w / 2);
        this.textField.y = (this.h - (25 / 2));
        this.textField.filters = [new DropShadowFilter(0, 0, 0)];
    }

    private function resizeTextField():void {
        if (this.textField.width > (this.w - 10)) {
            this.textSize = (this.textSize - 2);
            this.textField.setSize(this.textSize).setColor(0xFFFFFF);
            this.resizeTextField();
        }
    }

    public function load():void {
        this._loader = new Loader();
        this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
        this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onIOError);
        this._loader.load(new URLRequest(this._vo.imageURL));
    }

    private function onComplete(_arg_1:Event):void {
        this.imageContainer.addChild(this._loader);
    }

    private function onIOError(_arg_1:IOErrorEvent):void {
        switch (this.size) {
            case LARGE:
                this.imageContainer.addChild(new DefaultGraphicLarge());
                return;
            case SMALL:
                this.imageContainer.addChild(new DefaultGraphicSmall());
                return;
        }
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        this.clickSignal.dispatch(this._vo);
    }


}
}//package kabam.rotmg.news.view
