package  {
	
	import flash.events.Event;
	import com.milkmangames.nativeextensions.*;
	import com.milkmangames.nativeextensions.events.*;
	import starling.display.Stage;
	
	
	public class Rating {
		
		
		static function setup(stage:Stage) {
			
			if (CONFIG::AIR && RateBox.isSupported()) {
				Environment.ratingSupported = true;
				RateBox.create("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx","Enjoying Dropsy?","To say thanks, we'll give you 20 FREE Elims just for rating.","Rate Now","Ask Me Later","Don't ask again");
				//RateBox.rateBox.useTestMode();
				RateBox.rateBox.setAutoPrompt(false);
				
				RateBox.rateBox.addEventListener(RateBoxEvent.RATE_SELECTED,onDidRate);
				RateBox.rateBox.addEventListener(RateBoxEvent.NEVER_SELECTED,onWillNeverRate);
				
				function onDidRate(e:RateBoxEvent):void {
					Data.saveObj.hasRated = true;
					Data.flushSave();
				}
				
				function onWillNeverRate(evt:RateBoxEvent):void {
					Data.saveObj.declinedRating = true;
					Data.flushSave();
				}
			}
		}
		
		
		static function showRateBox() {
			if (CONFIG::AIR && !RateBox.rateBox.didRateCurrentVersion()) {
				RateBox.rateBox.showRatingPrompt("Enjoying Dropsy?","To say thanks, we'll give you 20 FREE Elims just for rating.","Rate Now","Ask Me Later","Don't ask again");
			}
		}
	}
}
