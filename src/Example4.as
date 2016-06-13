package  {
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureSmoothing;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	
	public class Example4 {
		
		static var textFont:GameFont;
		
		static var tutorialText1:TextField;
		static var tutorialText2A:TextField;
		static var tutorialText2B:TextField;
		static var tutorialText2C:TextField;
		static var tutorialText3:TextField;
		
		static var defaultFormat1:TextFormat;
		static var defaultFormat2:TextFormat;
		static var defaultFormat3:TextFormat;
		
		static var redFormat:TextFormat;
		static var yellowFormat:TextFormat;
		static var blueFormat:TextFormat;
		
		static var touchList:Vector.<Touch>;
		static var diffX:int;
		static var origin:Point;
		static var point:Point;
		static var target:Image;
		static var initX:int;
		
		
		static function setup(stage:Stage) {
			
			textFont = new GameFont();
			
			// TEXT FORMATS						
			defaultFormat1 = new TextFormat();
			defaultFormat1.size = int(Environment.rectSprite.height*0.067);
			defaultFormat1.color = Hud.gameTextColor;
			defaultFormat1.align = TextFormatAlign.CENTER;
			defaultFormat1.font = textFont.fontName;
			
			defaultFormat2 = new TextFormat();
			defaultFormat2.size = int(Environment.rectSprite.height*0.04);
			defaultFormat2.color = Hud.gameTextColor;
			defaultFormat2.align = TextFormatAlign.CENTER;
			//defaultFormat2.leading = int((Environment.rectSprite.height*(-0.07843) + Environment.rectSprite.y));
			//defaultFormat2.leading = int((Environment.rectSprite.height*(0.01) + Environment.rectSprite.y));
			defaultFormat2.leading = 10;
			defaultFormat2.font = textFont.fontName;
			
			defaultFormat3 = new TextFormat();
			defaultFormat3.size = int(Environment.rectSprite.height*0.0318);
			defaultFormat3.color = Hud.subTextColor;
			defaultFormat3.align = TextFormatAlign.CENTER;
			defaultFormat3.font = textFont.fontName;
			
			
			redFormat = new TextFormat();
			redFormat.size = int(Environment.rectSprite.height*0.04);
			redFormat.color = Board.dotColors0[2];
			redFormat.align = TextFormatAlign.CENTER;
			redFormat.font = textFont.fontName;
			
			yellowFormat = new TextFormat();
			yellowFormat.size = int(Environment.rectSprite.height*0.04);
			yellowFormat.color = Board.dotColors0[1];
			yellowFormat.align = TextFormatAlign.CENTER;
			yellowFormat.font = textFont.fontName;
			
			blueFormat = new TextFormat();
			blueFormat.size = int(Environment.rectSprite.height*0.04);
			blueFormat.color = Board.dotColors0[0];
			blueFormat.align = TextFormatAlign.CENTER;
			blueFormat.font = textFont.fontName;
			
			
			// TEXT FIELDS			
			tutorialText1 = new TextField();
			tutorialText1.defaultTextFormat = defaultFormat1;
			tutorialText1.embedFonts = true;
			tutorialText1.selectable = false;
			tutorialText1.antiAliasType = AntiAliasType.ADVANCED;
			tutorialText1.text = "TIPS";
			Starling.current.nativeOverlay.addChild(tutorialText1);
			tutorialText1.width = int(Environment.rectSprite.width*0.70);
			tutorialText1.height = int(Environment.rectSprite.height*0.4412);
			tutorialText1.x = int((Environment.rectSprite.width/2 - tutorialText1.width/2) + Environment.rectSprite.x);
			tutorialText1.y = int((Environment.rectSprite.height*0.08) + Environment.rectSprite.y);
			Screens.example4ScreenObjects.push(tutorialText1);
			
			
			tutorialText2A = new TextField();
			tutorialText2A.defaultTextFormat = defaultFormat2;
			tutorialText2A.embedFonts = true;
			tutorialText2A.selectable = false;
			tutorialText2A.wordWrap = true;
			tutorialText2A.multiline = true;
			tutorialText2A.antiAliasType = AntiAliasType.ADVANCED;
			tutorialText2A.text = "YOU CAN ONLY SLIDE BLOCKS SIDE TO SIDE";
			Starling.current.nativeOverlay.addChild(tutorialText2A);
			tutorialText2A.width = int(Environment.rectSprite.width*0.85);
			tutorialText2A.height = int(Environment.rectSprite.height*0.22);
			tutorialText2A.x = int((Environment.rectSprite.width/2 - tutorialText2A.width/2) + Environment.rectSprite.x);
			tutorialText2A.y = int((Environment.rectSprite.height*0.215) + Environment.rectSprite.y);
			Screens.example4ScreenObjects.push(tutorialText2A);
			
			
			tutorialText2B = new TextField();
			tutorialText2B.defaultTextFormat = defaultFormat2;
			tutorialText2B.embedFonts = true;
			tutorialText2B.selectable = false;
			tutorialText2B.wordWrap = true;
			tutorialText2B.multiline = true;
			tutorialText2B.antiAliasType = AntiAliasType.ADVANCED;
			tutorialText2B.text = "EARN 1 POINT FOR EACH BLOCK REMOVED";
			Starling.current.nativeOverlay.addChild(tutorialText2B);
			tutorialText2B.width = int(Environment.rectSprite.width*0.85);
			tutorialText2B.height = int(Environment.rectSprite.height*0.25);
			tutorialText2B.x = int((Environment.rectSprite.width/2 - tutorialText2B.width/2) + Environment.rectSprite.x);
			tutorialText2B.y = int((Environment.rectSprite.height*0.402) + Environment.rectSprite.y);
			Screens.example4ScreenObjects.push(tutorialText2B);
			
			
			tutorialText2C = new TextField();
			tutorialText2C.defaultTextFormat = defaultFormat2;
			tutorialText2C.embedFonts = true;
			tutorialText2C.selectable = false;
			tutorialText2C.wordWrap = true;
			tutorialText2C.multiline = true;
			tutorialText2C.antiAliasType = AntiAliasType.ADVANCED;
			tutorialText2C.text = "EARN 1 ELIM FOR EVERY 250 POINTS, OR BY LINING UP 5 BLOCKS\nIN A ROW";
			Starling.current.nativeOverlay.addChild(tutorialText2C);
			tutorialText2C.width = int(Environment.rectSprite.width*0.85);
			tutorialText2C.height = int(Environment.rectSprite.height*0.25);
			tutorialText2C.x = int((Environment.rectSprite.width/2 - tutorialText2C.width/2) + Environment.rectSprite.x);
			tutorialText2C.y = int((Environment.rectSprite.height*0.582) + Environment.rectSprite.y);
			Screens.example4ScreenObjects.push(tutorialText2C);
			
			
			tutorialText3 = new TextField();
			tutorialText3.defaultTextFormat = defaultFormat3;
			tutorialText3.embedFonts = true;
			tutorialText3.selectable = false;
			tutorialText3.wordWrap = true;
			tutorialText3.antiAliasType = AntiAliasType.ADVANCED;
			tutorialText3.text = "TOUCH TO BEGIN";
			Starling.current.nativeOverlay.addChild(tutorialText3);
			tutorialText3.width = int(Environment.rectSprite.width*0.85);
			tutorialText3.height = int(Environment.rectSprite.height*0.32);
			tutorialText3.x = int((Environment.rectSprite.width/2 - tutorialText3.width/2) + Environment.rectSprite.x);
			tutorialText3.y = int((Environment.rectSprite.height*0.866) + Environment.rectSprite.y);
			Screens.example4ScreenObjects.push(tutorialText3);
			
			
			tutorialText2A.setTextFormat(blueFormat, 19, 25);
			tutorialText2B.setTextFormat(blueFormat, 22, 27);
			tutorialText2C.setTextFormat(blueFormat, 50, 58);
			tutorialText2B.setTextFormat(yellowFormat, 5, 12);
			tutorialText2C.setTextFormat(yellowFormat, 22, 32);
			tutorialText2C.setTextFormat(redFormat, 5, 11);
			
			stage.addEventListener(TouchEvent.TOUCH, stageTouchHandler);
		}
		
		
		static function stageTouchHandler(evt:TouchEvent):void {
			touchList = evt.getTouches(Environment.stageRef);
			if (touchList.length > 0) {
				if (evt.target == Environment.stageRef && touchList[0].phase == TouchPhase.BEGAN) {
					Environment.stageRef.removeEventListener(TouchEvent.TOUCH, stageTouchHandler);
					
					var lastTransition:Timer = new Timer(250);
					lastTransition.start();
					
					lastTransition.addEventListener(TimerEvent.TIMER, lastTransitionHandler);
					function lastTransitionHandler(evt:TimerEvent):void {
						lastTransition.stop();
						lastTransition.removeEventListener(TimerEvent.TIMER, lastTransitionHandler);
						lastTransition = null;										
						
						Environment.stageRef.addEventListener(Event.ENTER_FRAME, loop2);
						function loop2(evt:Event) {
							tutorialText1.alpha -= 0.06;
							tutorialText2A.alpha -= 0.06;
							tutorialText2B.alpha -= 0.06;
							tutorialText2C.alpha -= 0.06;
							tutorialText3.alpha -= 0.06;
							
							if (tutorialText1.alpha <=0) {
								
								Environment.stageRef.removeEventListener(Event.ENTER_FRAME, loop2);
								
								var timer:Timer = new Timer(500);
								timer.start();
								
								timer.addEventListener(TimerEvent.TIMER, timerHandler);
								function timerHandler(evt:TimerEvent):void {
									timer.stop();
									timer.removeEventListener(TimerEvent.TIMER, timerHandler);
									timer = null;
									
									Screens.clearExample4Screen();
									Tutorial.finish();
								}
							}
						}
					}
				}
			}
		}
	}
}
