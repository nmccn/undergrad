//Authors: Nicholas McClellan
//		   Benjamin Jessing
//		   Marie McCarthy
package levelPieces;

import gameEngine.*;

public class Queen extends GamePiece{

	//Constructor
	public Queen(int location) {
		super('q', location);

	}

	@Override
	//location  for this knight is now randomized
	public InteractionResult interact(Drawable[] pieces, int playerLocation) {
		//conditional;  if in range to interact
		if(this.location == playerLocation) {
			return 	InteractionResult.KILL;
		}
		//otherwise
		else {
			return InteractionResult.NONE;
		}
	}
}
