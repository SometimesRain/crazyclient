package com.company.assembleegameclient.screens {
import com.company.assembleegameclient.appengine.SavedNewsItem;

import flash.display.Sprite;

import kabam.rotmg.core.model.PlayerModel;

public class Graveyard extends Sprite {

    private var lines_:Vector.<GraveyardLine>;
    private var hasCharacters_:Boolean = false;

    public function Graveyard(_arg_1:PlayerModel) {
        var _local_2:SavedNewsItem;
        this.lines_ = new Vector.<GraveyardLine>();
        super();
        for each (_local_2 in _arg_1.getNews()) {
            if (_local_2.isCharDeath()) {
                this.addLine(new GraveyardLine(_local_2.getIcon(), _local_2.title_, _local_2.tagline_, _local_2.link_, _local_2.date_, _arg_1.getAccountId()));
                this.hasCharacters_ = true;
            }
        }
    }

    public function hasCharacters():Boolean {
        return (this.hasCharacters_);
    }

    public function addLine(_arg_1:GraveyardLine):void {
        _arg_1.y = (4 + (this.lines_.length * (GraveyardLine.HEIGHT + 4)));
        this.lines_.push(_arg_1);
        addChild(_arg_1);
    }


}
}//package com.company.assembleegameclient.screens
