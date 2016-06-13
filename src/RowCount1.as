package  {
	
	
	public class RowCount1 {
		
		static var row;
		static var moveList;
		
		
		static function check(diffX, row0, xList, target, moveList0):void {
			
			row = row0;
			moveList = moveList0;
						
			// BOUNDS			
			if (row[0].x < 0) {
				row[0].x = 0;
			}
			if (row[0].x >= Board.dotWidth*4) {
				row[0].x = Board.dotWidth*4;
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
			if (row[0].x >= Board.dotWidth*2.5 && row[0].x < Board.dotWidth*3.5) {
				row[0].x = Board.dotWidth*3;
			}
			if (row[0].x >= Board.dotWidth*3.5) {
				row[0].x = Board.dotWidth*4;
			}
		}
	}
}
