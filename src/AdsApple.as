package  {
	
	import com.milkmangames.nativeextensions.ios.*;
	import com.milkmangames.nativeextensions.ios.events.*;
	import flash.desktop.NativeApplication;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.core.Starling;
	
	
	public class AdsApple {
		
		static var attemptTimer:Timer = new Timer(7000);
		static var adLoaded:Boolean = false;
		
		
		static function setup() {
			if (!IAd.isSupported()) {
				return;
			}
			
			IAd.create();
			
			if (!IAd.iAd.isIAdAvailable() || !IAd.iAd.isInterstitialAvailable()) {
				return;
			}
			
			IAd.iAd.addEventListener(IAdEvent.INTERSTITIAL_AD_LOADED, onReceiveAd);
			IAd.iAd.addEventListener(IAdErrorEvent.INTERSTITIAL_AD_FAILED, onFailedReceiveAd);
			IAd.iAd.addEventListener(IAdEvent.INTERSTITIAL_SHOWN, onScreenPresented);
			IAd.iAd.addEventListener(IAdEvent.INTERSTITITAL_DISMISSED, onScreenDismissed);			
		}
		
		
		static function loadAd() {
			if (!adLoaded) {
				IAd.iAd.loadInterstitial(false);
			}
		}
		
		static function showAd():void {
			if (IAd.iAd.isInterstitialReady() && IAd.iAd.isInterstitialAvailable()) {
				IAd.iAd.showPendingInterstitial();
			}
		}
		
		
		// LISTENERS		
		static function onReceiveAd(e:IAdEvent):void {
			if (!adLoaded) {
				adLoaded = true;
			}			
		}		
		
		
		static function onFailedReceiveAd(e:IAdErrorEvent):void {
			adLoaded = false;
			attemptTimer.start();
			attemptTimer.addEventListener(TimerEvent.TIMER, attemptTimerHandler);
		}

		
		static function attemptTimerHandler(evt:TimerEvent):void {
			attemptTimer.stop();
			attemptTimer.reset();
			attemptTimer.removeEventListener(TimerEvent.TIMER, attemptTimerHandler);
			
			try {
				IAd.iAd.destroyBannerAd();
			}
			catch (e:Error) {
				
			}
			
			loadAd();		
		}
		
		static function onScreenPresented(e:IAdEvent):void {
			Starling.current.stop();
		}
		
		static function onScreenDismissed(e:IAdEvent):void {
			Starling.current.start();
		}
	}
}
