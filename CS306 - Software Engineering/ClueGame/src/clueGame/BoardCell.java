//Authors: Nicholas McClellan
//		   Cat de Frates
package clueGame;

public class BoardCell {
	//row & column variables
	private int row;
	private int column;
	private char initial;
	private boolean isDoor;
	private DoorDirection direction;

	//Constructor for the individual cells, init to grid[i][j]
	public BoardCell(int i, int j, char initial) {
		super();
		this.row = i;
		this.column = j;
		this.initial = initial;
		this.isDoor = false;
		this.direction = DoorDirection.NONE;
	}

	public BoardCell() {
		
	}

	// equals override function
	@Override
	public boolean equals(Object a) {
		BoardCell cell = (BoardCell) a;
		if (a == this) {
            return true;
        }
		if (a == null) {
            return false;
        }
		return this.row == cell.row && this.column == cell.column && this.initial == cell.initial;
	}
	
	//helper functions to determine if a walkway
	public boolean isWalkway() {
		return (this.initial == 'W');
	}

	//helper functions to determine if a room
	public boolean isRoom() {
		return (!this.isWalkway() && !this.isDoorway());
	}
			
	//helper functions to determine if a doorway
	public boolean isDoorway() {
		return this.isDoor;
	}
	
	///helper functions to determine space on board initial
	public char getInitial() {
		return this.initial;
	}

	//helper function to determine door direction
	public DoorDirection getDoorDirection() {
		return this.direction;
	}
	
	//getter function for the row of the board
	public int getRow() {
		return row;
	}
	
	//getter function for the column of the board
	public int getColumn() {
		return column;
	}
	
	//getter function for setting the door direction
	public void setDirection(char direction) {
		//based on 2nd letter of initial, decide the direction of the door. 
		switch(direction) {
			case 'U':
				this.direction = DoorDirection.UP;
				break;
			case 'D':
				this.direction = DoorDirection.DOWN;
				break;
			case 'L':
				this.direction = DoorDirection.LEFT;
				break;
			case 'R':
				this.direction = DoorDirection.RIGHT;
				break;
			//Default case sets the direction to none.
			default:
				this.direction = DoorDirection.NONE;
				break;
		}
	}
	
	//mark the space as a door
	public void setDoor() {
		this.isDoor = true;
	}

	//To string method
	@Override
	public String toString() {
		return "BoardCell [row=" + row + ", column=" + column + ", initial=" + initial + ", isDoor=" + isDoor
				+ ", direction=" + direction + "]";
	}
	

	
	
	
	
}
