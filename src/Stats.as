package  {
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.*;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import flash.utils.Timer;	
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	public class Stats {
		
		static var isPaused:Boolean = false;
		static var optionsUp:Boolean = false;
		static var point:Point;
		static var statsTouchList:Vector.<Touch>;
		static var statsSprite:Sprite;
		static var statsText:TextField;
		static var gap:int;
		static var currentElimsBG:Image;
		static var totalElimsBG:Image;
		static var scoresBG:Image;
		static var strip1:Image;
		static var currentElimHeader:TextField;
		static var totalElimHeader:TextField;
		static var currentElims:TextField;
		static var totalElims:TextField;
		static var currentElimSubText:TextField;
		static var totalElimSubText:TextField;
		static var swipeBox1:Sprite;
		static var swipeBoxFiller1:Image;
		static var swipeBox2:Sprite;
		static var swipeBoxFiller2:Image;
		static var nextSwipeBox:int
		static var tweenSpeed:Number = 0.65;
		static var recordsHeader:TextField;
		static var scoreHeader1:TextField;
		static var scoreHeader2:TextField;
		static var scoreHeader3:TextField;
		static var scoreHeader4:TextField;
		static var scoreHeader5:TextField;
		static var scoreHeader6:TextField;
		static var score1:TextField;
		static var score2:TextField;
		static var score3:TextField;
		static var score4:TextField;
		static var score5:TextField;
		static var score6:TextField;
		static var swipeBox1Tween:Tween;
		static var swipeBox2Tween:Tween;
		static var alphaBox1:Image;
		static var alphaBox2:Image;
		static var swipeDir:int;
		static var swipePoint:Point;
		static var scoresAreAnimated:Boolean = false;
		static var canSwipe:Boolean = true;
		static var arrowLeft:Image;
		static var arrowRight:Image;
		static var arrowLeftButton:Image;
		static var arrowRightButton:Image;
		static var scoreSet:int = Data.saveObj.scoreSet;
		static var resumeButton:Sprite;
		static var optionsButton:Sprite;
		static var exitButton:Sprite;
		static var resumeButtonFiller:Image;
		static var optionsButtonFiller:Image;
		static var exitButtonFiller:Image;
		static var resumeButtonText:TextField;
		static var optionsButtonText:TextField;
		static var exitButtonText:TextField;
		static var resumeButtonOn:Boolean = false;
		static var optionsButtonOn:Boolean = false;
		static var exitButtonOn:Boolean = false;
		static var currentElimsButtonOn:Boolean = false;
		static var totalElimsButtonOn:Boolean = false;
		static var minimalGear:Image;
		static var gearTouchList:Vector.<Touch>;
		static var buttonColorOff:uint = Intro.buttonColorOff;
		static var buttonColorOn:uint = Hud.highlightColorList[Hud.colorTheme];
		static var textColorOff:uint = Intro.textColorOff; 
		static var textColorOn:uint = Intro.textColorOn; 
		static var gameMode:int = 0;
		static var currentElimsCover:Image;
		static var currentElimsButton:Image;
		static var totalElimsButton:Image;
		
		
		static function display(stage:Stage, id:int) {  // 0 over, 1 active	
			gameMode = id;
			swipePoint = new Point();
			
			nextSwipeBox = 2;
			scoreSet = 0;
			
			if (gameMode == 1) {
				scoreSet = 1;
			}
			if (gameMode == 2) {
				scoreSet = 2;
			}
			
			scoreSet = 0;
			point = new Point();
			
			resumeButtonOn = false;
			optionsButtonOn = false;
			exitButtonOn = false;
			
			statsSprite = new Sprite();
			stage.addChild(statsSprite);
			Screens.statsScreenObjects.push(statsSprite);
			
			statsText = new TextField(int(Environment.rectSprite.width*0.390625), int(Environment.rectSprite.height*0.08824), String("STATS"), "Font", int(Environment.rectSprite.height*0.067), Hud.gameTextColor, false);
			statsText.hAlign = HAlign.CENTER;
			statsText.vAlign = VAlign.TOP;
			statsText.x = int((Environment.rectSprite.width/2 - statsText.width/2) + Environment.rectSprite.x);
			statsText.y = int((Environment.rectSprite.height*0.0401) + Environment.rectSprite.y);
			statsText.touchable = false;
			statsSprite.addChild(statsText);
			Screens.statsScreenObjects.push(statsText);
			
			gap = int(Environment.rectSprite.width*0.0125);
			
			currentElimsBG = Atlas.generate("filler");
			currentElimsBG.width = Main.screenWidth/2;
			currentElimsBG.height = int(Environment.rectSprite.height*0.18495);
			currentElimsBG.x = 0;
			currentElimsBG.y = int((Environment.rectSprite.height*0.1619) + Environment.rectSprite.y);
			currentElimsBG.color = Hud.statsBoxColor;
			stage.addChild(currentElimsBG);
			Screens.statsScreenObjects.push(currentElimsBG);
			
			totalElimsBG = Atlas.generate("filler");
			totalElimsBG.width = Main.screenWidth/2 + 10;
			totalElimsBG.height = int(Environment.rectSprite.height*0.18495);
			totalElimsBG.x = Main.screenWidth/2;
			totalElimsBG.y = int((Environment.rectSprite.height*0.1619) + Environment.rectSprite.y);
			totalElimsBG.color = Hud.statsBoxColor;
			stage.addChild(totalElimsBG);
			Screens.statsScreenObjects.push(totalElimsBG);
			
			scoresBG = Atlas.generate("filler");
			scoresBG.width = Main.screenWidth + 10;
			scoresBG.height = int(Environment.rectSprite.height*0.28814);
			scoresBG.x = 0;
			scoresBG.y = int(currentElimsBG.y + currentElimsBG.height + gap);
			scoresBG.color = Hud.statsBoxColor;
			stage.addChild(scoresBG);
			Screens.statsScreenObjects.push(scoresBG);
			
			strip1 = Atlas.generate("filler");
			strip1.width = gap;
			strip1.height = currentElimsBG.height;
			strip1.x = Main.screenWidth/2 - gap/2;
			strip1.y = currentElimsBG.y;
			strip1.color = stage.color;
			strip1.touchable = false;
			stage.addChild(strip1);
			Screens.statsScreenObjects.push(strip1);
			
			currentElimHeader = new TextField(int(Environment.rectSprite.width*0.234), int(Environment.rectSprite.height*0.0589), String("ELIMS"), "Font", int(Environment.rectSprite.height*0.0353), 0x7B7B7B, false);
			currentElimHeader.hAlign = HAlign.CENTER;
			currentElimHeader.vAlign = VAlign.TOP;
			currentElimHeader.x = int(((Main.screenWidth/2)/2) - currentElimHeader.width/2);
			currentElimHeader.y = int((Environment.rectSprite.height*0.1765) + Environment.rectSprite.y);
			currentElimHeader.touchable = false;
			statsSprite.addChild(currentElimHeader);
			Screens.statsScreenObjects.push(currentElimHeader);
			
			totalElimHeader = new TextField(int(Environment.rectSprite.width*0.234), int(Environment.rectSprite.height*0.0589), String("TOTAL"), "Font", int(Environment.rectSprite.height*0.0353), 0x7B7B7B, false);
			totalElimHeader.hAlign = HAlign.CENTER;
			totalElimHeader.vAlign = VAlign.TOP;
			totalElimHeader.x = int(Main.screenWidth - ((Main.screenWidth/2)/2) - totalElimHeader.width/2);
			totalElimHeader.y = int((Environment.rectSprite.height*0.1765) + Environment.rectSprite.y);
			totalElimHeader.touchable = false;
			statsSprite.addChild(totalElimHeader);
			Screens.statsScreenObjects.push(totalElimHeader);
			
			currentElims = new TextField(int(Environment.rectSprite.width*0.453125), int(Environment.rectSprite.height*0.0686), String(Score.addCommas(Environment.currentRedux)), "Font", int(Environment.rectSprite.height*0.051), Hud.highlightColorList[Hud.colorTheme], false);
			
			if (gameMode == 0 || gameMode == 2) {
				currentElims.text = String("--");
			}
			
			currentElims.hAlign = HAlign.CENTER;
			currentElims.vAlign = VAlign.TOP;
			currentElims.x = int(((Main.screenWidth/2)/2) - currentElims.width/2);
			currentElims.y = int((Environment.rectSprite.height*0.2206) + Environment.rectSprite.y);
			currentElims.touchable = false;
			statsSprite.addChild(currentElims);
			Screens.statsScreenObjects.push(currentElims);
			
			totalElims = new TextField(int(Environment.rectSprite.width*0.453125), int(Environment.rectSprite.height*0.0686), String(Score.addCommas(Environment.totalRedux)), "Font", int(Environment.rectSprite.height*0.051), Hud.highlightColorList[Hud.colorTheme], false);
			totalElims.hAlign = HAlign.CENTER;
			totalElims.vAlign = VAlign.TOP;
			totalElims.x = int(Main.screenWidth - ((Main.screenWidth/2)/2) - totalElims.width/2);
			totalElims.y = int((Environment.rectSprite.height*0.2206) + Environment.rectSprite.y);
			totalElims.touchable = false;
			statsSprite.addChild(totalElims);
			Screens.statsScreenObjects.push(totalElims);
			
			currentElimSubText = new TextField(int(Environment.rectSprite.width*0.4579), int(Environment.rectSprite.height*0.051), String("TAP TO TRANSFER 10 ELIMS\nFROM YOUR TOTAL"), "Font", int(Environment.rectSprite.height*0.018), 0x999999, false);
			currentElimSubText.hAlign = HAlign.CENTER;
			currentElimSubText.vAlign = VAlign.TOP;
			currentElimSubText.x = int(((Main.screenWidth/2)/2) - currentElimSubText.width/2);
			currentElimSubText.y = int((Environment.rectSprite.height*0.2893) + Environment.rectSprite.y);
			currentElimSubText.touchable = false;
			statsSprite.addChild(currentElimSubText);
			Screens.statsScreenObjects.push(currentElimSubText);
			
			totalElimSubText = new TextField(int(Environment.rectSprite.width*0.5172), int(Environment.rectSprite.height*0.051), String("EARN ELIMS BY PLAYING\nOR TAP TO PURCHASE MORE"), "Font", int(Environment.rectSprite.height*0.018), 0x999999, false);
			totalElimSubText.hAlign = HAlign.CENTER;
			totalElimSubText.vAlign = VAlign.TOP;
			totalElimSubText.x = int(Main.screenWidth - ((Main.screenWidth/2)/2) - totalElimSubText.width/2);
			totalElimSubText.y = int((Environment.rectSprite.height*0.2893) + Environment.rectSprite.y);
			totalElimSubText.touchable = false;
			statsSprite.addChild(totalElimSubText);
			Screens.statsScreenObjects.push(totalElimSubText);
			
			recordsHeader = new TextField(int(Environment.rectSprite.width*0.290625), int(Environment.rectSprite.height*0.0491), String("RECORDS"), "Font", int(Environment.rectSprite.height*0.0353), 0x7B7B7B, false);
			recordsHeader.hAlign = HAlign.CENTER;
			recordsHeader.vAlign = VAlign.TOP;
			recordsHeader.x = int((Environment.rectSprite.width*0.364375) + Environment.rectSprite.x);
			recordsHeader.y = int((Environment.rectSprite.height*0.383) + Environment.rectSprite.y);
			recordsHeader.touchable = false;
			statsSprite.addChild(recordsHeader);
			Screens.statsScreenObjects.push(recordsHeader);
			
			// SWIPE
			swipeBox1 = new Sprite();
			stage.addChild(swipeBox1);
			swipeBoxFiller1 = Atlas.generate("filler");
			swipeBoxFiller1.width = Main.screenWidth;
			swipeBoxFiller1.height = scoresBG.height;
			swipeBoxFiller1.alpha = 0.0;
			swipeBox1.addChild(swipeBoxFiller1);
			swipeBox1.x = 0;
			swipeBox1.y = scoresBG.y;
			Screens.statsScreenObjects.push(swipeBox1);
			
			swipeBox2 = new Sprite();
			stage.addChild(swipeBox2);
			swipeBoxFiller2 = Atlas.generate("filler");
			swipeBoxFiller2.width = Main.screenWidth;
			swipeBoxFiller2.height = scoresBG.height;
			swipeBoxFiller2.alpha = 0.0;
			swipeBox2.addChild(swipeBoxFiller2);
			swipeBox2.x = Main.screenWidth;
			swipeBox2.y = scoresBG.y;
			Screens.statsScreenObjects.push(swipeBox2);
			
			alphaBox1 = Atlas.generate("grad");
			alphaBox1.width = int(Environment.rectSprite.width*0.1172);
			alphaBox1.height = scoresBG.height;
			alphaBox1.x = scoresBG.x;
			alphaBox1.y = scoresBG.y;
			alphaBox1.smoothing = TextureSmoothing.BILINEAR;
			alphaBox1.touchable = false;
			alphaBox1.color = scoresBG.color;
			stage.addChild(alphaBox1);
			Screens.statsScreenObjects.push(alphaBox1);
			
			alphaBox2 = Atlas.generate("grad");
			alphaBox2.width = int(Environment.rectSprite.width*0.1172);
			alphaBox2.height = scoresBG.height;
			alphaBox2.x = Main.screenWidth;
			alphaBox2.y = scoresBG.y;
			alphaBox2.scaleX *= -1.0;
			alphaBox2.smoothing = TextureSmoothing.BILINEAR;
			alphaBox2.touchable = false;
			alphaBox2.color = scoresBG.color;
			stage.addChild(alphaBox2);
			Screens.statsScreenObjects.push(alphaBox2);
			
			scoreHeader1 = new TextField(int(Environment.rectSprite.width*0.4375), int(Environment.rectSprite.height*0.0549), String("PERPETUA"), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			scoreHeader1.hAlign = HAlign.LEFT;
			scoreHeader1.vAlign = VAlign.TOP;
			scoreHeader1.x = int((Environment.rectSprite.width*0.15) + Environment.rectSprite.x);
			scoreHeader1.y = int(Environment.rectSprite.height*0.0931);
			scoreHeader1.touchable = false;
			swipeBox1.addChild(scoreHeader1);
			Screens.statsScreenObjects.push(scoreHeader1);
			
			scoreHeader2 = new TextField(int(Environment.rectSprite.width*0.4375), int(Environment.rectSprite.height*0.0549), String("TODAY"), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			scoreHeader2.hAlign = HAlign.LEFT;
			scoreHeader2.vAlign = VAlign.TOP;
			scoreHeader2.x = int((Environment.rectSprite.width*0.15) + Environment.rectSprite.x);
			scoreHeader2.y = int(Environment.rectSprite.height*0.147);
			scoreHeader2.touchable = false;
			swipeBox1.addChild(scoreHeader2);
			Screens.statsScreenObjects.push(scoreHeader2);
			
			scoreHeader3 = new TextField(int(Environment.rectSprite.width*0.4375), int(Environment.rectSprite.height*0.0549), String(""), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			scoreHeader3.hAlign = HAlign.LEFT;
			scoreHeader3.vAlign = VAlign.TOP;
			scoreHeader3.x = int((Environment.rectSprite.width*0.15) + Environment.rectSprite.x);
			scoreHeader3.y = int(Environment.rectSprite.height*0.2);
			scoreHeader3.touchable = false;
			swipeBox1.addChild(scoreHeader3);
			Screens.statsScreenObjects.push(scoreHeader3);
			
			score1 = new TextField(int(Environment.rectSprite.width*0.4097), int(Environment.rectSprite.height*0.0549), String(Score.addCommas(Data.saveObj.highScore)), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			if (Data.saveObj.highScore == 0) {
				score1.text = String("--");
			}
			score1.hAlign = HAlign.CENTER;
			score1.vAlign = VAlign.TOP;
			score1.x = int((Environment.rectSprite.width*0.5333) + Environment.rectSprite.x);
			score1.y = int(Environment.rectSprite.height*0.0931);
			score1.touchable = false;
			swipeBox1.addChild(score1);
			Screens.statsScreenObjects.push(score1);
			
			score2 = new TextField(int(Environment.rectSprite.width*0.4097), int(Environment.rectSprite.height*0.0549), String(Score.addCommas(Data.saveObj.todaysHigh)), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			if (Data.saveObj.todaysHigh == 0) {
				score2.text = String("--");
			}
			score2.hAlign = HAlign.CENTER;
			score2.vAlign = VAlign.TOP;
			score2.x = int((Environment.rectSprite.width*0.5333) + Environment.rectSprite.x); 
			score2.y = int(Environment.rectSprite.height*0.147);
			score2.touchable = false;
			swipeBox1.addChild(score2);
			Screens.statsScreenObjects.push(score2);
			
			score3 = new TextField(int(Environment.rectSprite.width*0.4097), int(Environment.rectSprite.height*0.0549), String(""), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			score3.hAlign = HAlign.CENTER;
			score3.vAlign = VAlign.TOP;
			score3.x = int((Environment.rectSprite.width*0.5333) + Environment.rectSprite.x);
			score3.y = int(Environment.rectSprite.height*0.2);
			score3.touchable = false;
			swipeBox1.addChild(score3);
			Screens.statsScreenObjects.push(score3);

			scoreHeader4 = new TextField(int(Environment.rectSprite.width*0.4375), int(Environment.rectSprite.height*0.0549), String("TIMED (3)"), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			scoreHeader4.hAlign = HAlign.LEFT;
			scoreHeader4.vAlign = VAlign.TOP;
			scoreHeader4.x = int((Environment.rectSprite.width*0.15) + Environment.rectSprite.x);
			scoreHeader4.y = int(Environment.rectSprite.height*0.0931);
			scoreHeader4.touchable = false;
			swipeBox2.addChild(scoreHeader4);
			Screens.statsScreenObjects.push(scoreHeader4);
			
			scoreHeader5 = new TextField(int(Environment.rectSprite.width*0.4375), int(Environment.rectSprite.height*0.0549), String("TIMED (60)"), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			scoreHeader5.hAlign = HAlign.LEFT;
			scoreHeader5.vAlign = VAlign.TOP;
			scoreHeader5.x = int((Environment.rectSprite.width*0.15) + Environment.rectSprite.x);
			scoreHeader5.y = int(Environment.rectSprite.height*0.147);
			scoreHeader5.touchable = false;
			swipeBox2.addChild(scoreHeader5);
			Screens.statsScreenObjects.push(scoreHeader5);
			
			scoreHeader6 = new TextField(int(Environment.rectSprite.width*0.4375), int(Environment.rectSprite.height*0.0549), String("TIMED (90)"), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			scoreHeader6.hAlign = HAlign.LEFT;
			scoreHeader6.vAlign = VAlign.TOP;
			scoreHeader6.x = int((Environment.rectSprite.width*0.15) + Environment.rectSprite.x);
			scoreHeader6.y = int(Environment.rectSprite.height*0.2);
			scoreHeader6.touchable = false;
			swipeBox2.addChild(scoreHeader6);
			Screens.statsScreenObjects.push(scoreHeader6);
			
			score4 = new TextField(int(Environment.rectSprite.width*0.4097), int(Environment.rectSprite.height*0.0549), String(Score.addCommas(Data.saveObj.timedScore0)), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			if (Data.saveObj.timedScore0 == 0) {
				score4.text = String("--");
			}
			score4.hAlign = HAlign.CENTER;
			score4.vAlign = VAlign.TOP;
			score4.x = int((Environment.rectSprite.width*0.5333) + Environment.rectSprite.x);
			score4.y = int(Environment.rectSprite.height*0.0931);
			score4.touchable = false;
			swipeBox2.addChild(score4);
			Screens.statsScreenObjects.push(score4);
			
			score5 = new TextField(int(Environment.rectSprite.width*0.4097), int(Environment.rectSprite.height*0.0549), String(Score.addCommas(Data.saveObj.timedscore1)), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			if (Data.saveObj.timedscore4 == 0) {
				score5.text = String("--");
			}
			score5.hAlign = HAlign.CENTER;
			score5.vAlign = VAlign.TOP;
			score5.x = int((Environment.rectSprite.width*0.5333) + Environment.rectSprite.x);
			score5.y = int(Environment.rectSprite.height*0.147);
			score5.touchable = false;
			swipeBox2.addChild(score5);
			Screens.statsScreenObjects.push(score5);
			
			score6 = new TextField(int(Environment.rectSprite.width*0.4097), int(Environment.rectSprite.height*0.0549), String(Score.addCommas(Data.saveObj.timedscore2)), "Font", int(Environment.rectSprite.height*0.0412), Intro.textColorOff, false);
			if (Data.saveObj.timedscore5 == 0) {
				score6.text = String("--");
			}
			score6.hAlign = HAlign.CENTER;
			score6.vAlign = VAlign.TOP;
			score6.x = int((Environment.rectSprite.width*0.5333) + Environment.rectSprite.x);
			score6.y = int(Environment.rectSprite.height*0.2);
			score6.touchable = false;
			swipeBox2.addChild(score6);
			Screens.statsScreenObjects.push(score6);
			
			swipeDir = 0;
			
			swipeBox1Tween = new Tween(swipeBox1, tweenSpeed, Transitions.EASE_OUT_BACK);
			swipeBox2Tween = new Tween(swipeBox2, tweenSpeed, Transitions.EASE_OUT_BACK);
			
			arrowLeft = Atlas.generate("arrow");
			arrowLeft.width = int(Environment.rectSprite.width*0.06078);
			arrowLeft.scaleY = arrowLeft.scaleX;
			arrowLeft.smoothing = TextureSmoothing.BILINEAR;
			arrowLeft.x = int(Environment.rectSprite.width*0.025);
			arrowLeft.y = int((Environment.rectSprite.height*0.4436) + Environment.rectSprite.y);
			arrowLeft.color = Hud.statsArrowColor;
			arrowLeft.touchable = false;
			stage.addChild(arrowLeft);
			Screens.statsScreenObjects.push(arrowLeft);
			
			arrowRight = Atlas.generate("arrow");
			arrowRight.width = int(Environment.rectSprite.width*0.06078);
			arrowRight.scaleY = arrowLeft.scaleX;
			arrowRight.smoothing = TextureSmoothing.BILINEAR;
			arrowRight.x = int(Main.screenWidth - arrowLeft.x - arrowLeft.width);
			arrowRight.y = int((Environment.rectSprite.height*0.4436) + Environment.rectSprite.y);
			
			arrowRight.scaleX *= -1.0;
			arrowRight.x += arrowRight.width;
			
			arrowRight.color = Hud.statsArrowColor;
			
			arrowRight.touchable = false;
			stage.addChild(arrowRight);
			Screens.statsScreenObjects.push(arrowRight);			
			
			if (gameMode == 0 || gameMode == 2) {
				currentElimsCover = Atlas.generate("filler");
				currentElimsCover.width = strip1.x;
				currentElimsCover.height = currentElimsBG.height;
				currentElimsCover.x = currentElimsBG.x;
				currentElimsCover.y = currentElimsBG.y;
				currentElimsCover.alpha = 0.75;
				currentElimsCover.color = currentElimsBG.color;
				statsSprite.addChild(currentElimsCover);
				Screens.statsScreenObjects.push(currentElimsCover);
				
				currentElims.color = currentElimHeader.color;
				currentElimsCover.touchable = false;
				
			}
			
			if (gameMode == 1 || gameMode == 2) {
				resumeButton = new Sprite();
				stage.addChild(resumeButton);
				resumeButtonFiller = Atlas.generate("filler");
				resumeButtonFiller.width = Main.screenWidth + 50;
				resumeButtonFiller.height = int(Environment.rectSprite.height*0.0941);
				resumeButtonFiller.color = Intro.buttonColorOff;
				resumeButton.addChild(resumeButtonFiller);
				resumeButtonText = new TextField(int(Environment.rectSprite.width*0.84375), int(Environment.rectSprite.height*0.0941), String("RESUME"), "Font", int(Environment.rectSprite.height*0.06275), Intro.textColorOff, false);
				if (gameMode == 1) {
					resumeButtonText.text = "RESUME";
				}
				if (gameMode == 2) {
					resumeButtonText.text = "AGAIN?";
				}
				resumeButtonText.hAlign = HAlign.CENTER;
				resumeButtonText.vAlign = VAlign.CENTER;
				resumeButtonText.x = int(Main.screenWidth/2 - resumeButtonText.width/2);
				resumeButtonText.touchable = false;
				resumeButton.x = 0;
				resumeButton.y = int((Environment.rectSprite.height*0.6832) + Environment.rectSprite.y);
				resumeButton.addChild(resumeButtonText);
				Screens.statsScreenObjects.push(resumeButton);
				
				optionsButton = new Sprite();
				stage.addChild(optionsButton);
				optionsButtonFiller = Atlas.generate("filler");
				optionsButtonFiller.width = Main.screenWidth + 50;
				optionsButtonFiller.height = int(Environment.rectSprite.height*0.0941);
				optionsButtonFiller.color = Intro.buttonColorOff;
				optionsButton.addChild(optionsButtonFiller);
				optionsButtonText = new TextField(int(Environment.rectSprite.width*0.625), int(Environment.rectSprite.height*0.0941), String("OPTIONS"), "Font", int(Environment.rectSprite.height*0.06275), Intro.textColorOff, false);
				optionsButtonText.hAlign = HAlign.CENTER;
				optionsButtonText.vAlign = VAlign.CENTER;
				optionsButtonText.x = int(Main.screenWidth/2 - optionsButtonText.width/2);
				optionsButtonText.touchable = false;
				optionsButton.x = 0;
				optionsButton.y = int((Environment.rectSprite.height*0.6832) + optionsButtonFiller.height + Environment.rectSprite.y);
				optionsButton.addChild(optionsButtonText);
				Screens.statsScreenObjects.push(optionsButton);
			}
			
			exitButton = new Sprite();			
			stage.addChild(exitButton);
			exitButtonFiller = Atlas.generate("filler");
			exitButtonFiller.width = Main.screenWidth + 50;
			exitButtonFiller.height = int(Environment.rectSprite.height*0.0941);
			exitButtonFiller.color = Intro.buttonColorOff;
			exitButton.addChild(exitButtonFiller);
			exitButtonText = new TextField(int(Environment.rectSprite.width*0.625), int(Environment.rectSprite.height*0.0941), String("EXIT"), "Font", int(Environment.rectSprite.height*0.06275), Intro.textColorOff, false);
			
			if (gameMode == 0) {
				exitButtonText.text = String("BACK");
			}
			
			exitButtonText.hAlign = HAlign.CENTER;
			exitButtonText.vAlign = VAlign.CENTER;
			exitButtonText.x = int(Main.screenWidth/2 - exitButtonText.width/2);
			exitButtonText.touchable = false;
			exitButton.x = 0;
			if (gameMode == 0) {
				exitButton.y = int((Environment.rectSprite.height*0.6832) + exitButtonFiller.height + Environment.rectSprite.y);
			} else 
			if (gameMode == 1 || gameMode == 2) {
				exitButton.y = int((Environment.rectSprite.height*0.6832) + exitButtonFiller.height + exitButtonFiller.height + Environment.rectSprite.y);
			}
			exitButton.addChild(exitButtonText);
			Screens.statsScreenObjects.push(exitButton);
			
			if (Screens.gameMode == "perpetua") {
				scoreSet = 0;
			}
				
			if (Screens.gameMode == "timed") {
				scoreSet = 1;
				nextSwipeBox = 1;
				changeScoreSet();
				nextSwipeBox = 2;
			}
				
			if (Screens.gameMode == "moves") {
				scoreSet = 2;
				nextSwipeBox = 1;
				changeScoreSet();
				nextSwipeBox = 2;
			}
			
			stage.setChildIndex(statsSprite, stage.numChildren-1);
			
			statsSprite.flatten();
			Screens.clearOptionsScreen();
			
			if (Board.ended) {
				End.clear();
				Board.ended = false;
				Screens.clearCurrentScreen();
			}
			
			if (Board.statsIcon) {
				Board.statsIcon.color = Hud.iconsOffColor;
			}
						
			for each (var id0 in Screens.currentScreenObjects) {
				id0.visible = false;
			}
			
			if (Stats.gameMode && Stats.gameMode == 1) {
				Board.boardSprite.flatten();
			}
			
			Environment.stageRef.addEventListener(Event.ENTER_FRAME, next);
			function next(evt:Event):void {
				Environment.stageRef.removeEventListener(Event.ENTER_FRAME, next);
				
				var touchDelay:Number = setTimeout(touchDelayHandler, 250);
				function touchDelayHandler() {
					Environment.stageRef.addEventListener(TouchEvent.TOUCH, stageStatsTouchHandler);
				}
			}
			
			if (Redux.waitingForStats) {
				Redux.waitingForStats = false;
			}
		}

		
		static function stageStatsTouchHandler(evt:TouchEvent):void {
			
			if (!optionsUp) {
			
				statsTouchList = evt.getTouches(Environment.stageRef);
				if (statsTouchList.length > 0) {
					
					point = statsTouchList[0].getLocation(Environment.stageRef);
					
					if (canSwipe && !Store.purchaseWindowUp && !scoresAreAnimated && swipeBox1 && swipeBox1.bounds.containsPoint(point)) {
						
						if (statsTouchList[0].phase == TouchPhase.BEGAN) {
							swipePoint = point;
							nextSwipeBox = 2;
						}
						
						if (statsTouchList[0].phase == TouchPhase.MOVED) {							
							if (swipePoint != null && point.x - swipePoint.x > 10) {
								
								scoresAreAnimated = true;
								
								swipeBox2.x = swipeBox1.x - swipeBox1.width;
								swipeDir = 1;
								
								scoreSet--;
								if (scoreSet < 0) {
									scoreSet = 2;
								}
								changeScoreSet();
								
								swipe();
								
							} else if (swipePoint != null && point.x - swipePoint.x < -10) {
								
								scoresAreAnimated = true;
								
								swipeBox2.x = swipeBox1.x + swipeBox1.width;
								swipeDir = -1;
								
								scoreSet++;
								if (scoreSet > 2) {
									scoreSet = 0;
								}
								changeScoreSet();
								
								swipe();
							}
						}
					}
					
					if (canSwipe && !Store.purchaseWindowUp && !scoresAreAnimated && swipeBox2 && swipeBox2.bounds.containsPoint(point)) {
						
						if (statsTouchList[0].phase == TouchPhase.BEGAN) {
							swipePoint = point;
							nextSwipeBox = 1;
						}
						
						if (statsTouchList[0].phase == TouchPhase.MOVED) {							
							if (swipePoint != null && point.x - swipePoint.x > 10) {
								
								scoresAreAnimated = true;
								
								swipeBox1.x = swipeBox2.x - swipeBox1.width;
								swipeDir = 1;
								
								scoreSet--;
								if (scoreSet < 0) {
									scoreSet = 2;
								}
								changeScoreSet();
										
								swipe();
								
							} else if (swipePoint != null && point.x - swipePoint.x < -10) {
								
								scoresAreAnimated = true;
								
								swipeBox1.x = swipeBox2.x + swipeBox2.width;
								swipeDir = -1;
								
								scoreSet++;
								if (scoreSet > 2) {
									scoreSet = 0;
								}
								changeScoreSet();
								
								swipe();
							}
						}
					}						
					
					if (gameMode == 0 && !Store.purchaseWindowUp) {
						
						
						if (totalElimsBG && totalElimsBG.bounds.containsPoint(point)) {
							
							if (statsTouchList[0].phase == TouchPhase.BEGAN || statsTouchList[0].phase == TouchPhase.MOVED) {
								if (!totalElimsButtonOn) {
									if (!Store.purchaseWindowUp && !totalElimsButtonOn) {
										
										totalElimsBG.color = Hud.statsBoxColorOn;
										totalElimsButtonOn = true;
										
										Audio.playButton();
									}
								}
							}
							if (statsTouchList[0].phase == TouchPhase.ENDED) {
								if (!Store.purchaseWindowUp) {
									Screens.clearStatsListeners();
									
									var statsTimerStore:Timer;			
									statsTimerStore = new Timer(Screens.transVal);
									statsTimerStore.start();
									
									statsTimerStore.addEventListener(TimerEvent.TIMER, statsTimerStoreHandler);
									function statsTimerStoreHandler(evt:TimerEvent):void {
										statsTimerStore.stop();
										statsTimerStore.removeEventListener(TimerEvent.TIMER, statsTimerStoreHandler);
										statsTimerStore = null;
										
										Screens.clearStatsScreen();
										Screens.setStore();
									}										
								} else {
									totalElimsBG.color = Hud.statsBoxColor;
								}
								totalElimsButtonOn = false;
								exitButtonFiller.color = Intro.buttonColorOff;
								exitButtonText.color = Intro.textColorOff;
								exitButtonOn = false;
							}
						} else 
						
						if (exitButton && exitButton.bounds.containsPoint(point)) {
							
							if (statsTouchList[0].phase == TouchPhase.BEGAN || statsTouchList[0].phase == TouchPhase.MOVED) {
								if(!exitButtonOn) {
									if (!exitButtonOn) {
										exitButtonFiller.color = Intro.buttonColorOn;
										exitButtonText.color = Intro.textColorOn;
										exitButtonOn = true;
										
										Audio.playButton();
									}
								}
							}
							if (statsTouchList[0].phase == TouchPhase.ENDED) {		
								Environment.stageRef.removeEventListener(TouchEvent.TOUCH, stageStatsTouchHandler);
								if (Screens.gameMode == "timed") {
									Hud.gameTimer.removeEventListener(TimerEvent.TIMER, Hud.handleTimer);
								}
								
								if (Score.resetTimer.running) {
									Score.resetTimer.stop();
								}
								
								totalElimsBG.color = Hud.statsBoxColor;
								totalElimsButtonOn = false;
								exitButtonOn = false;
								
								Data.flushSave();
								End.removeAllListeners();
								End.clear();
								Redux.balanceRedux();
								isPaused = false;
								exitButtonOn = false;
								Stats.gameMode = 0;
								
								exitButtonFiller.color = Intro.buttonColorOn;
								exitButtonText.color = Intro.textColorOn;
								
								Screens.clearStatsListeners();
									
								var statsTimerIntro:Timer;			
								statsTimerIntro = new Timer(Screens.transVal);
								statsTimerIntro.start();
								
								statsTimerIntro.addEventListener(TimerEvent.TIMER, statsTimerIntroHandler);
								function statsTimerIntroHandler(evt:TimerEvent):void {
									statsTimerIntro.stop();
									statsTimerIntro.removeEventListener(TimerEvent.TIMER, statsTimerIntroHandler);
									statsTimerIntro = null;
									
									Screens.clearStatsScreen();
									Screens.setIntro();
								}
							}
						} else
						if (totalElimsButtonOn || exitButtonOn) {							
							exitButtonFiller.color = Intro.buttonColorOff;
							exitButtonText.color = Intro.textColorOff;
							exitButtonOn = false;								

							totalElimsBG.color = Hud.statsBoxColor;
							totalElimsButtonOn = false;
						}
					} else 
					if (gameMode == 1 || gameMode == 2) {
						
						if (currentElimsBG && currentElimsBG.bounds.containsPoint(point)) {
						
							if (statsTouchList[0].phase == TouchPhase.BEGAN || statsTouchList[0].phase == TouchPhase.MOVED) {
								if (!currentElimsButtonOn) {
									if (!Store.purchaseWindowUp && gameMode == 1 && !currentElimsButtonOn) {
										currentElimsBG.color = Hud.statsBoxColorOn;
										currentElimsButtonOn = true;
										
										totalElimsBG.color = Hud.statsBoxColor;
										totalElimsButtonOn = false;
										
										Audio.playButton();
									}
								}
							}
							if (statsTouchList[0].phase == TouchPhase.ENDED) {
								if (!Store.purchaseWindowUp) {
									
									if (Environment.totalRedux == 0) {
										Screens.clearStatsListeners();
									
										var statsTimerStore2:Timer;			
										statsTimerStore2 = new Timer(Screens.transVal);
										statsTimerStore2.start();
										
										statsTimerStore2.addEventListener(TimerEvent.TIMER, statsTimerStore2Handler);
										function statsTimerStore2Handler(evt:TimerEvent):void {
											statsTimerStore2.stop();
											statsTimerStore2.removeEventListener(TimerEvent.TIMER, statsTimerStore2Handler);
											statsTimerStore2 = null;
											
											Screens.clearStatsScreen();
											Screens.setStore();
										}
									} else {
										statsSprite.unflatten();										
										
										if (gameMode == 1) {
											Redux.newRedux();
											
											currentElims.text = String(Score.addCommas(Environment.currentRedux));
											totalElims.text = String(Score.addCommas(Environment.totalRedux));
										}
										
										currentElimsBG.color = Hud.statsBoxColor;
										currentElimsButtonOn = false;
										
										totalElimsBG.color = Hud.statsBoxColor;
										totalElimsButtonOn = false;
										
										resumeButtonFiller.color = Intro.buttonColorOff;
										resumeButtonText.color = Intro.textColorOff;
										resumeButtonOn = false;
										
										optionsButtonFiller.color = Intro.buttonColorOff;
										optionsButtonText.color = Intro.textColorOff;
										optionsButtonOn = false;
										
										exitButtonFiller.color = Intro.buttonColorOff;
										exitButtonText.color = Intro.textColorOff;
										exitButtonOn = false;
										
										statsSprite.flatten();
									}
								}
							}
						} else 
						
						if (totalElimsBG && totalElimsBG.bounds.containsPoint(point)) {
							
							if (statsTouchList[0].phase == TouchPhase.BEGAN || statsTouchList[0].phase == TouchPhase.MOVED) {
								if (!totalElimsButtonOn) {
									if (!Store.purchaseWindowUp && !totalElimsButtonOn) {											
										
										currentElimsBG.color = Hud.statsBoxColor;
										currentElimsButtonOn = false;
										
										totalElimsBG.color = Hud.statsBoxColorOn;
										totalElimsButtonOn = true;
										
										Audio.playButton();
									}
								}
							}
							if (statsTouchList[0].phase == TouchPhase.ENDED) {
								if (!Store.purchaseWindowUp) {
									Screens.clearStatsListeners();
								
									var statsTimerStore3:Timer;			
									statsTimerStore3 = new Timer(Screens.transVal);
									statsTimerStore3.start();
									
									statsTimerStore3.addEventListener(TimerEvent.TIMER, statsTimerStore3Handler);
									function statsTimerStore3Handler(evt:TimerEvent):void {
										statsTimerStore3.stop();
										statsTimerStore3.removeEventListener(TimerEvent.TIMER, statsTimerStore3Handler);
										statsTimerStore3 = null;
										
										Screens.clearStatsScreen();
										Screens.setStore();
									}										
								} else {
									totalElimsBG.color = Hud.statsBoxColor;
								}
								
								currentElimsBG.color = Hud.statsBoxColor;
								currentElimsButtonOn = false;
								
								totalElimsButtonOn = false;
								
								resumeButtonFiller.color = Intro.buttonColorOff;
								resumeButtonText.color = Intro.textColorOff;
								resumeButtonOn = false;
								
								optionsButtonFiller.color = Intro.buttonColorOff;
								optionsButtonText.color = Intro.textColorOff;
								optionsButtonOn = false;
								
								exitButtonFiller.color = Intro.buttonColorOff;
								exitButtonText.color = Intro.textColorOff;
								exitButtonOn = false;
							}
						} else 
						
						if (!Store.purchaseWindowUp && resumeButton && resumeButton.bounds.containsPoint(point)) {
							
							if (statsTouchList[0].phase == TouchPhase.BEGAN || statsTouchList[0].phase == TouchPhase.MOVED) {
								if (!resumeButtonOn) {
									
									if (resumeButtonText.text == "RESUME" || resumeButtonText.text == "AGAIN?") {
										
										currentElimsBG.color = Hud.statsBoxColor;
										currentElimsButtonOn = false;
										
										totalElimsBG.color = Hud.statsBoxColor;
										totalElimsButtonOn = false;
										
										resumeButtonFiller.color = Intro.buttonColorOn;
										resumeButtonText.color = Intro.textColorOn;
										resumeButtonOn = true;
										
										optionsButtonFiller.color = Intro.buttonColorOff;
										optionsButtonText.color = Intro.textColorOff;
										optionsButtonOn = false;
										
										exitButtonFiller.color = Intro.buttonColorOff;
										exitButtonText.color = Intro.textColorOff;
										exitButtonOn = false;
										
										Audio.playButton();
									} else {
										
										currentElimsBG.color = Hud.statsBoxColor;
										currentElimsButtonOn = false;
										
										totalElimsBG.color = Hud.statsBoxColor;
										totalElimsButtonOn = false;
										
										resumeButtonFiller.color = Intro.buttonColorOff;
										resumeButtonText.color = Intro.textColorOff;
										resumeButtonOn = false;
										
										optionsButtonFiller.color = Intro.buttonColorOff;
										optionsButtonText.color = Intro.textColorOff;
										optionsButtonOn = false;
										
										exitButtonFiller.color = Intro.buttonColorOff;
										exitButtonText.color = Intro.textColorOff;
										exitButtonOn = false;
									}
								}
							}
							if (statsTouchList[0].phase == TouchPhase.ENDED) {
								if (resumeButtonText.text == "RESUME" || resumeButtonText.text == "AGAIN?") {
								
									if (gameMode == 1) { 
										
										Screens.clearStatsListeners();
									
										var statsTimerResume:Timer;			
										statsTimerResume = new Timer(Screens.transVal);
										statsTimerResume.start();
										
										statsTimerResume.addEventListener(TimerEvent.TIMER, statsTimerResumeHandler);
										function statsTimerResumeHandler(evt:TimerEvent):void {
											statsTimerResume.stop();
											statsTimerResume.removeEventListener(TimerEvent.TIMER, statsTimerResumeHandler);
											statsTimerResume = null;
											
											Screens.clearStatsScreen();
											Screens.unsetStats();
										}
										
										Hud.reduxText.text = String("ELIMS\n" + Score.addCommas(Environment.currentRedux));
									}
									if (gameMode == 2) {
										Stats.gameMode = 1;
										Environment.stageRef.removeEventListener(TouchEvent.TOUCH, stageStatsTouchHandler);
										if (Screens.gameMode == "timed") {
											Hud.gameTimer.removeEventListener(TimerEvent.TIMER, Hud.handleTimer);
										}
										
										if (Score.resetTimer.running) {
											Score.resetTimer.stop(); 
										}
										
										Data.flushSave();			
										End.removeAllListeners();
										End.clear();
										Redux.balanceRedux();
										isPaused = false;
										resumeButtonOn = false;
										
										Screens.clearStatsListeners();
									
										var statsTimerAgain:Timer;			
										statsTimerAgain = new Timer(Screens.transVal);
										statsTimerAgain.start();
										
										statsTimerAgain.addEventListener(TimerEvent.TIMER, statsTimerAgainHandler);
										function statsTimerAgainHandler(evt:TimerEvent):void {
											statsTimerAgain.stop();
											statsTimerAgain.removeEventListener(TimerEvent.TIMER, statsTimerAgainHandler);
											statsTimerAgain = null;
											
											Screens.clearStatsScreen();
											Screens.setGame(Score.currentGameMode);
										}
									}
								}
							}
						} else 
						if (!Store.purchaseWindowUp && optionsButton && optionsButton.bounds.containsPoint(point)) {
							
							if (statsTouchList[0].phase == TouchPhase.BEGAN || statsTouchList[0].phase == TouchPhase.MOVED) {
								if (!optionsButtonOn) {
									
									totalElimsBG.color = Hud.statsBoxColor;
									totalElimsButtonOn = false;

									currentElimsBG.color = Hud.statsBoxColor;
									currentElimsButtonOn = false;
									
									resumeButtonFiller.color = Intro.buttonColorOff;
									resumeButtonText.color = Intro.textColorOff;
									resumeButtonOn = false;
									
									optionsButtonFiller.color = Intro.buttonColorOn;
									optionsButtonText.color = Intro.textColorOn;
									optionsButtonOn = true;
									
									exitButtonFiller.color = Intro.buttonColorOff;
									exitButtonText.color = Intro.textColorOff;
									exitButtonOn = false;
									
									Audio.playButton();
									
								}
							}
							if (statsTouchList[0].phase == TouchPhase.ENDED) {
								Environment.stageRef.removeEventListener(TouchEvent.TOUCH, stageStatsTouchHandler);
								
								if (optionsButtonText.text == "YES") {
									if (Screens.gameMode == "timed") {
										Hud.gameTimer.removeEventListener(TimerEvent.TIMER, Hud.handleTimer);
									}
									
									if (Score.resetTimer.running) {
										Score.resetTimer.stop();
									}
									
									Data.flushSave();
									End.removeAllListeners();
									End.clear();
									Redux.balanceRedux();
									
									Screens.clearCurrentScreen();
									isPaused = false;
									exitButtonOn = false;
									Stats.gameMode = 0;
									
									Screens.clearStatsListeners();
									
									var statsTimerIntro4:Timer;			
									statsTimerIntro4 = new Timer(Screens.transVal);
									statsTimerIntro4.start();
									
									statsTimerIntro4.addEventListener(TimerEvent.TIMER, statsTimerIntro4Handler);
									function statsTimerIntro4Handler(evt:TimerEvent):void {
										statsTimerIntro4.stop();
										statsTimerIntro4.removeEventListener(TimerEvent.TIMER, statsTimerIntro4Handler);
										statsTimerIntro4 = null;
										
										Screens.clearStatsScreen();
										Screens.setIntro();
									}
								} else 
								
								if (optionsButtonText.text == "OPTIONS") {
									if (Score.resetTimer.running) {
										Score.resetTimer.stop();
									}
									optionsButtonOn = false;
									
									optionsButtonFiller.color = Intro.buttonColorOn;
									optionsButtonText.color = Intro.textColorOn;
									
									Screens.clearStatsListeners();
									
									var statsTimerOptions:Timer;			
									statsTimerOptions = new Timer(Screens.transVal);
									statsTimerOptions.start();
									
									statsTimerOptions.addEventListener(TimerEvent.TIMER, statsTimerOptionsHandler);
									function statsTimerOptionsHandler(evt:TimerEvent):void {
										statsTimerOptions.stop();
										statsTimerOptions.removeEventListener(TimerEvent.TIMER, statsTimerOptionsHandler);
										statsTimerOptions = null;
										
										Screens.clearStatsScreen();
										Screens.setOptions();
									}
								}
							}
						} else
						if (!Store.purchaseWindowUp && exitButton && exitButton.bounds.containsPoint(point)) {
							
							if (statsTouchList[0].phase == TouchPhase.BEGAN || statsTouchList[0].phase == TouchPhase.MOVED) {
								if (!exitButtonOn) {							
									
									totalElimsBG.color = Hud.statsBoxColor;
									totalElimsButtonOn = false;

									currentElimsBG.color = Hud.statsBoxColor;
									currentElimsButtonOn = false;
									
									resumeButtonFiller.color = Intro.buttonColorOff;
									resumeButtonText.color = Intro.textColorOff;
									resumeButtonOn = false;
																			
									optionsButtonFiller.color = Intro.buttonColorOff;
									optionsButtonText.color = Intro.textColorOff;
									optionsButtonOn = false;
								
								
									exitButtonFiller.color = Intro.buttonColorOn;
									exitButtonText.color = Intro.textColorOn;
									exitButtonOn = true;
									
									Audio.playButton();
								}
							}
							if (statsTouchList[0].phase == TouchPhase.ENDED) {		
								Environment.stageRef.removeEventListener(TouchEvent.TOUCH, stageStatsTouchHandler);
								
								if (exitButtonText.text == "EXIT") {
									
									var statsTimerIntro2:Timer;			
									statsTimerIntro2 = new Timer(Screens.transVal);
									statsTimerIntro2.start();
									
									statsTimerIntro2.addEventListener(TimerEvent.TIMER, statsTimerIntro2Handler);
									function statsTimerIntro2Handler(evt:TimerEvent):void {
										statsTimerIntro2.stop();
										statsTimerIntro2.removeEventListener(TimerEvent.TIMER, statsTimerIntro2Handler);
										statsTimerIntro2 = null;
										
										resumeButtonText.text = String("ARE YOU SURE?") ;
										optionsButtonText.text = String("YES");
										exitButtonText.text = String("NO");
										
										exitButtonFiller.color = Intro.buttonColorOff;
										exitButtonText.color = Intro.textColorOff;
										exitButtonOn = false;
										
										Environment.stageRef.addEventListener(TouchEvent.TOUCH, stageStatsTouchHandler);
									}
								} else 
								if (exitButtonText.text == "NO") {
									
									var statsTimerIntro3:Timer;			
									statsTimerIntro3 = new Timer(Screens.transVal);
									statsTimerIntro3.start();
									
									statsTimerIntro3.addEventListener(TimerEvent.TIMER, statsTimerIntro3Handler);
									function statsTimerIntro3Handler(evt:TimerEvent):void {
										statsTimerIntro3.stop();
										statsTimerIntro3.removeEventListener(TimerEvent.TIMER, statsTimerIntro3Handler);
										statsTimerIntro3 = null;
										
										if (gameMode == 1) {
											resumeButtonText.text = String("RESUME");
										} else if (gameMode == 2) {
											resumeButtonText.text = String("AGAIN?");
										}
										
										optionsButtonText.text = String("OPTIONS");
										exitButtonText.text = String("EXIT");
										
										exitButtonFiller.color = Intro.buttonColorOff;
										exitButtonText.color = Intro.textColorOff;
										exitButtonOn = false;
										
										Environment.stageRef.addEventListener(TouchEvent.TOUCH, stageStatsTouchHandler);
									}
								}
							}
						} else
						if (currentElimsButtonOn || totalElimsButtonOn || resumeButtonOn || optionsButtonOn || exitButtonOn) {
							
							totalElimsBG.color = Hud.statsBoxColor;
							totalElimsButtonOn = false;

							currentElimsBG.color = Hud.statsBoxColor;
							currentElimsButtonOn = false;
							
							resumeButtonFiller.color = Intro.buttonColorOff;
							resumeButtonText.color = Intro.textColorOff;
							resumeButtonOn = false;
							
							optionsButtonFiller.color = Intro.buttonColorOff;
							optionsButtonText.color = Intro.textColorOff;
							optionsButtonOn = false;
							
							exitButtonFiller.color = Intro.buttonColorOff;
							exitButtonText.color = Intro.textColorOff;
							exitButtonOn = false;
						}
					}
					
					if (statsTouchList[0].phase == TouchPhase.ENDED) {
						canSwipe = true;
					}
				}
			}
		}
		
		
		static function swipe() {
			canSwipe = false;
			
			swipeBox1Tween.moveTo(swipeBox1.x + (Main.screenWidth*swipeDir), swipeBox1.y);
			Starling.juggler.add(swipeBox1Tween);
			
			swipeBox2Tween.moveTo(swipeBox2.x + (Main.screenWidth*swipeDir), swipeBox2.y);
			Starling.juggler.add(swipeBox2Tween);
			
			swipeBox1Tween.onComplete = done;
			swipeBox2Tween.onComplete = done;
			
			function done() {
				Starling.juggler.purge();
				swipeBox1Tween.reset(swipeBox1, tweenSpeed, Transitions.EASE_OUT_BACK);
				swipeBox2Tween.reset(swipeBox2, tweenSpeed, Transitions.EASE_OUT_BACK);
				scoresAreAnimated = false;
				swipePoint = null;
			}
		}
		
		
		static function changeScoreSet() {
			if (scoreSet == 0) {
				
				Stats["scoreHeader" + (1 + (nextSwipeBox-1)*3)].text = String("PERPETUA");
				Stats["scoreHeader" + (2 + (nextSwipeBox-1)*3)].text = String("TODAY");
				Stats["scoreHeader" + (3 + (nextSwipeBox-1)*3)].text = String("");
				
				if (Data.saveObj.highScore == 0) {
					Stats["score" + (1 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (1 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.highScore));
				}
				
				if (Data.saveObj.todaysHigh == 0) {
					Stats["score" + (2 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (2 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.todaysHigh));
				}
				
				Stats["score" + (3 + (nextSwipeBox-1)*3)].text = String("");
			}
			
			if (scoreSet == 1) {
				Stats["scoreHeader" + (1 + (nextSwipeBox-1)*3)].text = String("TIMED (" + Score.timedOptions[0] + ")");
				Stats["scoreHeader" + (2 + (nextSwipeBox-1)*3)].text = String("TIMED (" + Score.timedOptions[1] + ")");
				Stats["scoreHeader" + (3 + (nextSwipeBox-1)*3)].text = String("TIMED (" + Score.timedOptions[2] + ")");
				
				if (Data.saveObj.timedScore0 == 0) {
					Stats["score" + (1 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (1 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.timedScore0));
				}
				
				if (Data.saveObj.timedScore1 == 0) {
					Stats["score" + (2 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (2 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.timedScore1));
				}
				
				if (Data.saveObj.timedScore2 == 0) {
					Stats["score" + (3 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (3 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.timedScore2));
				}
			}
			
			if (scoreSet == 2) {
				Stats["scoreHeader" + (1 + (nextSwipeBox-1)*3)].text = String("MOVES (" + Score.movesOptions[0] + ")");
				Stats["scoreHeader" + (2 + (nextSwipeBox-1)*3)].text = String("MOVES (" + Score.movesOptions[1] + ")");
				Stats["scoreHeader" + (3 + (nextSwipeBox-1)*3)].text = String("MOVES (" + Score.movesOptions[2] + ")");
				
				if (Data.saveObj.movesScore0 == 0) {
					Stats["score" + (1 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (1 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.movesScore0));
				}
				
				if (Data.saveObj.movesScore1 == 0) {
					Stats["score" + (2 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (2 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.movesScore1));
				}
				
				if (Data.saveObj.movesScore2 == 0) {
					Stats["score" + (3 + (nextSwipeBox-1)*3)].text = String("--");
				} else {
					Stats["score" + (3 + (nextSwipeBox-1)*3)].text = String(Score.addCommas(Data.saveObj.movesScore2));
				}
			}
		}
	}
}
