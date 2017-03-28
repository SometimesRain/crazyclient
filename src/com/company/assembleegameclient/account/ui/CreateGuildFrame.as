package com.company.assembleegameclient.account.ui {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.game.events.GuildResultEvent;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.MouseEvent;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.text.model.TextKey;

import org.osflash.signals.Signal;

public class CreateGuildFrame extends Frame {

    public const close:Signal = new Signal();

    private var name_:TextInputField;
    private var gs_:GameSprite;

    public function CreateGuildFrame(_arg_1:GameSprite) {
        super(TextKey.GUILD_TITLE, TextKey.FRAME_CANCEL, TextKey.GUILD_CREATE);
        this.gs_ = _arg_1;
        this.name_ = new TextInputField(TextKey.GUILD_NAME, false);
        this.name_.inputText_.restrict = "A-Za-z ";
        var _local_2:int = 20;
        this.name_.inputText_.maxChars = _local_2;
        addTextInputField(this.name_);
        addPlainText(TextKey.FRAME_MAX_CHAR, {"maxChars": _local_2});
        addPlainText(TextKey.FRAME_RESTRICT_CHAR);
        addPlainText(TextKey.GUILD_WARNING);
        leftButton_.addEventListener(MouseEvent.CLICK, this.onCancel);
        rightButton_.addEventListener(MouseEvent.CLICK, this.onCreate);
    }

    private function onCancel(_arg_1:MouseEvent):void {
        this.close.dispatch();
    }

    private function onCreate(_arg_1:MouseEvent):void {
        this.gs_.addEventListener(GuildResultEvent.EVENT, this.onResult);
        this.gs_.gsc_.createGuild(this.name_.text());
        disable();
    }

    private function onResult(_arg_1:GuildResultEvent):void {
        var _local_2:Player;
        this.gs_.removeEventListener(GuildResultEvent.EVENT, this.onResult);
        if (_arg_1.success_) {
            _local_2 = StaticInjectorContext.getInjector().getInstance(GameModel).player;
            if (_local_2 != null) {
                _local_2.fame_ = (_local_2.fame_ - Parameters.GUILD_CREATION_PRICE);
            }
            this.close.dispatch();
        }
        else {
            this.name_.setError(_arg_1.errorKey, _arg_1.errorTokens);
            enable();
        }
    }


}
}//package com.company.assembleegameclient.account.ui
