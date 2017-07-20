package kabam.rotmg.fame.view {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.screens.ScoreTextLine;
import com.company.assembleegameclient.screens.ScoringBox;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.util.FameUtil;
import com.company.rotmg.graphics.FameIconBackgroundDesign;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.util.BitmapUtil;
import com.gskinner.motion.GTween;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import com.company.assembleegameclient.map.GroundLibrary;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.ui.view.components.ScreenBase;

import org.osflash.signals.Signal;
import org.osflash.signals.natives.NativeMappedSignal;

public class FameView extends Sprite {

    public var closed:Signal;
    private var infoContainer:DisplayObjectContainer;
    private var overlayContainer:Bitmap;
    private var title:TextFieldDisplayConcrete;
    private var date:TextFieldDisplayConcrete;
    private var scoringBox:ScoringBox;
    private var finalLine:ScoreTextLine;
    private var continueBtn:TitleMenuOption;
    private var isAnimation:Boolean;
    private var isFadeComplete:Boolean;
    private var isDataPopulated:Boolean;

    public function FameView() {
        addChild(new ScreenBase());
        addChild((this.infoContainer = new Sprite()));
        addChild((this.overlayContainer = new Bitmap()));
        this.continueBtn = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
        this.continueBtn.setAutoSize(TextFieldAutoSize.CENTER);
        this.continueBtn.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
        this.closed = new NativeMappedSignal(this.continueBtn, MouseEvent.CLICK);
    }

    public function setIsAnimation(_arg_1:Boolean):void {
        this.isAnimation = _arg_1;
    }

    public function setBackground(_arg_1:BitmapData):void {
        this.overlayContainer.bitmapData = _arg_1;
        var _local_2:GTween = new GTween(this.overlayContainer, 2, {"alpha": 0});
        _local_2.onComplete = this.onFadeComplete;
        SoundEffectLibrary.play("death_screen");
    }

    public function clearBackground():void {
        this.overlayContainer.bitmapData = null;
    }

    private function onFadeComplete(_arg_1:GTween):void {
        removeChild(this.overlayContainer);
        this.isFadeComplete = true;
        if (this.isDataPopulated) {
            this.makeContinueButton();
        }
    }

    public function setCharacterInfo(_arg_1:String, _arg_2:int, _arg_3:int):void {
        this.title = new TextFieldDisplayConcrete().setSize(38).setColor(0xCCCCCC);
        this.title.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this.title.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        var _local_4:String = ObjectLibrary.typeToDisplayId_[_arg_3];
        this.title.setStringBuilder(new LineBuilder().setParams(TextKey.CHARACTER_INFO, {
            "name": _arg_1,
            "level": _arg_2,
            "type": _local_4
        }));
        this.title.x = (stage.stageWidth / 2);
        this.title.y = 225;
        this.infoContainer.addChild(this.title);
    }

    public function setDeathInfo(_arg_1:String, _arg_2:String):void {
        this.date = new TextFieldDisplayConcrete().setSize(24).setColor(0xCCCCCC);
        this.date.setBold(true).setAutoSize(TextFieldAutoSize.CENTER);
        this.date.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        var _local_3:LineBuilder = new LineBuilder();
        if (_arg_2) {
            _local_3.setParams(TextKey.DEATH_INFO_LONG, {
                "date": _arg_1,
               "killer":this.convertKillerString(_arg_2)
            });
        }
        else {
            //_local_3.setParams(TextKey.DEATH_INFO_SHORT, {"date": this.date});
			_local_3.setParams(TextKey.DEATH_INFO_SHORT,{"date":_arg_1});
        }
        this.date.setStringBuilder(_local_3);
        this.date.x = (stage.stageWidth / 2);
        this.date.y = 272;
        this.infoContainer.addChild(this.date);
    }
	
	private function convertKillerString(param1:String) : String
	{
		var _loc2_:Array = param1.split(".");
		var _loc3_:String = _loc2_[0];
		var _loc4_:String = _loc2_[1];
		if(_loc4_ == null)
		{
			_loc4_ = _loc3_;
            switch(_loc4_)
            {
               case "lava":
                  _loc4_ = "Lava";
                  break;
               case "lava blend":
                  _loc4_ = "Lava Blend";
                  break;
               case "liquid evil":
                  _loc4_ = "Liquid Evil";
                  break;
               case "evil water":
                  _loc4_ = "Evil Water";
                  break;
               case "puke water":
                  _loc4_ = "Puke Water";
                  break;
               case "hot lava":
                  _loc4_ = "Hot Lava";
                  break;
               case "pure evil":
                  _loc4_ = "Pure Evil";
                  break;
            }
		}
		else
		{
			_loc4_ = _loc4_.substr(0,_loc4_.length - 1);
			_loc4_ = _loc4_.replace(/_/g," ");
			_loc4_ = _loc4_.replace(/APOS/g,"\'");
			_loc4_ = _loc4_.replace(/BANG/g,"!");
		}
		if (ObjectLibrary.getPropsFromId(_loc4_) != null)
		{
			_loc4_ = ObjectLibrary.getPropsFromId(_loc4_).displayId_;
		}
		else if (GroundLibrary.getPropsFromId(_loc4_) != null)
		{
			_loc4_ = GroundLibrary.getPropsFromId(_loc4_).displayId_;
		}
		return _loc4_;
	}

    public function setIcon(_arg_1:BitmapData):void {
        var _local_2:Sprite;
        var _local_4:Bitmap;
        _local_2 = new Sprite();
        var _local_3:Sprite = new FameIconBackgroundDesign();
        _local_3.filters = [new DropShadowFilter(0, 0, 0, 0.5, 12, 12)];
        _local_2.addChild(_local_3);
        _local_4 = new Bitmap(_arg_1);
        _local_4.x = ((_local_2.width / 2) - (_local_4.width / 2));
        _local_4.y = ((_local_2.height / 2) - (_local_4.height / 2));
        _local_2.addChild(_local_4);
        _local_2.y = 20;
        _local_2.x = ((stage.stageWidth / 2) - (_local_2.width / 2));
        this.infoContainer.addChild(_local_2);
    }

    public function setScore(_arg_1:int, _arg_2:XML):void {
        this.scoringBox = new ScoringBox(new Rectangle(0, 0, 784, 150), _arg_2);
        this.scoringBox.x = 8;
        this.scoringBox.y = 316;
        addChild(this.scoringBox);
        this.infoContainer.addChild(this.scoringBox);
        var _local_3:BitmapData = FameUtil.getFameIcon();
        _local_3 = BitmapUtil.cropToBitmapData(_local_3, 6, 6, (_local_3.width - 12), (_local_3.height - 12));
        this.finalLine = new ScoreTextLine(24, 0xCCCCCC, 0xFFC800, TextKey.FAMEVIEW_TOTAL_FAME_EARNED, null, 0, _arg_1, "", "", new Bitmap(_local_3));
        this.finalLine.x = 10;
        this.finalLine.y = 470;
        this.infoContainer.addChild(this.finalLine);
        this.isDataPopulated = true;
        if (((!(this.isAnimation)) || (this.isFadeComplete))) {
            this.makeContinueButton();
        }
    }

    private function makeContinueButton():void {
        this.infoContainer.addChild(new ScreenGraphic());
        this.continueBtn.x = (stage.stageWidth / 2);
        this.continueBtn.y = 550;
        this.infoContainer.addChild(this.continueBtn);
        if (this.isAnimation) {
            this.scoringBox.animateScore();
        }
        else {
            this.scoringBox.showScore();
        }
    }


}
}//package kabam.rotmg.fame.view
