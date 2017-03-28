package com.company.assembleegameclient.ui.options {
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.Graphics;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

public class ChoiceBox extends Sprite {

    public static const WIDTH:int = 80;
    public static const HEIGHT:int = 32;
    public var labels_:Vector.<StringBuilder>;
    public var values_:Array;
    public var selectedIndex_:int = -1;
    public var labelText_:TextFieldDisplayConcrete;
    private var over_:Boolean = false;
    private var color:Number = 0xFFFFFF;
    private var showRed:Boolean = false;
    private var internalFill_:GraphicsSolidFill = new GraphicsSolidFill(0x333333, 1);
    private var overLineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xB3B3B3, 1);
    private var normalLineFill_:GraphicsSolidFill = new GraphicsSolidFill(0x444444, 1);
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(
            2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, normalLineFill_
    );
    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[
        internalFill_, lineStyle_, path_, GraphicsUtil.END_STROKE, GraphicsUtil.END_FILL
    ];

    public function ChoiceBox(_arg_1:Vector.<StringBuilder>, _arg_2:Array, _arg_3:Object, _arg_4:Number = 0xFFFFFF, showRed_:Boolean = false) {
        super();
        this.color = _arg_4;
		this.showRed = showRed_;
        this.labels_ = _arg_1;
        this.values_ = _arg_2;
        this.labelText_ = new TextFieldDisplayConcrete().setSize(16).setColor(color);
        this.labelText_.x = (WIDTH / 2);
        this.labelText_.y = (HEIGHT / 2);
        this.labelText_.setAutoSize(TextFieldAutoSize.CENTER).setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.labelText_.setBold(true);
        this.labelText_.filters = [new DropShadowFilter(0, 0, 0, 1, 4, 4, 2)];
        addChild(this.labelText_);
        this.setValue(_arg_3);
        addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
        addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
        addEventListener(MouseEvent.CLICK, this.onClick);
    }

    public function setValue(_arg_1:*, _arg_2:Boolean = true):void {
        var _local_3:int;
        while (_local_3 < this.values_.length) {
            if (_arg_1 == this.values_[_local_3]) {
                if (_local_3 == this.selectedIndex_) {
                    return;
                }
                this.selectedIndex_ = _local_3;
                break;
            }
            _local_3++;
        }
        this.setSelected(this.selectedIndex_);
        if (_arg_2) {
            dispatchEvent(new Event(Event.CHANGE));
        }
    }

    public function value():Object {
        return (this.values_[this.selectedIndex_]);
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.over_ = true;
        this.drawBackground();
    }

    private function onRollOut(_arg_1:MouseEvent):void {
        this.over_ = false;
        this.drawBackground();
    }

    private function onClick(_arg_1:MouseEvent):void {
        this.setSelected(((this.selectedIndex_ + 1) % this.values_.length));
		if (showRed) {
			color = color == 0xFFFFFF ? 0xFF0000 : 0xFFFFFF; //color hack
			labelText_.setColor(color);
		}
        dispatchEvent(new Event(Event.CHANGE));
    }

    private function drawBackground():void {
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(0, 0, WIDTH, HEIGHT, 4, [1, 1, 1, 1], this.path_);
        this.lineStyle_.fill = ((this.over_) ? this.overLineFill_ : this.normalLineFill_);
        graphics.drawGraphicsData(this.graphicsData_);
        var _local_1:Graphics = graphics;
        _local_1.clear();
        _local_1.drawGraphicsData(this.graphicsData_);
    }

    private function setSelected(_arg_1:int):void {
        this.selectedIndex_ = _arg_1;
        if ((((this.selectedIndex_ < 0)) || ((this.selectedIndex_ >= this.labels_.length)))) {
            this.selectedIndex_ = 0;
        }
        this.setText(this.labels_[this.selectedIndex_]);
    }

    private function setText(_arg_1:StringBuilder):void {
        this.labelText_.setStringBuilder(_arg_1);
        this.drawBackground();
    }


}
}//package com.company.assembleegameclient.ui.options
