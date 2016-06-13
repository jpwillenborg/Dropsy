package  {
	
	import com.adobe.nativeExtensions.Vibration;
	import flash.system.Capabilities;
	
	
	public class Vibrate {
		
		static var deviceListNoVibrate:Array = ["iPad", "iPod"];
		static var duration:uint;
		
		
		static function check() {			
			if (CONFIG::AIR) {
				if (Vibration.isSupported) {
					
					for each (var id in deviceListNoVibrate) {
						if (String(flash.system.Capabilities.os).indexOf(id) >= 0) {
							Hud.canVibrate = false;
							break;
						} else {
							Hud.canVibrate = true;
						}
					}					
				} else {
					Hud.canVibrate = false;
				}
			} else {
				Hud.canVibrate = false;
			}
		}
		
		
		static function buzz(id:uint) {
			duration = id;
			
			if (Hud.vibrate == "on") {
				if (CONFIG::AIR) {
					getBuzz();
				}
			}
		}
		

		static function getBuzz() {
			if (Vibration.isSupported) {
				var vibe:Vibration = new Vibration();
				vibe.vibrate(duration);
			}
		}
	}
}
