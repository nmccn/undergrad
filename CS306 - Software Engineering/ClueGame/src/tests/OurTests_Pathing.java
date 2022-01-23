package tests;

/*
 * This program tests that adjacencies and targets are calculated correctly.
 */

import java.util.Set;

//Doing a static import allows me to write assertEquals rather than
//assertEquals
import static org.junit.Assert.*;
import org.junit.BeforeClass;
import org.junit.Test;

import clueGame.Board;
import clueGame.BoardCell;

public class OurTests_Pathing {
	// We make the Board static because we can load it one time and 
	// then do all the tests. 
	private static Board board;
	@BeforeClass
	public static void setUp() {
		// Board is singleton, get the only instance
		board = Board.getInstance();
		// set the file names to use my config files
		board.setConfigFiles("BoardLayoutCSV.csv", "RoomsLegend.txt", "player_legend.txt", "WeaponsLegend.txt");		
		// Initialize will load BOTH config files 
		board.initialize();
	}
	/////////////////////////a////////////////////////////////////
	////					Adj. Testing					 ////
	/////////////////////////////////////////////////////////////

	// Test walkway pieces surrounded by only other walkways
	// These tests are LIGHT PURPLE on the planning spreadsheet
	@Test
	public void testOnlyAdj_Walkway()
	{
		//both pieces surrounded on all sides by other walkways
		Set<BoardCell> testList = board.getAdjList(10, 2);
		assertTrue(testList.contains(board.getCellAt(9, 2)));
		assertTrue(testList.contains(board.getCellAt(11, 2)));
		assertTrue(testList.contains(board.getCellAt(10, 3)));
		assertTrue(testList.contains(board.getCellAt(10, 1)));
		assertEquals(4, testList.size());

		testList = board.getAdjList(13, 14);
		assertTrue(testList.contains(board.getCellAt(12, 14)));
		assertTrue(testList.contains(board.getCellAt(14, 14)));
		assertTrue(testList.contains(board.getCellAt(13, 13)));
		assertTrue(testList.contains(board.getCellAt(13, 15)));
		assertEquals(4, testList.size());
	}

	// Ensure that player does not move around within room
	// These cells are ORANGE on the planning spreadsheet
	@Test
	public void testInsideRooms()
	{
		// Test a corner
		Set<BoardCell> testList = board.getAdjList(0, 2);
		assertEquals(0, testList.size());
		// Test one that has walkway underneath
		testList = board.getAdjList(16, 21);
		assertEquals(0, testList.size());
		// Test one that has walkway above
		testList = board.getAdjList(19, 9);
		assertEquals(0, testList.size());
		// Test one that is in middle of room
		testList = board.getAdjList(23, 18);
		assertEquals(0, testList.size());
		// Test one beside a door
		testList = board.getAdjList(6, 11);
		assertEquals(0, testList.size());
		// Test one in a corner of room
		testList = board.getAdjList(25, 0);
		assertEquals(0, testList.size());
	}

	@Test
	// Test walkway piece at the edge of the board
	// These tests are LIGHT PURPLE on the planning spreadsheet
	public void testWalkway_EdgePiece1() {
		//right edge
		Set<BoardCell> testList = board.getAdjList(19, 21);
		assertTrue(testList.contains(board.getCellAt(18, 21)));
		assertTrue(testList.contains(board.getCellAt(20, 21)));
		assertTrue(testList.contains(board.getCellAt(19, 20)));
		assertEquals(3, testList.size());

		//top edge
		testList = board.getAdjList(0, 7);
		assertTrue(testList.contains(board.getCellAt(1, 7)));
		assertEquals(1, testList.size());

		//bottom
		testList = board.getAdjList(25, 16);
		assertTrue(testList.contains(board.getCellAt(24, 16)));
		assertEquals(1, testList.size());

		//left edge
		testList = board.getAdjList(19, 0);
		assertTrue(testList.contains(board.getCellAt(18, 0)));
		assertTrue(testList.contains(board.getCellAt(19, 1)));
		assertEquals(2, testList.size());
	}


	@Test
	//Test walkway piece beside a room
	// These tests are LIGHT PURPLE on the planning spreadsheet
	public void testWalkway_BesideRoom() {
		//TO THE LEFT OF A ROOM
		Set<BoardCell> testList = board.getAdjList(3, 14);
		assertTrue(testList.contains(board.getCellAt(2, 14)));
		assertTrue(testList.contains(board.getCellAt(4, 14)));
		assertTrue(testList.contains(board.getCellAt(3, 15)));
		assertEquals(3, testList.size());

		//TO THE RIGHT OF A ROOM
		testList = board.getAdjList(20, 13);
		assertTrue(testList.contains(board.getCellAt(19, 13)));
		assertTrue(testList.contains(board.getCellAt(21, 13)));
		assertTrue(testList.contains(board.getCellAt(20, 14)));
		assertEquals(3, testList.size());

		//CORNER BETWEEN TWO ROOM PIECES
		testList = board.getAdjList(4, 6);
		assertTrue(testList.contains(board.getCellAt(5, 6)));
		assertTrue(testList.contains(board.getCellAt(4, 7)));
		assertEquals(2, testList.size());

		//CORNER BETWEEN TWO ROOM PIECES
		testList = board.getAdjList(9, 17);
		assertTrue(testList.contains(board.getCellAt(10, 17)));
		assertTrue(testList.contains(board.getCellAt(9, 18)));
		assertEquals(2, testList.size());

		//BETWEEN TWO ROOMS, LEFT AND RIGHT
		testList = board.getAdjList(25, 16);
		assertTrue(testList.contains(board.getCellAt(24, 16)));
		assertEquals(1, testList.size());

		//TEST WALKWAY THAT IS NOT THE CORRECT DIRECTION TO ENTER A DOOR
		testList = board.getAdjList(13, 3);
		assertTrue(testList.contains(board.getCellAt(12, 3)));
		assertTrue(testList.contains(board.getCellAt(13, 4)));
		assertEquals(2, testList.size());
	}

	// Test adjacency at entrance to rooms
	// These tests are GREEN in planning spreadsheet
	@Test
	public void testDoorEntrance()
	{
		// Test beside a door direction RIGHT
		Set<BoardCell> testList = board.getAdjList(14, 4);
		assertTrue(testList.contains(board.getCellAt(14, 3)));
		assertTrue(testList.contains(board.getCellAt(14, 5)));
		assertTrue(testList.contains(board.getCellAt(13, 4)));
		assertTrue(testList.contains(board.getCellAt(15, 4)));
		assertEquals(4, testList.size());
		// Test beside a door direction DOWN
		testList = board.getAdjList(9, 19);
		assertTrue(testList.contains(board.getCellAt(8, 19)));
		assertTrue(testList.contains(board.getCellAt(10, 19)));
		assertTrue(testList.contains(board.getCellAt(9, 18)));
		assertEquals(3, testList.size());
		// Test beside a door direction LEFT
		testList = board.getAdjList(24, 13);
		assertTrue(testList.contains(board.getCellAt(24, 14)));
		assertTrue(testList.contains(board.getCellAt(23, 13)));
		assertTrue(testList.contains(board.getCellAt(25, 13)));
		assertEquals(3, testList.size());
		// Test beside a door direction UP
		testList = board.getAdjList(18, 10);
		assertTrue(testList.contains(board.getCellAt(19, 10)));
		assertTrue(testList.contains(board.getCellAt(17, 10)));
		assertTrue(testList.contains(board.getCellAt(18, 11)));
		assertTrue(testList.contains(board.getCellAt(18, 9)));
		assertEquals(4, testList.size());
	}

	// Test adjacency at entrance to rooms
	// These tests are GREEN in planning spreadsheet
	@Test
	public void testDoorEntrance_EdgeCase()
	{
		// Test beside a door direction DOWN, with walkway to the left
		Set<BoardCell> testList = board.getAdjList(8, 5);
		assertTrue(testList.contains(board.getCellAt(7, 5)));
		assertTrue(testList.contains(board.getCellAt(9, 5)));
		assertTrue(testList.contains(board.getCellAt(8, 4)));
		assertTrue(testList.contains(board.getCellAt(8, 6)));
		assertEquals(4, testList.size());
		//Test besides a door direction DOWN with walkway to the right
		testList = board.getAdjList(8, 10);
		assertTrue(testList.contains(board.getCellAt(7, 10)));
		assertTrue(testList.contains(board.getCellAt(9, 10)));
		assertTrue(testList.contains(board.getCellAt(8, 9)));
		assertTrue(testList.contains(board.getCellAt(8, 11)));
		assertEquals(4, testList.size());
	}

	// Ensure that the adjacency list from a doorway is only the
	// walkway. NOTE: This test could be merged with door 
	// direction test. 
	// These tests are PURPLE on the planning spreadsheet
	@Test
	public void testRoomDoors()
	{
		// TEST DOORWAY RIGHT 
		Set<BoardCell> testList = board.getAdjList(14, 3);
		assertEquals(1, testList.size());
		assertTrue(testList.contains(board.getCellAt(14, 4)));
		// TEST DOORWAY LEFT 
		testList = board.getAdjList(24, 14);
		assertEquals(1, testList.size());
		assertTrue(testList.contains(board.getCellAt(24, 13)));
		//TEST DOORWAY DOWN 
		testList = board.getAdjList(8, 19);
		assertEquals(1, testList.size());
		assertTrue(testList.contains(board.getCellAt(9, 19)));
		//TEST DOORWAY UP
		testList = board.getAdjList(21, 19);
		assertEquals(1, testList.size());
		assertTrue(testList.contains(board.getCellAt(20, 19)));

	}

	// Ensure that the adjacency list from a doorway is only the
	// walkway. NOTE: This test could be merged with door 
	// direction test. 
	// These tests are PURPLE on the planning spreadsheet
	@Test
	public void testRoomDoors_EdgeCase()
	{
		//TEST DOORWAY DOWN, WHERE THERE'S A WALKWAY ADJACENT TO MULTIPLE SIDES
		Set<BoardCell> testList = board.getAdjList(7, 10);
		assertEquals(1, testList.size());
		assertTrue(testList.contains(board.getCellAt(8, 10)));
		//TEST DOORWAY DOWN, WHEN THERES A WALKWAY TO THE LEFT
		testList = board.getAdjList(7, 5);
		assertEquals(1, testList.size());
		assertTrue(testList.contains(board.getCellAt(8, 5)));
	}

	/////////////////////////////////////////////////////////////
	////					Target Testing					 ////
	/////////////////////////////////////////////////////////////

	// Tests of just walkways, 1 step, includes on edge of board
	// and beside room
	// Have already tested adjacency lists on all four edges, will
	// only test two edges here
	// These are AQUA on the planning spreadsheet
	@Test
	public void testTarget_OneStep() {
		board.calcTargets(25, 13, 1);
		Set<BoardCell> targets= board.getTargets();
		assertEquals(1, targets.size());
		assertTrue(targets.contains(board.getCellAt(24, 13)));

		board.calcTargets(18, 1, 1);
		targets= board.getTargets();
		assertEquals(3, targets.size());
		assertTrue(targets.contains(board.getCellAt(18, 2)));
		assertTrue(targets.contains(board.getCellAt(19, 1)));	
		assertTrue(targets.contains(board.getCellAt(18, 0)));			
	}

	// Tests of just walkways, 2 steps
	// These are AQUA on the planning spreadsheet
	@Test
	public void testTarget_TwoSteps() {
		board.calcTargets(25, 13, 2);
		Set<BoardCell> targets= board.getTargets();
		assertEquals(2, targets.size());
		assertTrue(targets.contains(board.getCellAt(23, 13)));
		assertTrue(targets.contains(board.getCellAt(24, 14)));

		board.calcTargets(18, 1, 2);
		targets= board.getTargets();
		assertEquals(4, targets.size());
		assertTrue(targets.contains(board.getCellAt(19, 0)));
		assertTrue(targets.contains(board.getCellAt(20, 1)));	
		assertTrue(targets.contains(board.getCellAt(18, 3)));
		assertTrue(targets.contains(board.getCellAt(19, 2)));	
	}

	// Tests of just walkways, 3 steps
	// These are AQUA on the planning spreadsheet
	@Test
	public void testTarget_ThreeSteps() {
		board.calcTargets(25, 13, 3);
		Set<BoardCell> targets= board.getTargets();

		assertEquals(2, targets.size());
		assertTrue(targets.contains(board.getCellAt(22, 13)));
		assertTrue(targets.contains(board.getCellAt(24, 14)));

		// Includes a path that doesn't have enough length
		board.calcTargets(18, 1, 3);
		targets= board.getTargets();
		assertEquals(6, targets.size());
		assertTrue(targets.contains(board.getCellAt(19, 1)));
		assertTrue(targets.contains(board.getCellAt(20, 2)));	
		assertTrue(targets.contains(board.getCellAt(18, 2)));	
		assertTrue(targets.contains(board.getCellAt(19, 3)));
		assertTrue(targets.contains(board.getCellAt(18, 4)));	
		assertTrue(targets.contains(board.getCellAt(18, 0)));		
	}	

	// Tests of just walkways plus one door, 6 steps
	// These are AQUA on the planning spreadsheet

	@Test
	public void testTarget_SixSteps() {
		board.calcTargets(25, 13, 6);
		Set<BoardCell> targets= board.getTargets();

		assertEquals(7, targets.size());
		assertTrue(targets.contains(board.getCellAt(19, 13)));
		assertTrue(targets.contains(board.getCellAt(22, 14)));
		assertTrue(targets.contains(board.getCellAt(20, 14)));
		assertTrue(targets.contains(board.getCellAt(21, 15)));
		assertTrue(targets.contains(board.getCellAt(24, 14)));
		assertTrue(targets.contains(board.getCellAt(21, 13)));
		assertTrue(targets.contains(board.getCellAt(22, 16)));

		// Includes a path that doesn't have enough length
		board.calcTargets(18, 1, 6);
		targets= board.getTargets();

		assertEquals(15, targets.size());
		assertTrue(targets.contains(board.getCellAt(19, 0)));
		assertTrue(targets.contains(board.getCellAt(18, 5)));
		assertTrue(targets.contains(board.getCellAt(20, 1)));
		assertTrue(targets.contains(board.getCellAt(15, 4)));
		assertTrue(targets.contains(board.getCellAt(20, 5)));
		assertTrue(targets.contains(board.getCellAt(18, 7)));
		assertTrue(targets.contains(board.getCellAt(17, 4)));
		assertTrue(targets.contains(board.getCellAt(21, 4)));
		assertTrue(targets.contains(board.getCellAt(19, 2)));
		assertTrue(targets.contains(board.getCellAt(16, 5)));
		assertTrue(targets.contains(board.getCellAt(18, 3)));
		assertTrue(targets.contains(board.getCellAt(19, 4)));
		assertTrue(targets.contains(board.getCellAt(20, 3)));
		assertTrue(targets.contains(board.getCellAt(19, 6)));
		assertTrue(targets.contains(board.getCellAt(17, 6)));

	}	

	// Test getting into a room (normally) (ie, perfect amount of moves)
	// These are AQUA on the planning spreadsheet

	@Test 
	public void testTargets_EnterRoom()
	{
		//Room is 1 space away
		board.calcTargets(20, 19, 1);
		Set<BoardCell> targets= board.getTargets();
		assertEquals(4, targets.size());
		assertTrue(targets.contains(board.getCellAt(21, 19)));
		assertTrue(targets.contains(board.getCellAt(19, 19)));
		assertTrue(targets.contains(board.getCellAt(20, 20)));
		assertTrue(targets.contains(board.getCellAt(20, 18)));

		// One room is exactly 2 away
		board.calcTargets(9, 10, 2);
		targets= board.getTargets();
		// directly left (can't go right 2 steps)
		assertTrue(targets.contains(board.getCellAt(7, 10)));
		assertTrue(targets.contains(board.getCellAt(8, 11)));
		assertTrue(targets.contains(board.getCellAt(9, 12)));
		assertTrue(targets.contains(board.getCellAt(10, 11)));
		assertTrue(targets.contains(board.getCellAt(11, 10)));
		assertTrue(targets.contains(board.getCellAt(10, 9)));
		assertTrue(targets.contains(board.getCellAt(9, 8)));
		assertTrue(targets.contains(board.getCellAt(8, 9)));
		assertEquals(8, targets.size());

		//Room is 1 space away, but given 2 moves
		board.calcTargets(22, 5, 2);
		targets= board.getTargets();
		assertEquals(5, targets.size());
		//door
		assertTrue(targets.contains(board.getCellAt(23, 5)));
		assertTrue(targets.contains(board.getCellAt(21, 4)));
		assertTrue(targets.contains(board.getCellAt(21, 6)));
		assertTrue(targets.contains(board.getCellAt(20, 5)));
		assertTrue(targets.contains(board.getCellAt(22, 7)));

		//Room is 1 space away, but given 2 moves
		board.calcTargets(9, 18, 2);
		targets= board.getTargets();

		assertEquals(5, targets.size());
		//door
		assertTrue(targets.contains(board.getCellAt(8, 18)));
		assertTrue(targets.contains(board.getCellAt(10, 19)));
		assertTrue(targets.contains(board.getCellAt(10, 17)));
		assertTrue(targets.contains(board.getCellAt(11, 18)));
		assertTrue(targets.contains(board.getCellAt(8, 19)));
	}

	// Test getting out of a room
	// These are AQUA on the planning spreadsheet
	@Test
	public void testTargets_Exit()
	{
		// Take one step, essentially just the adj list
		board.calcTargets(15, 19, 1);
		Set<BoardCell> targets= board.getTargets();
		// Ensure doesn't exit through the wall
		assertEquals(1, targets.size());
		assertTrue(targets.contains(board.getCellAt(14, 19)));
		// Take 2 steps from door
		board.calcTargets(8, 18, 2);
		targets= board.getTargets();
		assertEquals(3, targets.size());
		assertTrue(targets.contains(board.getCellAt(9, 17)));
		assertTrue(targets.contains(board.getCellAt(9, 19)));
		assertTrue(targets.contains(board.getCellAt(10, 18)));

		// Take two steps
		board.calcTargets(24, 14, 2);
		targets= board.getTargets();
		assertEquals(2, targets.size());
		assertTrue(targets.contains(board.getCellAt(25, 13)));
		assertTrue(targets.contains(board.getCellAt(23, 13)));

		// Take four step
		board.calcTargets(19, 10, 4);
		targets= board.getTargets();
		// Ensure doesn't exit through the wall
		assertEquals(7, targets.size());
		assertTrue(targets.contains(board.getCellAt(18, 13)));
		assertTrue(targets.contains(board.getCellAt(17, 12)));
		assertTrue(targets.contains(board.getCellAt(18, 7)));
		assertTrue(targets.contains(board.getCellAt(17, 8)));
		assertTrue(targets.contains(board.getCellAt(18, 11)));
		assertTrue(targets.contains(board.getCellAt(17, 10)));
		assertTrue(targets.contains(board.getCellAt(18, 9)));
	}
}
