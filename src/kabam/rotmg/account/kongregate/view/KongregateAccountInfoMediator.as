package kabam.rotmg.account.kongregate.view {
import robotlegs.bender.bundles.mvcs.Mediator;

public class KongregateAccountInfoMediator extends Mediator {

    [Inject]
    public var view:KongregateAccountInfoView;
    [Inject]
    public var api:KongregateApi;


    override public function initialize():void {
        this.view.register.add(this.onRegister);
    }

    override public function destroy():void {
        this.view.register.remove(this.onRegister);
    }

    private function onRegister():void {
        this.api.showRegistrationDialog();
    }


}
}//package kabam.rotmg.account.kongregate.view
