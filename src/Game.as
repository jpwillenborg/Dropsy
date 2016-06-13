package {
	
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	
	
	public class Game extends Sprite {
		
		
		function Game() {
			addEventListener(Event.ADDED_TO_STAGE, start);
			function start(evt:Event):void {
				Environment.setup(stage);
				Screens.setLoading();				
				Hud.initBrightness();
				removeEventListener(Event.ADDED_TO_STAGE, start);
			}
		}
	}
}
