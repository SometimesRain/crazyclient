package kabam.rotmg.dailyLogin.signal
{
	import org.osflash.signals.Signal;
	import kabam.rotmg.dailyLogin.message.ClaimDailyRewardResponse;
	
	public class ClaimDailyRewardResponseSignal extends Signal
	{
		 
		
		public function ClaimDailyRewardResponseSignal()
		{
			super(ClaimDailyRewardResponse);
		}
	}
}
