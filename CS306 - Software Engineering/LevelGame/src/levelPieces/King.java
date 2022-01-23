//Authors: Nicholas McClellan
//		   Benjamin Jessing
//		   Marie McCarthy
package levelPieces;

import gameEngine.*;

public class King extends GamePiece {

	//Constructor
	public King(int location) {
		super('k', location);

	}

	@Override
	//Results from coming into contact with pieces
	public InteractionResult interact(Drawable[] gameBoard, int playerLocation) {
		//determine distance
		int distance = Math.abs(this.location - playerLocation);
		//conditional; in range to interact
		if(distance <= 1) {
			return 	InteractionResult.HIT;
		}
		//otherwise
		else {
			return InteractionResult.NONE;
		}
	}


}
