package  {
	
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import starling.display.Image;
	
	
	public class Hud {
		
		static var hudSprite:Sprite;
		static var spriteAnchor:Image;
		static var scoreHeader:TextField;
		static var score:TextField;
		static var highScoreHeader:TextField;
		static var highScore:TextField;
		static var timedHeader:TextField;
		static var timed:TextField;
		static var movesHeader:TextField;
		static var moves:TextField;
		static var gameTimer:Timer;
		static var reduxText:TextField;
		static var colorTheme:int = Data.saveObj.colors;
		static var theme:String = Data.saveObj.theme;
		static var vibrate:String = Data.saveObj.vibrate;
		static var canVibrate:Boolean;
		static var stageColorLight:uint = 0xFFFFFF;
		static var stageColorDark:uint = 0x000000;
		static var gameTextSize:int = Environment.rectSprite.height*0.051;
		static var gameTextColorLight:uint = 0x000000;
		static var gameTextColorDark:uint = 0xFFFFFF;
		static var gameTextColor:uint = gameTextColorDark;
		static var subTextColor:uint = 0x7E8995;
		static var iconsColorLight:uint = 0x80929F;
		static var iconsColorLightOn:uint = 0x5E6B74;
		static var iconsColorDark:uint = 0x6D7D87;
		static var iconsColorDarkOn:uint = 0xB8CED9;
		static var iconsOnColor:uint = iconsColorDarkOn;
		static var iconsOffColor:uint = iconsColorDark;
		static var elimTextColorOn:uint = iconsColorDarkOn;
		static var elimTextColorOff:uint = iconsColorDark;
		static var hudTextColorLight:uint = 0x000000;
		static var hudTextColorDark:uint = 0xFFFFFF;
		static var hudTextColor:int = hudTextColorLight;
		static var statsBoxColorLight:uint = 0xECECEC;
		static var statsBoxColorDark:uint = 0x232323;
		static var statsBoxColor:uint = statsBoxColorLight;
		static var statsBoxColorOnLight:uint = 0xDBDBDB;
		static var statsBoxColorOnDark:uint = 0x333333;
		static var statsBoxColorOn:uint = statsBoxColorOnLight;
		static var storeBoxColorLight:uint = statsBoxColorLight;
		static var storeBoxColorDark:uint = statsBoxColorDark;
		static var storeBoxColor:uint = statsBoxColorLight;
		static var storeBoxColorOnLight:uint = 0xDBDBDB;
		static var storeBoxColorOnDark:uint = 0x313131;
		static var storeBoxColorOn:uint = statsBoxColorOnLight;
		static var statsArrowColorLight:uint = 0xC2C2C2;
		static var statsArrowColorDark:uint = 0x545454;
		static var statsArrowColor:uint = statsArrowColorLight;
		static var oldTime:int;
		static var newTime:int;
		static var timeElapsed:int;
		static var defaultTimerTime:int;
		static var timeLeft:int;
		static var highlightColorList:Array = [Board.dotColors0[0], Board.dotColors1[3], Board.dotColors2[1], Board.dotColors3[1]];


		static function setup(stage:Stage, id:int) {
			Score.setup(id);
			
			hudSprite = new Sprite();
			stage.addChild(hudSprite);
			Screens.currentScreenObjects.push(hudSprite);
			
			scoreHeader = new TextField(int(Environment.rectSprite.width*0.25), int(Environment.rectSprite.height*0.06), String("SCORE"), "Font", gameTextSize, hudTextColor, false);
			scoreHeader.hAlign = HAlign.LEFT;
			scoreHeader.vAlign = VAlign.TOP;
			scoreHeader.x = int(Environment.rectSprite.width*0.078125 + Environment.rectSprite.x);
			scoreHeader.y = int(Environment.rectSprite.height*0.0588 + Environment.rectSprite.y);
			scoreHeader.touchable = false;
			scoreHeader.autoSize = TextFieldAutoSize.HORIZONTAL;
			hudSprite.addChild(scoreHeader);
			Screens.currentScreenObjects.push(scoreHeader);
			
			score = new TextField(int(Environment.rectSprite.width*0.25), int(Environment.rectSprite.height*0.06), String(Score.addCommas(Score.currentScore)), "Font", gameTextSize, hudTextColor, false);
			score.hAlign = HAlign.LEFT;
			score.vAlign = VAlign.TOP;
			score.x = int(Environment.rectSprite.width*0.078125 + Environment.rectSprite.x);
			score.y = int(Environment.rectSprite.height*0.105 + Environment.rectSprite.y);
			score.touchable = false;
			score.autoSize = TextFieldAutoSize.HORIZONTAL;
			hudSprite.addChild(score);
			Screens.currentScreenObjects.push(score);
			
			if (Screens.gameMode == "perpetua") {
				setPerpetua();
			} else
			if (Screens.gameMode == "timed") {
				setTimed();
			} else
			if (Screens.gameMode == "moves") {
				setMoves();
			}
			
			reduxText = new TextField(int(Environment.rectSprite.width*0.38),  int(Environment.rectSprite.height*0.15), String("ELIMS\n" + Score.addCommas(Environment.currentRedux)), "Font", int(Environment.rectSprite.height*.0475), iconsOffColor, false);
			reduxText.hAlign = HAlign.CENTER;
			reduxText.vAlign = VAlign.CENTER;
			reduxText.x = int(Main.screenWidth/2 - reduxText.width/2);
			reduxText.y = Board.reduxIcon.y + (Board.reduxIcon.height - reduxText.height)/2;
			reduxText.touchable = false;
			hudSprite.addChild(reduxText);
			Screens.currentScreenObjects.push(reduxText);
			
			hudSprite.flatten();
		}
		
		
		static function setPerpetua() {
			highScoreHeader = new TextField(int(Environment.rectSprite.width*0.225), int(Environment.rectSprite.height*0.06), String("BEST"), "Font", gameTextSize, hudTextColor, false);
			highScoreHeader.hAlign = HAlign.RIGHT;
			highScoreHeader.vAlign = VAlign.TOP;			
			highScoreHeader.x = int(Main.screenWidth - highScoreHeader.width - scoreHeader.x);
			highScoreHeader.y = int(Environment.rectSprite.height*0.0588 + Environment.rectSprite.y);
			highScoreHeader.touchable = false;
			hudSprite.addChild(highScoreHeader);
			Screens.currentScreenObjects.push(highScoreHeader);
			
			highScore = new TextField(int(Environment.rectSprite.width*0.40), int(Environment.rectSprite.height*0.06), String(Score.addCommas(Score.highScore)), "Font", gameTextSize, hudTextColor, false);
			highScore.hAlign = HAlign.RIGHT;
			highScore.vAlign = VAlign.TOP;
			highScore.x = int(Main.screenWidth - highScore.width - score.x);
			highScore.y = int(Environment.rectSprite.height*0.105 + Environment.rectSprite.y);
			highScore.touchable = false;
			hudSprite.addChild(highScore);
			Screens.currentScreenObjects.push(highScore);
		}
		
		
		static function setTimed() {
			timedHeader = new TextField(int(Environment.rectSprite.width*0.3), int(Environment.rectSprite.height*0.06), String("TIME"), "Font", gameTextSize, hudTextColor, false);
			timedHeader.hAlign = HAlign.RIGHT;
			timedHeader.vAlign = VAlign.TOP;
			timedHeader.x = int(Main.screenWidth - timedHeader.width - scoreHeader.x);
			timedHeader.y = int(Environment.rectSprite.height*0.0588 + Environment.rectSprite.y);
			timedHeader.touchable = false;
			hudSprite.addChild(timedHeader);
			Screens.currentScreenObjects.push(timedHeader);			
			
			timed = new TextField(int(Environment.rectSprite.width*0.40), int(Environment.rectSprite.height*0.06), String(Score.addZeros(Score.timeLeft)), "Font", gameTextSize, hudTextColor, false);
			timed.hAlign = HAlign.RIGHT;
			timed.vAlign = VAlign.TOP;
			timed.x = int(Main.screenWidth - timed.width - score.x);
			timed.y = int(Environment.rectSprite.height*0.105 + Environment.rectSprite.y);
			timed.touchable = false;
			hudSprite.addChild(timed);
			Screens.currentScreenObjects.push(timed);
			
			defaultTimerTime = 1000;
			timeLeft = defaultTimerTime;
			timeElapsed = 0;
			gameTimer = new Timer(defaultTimerTime);
			gameTimer.addEventListener(TimerEvent.TIMER, handleTimer);
		}
		
		
		static function pauseHandler():void {
			if (Screens.gameMode && Screens.gameMode == "timed") {
				if (gameTimer.running) {
					newTime = getTimer();
					gameTimer.reset();
					timeElapsed = newTime - oldTime;
					
					timeLeft -= timeElapsed;
					
					if (timeLeft < 0) {						
						timeLeft = 0;
					}
					
					gameTimer.delay = timeLeft;
				}
			}
		}
		
		
		static function unpauseHandler():void {
			if (Screens.gameMode && Screens.gameMode == "timed") {
				if (!Drop.firstDrop) {
					gameTimer.start();
					oldTime = getTimer();
				}
			}
		}
		
		
		static function handleTimer(e:TimerEvent):void {
			Score.timeLeft--;
			if (Score.timeLeft == 0) {
				
				Board.boardIsActive = false;
				gameTimer.removeEventListener(TimerEvent.TIMER, handleTimer);

				if (Board.reduxRing) {
					Redux.resetRedux();
				}
				Board.reduxIcon.removeEventListener(TouchEvent.TOUCH, Board.reduxTouchHandler);
				Board.statsIcon.removeEventListener(TouchEvent.TOUCH, Board.statsIconTouchHandler);
				Environment.stageRef.removeEventListener(TouchEvent.TOUCH, Board.stageTouchHandler);				
				Environment.stageRef.removeEventListener(Event.ENTER_FRAME, Animations.fadeOut);
				
				End.lose();
				
			} else {
				gameTimer.reset();
				gameTimer.delay = defaultTimerTime;
				timeLeft = defaultTimerTime;				
				oldTime = getTimer();
				gameTimer.start();
			}
			
			Hud.hudSprite.unflatten();
			Hud.timed.text = String(Score.addZeros(Score.timeLeft));
			Hud.hudSprite.flatten();
		}
		
		
		static function setMoves() {
			
			movesHeader = new TextField(int(Environment.rectSprite.width*0.35), int(Environment.rectSprite.height*0.06), String("MOVES"), "Font", gameTextSize, hudTextColor, false);
			movesHeader.hAlign = HAlign.RIGHT;
			movesHeader.vAlign = VAlign.TOP;
			movesHeader.x = int(Main.screenWidth - movesHeader.width - scoreHeader.x);
			movesHeader.y = int(Environment.rectSprite.height*0.0588 + Environment.rectSprite.y);
			movesHeader.touchable = false;
			hudSprite.addChild(movesHeader);
			Screens.currentScreenObjects.push(movesHeader);
			
			moves = new TextField(int(Environment.rectSprite.width*0.4), int(Environment.rectSprite.height*0.06), String(Score.addZeros(Score.movesLeft)), "Font", gameTextSize, hudTextColor, false);
			moves.hAlign = HAlign.RIGHT;
			moves.vAlign = VAlign.TOP;
			moves.x = int(Main.screenWidth - moves.width - score.x);
			moves.y = int(Environment.rectSprite.height*0.105 + Environment.rectSprite.y);
			moves.touchable = false;
			hudSprite.addChild(moves);
			Screens.currentScreenObjects.push(moves);
		}
		
		
		static function changeBrightness() {			
			if (Stats.isPaused) {
				Board.boardSprite.unflatten();
			}
			
			if (hudSprite) {
				hudSprite.unflatten();
			}
			
			if (theme == "dark") {
				theme = "light";
				
				Environment.stageRef.color = stageColorLight;
				gameTextColor = gameTextColorLight;
				hudTextColor = hudTextColorLight;
				statsBoxColor = statsBoxColorLight;
				storeBoxColor = storeBoxColorLight;
				statsArrowColor = statsArrowColorLight;
				
				IntroSelect.backTextColor = gameTextColorLight;
				Options.saveTextColor = gameTextColorLight;
				Contact.backTextColor = gameTextColorLight;
				statsBoxColorOn = statsBoxColorOnLight;
				storeBoxColorOn = storeBoxColorOnLight;
				
				iconsOnColor = iconsColorLightOn;
				iconsOffColor = iconsColorLight;
		
				elimTextColorOn = iconsColorLightOn;
				elimTextColorOff = iconsColorLight;
				
				Intro.buttonColorOff = Environment.stageRef.color;
				Intro.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
				Intro.textColorOff = gameTextColorLight;
				Intro.textColorOn = gameTextColorDark;
				
				IntroSelect.buttonColorOff = Environment.stageRef.color;
				IntroSelect.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
				IntroSelect.textColorOff = gameTextColorLight;
				IntroSelect.textColorOn = gameTextColorDark;
				
				if (Intro.statsIcon) {
					Intro.statsIcon.color = Hud.iconsOffColor;
					Intro.optionsIcon.color = Hud.iconsOffColor;
				}
				
				if (Stats.currentElimsBG) {
					Stats.currentElimsBG.color = statsBoxColor;
					Stats.scoresBG.color = statsBoxColor;
					Stats.arrowLeft.color = statsArrowColor;
					Stats.arrowRight.color = statsArrowColor;
				}
				
				if (Screens.currentScreen == "intro" || Screens.currentScreen == "over") {
					Intro.perpetuaButtonFiller.color = Environment.stageRef.color;
					Intro.timedButtonFiller.color = Environment.stageRef.color;
					Intro.movesButtonFiller.color = Environment.stageRef.color;
					
					Intro.perpetuaButtonText.color = gameTextColor;
					Intro.timedButtonText.color = gameTextColor;
					Intro.movesButtonText.color = gameTextColor;
					
					if (IntroSelect.perpetuaButtonFiller) {
						IntroSelect.perpetuaButtonFiller.color = Environment.stageRef.color;
						IntroSelect.timedButtonFiller.color = Environment.stageRef.color;
						IntroSelect.movesButtonFiller.color = Environment.stageRef.color;
						
						IntroSelect.perpetuaButtonText.color = gameTextColor;
						IntroSelect.timedButtonText.color = gameTextColor;
						IntroSelect.movesButtonText.color = gameTextColor;
					}
				}
				
				if (Screens.currentScreen == "options") {
					Options.optionsText.color = gameTextColor;
					Options.themeButtonText.color = gameTextColor;
					Options.soundsButtonText.color = gameTextColor;
					
					if (canVibrate) {
						Options.vibrateButtonText.color = gameTextColor;
					}
					
					Options.saveButtonText.color = gameTextColor;
					Options.saveButtonFiller.color = Environment.stageRef.color;
				}
				
				if (Screens.gameMode == "perpetua") {
					scoreHeader.color = hudTextColor;
					score.color = hudTextColor;
					highScoreHeader.color = hudTextColor;
					highScore.color = hudTextColor;
					
					Board.statsIcon.color = iconsOffColor;
					
					if (Redux.reduxOn) {
						Board.reduxIcon.color = iconsOnColor;
						Board.reduxRing.color = iconsOnColor;
						reduxText.color = iconsOnColor;
					} else {
						Board.reduxIcon.color = iconsOffColor;
						Board.reduxRing.color = iconsOffColor;
						reduxText.color = iconsOffColor;
					}					
				}
				
				if (Screens.gameMode == "timed" && Score.prevID) {
					scoreHeader.color = hudTextColor;
					score.color = hudTextColor;
					timedHeader.color = hudTextColor;
					timed.color = hudTextColor;
					
					Board.statsIcon.color = iconsOffColor;
					
					if (Redux.reduxOn) {
						Board.reduxIcon.color = iconsOnColor;
						Board.reduxRing.color = iconsOnColor;
						reduxText.color = iconsOnColor;
					} else {
						Board.reduxIcon.color = iconsOffColor;
						Board.reduxRing.color = iconsOffColor;
						reduxText.color = iconsOffColor;
					}
				}
				
				if (Screens.gameMode == "moves" && Score.prevID) {
					scoreHeader.color = hudTextColor;
					score.color = hudTextColor;
					movesHeader.color = hudTextColor;
					moves.color = hudTextColor;
					
					Board.statsIcon.color = iconsOffColor;
					
					if (Redux.reduxOn) {
						Board.reduxIcon.color = iconsOnColor;
						Board.reduxRing.color = iconsOnColor;
						reduxText.color = iconsOnColor;
					} else {
						Board.reduxIcon.color = iconsOffColor;
						Board.reduxRing.color = iconsOffColor;
						reduxText.color = iconsOffColor;
					}
				}
				
			} else if (theme == "light") {
				theme = "dark";
				
				Environment.stageRef.color = stageColorDark;
				gameTextColor = gameTextColorDark;
				hudTextColor = hudTextColorDark;
				statsBoxColor = statsBoxColorDark;
				storeBoxColor = storeBoxColorDark;
				statsArrowColor = statsArrowColorDark;
				
				IntroSelect.backTextColor = gameTextColorDark;
				Options.saveTextColor = gameTextColorDark;
				Contact.backTextColor = gameTextColorDark;
				statsBoxColorOn = statsBoxColorOnDark;
				storeBoxColorOn = storeBoxColorOnDark;
				
				iconsOnColor = iconsColorDarkOn;
				iconsOffColor = iconsColorDark;
		
				elimTextColorOn = iconsColorDarkOn;
				elimTextColorOff = iconsColorDark;
				
				Intro.buttonColorOff = Environment.stageRef.color;
				Intro.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
				Intro.textColorOff = gameTextColorDark;
				Intro.textColorOn = gameTextColorLight;
				
				IntroSelect.buttonColorOff = Environment.stageRef.color;
				IntroSelect.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
				IntroSelect.textColorOff = gameTextColorDark;
				IntroSelect.textColorOn = gameTextColorLight;
				
				if (Intro.statsIcon) {
					Intro.statsIcon.color = Hud.iconsOffColor;
					Intro.optionsIcon.color = Hud.iconsOffColor;
				}
				
				if (Stats.currentElimsBG) {
					Stats.currentElimsBG.color = statsBoxColor;
					Stats.scoresBG.color = statsBoxColor;
					Stats.arrowLeft.color = statsArrowColor;
					Stats.arrowRight.color = statsArrowColor;
				}
				
				if (Screens.currentScreen == "intro" || Screens.currentScreen == "over") {
					Intro.perpetuaButtonFiller.color = Environment.stageRef.color;
					Intro.timedButtonFiller.color = Environment.stageRef.color;
					Intro.movesButtonFiller.color = Environment.stageRef.color;
					
					Intro.perpetuaButtonText.color = gameTextColor;
					Intro.timedButtonText.color = gameTextColor;
					Intro.movesButtonText.color = gameTextColor;
					
					if (IntroSelect.perpetuaButtonFiller) {
						IntroSelect.perpetuaButtonFiller.color = Environment.stageRef.color;
						IntroSelect.timedButtonFiller.color = Environment.stageRef.color;
						IntroSelect.movesButtonFiller.color = Environment.stageRef.color;
						
						IntroSelect.perpetuaButtonText.color = gameTextColor;
						IntroSelect.timedButtonText.color = gameTextColor;
						IntroSelect.movesButtonText.color = gameTextColor;
					}
				}
				
				if (Screens.currentScreen == "options") {
					Options.optionsText.color = gameTextColor;
					Options.themeButtonText.color = gameTextColor;
					Options.soundsButtonText.color = gameTextColor;
					
					if (canVibrate) {
						Options.vibrateButtonText.color = gameTextColor;
					}
					
					Options.saveButtonText.color = gameTextColorDark;
					Options.saveButtonFiller.color = Environment.stageRef.color;
				}
				
				if (Screens.gameMode == "perpetua") {
					scoreHeader.color = hudTextColor;
					score.color = hudTextColor;
					highScoreHeader.color = hudTextColor;
					highScore.color = hudTextColor;
					
					Board.statsIcon.color = iconsOffColor;
					
					if (Redux.reduxOn) {
						Board.reduxIcon.color = iconsOnColor;
						Board.reduxRing.color = iconsOnColor;
						reduxText.color = iconsOnColor;
					} else {
						Board.reduxIcon.color = iconsOffColor;
						Board.reduxRing.color = iconsOffColor;
						reduxText.color = iconsOffColor;
					}	
				}
				
				if (Screens.gameMode == "timed" && Score.prevID) {
					scoreHeader.color = hudTextColor;
					score.color = hudTextColor;
					timedHeader.color = hudTextColor;
					timed.color = hudTextColor;
					
					Board.statsIcon.color = iconsOffColor;
					
					if (Redux.reduxOn) {
						Board.reduxIcon.color = iconsOnColor;
						Board.reduxRing.color = iconsOnColor;
						reduxText.color = iconsOnColor;
					} else {
						Board.reduxIcon.color = iconsOffColor;
						Board.reduxRing.color = iconsOffColor;
						reduxText.color = iconsOffColor;
					}	
				}
				
				if (Screens.gameMode == "moves" && Score.prevID) {
					scoreHeader.color = hudTextColor;
					score.color = hudTextColor;
					movesHeader.color = hudTextColor;
					moves.color = hudTextColor;
					
					Board.statsIcon.color = iconsOffColor;
					
					if (Redux.reduxOn) {
						Board.reduxIcon.color = iconsOnColor;
						Board.reduxRing.color = iconsOnColor;
						reduxText.color = iconsOnColor;
					} else {
						Board.reduxIcon.color = iconsOffColor;
						Board.reduxRing.color = iconsOffColor;
						reduxText.color = iconsOffColor;
					}	
				}
			}
			
			if (hudSprite) {
				hudSprite.flatten();
			}
			
			if (Stats.isPaused) {
				Board.boardSprite.flatten();
				
				Stats.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
				
				
				Stats.resumeButtonFiller.color = Intro.buttonColorOff;
				Stats.resumeButtonText.color = Intro.textColorOff;

				Stats.optionsButtonFiller.color = Intro.buttonColorOff;
				Stats.optionsButtonText.color = Intro.textColorOff;

				Stats.exitButtonFiller.color = Intro.buttonColorOff;
				Stats.exitButtonText.color = Intro.textColorOff;
			}		
			
			Data.saveObj.theme = theme;
			Data.flushSave();
		}
		
		
		static function initBrightness() {
			if (Data.saveObj.theme == "light") {
				theme = "dark";
			} else {
				theme = "light";
			}
			changeBrightness();
		}
	}
}
