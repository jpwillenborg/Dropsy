package  {
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.animation.Transitions;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.TouchEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	
	public class Environment {
		
		[Embed(source="../assets/fonts/Font.otf", embedAsCFF="false", fontFamily="Font")]
		private static const GameFont:Class;
		
		public static var scale:int;
		public static var stageRef:Stage;
		public static var objList:Array = [];
		static var rectSprite:Sprite;
		static var rectFiller:Image;
		static var rectDiff:Number;
		static var rectScale:Number;
		static var adHeight:int = 0;
		static var adBound:int = Main.screenHeight - adHeight;
		static var adArea:Sprite;
		static var adFiller:Image;
		static var totalRedux:int;
		static var currentRedux:int;
		static var elimUpgrade:int;
		static var timedUpgrade:int;
		static var movesUpgrade:int;
		static var firstPlay:Boolean = true;
		static var ratingSupported:Boolean = false;
		
		
		static function setup(stage:Stage):void {
			stageRef = stage;
			
			// TEXTURES
			Atlas.setup();
			
			
			// SCREEN SCALE
			rectSprite = new Sprite();
			stage.addChild(rectSprite);
			rectFiller = Atlas.generate("filler");
			rectFiller.visible = false;
			rectFiller.width = int(Main.screenWidth);
			rectFiller.height = int(Main.screenWidth * (1020/640));

			if (rectFiller.height > adBound) {
				rectDiff = rectFiller.height - adBound;
				rectScale = adBound/rectFiller.height;
				
				rectFiller.width = int(rectFiller.width * rectScale);
				rectFiller.height = int(rectFiller.height * rectScale);
			}
			
			rectSprite.addChild(rectFiller);
			rectSprite.x = int(Main.screenWidth/2 - rectSprite.width/2);
			if (rectSprite.height < adBound) {
				rectSprite.y = int((adBound - rectSprite.height)/2);
			}
			
			
			// ADS AND STORE
			if (CONFIG::AIR) {
				if (CONFIG::ANDROID) {
					AdsAndroid.setup();
					StoreAndroid.setup();
				}
				if (CONFIG::IOS) {
					//
					StoreApple.setup();
				}
			}
			
			
			// AD AREA
			adArea = new Sprite();
			stageRef.addChild(adArea);
			adFiller = Atlas.generate("filler");
			adFiller.width = Main.screenWidth;
			adFiller.height = adHeight;
			adFiller.color = 0x0B94A2;
			adFiller.alpha = 0.0;
			adArea.addChild(adFiller);
			adArea.y = Main.screenHeight - adArea.height;
			adArea.flatten();
			
			
			// SAVE FILE
			Data.setup();
			
			
			// CHECK DAILY HIGH SCORE
			Score.checkHigh();
			Score.resetTimer = new Timer(1000);
			Score.resetTimer.addEventListener(TimerEvent.TIMER, Score.resetHandler);
			
			
			// RATE REDUX IF CLOSED EARLY
			Redux.resumeRateRedux();
			
			
			// UPDATE ELIMS
			totalRedux = Data.saveObj.totalRedux;
			currentRedux = Data.saveObj.currentRedux;
			elimUpgrade = Data.saveObj.elimUpgrade;
			timedUpgrade = Data.saveObj.timedUpgrade;
			movesUpgrade = Data.saveObj.movesUpgrade;
			
			
			// INIT AUDIO
			Audio.setup();
			
			
			// CHECK FOR VIBRATION
			Vibrate.check();
			
			
			// RATINGS
			if (CONFIG::AIR) {
				Rating.setup(stage);
			}
			
			
			// FOCUS 
			if (CONFIG::AIR) {
				Focus.setup();
			}
		}
	}
}
