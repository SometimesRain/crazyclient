package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.screens.charrects.CharacterRectList;

import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;

import kabam.rotmg.core.model.PlayerModel;

public class CharacterList extends Sprite {

    public static const WIDTH:int = 760;
    public static const HEIGHT:int = 415;
    public static const TYPE_CHAR_SELECT:int = 1;
    public static const TYPE_GRAVE_SELECT:int = 2;

    public var charRectList_:Sprite;

    public function CharacterList(_arg_1:PlayerModel, _arg_2:int) {
        var _local_3:Shape;
        var _local_4:Graphics;
        super();
        switch (_arg_2) {
            case TYPE_CHAR_SELECT:
                this.charRectList_ = new CharacterRectList();
                break;
            case TYPE_GRAVE_SELECT:
                this.charRectList_ = new Graveyard(_arg_1);
                break;
            default:
                this.charRectList_ = new Sprite();
        }
        addChild(this.charRectList_);
        if (height > 400) {
            _local_3 = new Shape();
            _local_4 = _local_3.graphics;
            _local_4.beginFill(0);
            _local_4.drawRect(0, 0, WIDTH, HEIGHT);
            _local_4.endFill();
            addChild(_local_3);
            mask = _local_3;
        }
    }

    public function setPos(_arg_1:Number):void {
        this.charRectList_.y = _arg_1;
    }


}
}//package com.company.assembleegameclient.screens
