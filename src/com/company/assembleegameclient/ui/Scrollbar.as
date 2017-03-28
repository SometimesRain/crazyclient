package com.company.assembleegameclient.ui {
import com.company.util.GraphicsUtil;

import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;
import flash.utils.getTimer;

public class Scrollbar extends Sprite {

    private var width_:int;
    private var height_:int;
    private var speed_:Number;
    private var indicatorRect_:Rectangle;
    private var jumpDist_:Number;
    private var background_:Sprite;
    private var upArrow_:Sprite;
    private var downArrow_:Sprite;
    private var posIndicator_:Sprite;
    private var target_:Sprite;
    private var lastUpdateTime_:int;
    private var change_:Number;
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[
        backgroundFill_, path_, GraphicsUtil.END_FILL
    ];

    public function Scrollbar(_arg_1:int, _arg_2:int, _arg_3:Number = 1, _arg_4:Sprite = null) {
        super();
        this.target_ = _arg_4;
        this.background_ = new Sprite();
        this.background_.addEventListener(MouseEvent.MOUSE_DOWN, this.onBackgroundDown);
        addChild(this.background_);
        this.upArrow_ = this.getSprite(this.onUpArrowDown);
        addChild(this.upArrow_);
        this.downArrow_ = this.getSprite(this.onDownArrowDown);
        addChild(this.downArrow_);
        this.posIndicator_ = this.getSprite(this.onStartIndicatorDrag);
        addChild(this.posIndicator_);
        this.resize(_arg_1, _arg_2, _arg_3);
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    private static function drawArrow(_arg_1:int, _arg_2:int, _arg_3:Graphics):void {
        _arg_3.clear();
        _arg_3.beginFill(0x353535, 0.01);
        _arg_3.drawRect((-(_arg_1) / 2), (-(_arg_2) / 2), _arg_1, _arg_2);
        _arg_3.endFill();
        _arg_3.beginFill(0xFFFFFF, 1);
        _arg_3.moveTo((-(_arg_1) / 2), (-(_arg_2) / 2));
        _arg_3.lineTo((_arg_1 / 2), 0);
        _arg_3.lineTo((-(_arg_1) / 2), (_arg_2 / 2));
        _arg_3.lineTo((-(_arg_1) / 2), (-(_arg_2) / 2));
        _arg_3.endFill();
    }


    public function pos():Number {
        return (((this.posIndicator_.y - this.indicatorRect_.y) / (this.indicatorRect_.height - this.posIndicator_.height)));
    }

    public function setIndicatorSize(_arg_1:Number, _arg_2:Number, _arg_3:Boolean = true):void {
        var _local_4:int = (((_arg_2 == 0)) ? this.indicatorRect_.height : ((_arg_1 / _arg_2) * this.indicatorRect_.height));
        _local_4 = Math.min(this.indicatorRect_.height, Math.max(this.width_, _local_4));
        this.drawIndicator(this.width_, _local_4, this.posIndicator_.graphics);
        this.jumpDist_ = ((_arg_1 / (_arg_2 - _arg_1)) * 0.33);
        if (_arg_3) {
            this.setPos(0);
        }
    }

    public function setPos(_arg_1:Number):void {
        _arg_1 = Math.max(0, Math.min(1, _arg_1));
        this.posIndicator_.y = ((_arg_1 * (this.indicatorRect_.height - this.posIndicator_.height)) + this.indicatorRect_.y);
        this.sendPos();
    }

    public function jumpUp():void {
        this.setPos((this.pos() - this.jumpDist_));
    }

    public function jumpDown():void {
        this.setPos((this.pos() + this.jumpDist_));
    }

    private function getSprite(_arg_1:Function):Sprite {
        var _local_2:Sprite = new Sprite();
        _local_2.addEventListener(MouseEvent.MOUSE_DOWN, _arg_1);
        _local_2.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
        _local_2.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        return (_local_2);
    }

    private function onRollOver(_arg_1:MouseEvent):void {
        var _local_2:Sprite = (_arg_1.target as Sprite);
        _local_2.transform.colorTransform = new ColorTransform(1, 0.8627, 0.5216);
    }

    private function onRollOut(_arg_1:MouseEvent):void {
        var _local_2:Sprite = (_arg_1.target as Sprite);
        _local_2.transform.colorTransform = new ColorTransform(1, 1, 1);
    }

    private function onBackgroundDown(_arg_1:MouseEvent):void {
        if (_arg_1.localY < this.posIndicator_.y) {
            this.jumpUp();
        }
        else {
            this.jumpDown();
        }
    }

    protected function onAddedToStage(_arg_1:Event):void {
        if (this.target_ != null) {
            this.target_.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        }
        else {
            if (parent) {
                parent.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
            else {
                WebMain.STAGE.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
        }
    }

    protected function onRemovedFromStage(_arg_1:Event):void {
        if (this.target_ != null) {
            this.target_.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
        }
        else {
            if (parent) {
                parent.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
            else {
                WebMain.STAGE.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
        }
        removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    protected function onMouseWheel(_arg_1:MouseEvent):void {
        if (_arg_1.delta > 0) {
            this.jumpUp();
        }
        else {
            if (_arg_1.delta < 0) {
                this.jumpDown();
            }
        }
    }

    private function onUpArrowDown(_arg_1:MouseEvent):void {
        addEventListener(Event.ENTER_FRAME, this.onArrowFrame);
        addEventListener(MouseEvent.MOUSE_UP, this.onArrowUp);
        this.lastUpdateTime_ = getTimer();
        this.change_ = -(this.speed_);
    }

    private function onDownArrowDown(_arg_1:MouseEvent):void {
        addEventListener(Event.ENTER_FRAME, this.onArrowFrame);
        addEventListener(MouseEvent.MOUSE_UP, this.onArrowUp);
        this.lastUpdateTime_ = getTimer();
        this.change_ = this.speed_;
    }

    private function onArrowFrame(_arg_1:Event):void {
        var _local_2:int = getTimer();
        var _local_3:Number = ((_local_2 - this.lastUpdateTime_) / 1000);
        var _local_4:Number = (((this.height_ - (this.width_ * 3)) * _local_3) * this.change_);
        this.setPos((((this.posIndicator_.y + _local_4) - this.indicatorRect_.y) / (this.indicatorRect_.height - this.posIndicator_.height)));
        this.lastUpdateTime_ = _local_2;
    }

    private function onArrowUp(_arg_1:Event):void {
        removeEventListener(Event.ENTER_FRAME, this.onArrowFrame);
        removeEventListener(MouseEvent.MOUSE_UP, this.onArrowUp);
    }

    private function onStartIndicatorDrag(_arg_1:MouseEvent):void {
        this.posIndicator_.startDrag(false, new Rectangle(0, this.indicatorRect_.y, 0, (this.indicatorRect_.height - this.posIndicator_.height)));
        stage.addEventListener(MouseEvent.MOUSE_UP, this.onStopIndicatorDrag);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onDragMove);
        this.sendPos();
    }

    private function onStopIndicatorDrag(_arg_1:MouseEvent):void {
        stage.removeEventListener(MouseEvent.MOUSE_UP, this.onStopIndicatorDrag);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDragMove);
        this.posIndicator_.stopDrag();
        this.sendPos();
    }

    private function onDragMove(_arg_1:MouseEvent):void {
        this.sendPos();
    }

    private function sendPos():void {
        dispatchEvent(new Event(Event.CHANGE));
    }

    public function resize(_arg_1:int, _arg_2:int, _arg_3:Number = 1):void {
        this.width_ = _arg_1;
        this.height_ = _arg_2;
        this.speed_ = _arg_3;
        var _local_4:int = (this.width_ * 0.75);
        this.indicatorRect_ = new Rectangle(0, (_local_4 + 5), this.width_, ((this.height_ - (_local_4 * 2)) - 10));
        var _local_5:Graphics = this.background_.graphics;
        _local_5.clear();
        _local_5.beginFill(0x545454, 1);
        _local_5.drawRect(this.indicatorRect_.x, this.indicatorRect_.y, this.indicatorRect_.width, this.indicatorRect_.height);
        _local_5.endFill();
        drawArrow(_local_4, this.width_, this.upArrow_.graphics);
        this.upArrow_.rotation = -90;
        this.upArrow_.x = (this.width_ / 2);
        this.upArrow_.y = (_local_4 / 2);
        drawArrow(_local_4, this.width_, this.downArrow_.graphics);
        this.downArrow_.x = (this.width_ / 2);
        this.downArrow_.y = (this.height_ - (_local_4 / 2));
        this.downArrow_.rotation = 90;
        this.drawIndicator(this.width_, this.height_, this.posIndicator_.graphics);
        this.posIndicator_.x = 0;
        this.posIndicator_.y = this.indicatorRect_.y;
    }

    private function drawIndicator(_arg_1:int, _arg_2:int, _arg_3:Graphics):void {
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(0, 0, _arg_1, _arg_2, 4, [1, 1, 1, 1], this.path_);
        _arg_3.clear();
        _arg_3.drawGraphicsData(this.graphicsData_);
    }


}
}//package com.company.assembleegameclient.ui
