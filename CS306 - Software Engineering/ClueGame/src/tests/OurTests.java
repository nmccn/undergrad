// authors: Cat de Frates and Nic Mcclellan
package tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.util.Map;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

import clueGame.Board;
import clueGame.BoardCell;
import clueGame.DoorDirection;

public class OurTests {
		// Constants that I will use to test whether the file was loaded correctly
		public static final int LEGEND_SIZE = 11;
		public static final int NUM_ROWS = 26;
		public static final int NUM_COLUMNS = 22;

		// NOTE: I made Board static because I only want to set it up one 
		// time (using @BeforeClass), no need to do setup before each test.
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
		
		@Test
		public void testRooms() {
			// Get the map of initial => room 
			Map<Character, String> legend = board.getLegend();
			// Ensure we read the correct number of rooms
			assertEquals(LEGEND_SIZE, legend.size());
			// To ensure data is correctly loaded, test retrieving a few rooms 
			// from the hash, including the first and last in the file and a few others
			assertEquals("closet", legend.get('X'));
			assertEquals("Bowling Alley", legend.get('B'));
			assertEquals("Library", legend.get('L'));
			assertEquals("Mom's Room", legend.get('M'));
			assertEquals("Dining Room", legend.get('D'));
			assertEquals("Walkway", legend.get('W'));
			assertEquals("Hallway", legend.get('H'));
			assertEquals("Kitchen", legend.get('K'));
			assertEquals("Garage", legend.get('G'));
		}
		
		@Test
		public void testBoardDimensions() {
			// Ensure we have the proper number of rows and columns
			assertEquals(NUM_ROWS, board.getNumRows());
			assertEquals(NUM_COLUMNS, board.getNumColumns());		
		}
		
		// Test a doorway in each direction (RIGHT/LEFT/UP/DOWN), plus 
		// two cells that are not a doorway.
		// These cells are white on the planning spreadsheet
		@Test
		public void FourDoorDirections() {
			BoardCell room = board.getCellAt(14, 3);
			assertTrue(room.isDoorway());
			assertEquals(DoorDirection.RIGHT, room.getDoorDirection());
			room = board.getCellAt(8, 18);
			assertTrue(room.isDoorway());
			assertEquals(DoorDirection.DOWN, room.getDoorDirection());
			room = board.getCellAt(24, 14);
			assertTrue(room.isDoorway());
			assertEquals(DoorDirection.LEFT, room.getDoorDirection());
			room = board.getCellAt(15, 19);
			assertTrue(room.isDoorway());
			assertEquals(DoorDirection.UP, room.getDoorDirection());
			// Test that room pieces that aren't doors know it
			room = board.getCellAt(22, 20);
			assertFalse(room.isDoorway());	
			// Test that walkways are not doors
			BoardCell cell = board.getCellAt(18, 21);
			assertFalse(cell.isDoorway());		

		}
		
		// Test that we have the correct number of doors
		@Test
		public void testNumberOfDoorways() 
		{
			int numDoors = 0;
			for (int row=0; row < board.getNumRows(); row++)
				for (int col=0; col < board.getNumColumns(); col++) {
					BoardCell cell = board.getCellAt(row, col);
					if (cell.isDoorway()) {
						numDoors++;
					}
				}
			Assert.assertEquals(11, numDoors);
		}

		// Test a few room cells to ensure the room initial is correct.
		@Test
		public void testRoomInitials() {
			// Test first cell in room
			assertEquals('C', board.getCellAt(13, 0).getInitial());
			assertEquals('M', board.getCellAt(23, 14).getInitial());
			assertEquals('B', board.getCellAt(0, 0).getInitial());
			// Test last cell in room
			assertEquals('D', board.getCellAt(4, 8).getInitial());
			assertEquals('K', board.getCellAt(25, 0).getInitial());
			// Test a walkway
			assertEquals('W', board.getCellAt(19, 5).getInitial());
			// Test the closet
			assertEquals('X', board.getCellAt(14, 10).getInitial());
		}
						
}
