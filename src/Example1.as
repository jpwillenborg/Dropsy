package  {
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
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
	
	
	public class Example1 {
		
		static var tutorialText1:TextField;
		static var tutorialText2:TextField;
		
		static var dotList:Array = [];
		static var turnRateList:Array = [0,0,0];
		static var dropRate:Number = 0;
		static var acceleration:Number = 1.3;
		static var initFallSpeed:Number = (Board.dotWidth) * (3/111);
		static var maxFallSpeed:Number = (Board.dotWidth) * (50/111);
		static var alphaRate:Number = 0.18;
		static var activeDot:int = 0;
		
		static var touchList:Vector.<Touch>;
		static var diffX:int;
		static var origin:Point;
		static var point:Point;
		static var target:Image;
		static var initX:int;
		static var moveOK:Boolean = false;
		
		
		static function setup(stage:Stage, dotWidth:int) {
			
			// TEXT			
			tutorialText1 = new TextField(int(Environment.rectSprite.width*0.70), int(Environment.rectSprite.height*0.4412), String("LET'S GET\nSTARTED"), "Font", int(Environment.rectSprite.height*0.067), Hud.gameTextColor, false);
			tutorialText1.hAlign = HAlign.CENTER;
			tutorialText1.vAlign = VAlign.TOP;
			tutorialText1.x = int((Environment.rectSprite.width/2 - tutorialText1.width/2) + Environment.rectSprite.x);
			tutorialText1.y = int((Environment.rectSprite.height*0.0667) + Environment.rectSprite.y);
			tutorialText1.touchable = false;
			tutorialText1.alpha = 0;
			stage.addChild(tutorialText1);
			Screens.example1ScreenObjects.push(tutorialText1);
			
			tutorialText2 = new TextField(int(Environment.rectSprite.width*0.80), int(Environment.rectSprite.height*0.13), String("SLIDE THE FAR\nBLOCK OVER"), "Font", int(Environment.rectSprite.height*0.0471), Hud.gameTextColor, false);
			tutorialText2.hAlign = HAlign.CENTER;
			tutorialText2.vAlign = VAlign.TOP;
			tutorialText2.x = int((Environment.rectSprite.width/2 - tutorialText2.width/2) + Environment.rectSprite.x);
			tutorialText2.y = int((Environment.rectSprite.height*0.72) + Environment.rectSprite.y);
			tutorialText2.touchable = false;
			tutorialText2.alpha = 0;
			stage.addChild(tutorialText2);
			Screens.example1ScreenObjects.push(tutorialText2);
			
			
			// DOTS
			var dot1:Image = Atlas.generate("game dot");
			dot1.color = Board.dotColors0[0];
			dot1.x = 0;
			dot1.y = 0;
			dot1.width = Board.dotWidth;
			dot1.height = Board.dotWidth;
			dot1.smoothing = TextureSmoothing.BILINEAR;
			dot1.alpha = 0;
			dotList.push(dot1);
			Tutorial.tutSprite.addChild(dot1);
			
			var dot2:Image = Atlas.generate("game dot");
			dot2.color = Board.dotColors0[0];
			dot2.x = dotWidth*2;
			dot2.y = 0;
			dot2.width = Board.dotWidth;
			dot2.height = Board.dotWidth;
			dot2.smoothing = TextureSmoothing.BILINEAR;
			dot2.alpha = 0;
			dotList.push(dot2);
			Tutorial.tutSprite.addChild(dot2);
			
			var dot3:Image = Atlas.generate("game dot");
			dot3.color = Board.dotColors0[0];
			dot3.x = dotWidth*3;
			dot3.y = 0;
			dot3.width = Board.dotWidth;
			dot3.height = Board.dotWidth;
			dot3.smoothing = TextureSmoothing.BILINEAR;
			dot3.alpha = 0;
			dotList.push(dot3);
			Tutorial.tutSprite.addChild(dot3);
			
			
			var timer5:Timer = new Timer(250);
			timer5.start();
			timer5.addEventListener(TimerEvent.TIMER, timer5Handler);
			function timer5Handler(evt:TimerEvent):void {
				timer5.addEventListener(TimerEvent.TIMER, timer5Handler);
				timer5.stop();
				timer5 = null
				
				stage.addEventListener(Event.ENTER_FRAME, fadeInTitle);
				function fadeInTitle(evt:Event):void {
					if (tutorialText1.alpha < 1.0) {
						tutorialText1.alpha += 0.08;
					} else {
						
						stage.removeEventListener(Event.ENTER_FRAME, fadeInTitle);
						
						var timer4:Timer = new Timer(250);
						timer4.start();
						
						timer4.addEventListener(TimerEvent.TIMER, timerHandler4);
						function timerHandler4(evt:TimerEvent):void {
							timer4.stop();
							timer4.removeEventListener(TimerEvent.TIMER, timerHandler4);
							timer4 = null;
							
							dot1.addEventListener(Event.ENTER_FRAME, drop);
							
							stage.addEventListener(Event.ENTER_FRAME, fadeInSubTitle);
							function fadeInSubTitle(evt:Event):void {
								if (tutorialText2.alpha < 1.0) {
									tutorialText2.alpha += 0.08;
								} else {
									stage.removeEventListener(Event.ENTER_FRAME, fadeInSubTitle);
								}
							}
						}
					}
				}
			}
				
			function drop(evt:Event):void {
				
				var h = evt.target;				
				
				if (turnRateList[activeDot] == 0) {
					turnRateList[activeDot] = initFallSpeed;
				}
				
				if (dotList[activeDot].alpha < 1.0) {
					dotList[activeDot].alpha += alphaRate;
				}						
				
				turnRateList[activeDot] *= acceleration;
				turnRateList[activeDot] = Math.ceil(turnRateList[activeDot]);
				
				turnRateList[activeDot] = Math.min(turnRateList[activeDot], maxFallSpeed);
				dotList[activeDot].y += turnRateList[activeDot];
				
				
				if (dotList[activeDot].y > dotWidth*3) {
					dotList[activeDot].y = dotWidth*3;
					dotList[activeDot].removeEventListener(Event.ENTER_FRAME, drop);
					activeDot++;
					Audio.playClick();
					
					if (activeDot <= 2) {
						dotList[activeDot].addEventListener(Event.ENTER_FRAME, drop);
					} else {
						dot1.addEventListener(TouchEvent.TOUCH, moveDot1);
					}
				}
			}

			
			function moveDot1(evt:TouchEvent) {
				
				touchList = evt.getTouches(Environment.stageRef);
				
				if (touchList.length > 0) {
					if (!moveOK && touchList[0].phase == TouchPhase.BEGAN) {
						origin = touchList[0].getLocation(Tutorial.tutSprite);
						point = touchList[0].getLocation(Tutorial.tutSprite);
						target = evt.target as Image;
						initX = target.x;
						moveOK = true;
					}
				
					if (moveOK && touchList[0].phase == TouchPhase.MOVED) {
						
						point = touchList[0].getLocation(Tutorial.tutSprite);
						target.x -= origin.x - point.x;
						diffX = point.x - origin.x;
						
						
						// BOUNDS
						if (target.x < 0) {
							target.x = 0;
						}
						if (target.x >= dotWidth) {
							target.x = dotWidth;
						}
						
						
						if (!target.bounds.containsPoint(point)) {						
							origin.x = target.x + target.width/2;
							origin.y = target.y + target.height/2;
						} else {
							origin = touchList[0].getLocation(Tutorial.tutSprite);
						}
					}
			
					if (moveOK && touchList[0].phase == TouchPhase.ENDED) {
						moveOK = false;
						
						// SNAP
						if (target.x < Board.dotWidth/2) {
							target.x = Board.dotWidth*0;
						}
						if (target.x >= dotWidth/2 && target.x < dotWidth*1.5) {
							target.x =dotWidth*1;
						}
						
						// CHECK						
						if (target.x > 0) {
							dot1.removeEventListener(TouchEvent.TOUCH, moveDot1);
							
							dot1.pivotX = dot1.width/2 * 256/Board.dotWidth;
							dot1.pivotY = dot1.height/2 * 256/Board.dotWidth;
							dot1.x += (dot1.width/2);
							dot1.y += (dot1.height/2);
							
							dot2.pivotX = dot2.width/2 * 256/Board.dotWidth;
							dot2.pivotY = dot2.height/2 * 256/Board.dotWidth;
							dot2.x += (dot2.width/2);
							dot2.y += (dot2.height/2);
							
							dot3.pivotX = dot3.width/2 * 256/Board.dotWidth;
							dot3.pivotY = dot3.height/2 * 256/Board.dotWidth;
							dot3.x += (dot3.width/2);
							dot3.y += (dot3.height/2);
							
							Audio.playClear();
							
							stage.addEventListener(Event.ENTER_FRAME, animate);
							function animate(evt:Event) {
								dot1.alpha -= 0.06;
								dot1.scaleX *= 0.83;
								dot1.scaleY *= 0.83;
								
								dot2.alpha -= 0.06;
								dot2.scaleX *= 0.83;
								dot2.scaleY *= 0.83;
								
								dot3.alpha -= 0.06;
								dot3.scaleX *= 0.83;
								dot3.scaleY *= 0.83;
								
								if (dot1.alpha <=0) {
									stage.removeEventListener(Event.ENTER_FRAME, animate);
									
									Tutorial.tutSprite.removeChild(dot1);
									Tutorial.tutSprite.removeChild(dot2);
									Tutorial.tutSprite.removeChild(dot3);
									
									
									var lastTransition:Timer = new Timer(550);
									lastTransition.start();
									
									lastTransition.addEventListener(TimerEvent.TIMER, lastTransitionHandler);
									function lastTransitionHandler(evt:TimerEvent):void {
										lastTransition.stop();
										lastTransition.removeEventListener(TimerEvent.TIMER, lastTransitionHandler);
										lastTransition = null;										
										
										stage.addEventListener(Event.ENTER_FRAME, loop2);
										function loop2(evt:Event) {
											tutorialText1.alpha -= 0.06;
											tutorialText2.alpha -= 0.06;
											
											if (tutorialText1.alpha <=0) {
												
												stage.removeEventListener(Event.ENTER_FRAME, loop2);
												
												var timer:Timer = new Timer(250);
												timer.start();
												
												timer.addEventListener(TimerEvent.TIMER, timerHandler);
												function timerHandler(evt:TimerEvent):void {
													timer.stop();
													timer.removeEventListener(TimerEvent.TIMER, timerHandler);
													timer = null;
													
													tutorialText1.alpha = 0;
													tutorialText1.y = dotWidth*3 + Tutorial.tutSprite.y + dotWidth - tutorialText1.height/2;
													tutorialText1.text = String("WELL DONE");
													
													tutorialText1.alpha = 1.0;
													
													Audio.playExtra();
																
													var timer2:Timer = new Timer(2000);
													timer2.start();
													timer2.addEventListener(TimerEvent.TIMER, timerHandler2);
													function timerHandler2(evt:TimerEvent):void {
														timer2.stop();
														timer2.removeEventListener(TimerEvent.TIMER, timerHandler2);
														timer2 = null;
														
														stage.addEventListener(Event.ENTER_FRAME, fadeInEnd2);
														function fadeInEnd2(evt:Event):void {
															if (tutorialText1.alpha > 0) {
																tutorialText1.alpha -= 0.08;
															} else {
																stage.removeEventListener(Event.ENTER_FRAME, fadeInEnd2);
																
																Screens.clearExample1Screen();
																Example2.setup(stage, dotWidth);
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
					}
				}
			}
		}
	}
}
