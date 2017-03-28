package kabam.rotmg.core.commands {
import kabam.rotmg.application.model.DomainModel;
import kabam.rotmg.application.model.PlatformModel;

public class SetupDomainSecurityCommand {

    [Inject]
    public var client:PlatformModel;
    [Inject]
    public var domains:DomainModel;


    public function execute():void {
        if (this.client.isWeb()) {
            this.domains.applyDomainSecurity();
        }
    }


}
}//package kabam.rotmg.core.commands
