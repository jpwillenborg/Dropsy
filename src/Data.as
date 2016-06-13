package {
	
	import flash.events.Event;
	import flash.net.SharedObject;
	

	public class Data {
		
		static var mySave:SharedObject;
		static var saveObj:Object = {};
		
		
		static function setup() {
			mySave = SharedObject.getLocal("saveData");
			if (mySave.data.saveFile == undefined) {
				createSave();
			} else {
				restoreSave();
			}
		}
		
		
		static function createSave() {
			saveObj.firstPlay = true;
			saveObj.timesPlayed = 0;
			saveObj.hasRated = false;
			saveObj.rateCheck = false;
			saveObj.declinedRating = false;
			saveObj.rateFreq = [5, 10, 15, 20, 25, 30, 35, 40];
			
			saveObj.highScore = 0;
			saveObj.todaysHigh = 0;
			
			var endDate:Date = new Date();
			endDate.setDate(endDate.getDate() + 1);
			endDate.setHours(0,0,0,0);
			saveObj.resetPoint = endDate;
			
			saveObj.timedScore0 = 0;
			saveObj.timedScore1 = 0;
			saveObj.timedScore2 = 0;
			saveObj.movesScore0 = 0;
			saveObj.movesScore1 = 0;
			saveObj.movesScore2 = 0;
			
			saveObj.scoreSet = 0;
			
			saveObj.totalRedux = 30;
			saveObj.elimUpgrade = 250;
			
			saveObj.timedUpgrade = 15;
			saveObj.movesUpgrade = 15;
			
			saveObj.currentRedux = 0;
			saveObj.colors = 0;
			saveObj.highlight = Hud.highlightColorList[0];
			saveObj.theme = "dark";
			saveObj.sounds = "on";
			saveObj.vibrate = "off";
			
			flushSave();
		}
		
		
		static function restoreSave() {
			saveObj = mySave.data.saveFile;
			flushSave();
		}
		
		
		static function flushSave() {
			mySave.data.saveFile = saveObj;
			mySave.flush();
		}
	}
}