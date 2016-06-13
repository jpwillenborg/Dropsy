package  {

	import starling.events.Event;
	import starling.events.TouchEvent;
	
	
	public class Check {
		
		RowCount1;RowCount2;RowCount3;RowCount4;RowCount5;
		
		static var row0:Array = [null, null, null, null, null];
		static var row1:Array = [null, null, null, null, null];
		static var row2:Array = [null, null, null, null, null];
		static var row3:Array = [null, null, null, null, null];
		static var row4:Array = [null, null, null, null, null];
		
		static var h0:int = 0;
		static var h1:int = 0;
		static var h2:int = 0;
		static var h3:int = 0;
		static var h4:int = 0;
		
		static var v0:int = 0;
		static var v1:int = 0;
		static var v2:int = 0;
		static var v3:int = 0;
		static var v4:int = 0;
		
		static var do5:int = 0;
		
		static var redHorzElim:Array = [];
		static var redVertElim:Array = [];
		static var yellowHorzElim:Array = [];
		static var yellowVertElim:Array = [];
		static var purpleHorzElim:Array = [];
		static var purpleVertElim:Array = [];
		static var greenHorzElim:Array = [];
		static var greenVertElim:Array = [];
		static var blueHorzElim:Array = [];
		static var blueVertElim:Array = [];
		static var orangeHorzElim:Array = [];
		static var orangeVertElim:Array = [];
		static var removeArray:Array = [];
		
		static var soundCheck:Boolean = false;		
		static var turnStarted:Boolean = false;
		
		
		static function checkOff():void {
			Board.orderInt++;
			
			for (var i:int = 0; i < Board.dotList.length; i++) {
				if (Board.dotList[i].y > Drop.dropY[i]) {
					if (!soundCheck) {
						
						Audio.playClick();
						
						Check.soundCheck = true;
					}
				}
			}
			
			
			if (Board.orderInt == Board.dotList.length) {			
				
				Board.orderInt = 0;
				
				for each (var id in Board.dotList) {
					id.removeEventListener(Event.ENTER_FRAME, Drop.moveAllDown);
				}
				
				Board.reorder();
				Check.patterns();
			}
		}
		
		
		static function patterns() {
			
			do5 = 0;
					
			v0 = 0;
			v1 = 0;
			v2 = 0;
			v3 = 0;
			v4 = 0;
			
			h0 = 0;
			h1 = 0;
			h2 = 0;
			h3 = 0;
			h4 = 0;
			
			if (!Board.gameOver) {
				Board.orderInt = 0;
				
				for (var i:int = 0; i < 5; i++) {
					for each (var id in Board["row" + i]) {
						if (id.x == Board.dotWidth * 0) {
							Check["row" + i].splice(0, 1, id);
						}
						if (id.x == Board.dotWidth * 1) {
							Check["row" + i].splice(1, 1, id);
						}
						if (id.x == Board.dotWidth * 2) {
							Check["row" + i].splice(2, 1, id);
						}
						if (id.x == Board.dotWidth * 3) {
							Check["row" + i].splice(3, 1, id);
						}
						if (id.x == Board.dotWidth * 4) {
							Check["row" + i].splice(4, 1, id);
						}
					}
				}
				
				for (var j:int = 0; j < 5; j++) {
					for each (var idH in Board.colorArray) {
						if (Check["row" + j][0] && Check["row" + j][1] && Check["row" + j][2]) {
							if (Check["row" + j][0].name == idH && Check["row" + j][1].name == idH && Check["row" + j][2].name == idH) {
								Check[idH + "HorzElim"].push(Check["row" + j][0]);
								Check[idH + "HorzElim"].push(Check["row" + j][1]);
								Check[idH + "HorzElim"].push(Check["row" + j][2]);
							}
						}
						if (Check["row" + j][1] && Check["row" + j][2] && Check["row" + j][3]) {
							if (Check["row" + j][1].name == idH && Check["row" + j][2].name == idH && Check["row" + j][3].name == idH) {
								Check[idH + "HorzElim"].push(Check["row" + j][1]);
								Check[idH + "HorzElim"].push(Check["row" + j][2]);
								Check[idH + "HorzElim"].push(Check["row" + j][3]);
							}
						}
						if (Check["row" + j][2] && Check["row" + j][3] && Check["row" + j][4]) {
							if (Check["row" + j][2].name == idH && Check["row" + j][3].name == idH && Check["row" + j][4].name == idH) {
								Check[idH + "HorzElim"].push(Check["row" + j][2]);
								Check[idH + "HorzElim"].push(Check["row" + j][3]);
								Check[idH + "HorzElim"].push(Check["row" + j][4]);
							}
						}
					}
				}
				
				for (var k:int = 0; k < 5; k++) {
					for each (var idV in Board.colorArray) {
						if (row0[k] && row1[k] && row2[k]) {
							if (row0[k].name == idV && row1[k].name == idV && row2[k].name == idV) {
								Check[idV + "VertElim"].push(row0[k]);
								Check[idV + "VertElim"].push(row1[k]);
								Check[idV + "VertElim"].push(row2[k]);
							}
						}
						if (row1[k] && row2[k] && row3[k]) {
							if (row1[k].name == idV && row2[k].name == idV && row3[k].name == idV) {
								Check[idV + "VertElim"].push(row1[k]);
								Check[idV + "VertElim"].push(row2[k]);
								Check[idV + "VertElim"].push(row3[k]);
							}
						}
						if (row2[k] && row3[k] && row4[k]) {
							if (row2[k].name == idV && row3[k].name == idV && row4[k].name == idV) {
								Check[idV + "VertElim"].push(row2[k]);
								Check[idV + "VertElim"].push(row3[k]);
								Check[idV + "VertElim"].push(row4[k]);
							}
						}
					}
				}
				
				if (redHorzElim.length > 0 || redVertElim.length > 0 || yellowHorzElim.length > 0 || yellowVertElim.length > 0 || purpleHorzElim.length > 0 || purpleVertElim.length > 0 || greenHorzElim.length > 0 || greenVertElim.length > 0 || blueHorzElim.length > 0 || blueVertElim.length > 0 || orangeHorzElim.length > 0 || orangeVertElim.length > 0) {	
					
					do5 = 0;
					
					v0 = 0;
					v1 = 0;
					v2 = 0;
					v3 = 0;
					v4 = 0;
					
					h0 = 0;
					h1 = 0;
					h2 = 0;
					h3 = 0;
					h4 = 0;
				
					for each (id in Board.colorArray) {
						
						for each (var id1 in Check[id + "HorzElim"]) {
							removeArray.push(id1);
						}
						
						for each (var id2 in Check[id + "VertElim"]) {
							removeArray.push(id2);
						}
					}
					
					
					//remove duplicates
					
					for (var i2:int = 0; i2 < removeArray.length - 1; i2++) {
						for (var j2:int = i2 + 1; j2 < removeArray.length; j2++) {
							if (removeArray[i2] === removeArray[j2]) {
								removeArray.splice(j2, 1);
							}
						}
					}
					
					
					// left with real count...now check
					
					for each (var vCheck in removeArray) {
						for (var vv:int = 0; vv < 5; vv++) {
							if (vCheck.x == Board.dotWidth * vv) {
								Check["v" + vv]++;
							}
						}
					}
					
					for (var vNum:int = 0; vNum < 5; vNum++) {
						if (Check["v" + vNum] == 5) {
							do5++;
						}
					}
					
					
					
					for each (var hCheck in removeArray) {
						for (var hh:int = 0; hh < 5; hh++) {
							if (hCheck.y == Board.dotWidth * hh) {
								Check["h" + hh]++;
							}
						}
					}
					
					for (var hNum:int = 0; hNum < 5; hNum++) {
						if (Check["h" + hNum] == 5) {
							do5++;
						}
					}
					
					
					if (do5 > 0) {						
						Audio.playUpgrade();
						Environment.currentRedux += do5;
						Hud.reduxText.text = String("ELIMS\n" + Environment.currentRedux);
					}
					
					
					//reset
					
					do5 = 0;
					
					v0 = 0;
					v1 = 0;
					v2 = 0;
					v3 = 0;
					v4 = 0;
					
					h0 = 0;
					h1 = 0;
					h2 = 0;
					h3 = 0;
					h4 = 0;
					
					Score.updateScore(removeArray.length);
					Animations.elim();
				} else {					
					if (Drop.singleAllowed) {
						Drop.singleAllowed = false;
						Drop.newDrop();
					} else {
						Audio.elimCount = 0;
						Board.reset();
						
						if (Screens.gameMode == "moves") {
							if (Score.movesLeft == 0 ) {
								Board.boardIsActive = false;
								
								if (Board.reduxRing) {
									Redux.resetRedux();
								}
								Board.reduxIcon.removeEventListener(TouchEvent.TOUCH, Board.reduxTouchHandler);
								Board.statsIcon.removeEventListener(TouchEvent.TOUCH, Board.statsIconTouchHandler);
								
								End.lose();
							}
						}
					}
					resetArrays();
				}
			}
		}
		
		
		static function reorderAfterElim() {
			for each (var id15 in removeArray) {
				for (var ii:int = 0; ii < Board.dotList.length; ii++) {
					if (id15 == Board.dotList[ii]) {
						Board.dotList.splice(ii, 1);
					}
				}
			}
			
			resetArrays();
			Drop.dropAll();
			Drop.singleAllowed = true;
			Board.reset();
			Board.disable();
		}
		
		
		static function resetArrays() {
			redHorzElim.length = 0;
			redVertElim.length = 0;
			yellowHorzElim.length = 0;
			yellowVertElim.length = 0;
			purpleHorzElim.length = 0;
			purpleVertElim.length = 0;
			greenHorzElim.length = 0;
			greenVertElim.length = 0;
			blueHorzElim.length = 0;
			blueVertElim.length = 0;
			orangeHorzElim.length = 0;
			orangeVertElim.length = 0;
			removeArray.length = 0;
			
			row0 = [null, null, null, null, null];
			row1 = [null, null, null, null, null];
			row2 = [null, null, null, null, null];
			row3 = [null, null, null, null, null];
			row4 = [null, null, null, null, null];
		}
	}
}
