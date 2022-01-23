//Authors: Nicholas McClellan
//		   Benjamin Jessing
//		   Marie McCarthy
package levelPieces;

import gameEngine.Drawable;
import gameEngine.InteractionResult;

public class Pawn extends GamePiece implements Drawable{

	//Constructor
	public Pawn(int location) {
		super('p', location);
	}

	@Override
	//Results from coming into contact with pieces
	public InteractionResult interact(Drawable[] pieces, int playerLocation) {
		return 	InteractionResult.NONE;
	}
}
