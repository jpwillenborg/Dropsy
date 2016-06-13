package  {
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.*;
	import flash.utils.Timer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	
	public class Redux {
		
		static var reduxOn:Boolean = false;
		static var reduxArray:Array = [];
		static var waitingForStats:Boolean = false;
		
		
		static function balanceRedux() {
			Environment.totalRedux += Environment.currentRedux;
			Environment.currentRedux = 0;
			
			Data.saveObj.totalRedux = Environment.totalRedux;
			Data.saveObj.currentRedux = Environment.currentRedux;			
		}
		
		
		static function newRedux() {
			if (Environment.totalRedux > 9) {
				Environment.totalRedux -= 10;
				Environment.currentRedux += 10;
			} else {
				Environment.currentRedux += Environment.totalRedux;
				Environment.totalRedux = 0;
			}
		}
		
		
		static function reduceRedux() {
			if (Environment.currentRedux > 0) {
				Environment.currentRedux--;
				Hud.reduxText.text = String("ELIMS\n" + Score.addCommas(Environment.currentRedux));
				
				Data.saveObj.totalRedux = Environment.totalRedux;
				Data.saveObj.currentRedux = Environment.currentRedux;
				Data.flushSave();
			}
		}
		
		
		static function rateRedux() {
			Environment.totalRedux += 20;
			Data.saveObj.totalRedux += 20;
			Data.flushSave();
		
			if (Screens.currentScreen == "stats" && Stats.statsSprite) {
				
				var updateRefresh:Timer;			
				updateRefresh = new Timer(250);
				updateRefresh.start();
				
				updateRefresh.addEventListener(TimerEvent.TIMER, updateRefreshHandler);
				function updateRefreshHandler(evt:TimerEvent):void {
					updateRefresh.stop();
					updateRefresh.removeEventListener(TimerEvent.TIMER, updateRefreshHandler);
					updateRefresh = null;
					
					Stats.statsSprite.unflatten();
					Stats.totalElims.text = String(Score.addCommas(Environment.totalRedux));
					Stats.statsSprite.flatten();
					Audio.playUpgrade();
				}
			}
		}
		
		
		static function resumeRateRedux() {
			if (Data.saveObj.hasRated && !Data.saveObj.rateCheck) {
				Data.saveObj.rateCheck = true;
				Data.saveObj.totalRedux += 20;
				Data.flushSave();
			}
		}
		
		
		static function set() {
			if (!reduxOn && Environment.currentRedux > 0) {
				reduxOn = true;
				setRing();
			} else {
				
				if (!reduxOn) {
					reduxOn = false;
					Hud.reduxText.color = Hud.iconsOffColor;
					Board.reduxIcon.color = Hud.iconsOffColor;
				} else {
					
					reduxOn = false;
					Hud.reduxText.color = Hud.iconsOffColor;
					Board.reduxIcon.color = Hud.iconsOffColor;
				}
			}
		}
		
		
		static function check(dot) {
			var dotName = dot.name;
			
			for each (var idC in Board.dotList) {
				if (dotName == idC.name) {					
					reduxArray.push(idC);
				}
			}
			
			if (reduxArray.length > 0) { 
				Board.canMove = false;
				Board.reduxIcon.color = Hud.iconsOffColor;
				Hud.reduxText.color = Hud.iconsOffColor;
				Board.reduxRing.color = Hud.iconsOffColor;
				
				Environment.stageRef.removeEventListener(Event.ENTER_FRAME, moveRing);
				Board.reduxRing.visible = false;
				Board.reduxRing.alpha = 1.0;
				Board.reduxRing.height = int(Environment.rectSprite.width*0.21875); // 203125
				Board.reduxRing.scaleX = Board.reduxRing.scaleY;
				
				elim();
			}
		}
		
		
		static function elim() {
			for each (var id0 in reduxArray) {
				id0.pivotX = id0.width/2 * 256/Board.dotWidth;
				id0.pivotY = id0.height/2 * 256/Board.dotWidth;
				id0.x += (id0.width/2);
				id0.y += (id0.height/2);
			}
			
			Audio.playClear();
			
			Vibrate.buzz(250);
			
			reduceRedux();
			
			Hud.hudSprite.unflatten();
			Hud.reduxText.color = Hud.iconsOffColor;
			Board.reduxIcon.color = Hud.iconsOffColor;
			Board.reduxRing.color = Hud.iconsOffColor;
			Hud.hudSprite.flatten();
			
			Environment.stageRef.addEventListener(Event.ENTER_FRAME, fadeOut);
		}
		
		
		static function fadeOut(evt:Event) {
				
			if (!Stats.isPaused) {
			
				for each (var id in reduxArray) {
					id.alpha -= 0.06;
					id.scaleX *= 0.90;
					id.scaleY *= 0.90;
				}
				
				if (reduxArray[0].alpha <= 0) {
					Environment.stageRef.removeEventListener(Event.ENTER_FRAME, fadeOut);
					for each (var id2 in reduxArray) {
						Board.boardSprite.removeChild(id2);
						id2.dispose();
					}
					
					Check.reorderAfterElim();
					resetRedux();
				}
			}
		}
		
		
		static function setRing() {
			Board.reduxRing.visible = true;
			Environment.stageRef.addEventListener(Event.ENTER_FRAME, moveRing);
		}
		
		
		static function moveRing(evt:Event) {
			if (!Stats.isPaused) {
				
				Board.reduxRing.alpha -= 0.012;
				Board.reduxRing.scaleX *= 1.008;
				Board.reduxRing.scaleY *=  1.008;
				if (Board.reduxRing.width >= Board.ringMax) {
					
					Board.reduxRing.alpha = 1.0;
					Board.reduxRing.height = int(Environment.rectSprite.width*0.21875);
					Board.reduxRing.scaleX = Board.reduxRing.scaleY;
				}
			}
		}
		
		
		static function resetRedux() {
			reduxArray.length = 0;
			reduxOn = false;
			Board.canMove = true;
			
			
			Hud.hudSprite.unflatten();
			if (!waitingForStats) {
				Board.reduxIcon.color = Hud.iconsOffColor;
				Board.reduxRing.color = Hud.iconsOffColor;
				Hud.reduxText.color = Hud.iconsOffColor;
			}
			Hud.hudSprite.flatten();
			
			Environment.stageRef.removeEventListener(Event.ENTER_FRAME, moveRing);
			Board.reduxRing.visible = false;
			Board.reduxRing.alpha = 1.0;
			Board.reduxRing.height = int(Environment.rectSprite.width*0.21875);
			Board.reduxRing.scaleX = Board.reduxRing.scaleY;
		}
	}
}
