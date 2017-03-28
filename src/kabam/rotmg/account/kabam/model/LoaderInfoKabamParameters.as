package kabam.rotmg.account.kabam.model {
import flash.display.LoaderInfo;

import kabam.lib.json.Base64Decoder;
import kabam.lib.json.JsonParser;

import robotlegs.bender.framework.api.ILogger;

public class LoaderInfoKabamParameters implements KabamParameters {

    [Inject]
    public var info:LoaderInfo;
    [Inject]
    public var json:JsonParser;
    [Inject]
    public var decoder:Base64Decoder;
    [Inject]
    public var logger:ILogger;


    public function getSignedRequest():String {
        return (this.info.parameters.kabam_signed_request);
    }

    public function getUserSession():Object {
        var signedRequest:String;
        var requestDetails:Array;
        var payload:String;
        var userSession:Object;
        signedRequest = this.getSignedRequest();
        try {
            requestDetails = signedRequest.split(".", 2);
            if (requestDetails.length != 2) {
                throw (new Error("Invalid signed request"));
            }
            payload = this.base64UrlDecode(requestDetails[1]);
            userSession = this.json.parse(payload);
        }
        catch (error:Error) {
            logger.info(((("Failed to get user session: " + error.toString()) + ", signed request: ") + signedRequest));
            userSession = null;
        }
        return (userSession);
    }

    protected function base64UrlDecode(_arg_1:String):String {
        var _local_2:RegExp = /-/g;
        var _local_3:RegExp = /_/g;
        var _local_4:int = (4 - (_arg_1.length % 4));
        while (_local_4--) {
            _arg_1 = (_arg_1 + "=");
        }
        _arg_1 = _arg_1.replace(_local_2, "+").replace(_local_3, "/");
        return (this.decoder.decode(_arg_1));
    }


}
}//package kabam.rotmg.account.kabam.model
