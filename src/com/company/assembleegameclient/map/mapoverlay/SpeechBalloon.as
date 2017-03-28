package com.company.assembleegameclient.map.mapoverlay {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.GraphicsUtil;

import flash.display.CapsStyle;
import flash.display.GraphicsPath;
import flash.display.GraphicsPathCommand;
import flash.display.GraphicsSolidFill;
import flash.display.GraphicsStroke;
import flash.display.IGraphicsData;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.ui.model.HUDModel;

public class SpeechBalloon extends Sprite implements IMapOverlayElement {

    public var go_:GameObject;
    public var lifetime_:int;
    public var hideable_:Boolean;
    public var offset_:Point = new Point();
    public var text_:TextField;
    private var backgroundFill_:GraphicsSolidFill = new GraphicsSolidFill(0, 1);
    private var outlineFill_:GraphicsSolidFill = new GraphicsSolidFill(0xFFFFFF, 1);
    private var lineStyle_:GraphicsStroke = new GraphicsStroke(
            2, false, LineScaleMode.NORMAL, CapsStyle.NONE, JointStyle.ROUND, 3, outlineFill_
    );
    private var path_:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
    private var senderName:String;
    private var isTrade:Boolean;
    private var isGuild:Boolean;
    private var startTime_:int = 0;
    private const graphicsData_:Vector.<IGraphicsData> = new <IGraphicsData>[
        lineStyle_, backgroundFill_, path_, GraphicsUtil.END_FILL, GraphicsUtil.END_STROKE
    ];

    public function SpeechBalloon(_arg_1:GameObject, _arg_2:String, _arg_3:String, _arg_4:Boolean, _arg_5:Boolean, _arg_6:uint, _arg_7:Number, _arg_8:uint, _arg_9:Number, _arg_10:uint, _arg_11:int, _arg_12:Boolean, _arg_13:Boolean) {
        super();
        this.go_ = _arg_1;
        this.senderName = _arg_3;
        this.isTrade = _arg_4;
        this.isGuild = _arg_5;
        this.lifetime_ = (_arg_11 * 1000);
        this.hideable_ = _arg_13;
        this.text_ = new TextField();
        this.text_.autoSize = TextFieldAutoSize.LEFT;
        this.text_.embedFonts = true;
        this.text_.width = 150;
        var _local_14:TextFormat = new TextFormat();
        _local_14.font = "Myriad Pro";
        _local_14.size = 14;
        _local_14.bold = _arg_12;
        _local_14.color = _arg_10;
        this.text_.defaultTextFormat = _local_14;
        this.text_.selectable = false;
        this.text_.mouseEnabled = false;
        this.text_.multiline = true;
        this.text_.wordWrap = true;
        this.text_.text = _arg_2;
        addChild(this.text_);
        var _local_15:int = (this.text_.textWidth + 4);
        this.offset_.x = (-(_local_15) / 2);
        this.backgroundFill_.color = _arg_6;
        this.backgroundFill_.alpha = _arg_7;
        this.outlineFill_.color = _arg_8;
        this.outlineFill_.alpha = _arg_9;
        graphics.clear();
        GraphicsUtil.clearPath(this.path_);
        GraphicsUtil.drawCutEdgeRect(-6, -6, (_local_15 + 12), (height + 12), 4, [1, 1, 1, 1], this.path_);
        this.path_.commands.splice(6, 0, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO);
        var _local_16:int = height;
        this.path_.data.splice(12, 0, ((_local_15 / 2) + 8), (_local_16 + 6), (_local_15 / 2), (_local_16 + 18), ((_local_15 / 2) - 8), (_local_16 + 6));
        graphics.drawGraphicsData(this.graphicsData_);
        filters = [new DropShadowFilter(0, 0, 0, 1, 16, 16)];
        this.offset_.y = ((-(height) - ((this.go_.texture_.height * (_arg_1.size_ / 100)) * 5)) - 2);
        visible = false;
        addEventListener(MouseEvent.RIGHT_CLICK, this.onSpeechBalloonRightClicked);
    }

    private function onSpeechBalloonRightClicked(e:MouseEvent):void {
        var hmod:HUDModel;
        var aPlayer:Player;
        var playerObjectId:int = this.go_.objectId_;
        try {
            hmod = StaticInjectorContext.getInjector().getInstance(HUDModel);
            if (((((!((hmod.gameSprite.map.goDict_[playerObjectId] == null))) && ((hmod.gameSprite.map.goDict_[playerObjectId] is Player)))) && (!((hmod.gameSprite.map.player_.objectId_ == playerObjectId))))) {
                aPlayer = (hmod.gameSprite.map.goDict_[playerObjectId] as Player);
                hmod.gameSprite.addChatPlayerMenu(aPlayer, e.stageX, e.stageY);
            }
            else {
                if (((((((!(this.isTrade)) && (!((this.senderName == null))))) && (!((this.senderName == ""))))) && (!((hmod.gameSprite.map.player_.name_ == this.senderName))))) {
                    hmod.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.senderName, this.isGuild);
                }
                else {
                    if (((((((this.isTrade) && (!((this.senderName == null))))) && (!((this.senderName == ""))))) && (!((hmod.gameSprite.map.player_.name_ == this.senderName))))) {
                        hmod.gameSprite.addChatPlayerMenu(null, e.stageX, e.stageY, this.senderName, false, true);
                    }
                }
            }
        }
        catch (e:Error) {
        }
    }

    public function draw(_arg_1:Camera, _arg_2:int):Boolean {
        if (this.startTime_ == 0) {
            this.startTime_ = _arg_2;
        }
        var _local_3:int = (_arg_2 - this.startTime_);
        if ((((_local_3 > this.lifetime_)) || (((!((this.go_ == null))) && ((this.go_.map_ == null)))))) {
            return (false);
        }
        if ((((this.go_ == null)) || (!(this.go_.drawn_)))) {
            visible = false;
            return (true);
        }
        if (((this.hideable_) && (!(Parameters.data_.textBubbles)))) {
            visible = false;
            return (true);
        }
        visible = true;
        x = int((this.go_.posS_[0] + this.offset_.x));
        y = int((this.go_.posS_[1] + this.offset_.y));
        return (true);
    }

    public function getGameObject():GameObject {
        return (this.go_);
    }

    public function dispose():void {
        parent.removeChild(this);
    }


}
}//package com.company.assembleegameclient.map.mapoverlay
