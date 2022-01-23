//Authors: Nicholas McClellan
//		   Benjamin Jessing
//		   Marie McCarthy
package levelPieces;
import java.lang.Math; 
import gameEngine.*;

public class Dog extends GamePiece implements Moveable{

	public boolean moveLeft = true;
	
	//Constructor
	public Dog(int location) {
		super('d', location);

	}

	@Override
	//Results from coming into contact with pieces
	public InteractionResult interact(Drawable[] gameBoard, int playerLocation) {
		//determine distance
		int distance = Math.abs(this.location - playerLocation);
		//conditional; in range to interact
		if(distance <= 2) {
			return 	InteractionResult.GET_POINT;
		}
		//otherwise
		else {
			return InteractionResult.NONE;
		}
	}

	@Override
	//Method to move linearly from side to side
	public void move(Drawable[] gameBoard, int playerLocation) {
	
		// this knight no longer will show in the drawn array
		gameBoard[this.location] = null;
		//Conditionals to check for edge positions
		if(this.location == 20) {
			moveLeft = true;
		}
		else if(this.location == 0) {
			moveLeft = false;
		}
		
		//Moving the piece based on boolean value
		if(moveLeft) {
			this.location--;
		}
		else {
			this.location++;
		}
		
		//setting the old piece to the new location
		gameBoard[this.location] = this;
	}
}