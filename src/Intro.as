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
	
	
	public class Intro {
		
		static var point:Point;
		static var introTouchList:Vector.<Touch>;
		static var firstView:Boolean = true;
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
		static var perpetuaButtonOn:Boolean = false;
		static var timedButtonOn:Boolean = false;
		static var movesButtonOn:Boolean = false;
		static var optionsIconOn:Boolean = false;
		static var contactIconOn:Boolean = false;
		static var statsIconOn:Boolean = false;
		static var timedMode:Boolean = false;
		static var movesMode:Boolean = false;
		static var statsIcon:Image;
		static var contactIcon:Image;
		static var optionsIcon:Image;
		static var gearTouchList:Vector.<Touch>;
		static var buttonColorOff:uint = Hud.stageColorLight;
		static var buttonColorOn:uint = Hud.highlightColorList[Hud.colorTheme];
		static var textColorOff:uint = Hud.gameTextColor;
		static var textColorOn:uint = Environment.stageRef.color;
		static var redBox:Image;
		
		
		static function display(stage:Stage) {
			Screens.gameMode = "none";
			buttonColorOn = Data.saveObj.highlight;
			point = new Point();
						
			logoSprite = new Sprite();			
			for (var i:int = 0; i < logoLetters.length; i++) {
				logoList[i] = Atlas.generate("logo " + logoLetters[i]);
				logoList[i].color = Board["dotColors" + Hud.colorTheme][i];
				logoList[i].smoothing = TextureSmoothing.BILINEAR;
				
				if (i == 0) {
					logoList[i].x = 0;
				} else {
					logoList[i].x = logoList[i-1].x + logoList[i-1].width;
				}
				
				logoSprite.addChild(logoList[i]);
			}
			
			logoSprite.height = int(Main.screenHeight/12.625);
			logoSprite.scaleX = logoSprite.scaleY;
			logoSprite.x = int(Main.screenWidth/2 - logoSprite.width/2);
			logoSprite.y = int((Environment.rectSprite.height * 0.1431) + Environment.rectSprite.y);	
			stage.addChild(logoSprite);
			logoSprite.touchable = false;
			Screens.introScreenObjects.push(logoSprite);
			
			
			perpetuaButton = new Sprite();
			perpetuaButton.x = 0;
			perpetuaButton.y = int((Environment.rectSprite.height*0.3667) + Environment.rectSprite.y);
			stage.addChild(perpetuaButton);
			perpetuaButtonFiller = Atlas.generate("filler");
			perpetuaButtonFiller.width = Main.screenWidth + 50;
			perpetuaButtonFiller.height = int(Environment.rectSprite.height*0.09412);
			perpetuaButtonFiller.color = buttonColorOff;
			perpetuaButton.addChild(perpetuaButtonFiller);
			perpetuaButtonText = new TextField(int(Environment.rectSprite.width*0.625), int(Environment.rectSprite.height*0.09412), String("PERPETUA"), "Font", int(Environment.rectSprite.height*0.06275), textColorOff, false);
			perpetuaButtonText.hAlign = HAlign.CENTER;
			perpetuaButtonText.vAlign = VAlign.CENTER;
			perpetuaButtonText.x = int(Main.screenWidth/2 - perpetuaButtonText.width/2);
			perpetuaButtonText.touchable = false;
			perpetuaButton.addChild(perpetuaButtonText);
			Screens.introScreenObjects.push(perpetuaButton);

			
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
			timedButtonText.hAlign = HAlign.CENTER;
			timedButtonText.vAlign = VAlign.CENTER;
			timedButtonText.x = int(Main.screenWidth/2 - timedButtonText.width/2);
			timedButtonText.touchable = false;
			timedButton.addChild(timedButtonText);
			Screens.introScreenObjects.push(timedButton);
			
			
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
			movesButtonText.hAlign = HAlign.CENTER;
			movesButtonText.vAlign = VAlign.CENTER;
			movesButtonText.x = int(Main.screenWidth/2 - movesButtonText.width/2);
			movesButtonText.touchable = false;
			movesButton.addChild(movesButtonText);
			Screens.introScreenObjects.push(movesButton);
			
			statsIcon = Atlas.generate("stats icon");
			statsIcon.height = int(Environment.rectSprite.width*0.21875);
			statsIcon.scaleX = statsIcon.scaleY;
			statsIcon.smoothing = TextureSmoothing.BILINEAR;
			statsIcon.color = Hud.iconsOffColor;
			statsIcon.x = int(Environment.rectSprite.x + Environment.rectSprite.width/4 - statsIcon.width/2);
			statsIcon.y = int((Environment.rectSprite.height*0.75) + Environment.rectSprite.y);
			stage.addChild(statsIcon);
			Screens.introScreenObjects.push(statsIcon);
			
			contactIcon = Atlas.generate("contact icon");
			contactIcon.height = int(Environment.rectSprite.width*0.21875);
			contactIcon.scaleX = statsIcon.scaleY;
			contactIcon.smoothing = TextureSmoothing.BILINEAR;
			contactIcon.color = Hud.iconsOffColor;
			contactIcon.x = int(Environment.rectSprite.x + ((Environment.rectSprite.width/4)*2) - contactIcon.width/2);
			contactIcon.y = int((Environment.rectSprite.height*0.75) + Environment.rectSprite.y);
			stage.addChild(contactIcon);
			Screens.introScreenObjects.push(contactIcon);
			
			optionsIcon = Atlas.generate("options icon");
			optionsIcon.height = int(Environment.rectSprite.width*0.21875);
			optionsIcon.scaleX = optionsIcon.scaleY;
			optionsIcon.smoothing = TextureSmoothing.BILINEAR;
			optionsIcon.color = Hud.iconsOffColor;
			optionsIcon.x = int(Environment.rectSprite.x + ((Environment.rectSprite.width/4)*3) - statsIcon.width/2);
			optionsIcon.y = int((Environment.rectSprite.height*0.75) + Environment.rectSprite.y);
			stage.addChild(optionsIcon);
			Screens.introScreenObjects.push(optionsIcon);
			
			var touchDelay:Number = setTimeout(touchDelayHandler, 250);
			function touchDelayHandler() {
				stage.addEventListener(TouchEvent.TOUCH, stageIntroTouchHandler);
			}
		}

		
		static function stageIntroTouchHandler(evt:TouchEvent):void {
			
				introTouchList = evt.getTouches(Environment.stageRef);
				if (introTouchList.length > 0) {
					
					point = introTouchList[0].getLocation(Environment.stageRef);
					
					if (perpetuaButton.bounds.containsPoint(point)) {
						if (introTouchList[0].phase == TouchPhase.BEGAN || introTouchList[0].phase == TouchPhase.MOVED) {
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
						if (introTouchList[0].phase == TouchPhase.ENDED) {
							perpetuaButtonOn = false;
							Screens.gameMode = "perpetua";
							
							Screens.clearIntroListeners();
							
							var introTimerIntroSelect0:Timer;			
							introTimerIntroSelect0 = new Timer(Screens.transVal);
							introTimerIntroSelect0.start();
							
							introTimerIntroSelect0.addEventListener(TimerEvent.TIMER, introTimerIntroSelectHandler0);
							function introTimerIntroSelectHandler0(evt:TimerEvent):void {
								introTimerIntroSelect0.stop();
								introTimerIntroSelect0.removeEventListener(TimerEvent.TIMER, introTimerIntroSelectHandler0);
								introTimerIntroSelect0 = null;
								
								Screens.clearIntroScreen();
								Screens.setGame(0);
							}
							
						}
					} else 
					
					if (timedButton.bounds.containsPoint(point)) {
						
						if (introTouchList[0].phase == TouchPhase.BEGAN || introTouchList[0].phase == TouchPhase.MOVED) {
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
						if (introTouchList[0].phase == TouchPhase.ENDED) {
							timedButtonOn = false;
							Screens.gameMode = "timed";
							
							Screens.clearIntroListeners();
							
							var introTimerIntroSelect1:Timer;			
							introTimerIntroSelect1 = new Timer(Screens.transVal);
							introTimerIntroSelect1.start();
							
							introTimerIntroSelect1.addEventListener(TimerEvent.TIMER, introTimerIntroSelectHandler1);
							function introTimerIntroSelectHandler1(evt:TimerEvent):void {
								introTimerIntroSelect1.stop();
								introTimerIntroSelect1.removeEventListener(TimerEvent.TIMER, introTimerIntroSelectHandler1);
								introTimerIntroSelect1 = null;
								
								Screens.clearIntroScreen();
								Screens.setIntroSelect();
							}
						}
					} else
					
					if (movesButton.bounds.containsPoint(point)) {
						
						if (introTouchList[0].phase == TouchPhase.BEGAN || introTouchList[0].phase == TouchPhase.MOVED) {
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
						if (introTouchList[0].phase == TouchPhase.ENDED) {
							
							movesButtonOn = false;
							Screens.gameMode = "moves";
							
							Screens.clearIntroListeners();
							
							var introTimerIntroSelect2:Timer;			
							introTimerIntroSelect2 = new Timer(Screens.transVal);
							introTimerIntroSelect2.start();
							
							introTimerIntroSelect2.addEventListener(TimerEvent.TIMER, introTimerIntroSelectHandler2);
							function introTimerIntroSelectHandler2(evt:TimerEvent):void {
								introTimerIntroSelect2.stop();
								introTimerIntroSelect2.removeEventListener(TimerEvent.TIMER, introTimerIntroSelectHandler2);
								introTimerIntroSelect2 = null;
								
								Screens.clearIntroScreen();
								Screens.setIntroSelect();
							}
						}
					} else {
						
					if (optionsIcon.bounds.containsPoint(point)) {
						if (introTouchList[0].phase == TouchPhase.BEGAN || introTouchList[0].phase == TouchPhase.MOVED) {
							if (!optionsIconOn) {
								optionsIcon.color = Hud.iconsOnColor;
								optionsIconOn = true;
								
								Audio.playButton();
							}
						}						
						if (introTouchList[0].phase == TouchPhase.ENDED) {
							optionsIconOn = false;
							Screens.clearIntroListeners();
							
							var introTimerOptions:Timer;			
							introTimerOptions = new Timer(Screens.transVal);
							introTimerOptions.start();
							
							introTimerOptions.addEventListener(TimerEvent.TIMER, introTimerOptionsHandler);
							function introTimerOptionsHandler(evt:TimerEvent):void {
								introTimerOptions.stop();
								introTimerOptions.removeEventListener(TimerEvent.TIMER, introTimerOptionsHandler);
								introTimerOptions = null;
								
								Screens.clearIntroScreen();
								Screens.setOptions();
							}
							
						}
					} else 
					
					if (contactIcon.bounds.containsPoint(point)) {
						if (introTouchList[0].phase == TouchPhase.BEGAN || introTouchList[0].phase == TouchPhase.MOVED) {
							if (!contactIconOn) {
								contactIcon.color = Hud.iconsOnColor;
								contactIconOn = true;
								
								Audio.playButton();
							}
						}						
						if (introTouchList[0].phase == TouchPhase.ENDED) {
							contactIconOn = false;
							Screens.clearIntroListeners();
							
							var introTimerContact:Timer;			
							introTimerContact = new Timer(Screens.transVal);
							introTimerContact.start();
							
							introTimerContact.addEventListener(TimerEvent.TIMER, introTimerContactHandler);
							function introTimerContactHandler(evt:TimerEvent):void {
								introTimerContact.stop();
								introTimerContact.removeEventListener(TimerEvent.TIMER, introTimerContactHandler);
								introTimerContact = null;
								
								Screens.clearIntroScreen();
								Screens.setContact();
							}
							
						}
					} else 
					
					if (statsIcon.visible && statsIcon.bounds.containsPoint(point)) {
						
						if (introTouchList[0].phase == TouchPhase.BEGAN || introTouchList[0].phase == TouchPhase.MOVED) {
							if (!statsIconOn) {
								statsIcon.color = Hud.iconsOnColor;
								statsIconOn = true;
								
								Audio.playButton();
							}
						}
						if (introTouchList[0].phase == TouchPhase.ENDED) {
							statsIconOn = false;
							Screens.clearIntroListeners();
							
							var introTimerStats:Timer;			
							introTimerStats = new Timer(Screens.transVal);
							introTimerStats.start();
							
							introTimerStats.addEventListener(TimerEvent.TIMER, introTimerStatsHandler);
							function introTimerStatsHandler(evt:TimerEvent):void {
								introTimerStats.stop();
								introTimerStats.removeEventListener(TimerEvent.TIMER, introTimerStatsHandler);
								introTimerStats = null;
								
								Screens.clearIntroScreen();
								Screens.setStats(0);
							}
						}
					} else
					
					if (perpetuaButtonOn || timedButtonOn || movesButtonOn || statsIconOn || contactIconOn || optionsIconOn) {
						perpetuaButtonFiller.color = buttonColorOff;
						timedButtonFiller.color = buttonColorOff;
						movesButtonFiller.color = buttonColorOff;
						
						perpetuaButtonText.color = textColorOff;
						timedButtonText.color = textColorOff;
						movesButtonText.color = textColorOff;
						
						statsIcon.color = Hud.iconsOffColor;
						contactIcon.color = Hud.iconsOffColor;
						optionsIcon.color = Hud.iconsOffColor;
						
						perpetuaButtonOn = false;
						timedButtonOn = false;
						movesButtonOn = false;	
						statsIconOn = false;
						contactIconOn = false;
						optionsIconOn = false;
						
					}
				}
			}
		}
	}
}
