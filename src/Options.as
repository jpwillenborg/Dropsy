package  {
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	public class Options {
		
		static var point:Point;
		static var optionsTouchList:Vector.<Touch>;
		static var optionDotsList:Array = [];
		static var optionsText:TextField;
		static var colorsButton:Sprite;
		static var colorsButtonFiller:Image;
		static var colorsHeaderText:TextField;
		static var colorsSubSprite:Sprite;
		static var themeButton:Sprite;
		static var themeButtonFiller:Image;
		static var themeHeaderText:TextField;
		static var themeButtonText:TextField;
		static var soundsButton:Sprite;
		static var soundsButtonFiller:Image;
		static var soundHeaderText:TextField;
		static var soundsButtonText:TextField;
		static var vibrateButton:Sprite;
		static var vibrateButtonFiller:Image;
		static var vibrateHeaderText:TextField;
		static var vibrateButtonText:TextField;
		static var saveButton:Sprite;
		static var saveButtonFiller:Image;
		static var saveButtonText:TextField;
		static var saveTextColor:uint = 0xFFFFFF;
		static var saveButtonOn:Boolean = false;
		
		
		static function display(stage:Stage) {
			var shift:int = int(Main.screenHeight*0.1177);
			
			optionsText = new TextField(int(Environment.rectSprite.width*0.625), int(Environment.rectSprite.height*0.08824), String("OPTIONS"), "Font", int(Environment.rectSprite.height*0.067), Hud.gameTextColor, false);
			optionsText.hAlign = HAlign.CENTER;
			optionsText.vAlign = VAlign.TOP;
			optionsText.x = int((Environment.rectSprite.width/2 - optionsText.width/2) + Environment.rectSprite.x);
			optionsText.y = int((Environment.rectSprite.height*0.075) + Environment.rectSprite.y);
			optionsText.touchable = false;
			stage.addChild(optionsText);
			Screens.optionsScreenObjects.push(optionsText);
			
			
			colorsButton = new Sprite();
			stage.addChild(colorsButton);
			Screens.optionsScreenObjects.push(colorsButton);
			colorsButtonFiller = Atlas.generate("filler");
			colorsButtonFiller.width = int(Environment.rectSprite.width*0.90);
			colorsButtonFiller.height = int(Environment.rectSprite.height*0.0863);
			colorsButtonFiller.visible = false;
			colorsButton.addChild(colorsButtonFiller);
			Screens.optionsScreenObjects.push(colorsButtonFiller);
			
			colorsButton.x = int(Main.screenWidth/2 - colorsButton.width/2);
			colorsButton.y = int((Environment.rectSprite.height*0.2239) + Environment.rectSprite.y);
			
			colorsHeaderText = new TextField(colorsButtonFiller.width, int(Environment.rectSprite.height*0.0941), String("COLORS"), "Font", int(Environment.rectSprite.height*0.0353), Hud.subTextColor, false);
			colorsHeaderText.hAlign = HAlign.CENTER;
			colorsHeaderText.vAlign = VAlign.TOP;
			colorsHeaderText.x = colorsButtonFiller.width/2 - colorsHeaderText.width/2;
			colorsHeaderText.touchable = false;
			colorsButton.addChild(colorsHeaderText);
			Screens.optionsScreenObjects.push(colorsHeaderText);
			
			colorsSubSprite = new Sprite();
			colorsButton.addChild(colorsSubSprite);
			Screens.optionsScreenObjects.push(colorsSubSprite);
			
			optionDotsList.length = 0;
			for (var i:int = 0; i < Board["dotColors" + Hud.colorTheme].length; i++) {
				var dot:Image = Atlas.generate("options dot");
				dot.width = int(Environment.rectSprite.width*0.109375);
				dot.height = dot.width;
				dot.color = Board.dotColorArray[Hud.colorTheme][i];
				dot.smoothing = TextureSmoothing.BILINEAR;
				dot.touchable = false;
				optionDotsList.push(dot);
				colorsSubSprite.addChild(dot);
				Screens.optionsScreenObjects.push(dot);
				dot.x = i * int(Environment.rectSprite.width*0.140625);
			}
			
			colorsSubSprite.x = colorsButtonFiller.width/2 - colorsSubSprite.width/2;
			colorsSubSprite.y = int(Environment.rectSprite.height*0.0625);
			colorsSubSprite.touchable = false;
			Screens.optionsScreenObjects.push(colorsButton);
			
			
			
			themeButton = new Sprite();
			stage.addChild(themeButton);
			Screens.optionsScreenObjects.push(themeButton);
			
			themeButtonFiller = Atlas.generate("filler");
			themeButtonFiller.width = int(Environment.rectSprite.width*0.4375);
			themeButtonFiller.height = int(Environment.rectSprite.height*0.1177);
			themeButtonFiller.visible = false;
			themeButton.addChild(themeButtonFiller);
			Screens.optionsScreenObjects.push(themeButtonFiller);
			
			themeButton.x = Main.screenWidth/2 - themeButton.width/2;
			themeButton.y = int((Environment.rectSprite.height*0.4174) + Environment.rectSprite.y);
			
			themeHeaderText = new TextField(themeButtonFiller.width, int(Environment.rectSprite.height*0.0941), String("THEME"), "Font", int(Environment.rectSprite.height*0.0353), Hud.subTextColor, false);
			themeHeaderText.hAlign = HAlign.CENTER;
			themeHeaderText.vAlign = VAlign.TOP;
			themeHeaderText.touchable = false;
			themeButton.addChild(themeHeaderText);
			Screens.optionsScreenObjects.push(themeHeaderText);
			
			themeButtonText = new TextField(themeButtonFiller.width, int(Environment.rectSprite.height*0.0941), String("DAY"), "Font", int(Environment.rectSprite.height*0.06275), Hud.gameTextColor, false);
			if (Hud.theme == "light") {
				themeButtonText.text = "DAY";
			} else {
				themeButtonText.text = "NIGHT";
			}
			themeButtonText.hAlign = HAlign.CENTER;
			themeButtonText.vAlign = VAlign.TOP;
			themeButtonText.touchable = false;
			themeButtonText.y = int(Environment.rectSprite.height*0.05);
			
			themeButton.addChild(themeButtonText);
			stage.addChild(themeButton);
			Screens.optionsScreenObjects.push(themeButtonText);
			
			
			
			soundsButton = new Sprite();
			stage.addChild(soundsButton);
			Screens.optionsScreenObjects.push(soundsButton);
			
			soundsButtonFiller = Atlas.generate("filler");
			soundsButtonFiller.width = int(Environment.rectSprite.width*0.3125);
			soundsButtonFiller.height = int(Environment.rectSprite.height*0.1177);
			soundsButtonFiller.visible = false;
			soundsButton.addChild(soundsButtonFiller);
			Screens.optionsScreenObjects.push(soundsButtonFiller);
			
			soundsButton.x = int((Environment.rectSprite.width*0.278125) - soundsButton.width/2 + Environment.rectSprite.x);
			soundsButton.y = int((Environment.rectSprite.height*0.6064) + Environment.rectSprite.y);
			
			soundHeaderText = new TextField(soundsButtonFiller.width, int(Environment.rectSprite.height*0.0941), String("SOUNDS"), "Font", int(Environment.rectSprite.height*0.0353), Hud.subTextColor, false);
			soundHeaderText.hAlign = HAlign.CENTER;
			soundHeaderText.vAlign = VAlign.TOP;
			soundHeaderText.touchable = false;
			soundsButton.addChild(soundHeaderText);
			Screens.optionsScreenObjects.push(soundHeaderText);
			soundsButtonText = new TextField(soundsButtonFiller.width, int(Environment.rectSprite.height*0.0941), String("ON"), "Font", int(Environment.rectSprite.height*0.06275), Hud.gameTextColor, false);
			if (Audio.sounds == "on") {
				soundsButtonText.text = "ON";
			} else {
				soundsButtonText.text = "OFF";
			}
			soundsButtonText.hAlign = HAlign.CENTER;
			soundsButtonText.vAlign = VAlign.TOP;
			soundsButtonText.touchable = false;
			soundsButtonText.x = 0;
			soundsButtonText.y = int(Environment.rectSprite.height*0.05);
			soundsButton.addChild(soundsButtonText);
			Screens.optionsScreenObjects.push(soundsButtonText);
			
			
			vibrateButton = new Sprite();
			stage.addChild(vibrateButton);
			Screens.optionsScreenObjects.push(vibrateButton);
			
			vibrateButtonFiller = Atlas.generate("filler");
			vibrateButtonFiller.width = int(Environment.rectSprite.width*0.3125);
			vibrateButtonFiller.height = int(Main.screenHeight*0.1177);
			vibrateButtonFiller.visible = false;
			vibrateButton.addChild(vibrateButtonFiller);
			Screens.optionsScreenObjects.push(vibrateButtonFiller);
			
			vibrateButton.x = int((Environment.rectSprite.width*0.721875) - vibrateButton.width/2 + Environment.rectSprite.x);
			vibrateButton.y = int((Environment.rectSprite.height*0.6064) + Environment.rectSprite.y);
			
			vibrateHeaderText = new TextField(vibrateButtonFiller.width, int(Environment.rectSprite.height*0.0941), String("VIBRATE"), "Font", int(Environment.rectSprite.height*0.0353), Hud.subTextColor, false);
			vibrateHeaderText.hAlign = HAlign.CENTER;
			vibrateHeaderText.vAlign = VAlign.TOP;
			vibrateHeaderText.touchable = false;
			vibrateButton.addChild(vibrateHeaderText);
			Screens.optionsScreenObjects.push(vibrateHeaderText);
			
			vibrateButtonText = new TextField(vibrateButtonFiller.width, int(Environment.rectSprite.height*0.0941), String("OFF"), "Font", int(Environment.rectSprite.height*0.06275), Hud.gameTextColor, false);
			if (Hud.vibrate == "on") {
				vibrateButtonText.text = "ON";
			} else {
				vibrateButtonText.text = "OFF";
			}
			
			if (!Hud.canVibrate) {
				vibrateHeaderText.color = 0xA3B3C0;
				vibrateButtonText.color = 0xA3B3C0;
				vibrateButtonText.text = String("OFF");
			}
			
			vibrateButtonText.hAlign = HAlign.CENTER;
			vibrateButtonText.vAlign = VAlign.TOP;
			vibrateButtonText.touchable = false;
			vibrateButtonText.x = 0;
			vibrateButtonText.y = int(Environment.rectSprite.height*0.05);
			vibrateButton.addChild(vibrateButtonText);
			Screens.optionsScreenObjects.push(vibrateButtonText);
			
			saveButton = new Sprite();
			stage.addChild(saveButton);
			
			saveButtonFiller = Atlas.generate("filler");
			saveButtonFiller.width = Main.screenWidth + 50;
			saveButtonFiller.height = int(Environment.rectSprite.height*0.0941);
			saveButtonFiller.color = stage.color;
			saveButton.addChild(saveButtonFiller);
			
			saveButtonText = new TextField(int(Environment.rectSprite.width*0.625), int(Environment.rectSprite.height*0.0941), String("SAVE"), "Font", int(Environment.rectSprite.height*0.06275), saveTextColor/*stage.color*/, false);
			saveButtonText.hAlign = HAlign.CENTER;
			saveButtonText.vAlign = VAlign.CENTER;
			saveButtonText.x = int(Main.screenWidth/2 - saveButtonText.width/2);
			saveButtonText.touchable = false;
			saveButton.x = 0;
			saveButton.y = int((Environment.rectSprite.height*0.8203) + Environment.rectSprite.y);
			
			saveButton.addChild(saveButtonText);
			Screens.optionsScreenObjects.push(saveButton);

			stage.addEventListener(TouchEvent.TOUCH, stageOptionsTouchHandler);
			
			var touchDelay:Number = setTimeout(touchDelayHandler, 250);
			function touchDelayHandler() {
				stage.addEventListener(TouchEvent.TOUCH, stageOptionsTouchHandler);
			}
		}
		
		
		static function stageOptionsTouchHandler(evt:TouchEvent):void {
			optionsTouchList = evt.getTouches(Environment.stageRef);
			if (optionsTouchList.length > 0) {
				
				point = optionsTouchList[0].getLocation(Environment.stageRef);
				
				if (colorsButton.bounds.containsPoint(point)) {
					
					if (optionsTouchList[0].phase == TouchPhase.BEGAN) {
						Audio.playButton();
					}
					
					if (optionsTouchList[0].phase == TouchPhase.ENDED) {
						
						Hud.colorTheme++;
						if (Hud.colorTheme > 3) {
							Hud.colorTheme = 0;
						}
						
						for (var i:int = 0; i < Board.dotColorArray[Hud.colorTheme].length; i++) {
							optionDotsList[i].color = Board.dotColorArray[Hud.colorTheme][i];
						}
						
						if (Stats.isPaused) {
							for each (var id in Board.dotList) {
								if (id.name == "red") {
									id.color = Board["dotColors" + Hud.colorTheme][0];
								}
								if (id.name == "yellow") {
									id.color = Board["dotColors" + Hud.colorTheme][1];
								}
								if (id.name == "purple") {
									id.color = Board["dotColors" + Hud.colorTheme][2];
								}
								if (id.name == "green") {
									id.color = Board["dotColors" + Hud.colorTheme][3];
								}
								if (id.name == "blue") {
									id.color = Board["dotColors" + Hud.colorTheme][4];
								}
								if (id.name == "orange") {
									id.color = Board["dotColors" + Hud.colorTheme][5];
								}
							}
						}
						
						Intro.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
						
						Data.saveObj.highlight = Hud.highlightColorList[Hud.colorTheme];
						Data.saveObj.colors = Hud.colorTheme;
						Data.flushSave();
					}
				} else
				if (themeButton.bounds.containsPoint(point)) {
					
					if (optionsTouchList[0].phase == TouchPhase.BEGAN) {
						Audio.playButton();
					}
					
					if (optionsTouchList[0].phase == TouchPhase.ENDED) {
						Hud.changeBrightness();
						if (themeButtonText.text == "DAY") {
							themeButtonText.text = "NIGHT";
						} else {
							themeButtonText.text = "DAY";
						}
						Data.flushSave();
					}
				} else
				
				if (soundsButton.bounds.containsPoint(point)) {
					
					if (optionsTouchList[0].phase == TouchPhase.BEGAN) {
						
					}
					
					if (optionsTouchList[0].phase == TouchPhase.ENDED) {
						if (soundsButtonText.text == "ON") {
							soundsButtonText.text = "OFF";
							Audio.sounds = "off";
							Data.saveObj.sounds = "off";
						} else {
							soundsButtonText.text = "ON";
							Audio.sounds = "on";
							Data.saveObj.sounds = "on";
							Audio.playButton();
						}
						
						Data.flushSave();
					}
				} else
				if (vibrateButton.bounds.containsPoint(point) && Hud.canVibrate) {
					
					if (optionsTouchList[0].phase == TouchPhase.BEGAN) {
						Audio.playButton();
					}
					
					if (optionsTouchList[0].phase == TouchPhase.ENDED) {
						if (vibrateButtonText.text == "ON") {
							vibrateButtonText.text = "OFF";
							Hud.vibrate = "off";
							Data.saveObj.vibrate = "off";
						} else {
							vibrateButtonText.text = "ON";
							Hud.vibrate = "on";
							Data.saveObj.vibrate = "on";
							Vibrate.buzz(250);
						}
						
						Data.flushSave();
					}
				} else
				
				if (saveButton.bounds.containsPoint(point)) {
					
					if (optionsTouchList[0].phase == TouchPhase.BEGAN || optionsTouchList[0].phase == TouchPhase.MOVED) {
						if (!saveButtonOn) {
								
							saveButtonFiller.color = Intro.buttonColorOn;
							saveButtonText.color = Intro.textColorOn;
							saveButtonOn = true;
							
							Audio.playButton();
						}
					}
					
					if (optionsTouchList[0].phase == TouchPhase.ENDED) {
						
						saveButtonFiller.color = Intro.buttonColorOff;
						saveButtonText.color = Intro.textColorOff;
						saveButtonOn = false;
						
						Environment.stageRef.removeEventListener(TouchEvent.TOUCH, stageOptionsTouchHandler);
						Data.flushSave();
						

						if (Stats.gameMode == 0) {
							Screens.gameMode = "none";
							Stats.optionsUp = false;
							
							saveButtonFiller.color = Intro.buttonColorOn;
							saveButtonText.color = Intro.textColorOn;
														
							Screens.clearOptionsListeners();
							
							var optionsTimerIntro:Timer;			
							optionsTimerIntro = new Timer(Screens.transVal);
							optionsTimerIntro.start();
							
							optionsTimerIntro.addEventListener(TimerEvent.TIMER, optionsTimerIntroHandler);
							function optionsTimerIntroHandler(evt:TimerEvent):void {
								optionsTimerIntro.stop();
								optionsTimerIntro.removeEventListener(TimerEvent.TIMER, optionsTimerIntroHandler);
								optionsTimerIntro = null;
								
								Screens.clearOptionsScreen();
								Screens.setIntro();
							}
						}
						if (Stats.gameMode == 1) {
							Intro.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
							Stats.optionsUp = false;
							
							saveButtonFiller.color = Intro.buttonColorOff;
							saveButtonText.color = Intro.textColorOff;
							
							saveButtonFiller.color = Intro.buttonColorOn;
							saveButtonText.color = Intro.textColorOn;
							
							Screens.clearOptionsListeners();
							
							var optionsTimerStats1:Timer;			
							optionsTimerStats1 = new Timer(Screens.transVal);
							optionsTimerStats1.start();
							
							optionsTimerStats1.addEventListener(TimerEvent.TIMER, optionsTimerStats1Handler);
							function optionsTimerStats1Handler(evt:TimerEvent):void {
								optionsTimerStats1.stop();
								optionsTimerStats1.removeEventListener(TimerEvent.TIMER, optionsTimerStats1Handler);
								optionsTimerStats1 = null;
								
								Screens.clearOptionsScreen();
								Screens.setStats(1);
							}
						}
						if (Stats.gameMode == 2) {
							Intro.buttonColorOn = Hud.highlightColorList[Hud.colorTheme];
							Stats.optionsUp = false;
							
							saveButtonFiller.color = Intro.buttonColorOn;
							saveButtonText.color = Intro.textColorOn;
	
							saveButtonFiller.color = Intro.buttonColorOn;
							saveButtonText.color = Intro.textColorOn;
							
							Screens.clearOptionsListeners();
							
							var optionsTimerStats2:Timer;			
							optionsTimerStats2 = new Timer(Screens.transVal);
							optionsTimerStats2.start();
							
							optionsTimerStats2.addEventListener(TimerEvent.TIMER, optionsTimerStats2Handler);
							function optionsTimerStats2Handler(evt:TimerEvent):void {
								optionsTimerStats2.stop();
								optionsTimerStats2.removeEventListener(TimerEvent.TIMER, optionsTimerStats2Handler);
								optionsTimerStats2 = null;
								
								Screens.clearOptionsScreen();
								Screens.setStats(2);
							}
						}
					}
				} else 
				
				if (saveButtonOn) {
					saveButtonFiller.color = Intro.buttonColorOff;
					saveButtonText.color = Intro.textColorOff;
					saveButtonOn = false;
				}
			}
		}			
	}
}
