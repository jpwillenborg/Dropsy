package  {
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;	
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	public class Loading {
		
		static var loadingText:TextField;
		static var dotSprite:Sprite;
		static var dotList:Array = [];
		static var bufferTimer:Timer;
		static var loadingTimerIntro:Timer;
		static var loadingTimerIntro2:Timer;
		static var timerInt:int = 0;
		static var cover:Image;
		static var gameTextColor:uint;
		static var coverColor:uint;
		
		
		static function display(stage:Stage) {
			
			// THEME
			if (Data.saveObj.theme == "dark") {
				gameTextColor = 0xFFFFFF;
				coverColor = 0x000000;
			} else {
				gameTextColor = 0x000000;
				coverColor = 0xFFFFFF;
			}
			
			// LOADING TEXT
			loadingText = new TextField(int(Environment.rectSprite.width*0.625), int(Environment.rectSprite.height*0.0981), String("LOADING"), "Font", int(Environment.rectSprite.height*0.058), gameTextColor, false);
			loadingText.hAlign = HAlign.CENTER;
			loadingText.vAlign = VAlign.TOP;
			loadingText.x = int((Environment.rectSprite.width/2 - loadingText.width/2) + Environment.rectSprite.x);
			loadingText.y = int((Environment.rectSprite.height*0.36) + Environment.rectSprite.y);
			loadingText.touchable = false;
			stage.addChild(loadingText);
			Screens.loadingScreenObjects.push(loadingText);
			
			// LOADING DOTS
			dotSprite = new Sprite();
			stage.addChild(dotSprite);
			Screens.loadingScreenObjects.push(dotSprite);
			
			for (var i:int = 0; i < 5; i++) {
				var dot:Image = Atlas.generate("options dot");
				dot.width = int(Environment.rectSprite.width*0.09375);
				dot.height = dot.width;
				dot.color = Board.dotColorArray[Hud.colorTheme][i];
				dot.smoothing = TextureSmoothing.BILINEAR;
				dot.touchable = false;
				dot.alpha = 0.0;
				dotList.push(dot);
				dotSprite.addChild(dot);
				Screens.loadingScreenObjects.push(dot);
				dot.x = i * int(Environment.rectSprite.width*0.105);
			}
			
			dotSprite.x = int((Environment.rectSprite.width/2 - dotSprite.width/2) + Environment.rectSprite.x);
			dotSprite.y = int((Environment.rectSprite.height*0.46) + Environment.rectSprite.y);
			
			
			// COVER
			cover = Atlas.generate("filler");
			cover.width = dotSprite.width + 10;
			cover.height = int(Environment.rectSprite.height*0.2);
			cover.x = int((Environment.rectSprite.width/2 - cover.width/2) + Environment.rectSprite.x);
			cover.y = loadingText.y - 10;
			cover.color = coverColor;
			cover.touchable = false;
			cover.alpha = 0.0;
			stage.addChild(cover);
			Screens.loadingScreenObjects.push(cover);
			
			bufferTimer = new Timer (450);
			bufferTimer.start();
			bufferTimer.addEventListener(TimerEvent.TIMER, bufferTimerHandler);
			function bufferTimerHandler(evt:TimerEvent):void {
				bufferTimer.removeEventListener(TimerEvent.TIMER, bufferTimerHandler);
				bufferTimer.stop();
				bufferTimer = null;
				
				stage.addEventListener(Event.ENTER_FRAME, loop0);
			}			
			
			function loop0(evt:Event):void {
				dotList[timerInt].alpha += 0.04;
				if (dotList[timerInt].alpha >= 1.0) {
					dotList[timerInt].alpha = 1.0;
					if (timerInt < dotList.length-1) {
						timerInt++;
					} else {
						stage.removeEventListener(Event.ENTER_FRAME, loop0);
						
						stage.addEventListener(Event.ENTER_FRAME, loop);
						function loop(evt:Event) {
							cover.alpha += 0.05;
							
							if (cover.alpha >= 1.0) {
								stage.removeEventListener(Event.ENTER_FRAME, loop);
								Screens.clearLoadingScreen();
								
								loadingTimerIntro2 = new Timer(500);
								loadingTimerIntro2.start();
								loadingTimerIntro2.addEventListener(TimerEvent.TIMER, loadingTimerIntroHandler2);
								function loadingTimerIntroHandler2(evt:TimerEvent):void {
									loadingTimerIntro2.stop();
									loadingTimerIntro2.removeEventListener(TimerEvent.TIMER, loadingTimerIntroHandler2);
									loadingTimerIntro2 = null;
									
									if (Data.saveObj.firstPlay) {
										Screens.setTutorial();
									} else {
										Screens.setIntro();
									}
								}
							}
						}
					}
				}
			}
		}		
	}
}
