package tests;

import static org.junit.Assert.*;

import org.junit.Test;

public class TestMovingPieces {

	@Test
	public void testCat() {
		fail("Not yet implemented");
	}
	
	@Test
	public void testDog() {
		fail("Not yet implemented");
	}

	@Test
	public void testKing() {
		fail("Not yet implemented");
	}

	@Test
	public void testKnight() {
		fail("Not yet implemented");
	}

	@Test
	public void testPawn() {
		fail("Not yet implemented");
	}

	@Test
	public void testQueen() {
		fail("Not yet implemented");
	}
}

//Example Code:
/*
	@Test
	public void testBumbleBee() {
		Drawable [] gameBoard = new Drawable[GameEngine.BOARD_SIZE];
		BumbleBee bee = new BumbleBee(10);
		gameBaord[10] = bee;
		// Hit points if player on same space
		assertEquals(InteractionResult.HIT, bee.interact(gameBoard, 10));
		// These loops ensure no interaction if not on same space
		for (int i=0; i<10; i++)
			assertEquals(InteractionResult.NONE, bee.interact(gameBoard, i));
		for (int i=11; i<GameEngine.BOARD_SIZE; i++)	
			assertEquals(InteractionResult.NONE, bee.interact(gameBoard, i));
	}


*/