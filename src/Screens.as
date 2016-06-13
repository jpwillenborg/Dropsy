package  {
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	public class Screens {
		
		static var transVal:int = 100;
		static var currentScreen:String = "none";
		static var gameMode:String = "none";
		static var loadingScreenObjects:Array = [];
		static var tutorialScreenObjects:Array = [];
		static var example1ScreenObjects:Array = [];
		static var example2ScreenObjects:Array = [];
		static var example3ScreenObjects:Array = [];
		static var example4ScreenObjects:Array = [];
		static var ratingScreenObjects:Array = [];
		static var introScreenObjects:Array = [];
		static var introSelectScreenObjects:Array = [];
		static var currentScreenObjects:Array = [];
		static var statsScreenObjects:Array = [];
		static var optionsScreenObjects:Array = [];
		static var contactScreenObjects:Array = [];
		static var storeScreenObjects:Array = [];
		
		
		static function setLoading() {
			currentScreen = "loading";
			Loading.display(Environment.stageRef);
		}
		
		
		static function setTutorial() {
			currentScreen = "tutorial";
			Tutorial.display(Environment.stageRef);
		}
		
		
		static function setRating() {
			currentScreen = "rating";
			Rating.setup(Environment.stageRef);
		}
		
		
		static function setIntro() {	
			clearStoreListeners();
			Redux.balanceRedux();
			currentScreen = "intro";
			Intro.display(Environment.stageRef);
		}
		
		
		static function setIntroSelect() {
			clearStoreListeners();
			Redux.balanceRedux();
			currentScreen = "intro";
			IntroSelect.display(Environment.stageRef);
		}
		
		
		static function setOptions() {
			clearStoreListeners();
			currentScreen = "options";
			Options.display(Environment.stageRef);
		}
		
		
		static function setContact() {
			clearStoreListeners();
			currentScreen = "contact";
			Contact.display(Environment.stageRef);
		}
		
		
		static function setGame(id) {
			clearStoreListeners();
			Score.currentGameMode = id;
			
			Score.currentScore = 0;
			Score.movesLeft = Score.movesLeftInit;
			Score.timeLeft = Score.timeLeftInit;
			
			Redux.balanceRedux();
			Redux.newRedux();
			
			currentScreen = gameMode;
			Board.setup(Environment.stageRef);
			Hud.setup(Environment.stageRef, id);
		}
		
		
		static function setStats(id:int) {
			clearStoreListeners();
			Score.checkHigh();
			currentScreen = "stats";
			Stats.display(Environment.stageRef, id);
		}
		
		
		static function unsetStats() {
			clearStoreListeners();
			Stats.isPaused = false;
			Stats.resumeButtonOn = false;
			
			Board.boardSprite.unflatten();
			Hud.hudSprite.unflatten();
			
			Board.statsIcon.color = Hud.iconsOffColor;
			
			for each (var id0 in Screens.currentScreenObjects) {
				id0.visible = true;
			}			
			
			if (Screens.gameMode == "timed") {
				Hud.unpauseHandler();
			}
			
			Hud.reduxText.text = String("ELIMS\n" + Score.addCommas(Environment.currentRedux));
			
			if (Score.resetTimer.running) {
				Score.resetTimer.stop();
			}
			
			Data.flushSave();
			
			var touchDelay:Number = setTimeout(touchDelayHandler, 250);
			function touchDelayHandler() {
				Environment.stageRef.addEventListener(TouchEvent.TOUCH, Board.stageTouchHandler);
			}
		}
		
		
		static function setStore() {
			currentScreen = "stats";
			Store.display(Environment.stageRef);
		}
		
		
		static function clearLoadingListeners() {

		}
		
		
		static function clearTutorialListeners() {
		}
		
		
		static function clearIntroListeners() {
			Environment.stageRef.removeEventListener(TouchEvent.TOUCH, Intro.stageIntroTouchHandler);
		}
		
		
		static function clearIntroSelectListeners() {
			Environment.stageRef.removeEventListener(TouchEvent.TOUCH, IntroSelect.stageIntroSelectTouchHandler);
		}
		
		
		static function clearOptionsListeners() {
			Environment.stageRef.removeEventListener(TouchEvent.TOUCH, Options.stageOptionsTouchHandler);
		}
		
		
		static function clearContactListeners() {
			Environment.stageRef.removeEventListener(TouchEvent.TOUCH, Contact.stageContactTouchHandler);
		}
		
		
		static function clearStatsListeners() {
			Environment.stageRef.removeEventListener(TouchEvent.TOUCH, Stats.stageStatsTouchHandler);
		}
		
		
		static function clearStoreListeners() {
			Environment.stageRef.removeEventListener(TouchEvent.TOUCH, Store.stageStoreTouchHandler);
		}
		
		
		static function clearLoadingScreen() {
			for (var i:int = loadingScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(loadingScreenObjects[i]);
				loadingScreenObjects[i].dispose();
				loadingScreenObjects[i] = null;
				loadingScreenObjects.pop();
			}
		}	
		
		
		static function clearTutorialScreen() {
			for (var i:int = tutorialScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(tutorialScreenObjects[i]);
				tutorialScreenObjects[i].dispose();
				tutorialScreenObjects[i] = null;
				tutorialScreenObjects.pop();
			}
		}	
		
		
		static function clearExample1Screen() {
			for (var i:int = example1ScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(example1ScreenObjects[i]);
				example1ScreenObjects[i].dispose();
				example1ScreenObjects[i] = null;
				example1ScreenObjects.pop();
			}
		}
		
		static function clearExample2Screen() {
			for (var i:int = example2ScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(example2ScreenObjects[i]);
				example2ScreenObjects[i].dispose();
				example2ScreenObjects[i] = null;
				example2ScreenObjects.pop();
			}
		}
		
		static function clearExample3Screen() {
			for (var i:int = example3ScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(example3ScreenObjects[i]);
				example3ScreenObjects[i].dispose();
				example3ScreenObjects[i] = null;
				example3ScreenObjects.pop();
			}
		}	
		
		static function clearExample4Screen() {
			for (var i:int = example4ScreenObjects.length-1; i >=0; i--) {
				Starling.current.nativeOverlay.removeChild(example4ScreenObjects[i]);
				example4ScreenObjects[i] = null;
				example4ScreenObjects.pop();
			}
		}	
		
		
		static function clearIntroScreen() {
			for (var i:int = introScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(introScreenObjects[i]);
				introScreenObjects[i].dispose();
				introScreenObjects[i] = null;
				introScreenObjects.pop();
			}
		}
		
		
		static function clearIntroSelectScreen() {
			for (var i:int = introSelectScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(introSelectScreenObjects[i]);
				introSelectScreenObjects[i].dispose();
				introSelectScreenObjects[i] = null;
				introSelectScreenObjects.pop();
			}
		}
		
		
		static function clearOptionsScreen() {
			for (var i:int = optionsScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(optionsScreenObjects[i]);
				optionsScreenObjects[i].dispose();
				optionsScreenObjects[i] = null;
				optionsScreenObjects.pop();
			}
		}
		
		
		static function clearContactScreen() {
			for (var i:int = contactScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(contactScreenObjects[i]);
				contactScreenObjects[i].dispose();
				contactScreenObjects[i] = null;
				contactScreenObjects.pop();
			}
		}
		
		
		static function clearCurrentScreen() {
			for (var i:int = currentScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(currentScreenObjects[i]);
				currentScreenObjects[i].dispose();
				currentScreenObjects[i] = null;
				currentScreenObjects.pop();
			}
		}
		
		
		static function clearStatsScreen() {
			for (var i:int = statsScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(statsScreenObjects[i]);
				statsScreenObjects[i].dispose();
				statsScreenObjects[i] = null;
				statsScreenObjects.pop();
			}
		}
		
		
		static function clearStoreScreen() {
			for (var i:int = storeScreenObjects.length-1; i >=0; i--) {
				Environment.stageRef.removeChild(storeScreenObjects[i]);
				storeScreenObjects[i].dispose();
				storeScreenObjects[i] = null;
				storeScreenObjects.pop();
			}
		}
	}
}
