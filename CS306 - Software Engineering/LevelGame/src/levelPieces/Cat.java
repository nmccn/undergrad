//Authors: Nicholas McClellan
//		   Benjamin Jessing
//		   Marie McCarthy
package levelPieces;

import gameEngine.Drawable;

public class Cat implements Drawable  {
	public int location;
	private char symbol;
	
	//Constructor
	public Cat(int location) {
		this.symbol = 'c';
		this.location = location;
	}

	@Override
	//This class only implements drawable, such that it is not a gamePiece
	public void draw() {
		System.out.print(symbol);
	}

}