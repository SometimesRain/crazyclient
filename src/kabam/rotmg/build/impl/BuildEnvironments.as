package kabam.rotmg.build.impl {
import kabam.rotmg.build.api.BuildEnvironment;

public final class BuildEnvironments {

    public static const LOCALHOST:String = "localhost";
    public static const PRIVATE:String = "private";
    public static const DEV:String = "dev";
    public static const TESTING:String = "testing";
    public static const TESTING2:String = "testing2";
    public static const PRODTEST:String = "prodtest";
    public static const PRODUCTION:String = "production";
    private static const IP_MATCHER:RegExp = /[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/;


    public function getEnvironment(_arg_1:String):BuildEnvironment {
        return (((this.isFixedIP(_arg_1)) ? BuildEnvironment.FIXED_IP : this.getEnvironmentFromName(_arg_1)));
    }

    private function isFixedIP(_arg_1:String):Boolean {
        return (!((_arg_1.match(IP_MATCHER) == null)));
    }

    private function getEnvironmentFromName(_arg_1:String):BuildEnvironment {
        switch (_arg_1) {
            case LOCALHOST:
                return (BuildEnvironment.LOCALHOST);
            case PRIVATE:
                return (BuildEnvironment.PRIVATE);
            case DEV:
                return (BuildEnvironment.DEV);
            case TESTING:
                return (BuildEnvironment.TESTING);
            case TESTING2:
                return (BuildEnvironment.TESTING2);
            case PRODTEST:
                return (BuildEnvironment.PRODTEST);
            case PRODUCTION:
                return (BuildEnvironment.PRODUCTION);
        }
        return (null);
    }


}
}//package kabam.rotmg.build.impl
