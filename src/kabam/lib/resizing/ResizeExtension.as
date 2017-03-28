package kabam.lib.resizing {
import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;

public class ResizeExtension implements IExtension {


    public function extend(_arg_1:IContext):void {
        _arg_1.extend(MediatorMapExtension);
        _arg_1.configure(ResizeConfig);
    }


}
}//package kabam.lib.resizing
