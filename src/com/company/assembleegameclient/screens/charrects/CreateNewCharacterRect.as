package com.company.assembleegameclient.screens.charrects {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.FameUtil;
import com.company.util.BitmapUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class CreateNewCharacterRect extends CharacterRect {

    private var bitmap_:Bitmap;

    public function CreateNewCharacterRect(_arg_1:PlayerModel) {
        var _local_2:int;
        super();
        super.className = new LineBuilder().setParams(TextKey.CREATE_NEW_CHARACTER_RECT_NEW_CHARACTER);
        super.color = 0x545454;
        super.overColor = 0x777777;
        super.init();
        this.makeBitmap();
        if (_arg_1.getNumStars() != FameUtil.maxStars()) {
            _local_2 = (FameUtil.maxStars() - _arg_1.getNumStars());
            super.makeTaglineIcon();
            super.makeTaglineText(new LineBuilder().setParams(_local_2+" stars to go"));//, {"remainingStars": _local_2}));
            taglineText.x = (taglineText.x + taglineIcon.width);
        }
    }

    public function makeBitmap():void {
        var _local_1:XML = ObjectLibrary.playerChars_[int((ObjectLibrary.playerChars_.length * Math.random()))];
        var _local_2:BitmapData = SavedCharacter.getImage(null, _local_1, AnimatedChar.RIGHT, AnimatedChar.STAND, 0, false, false);
        _local_2 = BitmapUtil.cropToBitmapData(_local_2, 6, 6, (_local_2.width - 12), (_local_2.height - 6));
        this.bitmap_ = new Bitmap();
        this.bitmap_.bitmapData = _local_2;
        this.bitmap_.x = CharacterRectConstants.ICON_POS_X;
        this.bitmap_.y = 0;
        selectContainer.addChild(this.bitmap_);
    }


}
}//package com.company.assembleegameclient.screens.charrects
