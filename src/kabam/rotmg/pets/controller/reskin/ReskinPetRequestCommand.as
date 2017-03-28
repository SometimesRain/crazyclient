package kabam.rotmg.pets.controller.reskin {
import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.messaging.impl.ReskinPet;
import kabam.rotmg.pets.data.PetFormModel;
import kabam.rotmg.pets.data.ReskinPetVO;

import robotlegs.bender.bundles.mvcs.Command;

public class ReskinPetRequestCommand extends Command {

    [Inject]
    public var vo:ReskinPetVO;
    [Inject]
    public var socketServer:SocketServer;
    [Inject]
    public var messages:MessageProvider;
    [Inject]
    public var reskinModel:PetFormModel;


    override public function execute():void {
        var _local_1:ReskinPet;
        _local_1 = (this.messages.require(GameServerConnection.PET_CHANGE_FORM_MSG) as ReskinPet);
        _local_1.petInstanceId = this.reskinModel.getSelectedPet().getID();
        _local_1.pickedNewPetType = this.reskinModel.getpetTypeFromSkinID(this.reskinModel.getSelectedSkin());
        _local_1.item = this.reskinModel.slotObjectData;
        this.socketServer.sendMessage(_local_1);
    }


}
}//package kabam.rotmg.pets.controller.reskin
