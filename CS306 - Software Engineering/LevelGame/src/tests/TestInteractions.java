package tests;

import static org.junit.Assert.*;

import org.junit.Test;

import gameEngine.Drawable;
import gameEngine.GameEngine;
import gameEngine.InteractionResult;
import levelPieces.Cat;
import levelPieces.Dog;
import levelPieces.King;
import levelPieces.Knight;
import levelPieces.Pawn;

public class TestInteractions {

	@Test
	//Non-interacting piece (not a gamepiece)
	public void testCat() {
		//Create a gameBoard local to the test
		Drawable [] gameBoard = new Drawable[GameEngine.BOARD_SIZE];
		//Create the piece, and add to the board
		Cat c = new Cat(10);
		gameBoard[c.location] = c;
		fail("Not yet implemented");
	}
	
	@Test
	public void testDog() {
		//Create a gameBoard local to the test
		Drawable [] gameBoard = new Drawable[GameEngine.BOARD_SIZE];
		//Create the piece, and add to the board
		Dog d = new Dog(10);
		gameBoard[d.getLocation()] = d;
		//Check the result is valid
		assertEquals(InteractionResult.GET_POINT, d.interact(gameBoard, 10));
		assertEquals(InteractionResult.GET_POINT, d.interact(gameBoard, 9));
		assertEquals(InteractionResult.GET_POINT, d.interact(gameBoard, 8));
		assertEquals(InteractionResult.GET_POINT, d.interact(gameBoard, 11));
		assertEquals(InteractionResult.GET_POINT, d.interact(gameBoard, 12));
		assertEquals(InteractionResult.NONE, d.interact(gameBoard, 7));
		assertEquals(InteractionResult.NONE, d.interact(gameBoard, 13));
	}

	@Test
	public void testKing() {
		//Create a gameBoard local to the test
		Drawable [] gameBoard = new Drawable[GameEngine.BOARD_SIZE];
		//Create the piece, and add to the board
		King k = new King(10);
		gameBoard[k.getLocation()] = k;
		//Check the result is valid
		assertEquals(InteractionResult.HIT, k.interact(gameBoard, 10));
		assertEquals(InteractionResult.HIT, k.interact(gameBoard, 9));
		assertEquals(InteractionResult.HIT, k.interact(gameBoard, 11));
		assertEquals(InteractionResult.NONE, k.interact(gameBoard, 8));
		assertEquals(InteractionResult.NONE, k.interact(gameBoard, 12));	
	}

	@Test
	public void testKnight() {
		//Create a gameBoard local to the test
		Drawable [] gameBoard = new Drawable[GameEngine.BOARD_SIZE];
		//Create the piece, and add to the board
		Knight $ = new Knight(10);
		gameBoard[$.getLocation()] = $;
		//Check the result is valid
		assertEquals(InteractionResult.ADVANCE, $.interact(gameBoard, 10));
		assertEquals(InteractionResult.NONE, $.interact(gameBoard, 9));
		assertEquals(InteractionResult.NONE, $.interact(gameBoard, 11));
	}

	@Test
	public void testPawn() {
		//Create a gameBoard local to the test
		Drawable [] gameBoard = new Drawable[GameEngine.BOARD_SIZE];
		//Create the piece, and add to the board
		Pawn p = new Pawn(10);
		gameBoard[p.getLocation()] = p;
		//Check the result is valid
		assertEquals(InteractionResult.NONE, p.interact(gameBoard, 10));
		assertEquals(InteractionResult.NONE, p.interact(gameBoard, 9));
		assertEquals(InteractionResult.NONE, p.interact(gameBoard, 11));
	}

	@Test
	public void testQueen() {
		//Create a gameBoard local to the test
		Drawable [] gameBoard = new Drawable[GameEngine.BOARD_SIZE];
		//Create the piece, and add to the board
		Pawn p = new Pawn(10);
		gameBoard[p.getLocation()] = p;
		//Check the result is valid
		assertEquals(InteractionResult.NONE, p.interact(gameBoard, 10));
		assertEquals(InteractionResult.NONE, p.interact(gameBoard, 9));
		assertEquals(InteractionResult.NONE, p.interact(gameBoard, 11));
		
	}

}
