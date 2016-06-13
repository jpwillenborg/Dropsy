package  {
	
	import flash.utils.*;
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.Event;
	
	
	public class Animations {
		
		
		static function elim() {
			
			for each (var id0 in Check.removeArray) {
				id0.pivotX = id0.width/2 * 256/Board.dotWidth;
				id0.pivotY = id0.height/2 * 256/Board.dotWidth;
				id0.x += (id0.width/2);
				id0.y += (id0.height/2);
			}
			
			Audio.playClear();
			
			Environment.stageRef.addEventListener(Event.ENTER_FRAME, fadeOut);
		}
		
		
		static function fadeOut(evt:Event) {
				
			if (!Stats.isPaused && !Board.gameOver) {
			
				for each (var id in Check.removeArray) {
					id.alpha -= 0.06;
					id.scaleX *= 0.83;
					id.scaleY *= 0.83;
				}
				
				if (Check.removeArray[0].alpha <= 0) {
					Environment.stageRef.removeEventListener(Event.ENTER_FRAME, fadeOut);
					for each (var id2 in Check.removeArray) {
						Board.boardSprite.removeChild(id2);
						id2.dispose();
					}
					
					Check.reorderAfterElim();
				}
			}
		}
	}
}
