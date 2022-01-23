//Authors: Nicholas McClellan
//		   Benjamin Jessing
//		   Marie McCarthy
package levelPieces;

import java.util.ArrayList;
import java.util.Arrays;

import gameEngine.GameEngine;
import gameEngine.Drawable;
import gameEngine.Moveable;

public class LevelEngine {
	//level1 and level2 member variables, getBoard for(GamePiece: level1){} etc.
	private Drawable[] gameBoard = new Drawable[GameEngine.BOARD_SIZE]; // pieces is the drawable array of pieces used for the board; pieces will be placed on different locations based on the level number
	private ArrayList<GamePiece> interactingPieces = new ArrayList<GamePiece>();
	private ArrayList<Moveable> movingPieces = new ArrayList<Moveable>();
	
	
	public LevelEngine() {
		super();
	}
	
	public void createLevel1(){
		//init the pieces
		Pawn ourPawn = new Pawn(3);
		Knight ourKnight = new Knight(5); 
		Queen ourQueen = new Queen(7); 
		King ourKing = new King(9); 
		Dog ourDog = new Dog(2); 
		Cat ourCat = new Cat(15); 
		//populate arrays
		gameBoard[ourPawn.location] = ourPawn;
		gameBoard[ourKnight.location] = ourKnight;
		gameBoard[ourQueen.location] = ourQueen;
		gameBoard[ourKing.location] = ourKing;
		gameBoard[ourDog.location] = ourDog;
		gameBoard[ourCat.location] =  ourCat;
		interactingPieces.add(ourPawn);
		interactingPieces.add(ourKnight);
		interactingPieces.add(ourQueen);
		interactingPieces.add(ourKing);
		interactingPieces.add(ourDog);
		movingPieces.add(ourKnight);	
		movingPieces.add(ourDog);
	}
	
	public void createLevel2(){
		//clear previous arrays
		Arrays.fill(gameBoard, null); // clear the pieces array
		interactingPieces.clear();
		movingPieces.clear();
		//init the pieces
		Pawn ourPawn = new Pawn(2);
		Knight ourKnight = new Knight(9); 
		Queen ourQueen = new Queen(7); 
		King ourKing = new King(5); 
		Dog ourDog = new Dog(3); 
		Cat ourCat = new Cat(15); 
		//populate arrays
		gameBoard[ourPawn.location] = ourPawn;
		gameBoard[ourKnight.location] = ourKnight;
		gameBoard[ourQueen.location] = ourQueen;
		gameBoard[ourKing.location] = ourKing;
		gameBoard[ourDog.location] = ourDog;
		gameBoard[ourCat.location]  = ourCat; 
		interactingPieces.add(ourPawn);
		interactingPieces.add(ourKnight);
		interactingPieces.add(ourQueen);
		interactingPieces.add(ourKing);
		interactingPieces.add(ourDog);
		movingPieces.add(ourDog);
		movingPieces.add(ourKnight);
	}
	
	public void createLevel(int levelNum) {
		if(levelNum == 1) {
			createLevel1();
		}
		else {
			createLevel2();
		}
	}

	public Drawable[] getBoard() { // how do we implement get board? 
		return gameBoard;
	}

	public ArrayList<Moveable> getMovingPieces() {
		return movingPieces;
	}

	public ArrayList<GamePiece> getInteractingPieces() {
		return interactingPieces;
	}

	public int getPlayerStartLoc() {
		return 0;
	}

}
