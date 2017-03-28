package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.constants.InventoryOwnerTypes;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.ui.BaseSimpleText;
import com.company.util.IntPoint;
import com.gskinner.motion.GTween;
import com.gskinner.motion.easing.Sine;

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.AddSpeechBalloonVO;
import kabam.rotmg.game.signals.AddSpeechBalloonSignal;
import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class Merchant extends SellableObject implements IInteractiveObject {

    private static const NONE_MESSAGE:int = 0;
    private static const NEW_MESSAGE:int = 1;
    private static const MINS_LEFT_MESSAGE:int = 2;
    private static const ITEMS_LEFT_MESSAGE:int = 3;
    private static const DISCOUNT_MESSAGE:int = 4;
    private static const T:Number = 1;
    private static const DOSE_MATRIX:Matrix = function ():Matrix {
        var _local_1:* = new Matrix();
        _local_1.translate(10, 5);
        return (_local_1);
    }();

    public var merchandiseType_:int = -1;
    public var count_:int = -1;
    public var minsLeft_:int = -1;
    public var discount_:int = 0;
    public var merchandiseTexture_:BitmapData = null;
    public var untilNextMessage_:int = 0;
    public var alpha_:Number = 1;
    private var addSpeechBalloon:AddSpeechBalloonSignal;
    private var stringMap:StringMap;
    private var firstUpdate_:Boolean = true;
    private var messageIndex_:int = 0;
    private var ct_:ColorTransform;

    public function Merchant(_arg_1:XML) {
        this.ct_ = new ColorTransform(1, 1, 1, 1);
        this.addSpeechBalloon = StaticInjectorContext.getInjector().getInstance(AddSpeechBalloonSignal);
        this.stringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
        super(_arg_1);
        isInteractive_ = true;
    }

    override public function setPrice(_arg_1:int):void {
        super.setPrice(_arg_1);
        this.untilNextMessage_ = 0;
    }

    override public function setRankReq(_arg_1:int):void {
        super.setRankReq(_arg_1);
        this.untilNextMessage_ = 0;
    }

    override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean {
        if (!super.addTo(_arg_1, _arg_2, _arg_3)) {
            return (false);
        }
        _arg_1.merchLookup_[new IntPoint(x_, y_)] = this;
        return (true);
    }

    override public function removeFromMap():void {
        var _local_1:IntPoint = new IntPoint(x_, y_);
        if (map_.merchLookup_[_local_1] == this) {
            map_.merchLookup_[_local_1] = null;
        }
        super.removeFromMap();
    }

    public function getSpeechBalloon(_arg_1:int):AddSpeechBalloonVO {
        var _local_2:LineBuilder;
        var _local_3:uint;
        var _local_4:uint;
        var _local_5:uint;
        switch (_arg_1) {
            case NEW_MESSAGE:
                _local_2 = new LineBuilder().setParams("Merchant.new");
                _local_3 = 0xE6E6E6;
                _local_4 = 0xFFFFFF;
                _local_5 = 5931045;
                break;
            case MINS_LEFT_MESSAGE:
                if (this.minsLeft_ == 0) {
                    _local_2 = new LineBuilder().setParams("Merchant.goingSoon");
                }
                else {
                    if (this.minsLeft_ == 1) {
                        _local_2 = new LineBuilder().setParams("Merchant.goingInOneMinute");
                    }
                    else {
                        _local_2 = new LineBuilder().setParams("Merchant.goingInNMinutes", {"minutes": this.minsLeft_});
                    }
                }
                _local_3 = 5973542;
                _local_4 = 16549442;
                _local_5 = 16549442;
                break;
            case ITEMS_LEFT_MESSAGE:
                _local_2 = new LineBuilder().setParams("Merchant.limitedStock", {"count": this.count_});
                _local_3 = 5973542;
                _local_4 = 16549442;
                _local_5 = 16549442;
                break;
            case DISCOUNT_MESSAGE:
                _local_2 = new LineBuilder().setParams("Merchant.discount", {"discount": this.discount_});
                _local_3 = 6324275;
                _local_4 = 16777103;
                _local_5 = 16777103;
                break;
            default:
                return (null);
        }
        _local_2.setStringMap(this.stringMap);
        return (new AddSpeechBalloonVO(this, _local_2.getString(), "", false, false, _local_3, 1, _local_4, 1, _local_5, 6, true, false));
    }

    override public function update(_arg_1:int, _arg_2:int):Boolean {
        var _local_5:GTween;
        super.update(_arg_1, _arg_2);
		if (false) { //add option, false by default
			if (this.firstUpdate_) {
				if (this.minsLeft_ == 2147483647) {
					_local_5 = new GTween(this, (0.5 * T), {"size_": 150}, {"ease": Sine.easeOut});
					_local_5.nextTween = new GTween(this, (0.5 * T), {"size_": 100}, {"ease": Sine.easeIn});
					_local_5.nextTween.paused = true;
				}
				this.firstUpdate_ = false;
			}
			this.untilNextMessage_ = (this.untilNextMessage_ - _arg_2);
			if (this.untilNextMessage_ > 0) {
				return (true);
			}
			this.untilNextMessage_ = 5000;
			var _local_3:Vector.<int> = new Vector.<int>();
			if (this.minsLeft_ == 2147483647) {
				_local_3.push(NEW_MESSAGE);
			}
			else {
				if ((((this.minsLeft_ >= 0)) && ((this.minsLeft_ <= 5)))) {
					_local_3.push(MINS_LEFT_MESSAGE);
				}
			}
			if ((((this.count_ >= 1)) && ((this.count_ <= 2)))) {
				_local_3.push(ITEMS_LEFT_MESSAGE);
			}
			if (this.discount_ > 0) {
				_local_3.push(DISCOUNT_MESSAGE);
			}
			if (_local_3.length == 0) {
				return (true);
			}
			this.messageIndex_ = (++this.messageIndex_ % _local_3.length);
			var _local_4:int = _local_3[this.messageIndex_];
			this.addSpeechBalloon.dispatch(this.getSpeechBalloon(_local_4));
		}
        return (true);
    }

    override public function soldObjectName():String {
        return (ObjectLibrary.typeToDisplayId_[this.merchandiseType_]);
    }

    override public function soldObjectInternalName():String {
        var _local_1:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        return (_local_1.@id.toString());
    }

    override public function getTooltip():ToolTip {
        return (new EquipmentToolTip(this.merchandiseType_, map_.player_, -1, InventoryOwnerTypes.NPC));
    }

    override public function getSellableType():int {
        return (this.merchandiseType_);
    }

    override public function getIcon():BitmapData {
        var _local_3:BaseSimpleText;
        var _local_1:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.merchandiseType_, 80, true);
        var _local_2:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        if (_local_2.hasOwnProperty("Doses")) {
            _local_1 = _local_1.clone();
            _local_3 = new BaseSimpleText(12, 0xFFFFFF, false, 0, 0);
            _local_3.text = String(_local_2.Doses);
            _local_3.updateMetrics();
            _local_1.draw(_local_3, DOSE_MATRIX);
        }
        if(_local_2.hasOwnProperty("Quantity"))
        {
            _local_1 = _local_1.clone();
            _local_3 = new BaseSimpleText(12, 0xFFFFFF, false, 0, 0);
            _local_3.text = String(_local_2.Quantity);
            _local_3.updateMetrics();
            _local_1.draw(_local_3, DOSE_MATRIX);
        }
        return (_local_1);
    }

    public function getTex1Id(_arg_1:int):int {
        var _local_2:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        if (_local_2 == null) {
            return (_arg_1);
        }
        if ((((_local_2.Activate == "Dye")) && (_local_2.hasOwnProperty("Tex1")))) {
            return (int(_local_2.Tex1));
        }
        return (_arg_1);
    }

    public function getTex2Id(_arg_1:int):int {
        var _local_2:XML = ObjectLibrary.xmlLibrary_[this.merchandiseType_];
        if (_local_2 == null) {
            return (_arg_1);
        }
        if ((((_local_2.Activate == "Dye")) && (_local_2.hasOwnProperty("Tex2")))) {
            return (int(_local_2.Tex2));
        }
        return (_arg_1);
    }

    override protected function getTexture(_arg_1:Camera, _arg_2:int):BitmapData {
        if ((((this.alpha_ == 1)) && ((size_ == 100)))) {
            return (this.merchandiseTexture_);
        }
        var _local_3:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.merchandiseType_, size_, false, false);
        if (this.alpha_ != 1) {
            this.ct_.alphaMultiplier = this.alpha_;
            _local_3.colorTransform(_local_3.rect, this.ct_);
        }
        return (_local_3);
    }

    public function setMerchandiseType(_arg_1:int):void {
        this.merchandiseType_ = _arg_1;
        this.merchandiseTexture_ = ObjectLibrary.getRedrawnTextureFromType(this.merchandiseType_, 100, false);
    }


}
}//package com.company.assembleegameclient.objects
