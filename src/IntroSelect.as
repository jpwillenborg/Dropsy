package  {
	
	import flash.geom.Point;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Stage;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	public class IntroSelect {
		
		static var point:Point;
		static var introSelectTouchList:Vector.<Touch>;
		static var logoSprite:Sprite;
		static var gameLogo:Image;
		static var logoLetters:Array = ["d","r","o","p","s","y"];
		static var logoList:Array = [];
		static var perpetuaButton:Sprite;
		static var timedButton:Sprite;
		static var movesButton:Sprite;
		static var perpetuaButtonFiller:Image;
		static var timedButtonFiller:Image;
		static var movesButtonFiller:Image;
		static var perpetuaButtonText:TextField;
		static var timedButtonText:TextField;
		static var movesButtonText:TextField;
		static var backButton:Sprite;
		static var backButtonFiller:Image;
		static var backButtonText:TextField;
		static var backTextColor:uint = textColorOff;
		static var backButtonOn:Boolean = false;
		static var modeText:TextField;
		static var modeSubText:TextField;
		static var perpetuaButtonOn:Boolean = false;
		static var timedButtonOn:Boolean = false;
		static var movesButtonOn:Boolean = false;
		static var timedMode:Boolean = false;
		static var movesMode:Boolean = false;
		static var statsIcon:Image;
		static var optionsIcon:Image;
		static var gearTouchList:Vector.<Touch>;
		static var buttonColorOff:uint = Hud.stageColorLight;
		static var buttonColorOn:uint = Hud.highlightColorList[Hud.colorTheme];
		static var textColorOff:uint = Hud.gameTextColor;
		static var textColorOn:uint = Environment.stageRef.color;
		static var redBox:Image;
		static var introSelectMode:int;
		
		
		static function display(stage:Stage) {
			buttonColorOn = Data.saveObj.highlight;
			point = new Point();
			
			modeText = new TextField(int(Environment.rectSprite.width), int(Environment.rectSprite.height*0.3), String("MODE"), "Font", int(Environment.rectSprite.height*0.06275), textColorOff, false);
			if (Screens.gameMode == "timed") {
				modeText.text = String("HOW MANY\nSECONDS?");
			}
			if (Screens.gameMode == "moves") {
				modeText.text = String("HOW MANY\nMOVES?");
			}
			modeText.hAlign = HAlign.CENTER;
			modeText.vAlign = VAlign.TOP;
			modeText.x = int(Main.screenWidth/2 - modeText.width/2);
			modeText.y = int((Environment.rectSprite.height*0.0784) + Environment.rectSprite.y);
			modeText.touchable = false;
			stage.addChild(modeText);
			Screens.introSelectScreenObjects.push(modeText);
			
			modeSubText = new TextField(int(Environment.rectSprite.width), int(Environment.rectSprite.height*0.0982), String("MODE"), "Font", int(Environment.rectSprite.height*0.0314), Hud.subTextColor, false);
			if (Screens.gameMode == "timed") {
				modeSubText.text = String("10 SECONDS ADDED FOR\nEVERY 15 POINTS EARNED");
			}
			if (Screens.gameMode == "moves") {
				modeSubText.text = String("10 MOVES ADDED FOR\nEVERY 15 POINTS EARNED");
			}
			modeSubText.hAlign = HAlign.CENTER;
			modeSubText.vAlign = VAlign.TOP;
			modeSubText.x = int(Main.screenWidth/2 - modeSubText.width/2);
			modeSubText.y = int((Environment.rectSprite.height*0.2589) + Environment.rectSprite.y);
			modeSubText.touchable = false;
			stage.addChild(modeSubText);
			Screens.introSelectScreenObjects.push(modeSubText);
			
			perpetuaButton = new Sprite();
			perpetuaButton.x = 0;
			perpetuaButton.y = int((Environment.rectSprite.height*0.4216) + Environment.rectSprite.y);
			stage.addChild(perpetuaButton);
			perpetuaButtonFiller = Atlas.generate("filler");
			perpetuaButtonFiller.width = Main.screenWidth + 50;
			perpetuaButtonFiller.height = int(Environment.rectSprite.height*0.09412);
			perpetuaButtonFiller.color = buttonColorOff;
			perpetuaButton.addChild(perpetuaButtonFiller);
			perpetuaButtonText = new TextField(int(Environment.rectSprite.width*0.625), int(Environment.rectSprite.height*0.09412), String("PERPETUA"), "Font", int(Environment.rectSprite.height*0.06275), textColorOff, false);
			if (Screens.gameMode == "timed") {
				perpetuaButtonText.text = String(Score.timedOptions[0]);
			}
			if (Screens.gameMode == "moves") {
				perpetuaButtonText.text = String(Score.movesOptions[0]);
			}
			perpetuaButtonText.hAlign = HAlign.CENTER;
			perpetuaButtonText.vAlign = VAlign.CENTER;
			perpetuaButtonText.x = int(Main.screenWidth/2 - perpetuaButtonText.width/2);
			perpetuaButtonText.touchable = false;
			perpetuaButton.addChild(perpetuaButtonText);
			Screens.introSelectScreenObjects.push(perpetuaButton);
			
			timedButton = new Sprite();
			timedButton.x = 0;
			timedButton.y = perpetuaButton.y + perpetuaButton.height;
			stage.addChild(timedButton);
			timedButtonFiller = Atlas.generate("filler");
			timedButtonFiller.width = Main.screenWidth + 50;
			timedButtonFiller.height = int(Environment.rectSprite.height*0.09412);
			timedButtonFiller.color = buttonColorOff;
			timedButton.addChild(timedButtonFiller);
			timedButtonText = new TextField(int(Main.screenWidth*0.625), int(Environment.rectSprite.height*0.09412), String("TIMED"), "Font", int(Environment.rectSprite.height*0.06275), textColorOff, false);
			if (Screens.gameMode == "timed") {
				timedButtonText.text = String(Score.timedOptions[1]);
			}
			if (Screens.gameMode == "moves") {
				timedButtonText.text = String(Score.movesOptions[1]);
			}
			timedButtonText.hAlign = HAlign.CENTER;
			timedButtonText.vAlign = VAlign.CENTER;
			timedButtonText.x = int(Main.screenWidth/2 - timedButtonText.width/2);
			timedButtonText.touchable = false;
			timedButton.addChild(timedButtonText);
			Screens.introSelectScreenObjects.push(timedButton);
			
			movesButton = new Sprite();			
			movesButton.x = 0;
			movesButton.y = timedButton.y + timedButton.height;
			stage.addChild(movesButton);
			movesButtonFiller = Atlas.generate("filler");
			movesButtonFiller.width = Main.screenWidth + 50;
			movesButtonFiller.height = int(Environment.rectSprite.height*0.09412);
			movesButtonFiller.color = buttonColorOff;
			movesButton.addChild(movesButtonFiller);
			movesButtonText = new TextField(int(Main.screenWidth*0.625), int(Environment.rectSprite.height*0.09412), String("MOVES"), "Font", int(Environment.rectSprite.height*0.06275), textColorOff, false);
			if (Screens.gameMode == "timed") {
				movesButtonText.text = String(Score.timedOptions[2]);
			}
			if (Screens.gameMode == "moves") {
				movesButtonText.text = String(Score.movesOptions[2]);
			}
			movesButtonText.hAlign = HAlign.CENTER;
			movesButtonText.vAlign = VAlign.CENTER;
			movesButtonText.x = int(Main.screenWidth/2 - movesButtonText.width/2);
			movesButtonText.touchable = false;
			movesButton.addChild(movesButtonText);
			Screens.introSelectScreenObjects.push(movesButton);
			
			backButton = new Sprite();			
			stage.addChild(backButton);
			backButtonFiller = Atlas.generate("filler");
			backButtonFiller.width = Main.screenWidth + 50;
			backButtonFiller.height = int(Environment.rectSprite.height*0.09412);
			backButtonFiller.color = stage.color;
			backButton.addChild(backButtonFiller);
			backButtonText = new TextField(int(Main.screenWidth*0.625), int(Environment.rectSprite.height*0.09412), String("BACK"), "Font", int(Environment.rectSprite.height*0.06275), backTextColor, false);
			backButtonText.hAlign = HAlign.CENTER;
			backButtonText.vAlign = VAlign.CENTER;
			backButtonText.x = int(Main.screenWidth/2 - backButtonText.width/2);
			backButtonText.touchable = false;
			backButton.x = 0;
			backButton.y = int((Environment.rectSprite.height*0.6981) + backButtonFiller.height + Environment.rectSprite.y);
			backButton.addChild(backButtonText);
			Screens.introSelectScreenObjects.push(backButton);
			
			var touchDelay:Number = setTimeout(touchDelayHandler, 250);
			function touchDelayHandler() {
				stage.addEventListener(TouchEvent.TOUCH, stageIntroSelectTouchHandler);
			}
		}
		
		
		static function stageIntroSelectTouchHandler(evt:TouchEvent):void {
			
			introSelectTouchList = evt.getTouches(Environment.stageRef);
			if (introSelectTouchList.length > 0) {
				
				point = introSelectTouchList[0].getLocation(Environment.stageRef);
				
				if (perpetuaButton.bounds.containsPoint(point)) {
					
					if (introSelectTouchList[0].phase == TouchPhase.BEGAN || introSelectTouchList[0].phase == TouchPhase.MOVED) {
						if (!perpetuaButtonOn) {
							perpetuaButtonFiller.color = buttonColorOn;
							timedButtonFiller.color = buttonColorOff;
							movesButtonFiller.color = buttonColorOff;
							
							perpetuaButtonText.color = textColorOn;
							timedButtonText.color = textColorOff;
							movesButtonText.color = textColorOff;
							
							perpetuaButtonOn = true;
							timedButtonOn = false;
							movesButtonOn = false;
							
							Audio.playButton();
						}
					}
					if (introSelectTouchList[0].phase == TouchPhase.ENDED) {
						
						perpetuaButtonOn = false;
						
						if (Screens.gameMode == "timed") {
							
							Screens.clearIntroSelectListeners();
							
							var introSelectTimerTimed0:Timer;			
							introSelectTimerTimed0 = new Timer(Screens.transVal);
							introSelectTimerTimed0.start();
							
							introSelectTimerTimed0.addEventListener(TimerEvent.TIMER, introSelectTimerTimed0Handler);
							function introSelectTimerTimed0Handler(evt:TimerEvent):void {
								introSelectTimerTimed0.stop();
								introSelectTimerTimed0.removeEventListener(TimerEvent.TIMER, introSelectTimerTimed0Handler);
								introSelectTimerTimed0 = null;
								
								Screens.clearIntroSelectScreen();
								Screens.setGame(Score.timedOptions[0]);
							}
							
						}
						if (Screens.gameMode == "moves") {
							
							Screens.clearIntroSelectListeners();
							
							var introSelectTimerMoves0:Timer;			
							introSelectTimerMoves0 = new Timer(Screens.transVal);
							introSelectTimerMoves0.start();
							
							introSelectTimerMoves0.addEventListener(TimerEvent.TIMER, introSelectTimerMoves0Handler);
							function introSelectTimerMoves0Handler(evt:TimerEvent):void {
								introSelectTimerMoves0.stop();
								introSelectTimerMoves0.removeEventListener(TimerEvent.TIMER, introSelectTimerMoves0Handler);
								introSelectTimerMoves0 = null;
								
								Screens.clearIntroSelectScreen();
								Screens.setGame(Score.movesOptions[0]);
							}
						}
					}
				} else 
				if (timedButton.bounds.containsPoint(point)) {
					
					if (introSelectTouchList[0].phase == TouchPhase.BEGAN || introSelectTouchList[0].phase == TouchPhase.MOVED) {
						if (!timedButtonOn) {							
							
							perpetuaButtonFiller.color = buttonColorOff;
							timedButtonFiller.color = buttonColorOn;
							movesButtonFiller.color = buttonColorOff;
							
							perpetuaButtonText.color = textColorOff;
							timedButtonText.color = textColorOn;
							movesButtonText.color = textColorOff;
							
							perpetuaButtonOn = false;
							timedButtonOn = true;
							movesButtonOn = false;
							
							Audio.playButton();
						}
					}
					if (introSelectTouchList[0].phase == TouchPhase.ENDED) {
						
						timedButtonOn = false;
						
						if (Screens.gameMode == "timed") {
							
							Screens.clearIntroSelectListeners();
							
							var introSelectTimerTimed1:Timer;			
							introSelectTimerTimed1 = new Timer(Screens.transVal);
							introSelectTimerTimed1.start();
							
							introSelectTimerTimed1.addEventListener(TimerEvent.TIMER, introSelectTimerTimed1Handler);
							function introSelectTimerTimed1Handler(evt:TimerEvent):void {
								introSelectTimerTimed1.stop();
								introSelectTimerTimed1.removeEventListener(TimerEvent.TIMER, introSelectTimerTimed1Handler);
								introSelectTimerTimed1 = null;
								
								Screens.clearIntroSelectScreen();
								Screens.setGame(Score.timedOptions[1]);
							}
						}
						if (Screens.gameMode == "moves") {
							
							Screens.clearIntroSelectListeners();
							
							var introSelectTimerMoves1:Timer;			
							introSelectTimerMoves1 = new Timer(Screens.transVal);
							introSelectTimerMoves1.start();
							
							introSelectTimerMoves1.addEventListener(TimerEvent.TIMER, introSelectTimerMoves1Handler);
							function introSelectTimerMoves1Handler(evt:TimerEvent):void {
								introSelectTimerMoves1.stop();
								introSelectTimerMoves1.removeEventListener(TimerEvent.TIMER, introSelectTimerMoves1Handler);
								introSelectTimerMoves1 = null;
								
								Screens.clearIntroSelectScreen();
								Screens.setGame(Score.movesOptions[1]);
							}
						}
					}
				} else
				if (movesButton.bounds.containsPoint(point)) {
					if (introSelectTouchList[0].phase == TouchPhase.BEGAN || introSelectTouchList[0].phase == TouchPhase.MOVED) {
						if (!movesButtonOn) {
							perpetuaButtonFiller.color = buttonColorOff;
							timedButtonFiller.color = buttonColorOff;
							movesButtonFiller.color = buttonColorOn;
							
							perpetuaButtonText.color = textColorOff;
							timedButtonText.color = textColorOff;
							movesButtonText.color = textColorOn;
							
							perpetuaButtonOn = false;
							timedButtonOn = false;
							movesButtonOn = true;
							
							Audio.playButton();
						}
					}
					if (introSelectTouchList[0].phase == TouchPhase.ENDED) {
						
						movesButtonOn = false;
						
						if (Screens.gameMode == "timed") {
							
							Screens.clearIntroSelectListeners();
							
							var introSelectTimerTimed2:Timer;			
							introSelectTimerTimed2 = new Timer(Screens.transVal);
							introSelectTimerTimed2.start();
							
							introSelectTimerTimed2.addEventListener(TimerEvent.TIMER, introSelectTimerTimed2Handler);
							function introSelectTimerTimed2Handler(evt:TimerEvent):void {
								introSelectTimerTimed2.stop();
								introSelectTimerTimed2.removeEventListener(TimerEvent.TIMER, introSelectTimerTimed2Handler);
								introSelectTimerTimed2 = null;
								
								Screens.clearIntroSelectScreen();
								Screens.setGame(Score.timedOptions[2]);
							}
						}
						if (Screens.gameMode == "moves") {
							
							Screens.clearIntroSelectListeners();
							
							var introSelectTimerMoves2:Timer;			
							introSelectTimerMoves2 = new Timer(Screens.transVal);
							introSelectTimerMoves2.start();
							
							introSelectTimerMoves2.addEventListener(TimerEvent.TIMER, introSelectTimerMoves2Handler);
							function introSelectTimerMoves2Handler(evt:TimerEvent):void {
								introSelectTimerMoves2.stop();
								introSelectTimerMoves2.removeEventListener(TimerEvent.TIMER, introSelectTimerMoves2Handler);
								introSelectTimerMoves2 = null;
								
								Screens.clearIntroSelectScreen();
								Screens.setGame(Score.movesOptions[2]);
							}
						}
					}
				} else
				if (backButton.visible && backButton.bounds.containsPoint(point)) {
					
					if (introSelectTouchList[0].phase == TouchPhase.BEGAN || introSelectTouchList[0].phase == TouchPhase.MOVED) {
						if (!backButtonOn) {
							
							backButtonFiller.color = Intro.buttonColorOn;
							backButtonText.color = Intro.textColorOn;
							backButtonOn = true;
							
							Audio.playButton();
						}
					}
					if (introSelectTouchList[0].phase == TouchPhase.ENDED) {	
						backButtonOn = false;
						
						Screens.clearIntroSelectListeners();
							
						var introSelectTimerIntro:Timer;			
						introSelectTimerIntro = new Timer(Screens.transVal);
						introSelectTimerIntro.start();
						
						introSelectTimerIntro.addEventListener(TimerEvent.TIMER, introSelectTimerIntroHandler);
						function introSelectTimerIntroHandler(evt:TimerEvent):void {
							introSelectTimerIntro.stop();
							introSelectTimerIntro.removeEventListener(TimerEvent.TIMER, introSelectTimerIntroHandler);
							introSelectTimerIntro = null;
							
							Screens.clearIntroSelectScreen();
							Screens.setIntro();
						}
					}
				} else {
				
					if (perpetuaButtonOn || timedButtonOn || movesButtonOn || backButtonOn) {
						perpetuaButtonFiller.color = buttonColorOff;
						timedButtonFiller.color = buttonColorOff;
						movesButtonFiller.color = buttonColorOff;
						
						perpetuaButtonText.color = textColorOff;
						timedButtonText.color = textColorOff;
						movesButtonText.color = textColorOff;
						
						backButtonFiller.color = Intro.buttonColorOff;					
						backButtonText.color = Intro.textColorOff;
						
						perpetuaButtonOn = false;
						timedButtonOn = false;
						movesButtonOn = false;	
						backButtonOn = false;
					}
				}
			}
		}
	}
}
