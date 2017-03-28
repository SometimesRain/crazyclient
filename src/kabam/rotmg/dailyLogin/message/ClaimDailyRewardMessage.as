package kabam.rotmg.dailyLogin.message
{
	import kabam.rotmg.messaging.impl.outgoing.OutgoingMessage;
	import flash.utils.IDataOutput;
	
	public class ClaimDailyRewardMessage extends OutgoingMessage
	{
		 
		
		public var claimKey:String;
		
		public var type:String;
		
		public function ClaimDailyRewardMessage(param1:uint, param2:Function)
		{
			super(param1,param2);
		}
		
		override public function writeToOutput(param1:IDataOutput) : void
		{
			param1.writeUTF(this.claimKey);
			param1.writeUTF(this.type);
		}
		
		override public function toString() : String
		{
			return "type";
		}
	}
}
