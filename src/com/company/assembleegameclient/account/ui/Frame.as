package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.ui.DeprecatedClickableText;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.DisplayObject;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.account.web.view.LabeledField;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class Frame extends Sprite {

    private static const INDENT:Number = 17;
    public var titleText_:TextFieldDisplayConcrete;
    public var leftButton_:DeprecatedClickableText;
    public var rightButton_:DeprecatedClickableText;
    public var textInputFields_:Vector.<TextInputField> = new Vector.<TextInputField>();
    public var navigationLinks_:Vector.<DeprecatedClickableText> = new Vector.<DeprecatedClickableText>();
    public var w_:int = 288;
    public var h_:int = 100;
    private var titleFill_:GraphicsSolidFill = new GraphicsSolidFill(0x4D4D4D, 1);
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0x363636, 1);
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(
            1, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_
    );
    private var path1_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private var path2_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[
        backgroundFill_,
        path2_,
        GraphicsUtil.END_FILL,
        titleFill_,
        path1_,
        GraphicsUtil.END_FILL,
        lineStyle_,
        path2_,
        GraphicsUtil.END_STROKE
    ];

    public function Frame(_arg_1:String, _arg_2:String = "", _arg_3:String = "", _arg_5:int = 288) {
        super();
        this.w_ = _arg_5;
        this.titleText_ = new TextFieldDisplayConcrete().setSize(13).setColor(0xB3B3B3);
        this.titleText_.setStringBuilder(new LineBuilder().setParams(_arg_1));
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0)];
        this.titleText_.x = 5;
        this.titleText_.y = 3;
        this.titleText_.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(this.titleText_);
        this.makeAndAddLeftButton(_arg_2);
        this.makeAndAddRightButton(_arg_3);
        filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
    }

    private function makeAndAddLeftButton(_arg_1:String):void {
        this.leftButton_ = new DeprecatedClickableText(18, true, _arg_1);
        if (_arg_1 != "") {
            this.leftButton_.buttonMode = true;
            this.leftButton_.x = 109;
            addChild(this.leftButton_);
        }
    }

    private function makeAndAddRightButton(_arg_1:String):void {
        this.rightButton_ = new DeprecatedClickableText(18, true, _arg_1);
        if (_arg_1 != "") {
            this.rightButton_.buttonMode = true;
            this.rightButton_.x = ((this.w_ - this.rightButton_.width) - 26);
            this.rightButton_.setAutoSize(TextFieldAutoSize.RIGHT);
            addChild(this.rightButton_);
        }
    }

    public function addLabeledField(_arg_1:LabeledField):void {
        addChild(_arg_1);
        _arg_1.y = (this.h_ - 60);
        _arg_1.x = 17;
        this.h_ = (this.h_ + _arg_1.getHeight());
    }

    public function addTextInputField(_arg_1:TextInputField):void {
        this.textInputFields_.push(_arg_1);
        addChild(_arg_1);
        _arg_1.y = (this.h_ - 60);
        _arg_1.x = 17;
        this.h_ += _arg_1.height;
    }

    public function addNavigationText(_arg_1:DeprecatedClickableText):void {
        this.navigationLinks_.push(_arg_1);
        _arg_1.x = INDENT;
        addChild(_arg_1);
        this.positionText(_arg_1);
    }

    public function addComponent(_arg_1:DisplayObject, _arg_2:int = 8):void {
        addChild(_arg_1);
        _arg_1.y = (this.h_ - 66);
        _arg_1.x = _arg_2;
        this.h_ = (this.h_ + _arg_1.height);
    }

    public function addPlainText(plainText:String, tokens:Object = null):void {
        var text:TextFieldDisplayConcrete;
        var position:Function;
        position = function ():void {
            positionText(text);
            draw();
        };
        text = new TextFieldDisplayConcrete().setSize(12).setColor(0xFFFFFF);
        text.setStringBuilder(new LineBuilder().setParams(plainText, tokens));
        text.filters = [new DropShadowFilter(0, 0, 0)];
        text.textChanged.add(position);
        addChild(text);
    }

    protected function positionText(_arg_1:DisplayObject):void {
        _arg_1.y = (this.h_ - 66);
        _arg_1.x = INDENT;
        this.h_ = (this.h_ + 20);
    }

    public function addTitle(_arg_1:String):void {
        var _local_2:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(20).setColor(0xB2B2B2).setBold(true);
        _local_2.setStringBuilder(new LineBuilder().setParams(_arg_1));
        _local_2.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        addChild(_local_2);
        _local_2.y = (this.h_ - 60);
        _local_2.x = 15;
        this.h_ = (this.h_ + 40);
    }

    public function addCheckBox(_arg_1:CheckBoxField):void {
        addChild(_arg_1);
        _arg_1.y = (this.h_ - 66);
        _arg_1.x = INDENT;
        this.h_ = (this.h_ + 44);
    }

    public function addRadioBox(_arg_1:PaymentMethodRadioButtons):void {
        addChild(_arg_1);
        _arg_1.y = (this.h_ - 66);
        _arg_1.x = 18;
        this.h_ = (this.h_ + _arg_1.height);
    }

    public function addSpace(_arg_1:int):void {
        this.h_ = (this.h_ + _arg_1);
    }

    public function disable():void {
        var _local_1:DeprecatedClickableText;
        mouseEnabled = false;
        mouseChildren = false;
        for each (_local_1 in this.navigationLinks_) {
            _local_1.setDefaultColor(0xB3B3B3);
        }
        this.leftButton_.setDefaultColor(0xB3B3B3);
        this.rightButton_.setDefaultColor(0xB3B3B3);
    }

    public function enable():void {
        var _local_1:DeprecatedClickableText;
        mouseEnabled = true;
        mouseChildren = true;
        for each (_local_1 in this.navigationLinks_) {
            _local_1.setDefaultColor(0xFFFFFF);
        }
        this.leftButton_.setDefaultColor(0xFFFFFF);
        this.rightButton_.setDefaultColor(0xFFFFFF);
    }

    protected function onAddedToStage(_arg_1:Event):void {
        this.draw();
        x = (400 - ((this.w_ - 6) / 2));
        y = (300 - (h_ / 2)); //was height
        if (this.textInputFields_.length > 0) {
            stage.focus = this.textInputFields_[0].inputText_;
        }
    }

    protected function draw():void {
        graphics.clear();
        GraphicsUtil.clearPath(this.path1_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, this.w_, (20 + 12), 4, [1, 1, 0, 0], this.path1_);
        GraphicsUtil.clearPath(this.path2_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, this.w_, this.h_, 4, [1, 1, 1, 1], this.path2_);
        this.leftButton_.y = (this.h_ - 52);
        this.rightButton_.y = (this.h_ - 52);
        graphics.drawGraphicsData(this.graphicsData_);
    }


}
}//package com.company.assembleegameclient.account.ui
