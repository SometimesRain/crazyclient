package com.company.assembleegameclient.mapeditor {
import com.company.assembleegameclient.ui.Scrollbar;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Chooser extends Sprite {

    public static const WIDTH:int = 136;
    public static const HEIGHT:int = 430;
    private static const SCROLLBAR_WIDTH:int = 20;
    public var layer_:int;
    public var selected_:Element;
    protected var elementSprite_:Sprite;
    protected var scrollBar_:Scrollbar;
    private var mask_:Shape;
    private var elements_:Vector.<Element> = new Vector.<Element>();
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(
            1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_
    );
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[
        lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE
    ];

    public function Chooser(_arg_1:int) {
        super();
        this.layer_ = _arg_1;
        this.drawBackground();
        this.elementSprite_ = new Sprite();
        this.elementSprite_.x = 4;
        this.elementSprite_.y = 6;
        addChild(this.elementSprite_);
        this.scrollBar_ = new Scrollbar(SCROLLBAR_WIDTH, (HEIGHT - 8), 0.1, this);
        this.scrollBar_.x = ((WIDTH - SCROLLBAR_WIDTH) - 6);
        this.scrollBar_.y = 4;
        this.scrollBar_.addEventListener(Event.CHANGE, this.onScrollBarChange);
        var _local_2:Shape = new Shape();
        _local_2.graphics.beginFill(0);
        _local_2.graphics.drawRect(0, 2, ((Chooser.WIDTH - SCROLLBAR_WIDTH) - 4), (Chooser.HEIGHT - 4));
        addChild(_local_2);
        this.elementSprite_.mask = _local_2;
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    public function selectedType():int {
        return (this.selected_.type_);
    }

    public function setSelectedType(_arg_1:int):void {
        var _local_2:Element;
        for each (_local_2 in this.elements_) {
            if (_local_2.type_ == _arg_1) {
                this.setSelected(_local_2);
                return;
            }
        }
    }

    protected function addElement(_arg_1:Element):void {
        var _local_2:int;
        _local_2 = this.elements_.length;
        _arg_1.x = ((((_local_2 % 2)) == 0) ? 0 : (2 + Element.WIDTH));
        _arg_1.y = ((int((_local_2 / 2)) * Element.HEIGHT) + 6);
        this.elementSprite_.addChild(_arg_1);
        if (_local_2 == 0) {
            this.setSelected(_arg_1);
        }
        _arg_1.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        this.elements_.push(_arg_1);
    }

    protected function removeElements():void
    {
        this.elements_ = new Vector.<Element>();
        removeChild(this.elementSprite_);
        this.elementSprite_ = new Sprite();
        this.elementSprite_.x = 4;
        this.elementSprite_.y = 6;
        var _local_1:Shape = new Shape();
        _local_1.graphics.beginFill(0);
        _local_1.graphics.drawRect(0, 2, Chooser.WIDTH - SCROLLBAR_WIDTH - 4, Chooser.HEIGHT - 4);
        addChild(_local_1);
        this.elementSprite_.mask = _local_1;
        addChild(this.elementSprite_);
    }

    protected function onMouseDown(_arg_1:MouseEvent):void {
        var _local_2:Element = (_arg_1.currentTarget as Element);
        this.setSelected(_local_2);
    }

    protected function setSelected(_arg_1:Element):void {
        if (this.selected_ != null) {
            this.selected_.setSelected(false);
        }
        this.selected_ = _arg_1;
        this.selected_.setSelected(true);
    }

    protected function onScrollBarChange(_arg_1:Event):void {
        this.elementSprite_.y = (6 - (this.scrollBar_.pos() * ((this.elementSprite_.height + 12) - HEIGHT)));
    }

    protected function onAddedToStage(_arg_1:Event):void {
        this.scrollBar_.setIndicatorSize(HEIGHT, this.elementSprite_.height);
        addChild(this.scrollBar_);
    }

    protected function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
    }

    private function drawBackground():void {
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, [1, 1, 1, 1], this.path_);
        graphics.drawGraphicsData(this.graphicsData_);
    }


}
}//package com.company.assembleegameclient.mapeditor
