package kabam.rotmg.packages.control {
import kabam.rotmg.dialogs.control.OpenDialogSignal;
import kabam.rotmg.packages.view.PackageInfoDialog;

public class AlreadyBoughtPackageCommand {

    private static const DIALOG_TITLE:String = "Package Purchased";
    private static const MESSAGE_TITLE:String = "You've already purchased this package!";
    private static const MESSAGE_BODY:String = "Please check your vault for any items purchased";

    [Inject]
    public var openDialog:OpenDialogSignal;


    public function execute():void {
        this.openDialog.dispatch(this.makeDialog());
    }

    private function makeDialog():PackageInfoDialog {
        return (new PackageInfoDialog().setTitle(DIALOG_TITLE).setBody(MESSAGE_TITLE, MESSAGE_BODY));
    }


}
}//package kabam.rotmg.packages.control
