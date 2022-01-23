//Authors: Nicholas McClellan
//		   Benjamin Jessing
//		   Marie McCarthy
package levelPieces;

import gameEngine.*;
import java.util.Arrays;


public class Knight extends GamePiece implements Moveable {
	
	//constructor
	public Knight(int location) {
		super('$', location);

	}

	@Override
	//Results from coming into contact with pieces
	public InteractionResult interact(Drawable[] pieces, int playerLocation) {
		//conditional; in range to interact
		if(this.location == playerLocation) {
			return 	InteractionResult.ADVANCE;
		}
		//otherwise
		else {
			return InteractionResult.NONE;
		}
	}

	@Override
	//Move method
	public void move(Drawable[] gameBoard, int playerLocation) {
		// this knight no longer will show in the drawn array
		gameBoard[this.location] = null;
		//location  for this knight is now randomized
		this.location = (int)(Math.random() * 20 + 1);
		//setting the old piece to the new location
		gameBoard[this.location] = this;
	}
}

