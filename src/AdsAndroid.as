package  {
	
	import com.milkmangames.nativeextensions.*;
	import com.milkmangames.nativeextensions.events.*;
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.core.Starling;
	
	
	public class AdsAndroid {
		
		static var attemptTimer:Timer = new Timer(7000);
		
		
		static function setup() {
			if (!AdMob.isSupported) {
				return;
			}
			
			AdMob.init("ca-app-pub-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			// during TESTING, activate test IDs.  You want to REMOVE this before publishing your final application.
			//AdMob.enableTestDeviceIDs(AdMob.getCurrentTestDeviceIDs());
			
			AdMob.addEventListener(AdMobEvent.RECEIVED_AD, onReceiveAd);
			AdMob.addEventListener(AdMobErrorEvent.FAILED_TO_RECEIVE_AD, onFailedReceiveAd);
			AdMob.addEventListener(AdMobEvent.SCREEN_PRESENTED, onScreenPresented);
			AdMob.addEventListener(AdMobEvent.SCREEN_DISMISSED, onScreenDismissed);
			AdMob.addEventListener(AdMobEvent.LEAVE_APPLICATION, onLeaveApplication);
		}
		
		
		static function loadAd() {
			AdMob.loadInterstitial("ca-app-pub-7171904617356378/1079126045", false);
		}
		
		
		static function showAd():void {
			if (AdMob.isInterstitialReady()) {
				AdMob.showPendingInterstitial();
			}
		}
		
		
		// LISTENERS		
		static function onReceiveAd(e:AdMobEvent):void {
			
		}
		
		
		static function onFailedReceiveAd(e:AdMobErrorEvent):void {
			attemptTimer.start();
			attemptTimer.addEventListener(TimerEvent.TIMER, attemptTimerHandler);
		}
		
		
		static function attemptTimerHandler(evt:TimerEvent):void {
			attemptTimer.stop();
			attemptTimer.reset();
			attemptTimer.removeEventListener(TimerEvent.TIMER, attemptTimerHandler);
			
			try {
				AdMob.destroyAd();
			}
			catch (e:Error) {
				
			}
			
			loadAd();
		}
		
		static function onScreenPresented(e:AdMobEvent):void {
			Starling.current.stop();
		}
		
		static function onScreenDismissed(e:AdMobEvent):void {
			Starling.current.start();
		}
		
		static function onLeaveApplication(e:AdMobEvent):void {
			Starling.current.stop();
		}
	}
}
