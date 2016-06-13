package  {
	
	
	public class RowCount5 {
		
		static var row;
		static var moveList;
		
		
		static function check(diffX, row0, xList, target, moveList0):void {
			
			row = row0;
			moveList = moveList0;
			
			
			// BOUNDS			
			if (row[0].x < 0) {
				row[0].x = 0;
			}
			if (row[0].x >= 0) {
				row[0].x = 0;
			}
			
			if (row[1].x < Board.dotWidth) {
				row[1].x = Board.dotWidth;
			}
			if (row[1].x >= Board.dotWidth) {
				row[1].x = Board.dotWidth;
			}
			
			if (row[2].x < Board.dotWidth*2) {
				row[2].x = Board.dotWidth*2;
			}
			if (row[2].x >= Board.dotWidth*2) {
				row[2].x = Board.dotWidth*2;
			}
			
			if (row[3].x < Board.dotWidth*3) {
				row[3].x = Board.dotWidth*3;
			}
			if (row[3].x >= Board.dotWidth*3) {
				row[3].x = Board.dotWidth*3;
			}
			
			if (row[4].x < Board.dotWidth*4) {
				row[4].x = Board.dotWidth*4;
			}
			if (row[4].x >= Board.dotWidth*4) {
				row[4].x = Board.dotWidth*4;
			}
		}
		
		
		static function snap(row0) {
			row = row0;
		}
	}
}
