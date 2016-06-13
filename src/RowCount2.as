package  {

	
	public class RowCount2 {
		
		static var row;
		static var moveList;
		
		
		static function check(diffX, row0, xList, target, moveList0):void {
			
			row = row0;
			moveList = moveList0;
			
			if (diffX > 0) {
				if (row[0].x > row[1].x - row[0].width) {
					setX(1);
					row[1].x = row[0].x + row[0].width;						
				}
			}
			
			if (diffX < 0) { // always reverse!!
				if (row[1].x < row[0].x + row[0].width) {
					setX(-1);	
					row[0].x = row[1].x - row[0].width;
				}
			}
			
			
			// SET X			
			function setX(potential) {
				if (potential == 1) {
					if (xList.length == 1) {
						if (target == row[0]) {
							xList[1] = row[1].x;
							moveList.push(row[1]);
						}
					}
				}
				
				if (potential == -1) {
					if (xList.length == 1) {
						if (target == row[1]) {
							xList[1] = row[0].x;
							moveList.push(row[0]);
						}
					}
				}
			}
			
			
			// MAGNET				
			if (moveList.length == 2) {
				if (moveList[0].x < moveList[1].x) {
					if (moveList[1].x > xList[1]) {
						moveList[1].x = target.x + target.width;
					} else {
						moveList[1].x = xList[1];
						moveList.splice(1,1);
						xList.splice(1,1);
					}
				} else 
				if (moveList[0].x > moveList[1].x) {
					if (moveList[1].x < xList[1]) {
						moveList[1].x = target.x - moveList[1].width;
					} else {
						moveList[1].x = xList[1];
						moveList.splice(1,1);
						xList.splice(1,1);
					}
				}
			} 
			
			
			// BOUNDS			
			if (row[0].x < Board.dotWidth*0) {
				row[0].x = Board.dotWidth*0;
			}
			if (row[0].x >= Board.dotWidth*3) {
				row[0].x = Board.dotWidth*3;
			}
			
			if (row[1].x < Board.dotWidth*1) {
				row[1].x = Board.dotWidth*1;
			}
			if (row[1].x >= Board.dotWidth*4) {
				row[1].x = Board.dotWidth*4;
			}
		}
		
		
		static function snap(row0) {
			
			row = row0;
			
			if (row[0].x < Board.dotWidth/2) {
				row[0].x = Board.dotWidth*0;
			}
			if (row[0].x >= Board.dotWidth/2 && row[0].x < Board.dotWidth*1.5) {
				row[0].x =Board.dotWidth*1;
			}
			if (row[0].x >= Board.dotWidth*1.5 && row[0].x < Board.dotWidth*2.5) {
				row[0].x = Board.dotWidth*2;
			}
			if (row[0].x >= Board.dotWidth*2.5) {
				row[0].x = Board.dotWidth*3;
			}
			
			
			if (row[1].x < Board.dotWidth*1.5) {
				row[1].x = Board.dotWidth;
			}
			if (row[1].x >= Board.dotWidth*1.5 && row[1].x < Board.dotWidth*2.5) {
				row[1].x = Board.dotWidth*2;
			}
			if (row[1].x >= Board.dotWidth*2.5 && row[1].x < Board.dotWidth*3.5) {
				row[1].x = Board.dotWidth*3;
			}
			if (row[1].x >= Board.dotWidth*3.5) {
				row[1].x = Board.dotWidth*4;
			}
		}
	}
}
