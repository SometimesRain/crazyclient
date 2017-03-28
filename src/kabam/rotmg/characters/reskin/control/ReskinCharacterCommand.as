package kabam.rotmg.characters.reskin.control {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;

import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.classes.model.CharacterSkin;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.model.GameModel;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.outgoing.Reskin;

public class ReskinCharacterCommand {

    [Inject]
    public var skin:CharacterSkin;
    [Inject]
    public var messages:MessageProvider;
    [Inject]
    public var server:SocketServer;


    public function execute():void {
        var _local_1:Reskin = (this.messages.require(GameServerConnection.RESKIN) as Reskin);
        _local_1.skinID = this.skin.id;
        var _local_2:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
        if (_local_2 != null) {
            _local_2.clearTextureCache();
            if (Parameters.skinTypes16.indexOf(_local_1.skinID) != -1) {
                _local_2.size_ = 70;
            }
            else {
                _local_2.size_ = 100;
            }
        }
        this.server.sendMessage(_local_1);
    }


}
}//package kabam.rotmg.characters.reskin.control
