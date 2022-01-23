package tests;

import static org.junit.Assert.*;

import java.awt.Color;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.junit.BeforeClass;
import org.junit.Test;

import clueGame.Board;
import clueGame.BoardCell;
import clueGame.Card;
import clueGame.CardType;
import clueGame.ComputerPlayer;
import clueGame.HumanPlayer;
import clueGame.Player;
import clueGame.Solution;

public class gameActionTest {

	// We make the Board static because we can load it one time and 
	// then do all the tests. 
	private static Board board;

	@BeforeClass
	public static void setUp() {
		board = Board.getInstance();
		// set the file names to use my config files
		board.setConfigFiles("BoardLayoutCSV.csv", "RoomsLegend.txt", "player_legend.txt", "WeaponsLegend.txt");		
		// Initialize will load BOTH config files 
		board.initialize();
	}

	@Test
	// ensures that a random cell is selected if a room isn't within range
	public void testTargetRandomSelection() {
		ComputerPlayer player = new ComputerPlayer("A", 13, 5, Color.BLACK, true);
		// Pick a location with no rooms in target, just 8 targets
		board.calcTargets(13, 5, 2);
		boolean loc_11_5 = false;
		boolean loc_13_4 = false;
		boolean loc_13_3 = false;
		boolean loc_14_4 = false;
		boolean loc_15_5 = false;
		boolean loc_14_6 = false;
		boolean loc_12_6 = false;
		boolean loc_12_4 = false;
		// Run the test a large number of times
		for (int i=0; i<100; i++) {
			BoardCell selected = player.pickLocation(board.getTargets());
			if (selected == board.getCellAt(11, 5))
				loc_11_5 = true;
			else if (selected == board.getCellAt(13, 3))
				loc_13_3 = true;
			else if (selected == board.getCellAt(14, 4))
				loc_14_4 = true;
			else if (selected == board.getCellAt(15, 5))
				loc_15_5 = true;
			else if (selected == board.getCellAt(14, 6))
				loc_14_6 = true;
			else if (selected == board.getCellAt(12, 6))
				loc_12_6 = true;
			else if (selected == board.getCellAt(12, 4))
				loc_12_4 = true;
			else {
				System.out.println(selected);
				fail("Invalid target selected");
			}
		}
		// Ensure each target was selected at least once
		assertTrue(loc_11_5);
		assertTrue(loc_13_3);
		assertTrue(loc_14_4);
		assertTrue(loc_15_5);
		assertTrue(loc_14_6);
		assertTrue(loc_12_6);
		assertTrue(loc_12_4);

	}

	@Test
	// One ensures that the room is always selected if it isn't the last visited
	public void testTargetRoom() {
		ComputerPlayer player = new ComputerPlayer("A", 8, 5, Color.BLACK, true);
		// Pick a location that will have a room in its target list
		board.calcTargets(8, 5, 2);
		BoardCell target = new BoardCell(7, 5, 'B');

		for(int i = 0; i < 100; i ++) {
			player.setLastVisited(null);
			BoardCell selected = player.pickLocation(board.getTargets());
			assertEquals(target, selected);
		}
	}

	@Test
	//  ensures that if the room is the last visited, a random choice is made
	public void testTargetRoomVisited() {
		ComputerPlayer player = new ComputerPlayer("A", 8, 5, Color.BLACK, true);
		// Pick a location with room that it just visited
		board.calcTargets(8, 5, 2);
		player.setLastVisited(board.getCellAt(7, 5));
		boolean loc_8_3 = false;
		boolean loc_9_4 = false;
		boolean loc_10_5 = false;
		boolean loc_9_6 = false;
		boolean loc_8_7 = false;
		boolean loc_7_6 = false;
		// the room, last visited
		boolean loc_7_5 = false;
		// Run the test a large number of times
		for (int i=0; i<100; i++) {
			// sets the last visited cell to be the room
			player.setLastVisited(board.getCellAt(7, 5));
			BoardCell selected = player.pickLocation(board.getTargets());
			if (selected == board.getCellAt(8, 3))
				loc_8_3 = true;
			else if (selected == board.getCellAt(9, 4))
				loc_9_4 = true;
			else if (selected == board.getCellAt(10, 5))
				loc_10_5 = true;
			else if (selected == board.getCellAt(9, 6))
				loc_9_6 = true;
			else if (selected == board.getCellAt(8, 7))
				loc_8_7 = true;
			else if (selected == board.getCellAt(7, 6))
				loc_7_6 = true;
			else if (selected == board.getCellAt(7, 5))
				loc_7_5 = true;
			else {
				System.out.println(selected);
				fail("Invalid target selected");
			}
		}
		// Ensure each target was selected at least once
		assertTrue(loc_8_3);
		assertTrue(loc_9_4);
		assertTrue(loc_10_5);
		assertTrue(loc_9_6);
		assertTrue(loc_8_7);
		assertTrue(loc_7_6);
		assertTrue(loc_7_5);
	}

	@Test
	// validates accusations against the solution
	public void testAccusation() {
		board.setTheAnswer("Mr. Green", "Kitchen", "Spatula");
		ComputerPlayer player = new ComputerPlayer("A", 8, 5, Color.BLACK, true);
		// correct accusation
		Solution accusation1 = player.makeAccusation("Mr. Green", "Kitchen", "Spatula");

		// wrong accusations
		Solution accusation2 = player.makeAccusation("Mr. Purple", "Kitchen", "Spatula");
		Solution accusation3 = player.makeAccusation("Mr. Green", "Dining Room", "Spatula");
		Solution accusation4 = player.makeAccusation("Mr. Green", "Kitchen", "Mallet");

		assertTrue(board.checkAccusation(accusation1));
		assertFalse(board.checkAccusation(accusation2));
		assertFalse(board.checkAccusation(accusation3));
		assertFalse(board.checkAccusation(accusation4));
	}

	@Test
	// test to ensure the computer players are making valid suggestions
	public void testSuggestion() {
		//create a computer player and get the the room they are in.
		ComputerPlayer player = new ComputerPlayer("A", 7, 5, Color.BLACK, true);
		char initial = board.getCellAt(player.getRow(), player.getColumn()).getInitial();
		Map<Character, String> legend = board.getLegend();
		String room = legend.get(initial);

		//populate hand and seen cards with a few cards
		Card card = new Card("Mr. Green", CardType.PERSON);
		player.addCardToSeen(card);
		card = new Card("Mrs. White", CardType.PERSON);
		player.addCardToSeen(card);
		card = new Card("Library", CardType.ROOM);
		player.addCardToSeen(card);
		card = new Card("Kitchen", CardType.ROOM);
		player.addCardToSeen(card);
		card = new Card("Spatula", CardType.WEAPON);
		player.addCardToSeen(card);
		card = new Card("Mallet", CardType.WEAPON);
		player.addCardToSeen(card);

		//check the room is where the player is at
		boolean match = false;
		if(room.equals("Bowling Alley")) {
			match = true;
		}
		assertTrue(match);

		//check if the weapon and player are not in the list of seen cards
		boolean suggestGreen = false;
		boolean suggestWhite = false;
		boolean suggestLibrary = false;
		boolean suggestKitchen = false;
		boolean suggestSpatula = false;
		boolean suggestMallet = false;

		//check if the weapon and player are valid suggestions
		boolean suggestScarlet = false;
		boolean suggestPeacock = false;
		boolean suggestPlate = false;
		boolean suggestKnife = false;

		// Run the test a large number of times
		for (int i=0; i<100; i++) {
			Solution suggestion = player.createSuggestion();
			if (suggestion.person.equals("Mr. Green")) {
				suggestGreen = true;
			}
			else if (suggestion.person.equals("Mrs. White")) {
				suggestWhite = true;
			}
			else if (suggestion.room.equals("Library")) {
				suggestLibrary = true;
			}
			else if (suggestion.room.equals("Kitchen")) {
				suggestKitchen = true;
			}
			else if (suggestion.weapon.equals("Spatula")) {
				suggestSpatula = true;
			}
			else if (suggestion.weapon.equals("Mallet")) {
				suggestMallet = true;
			}
			else if (suggestion.person.equals("Miss Scarlet")) {
				suggestScarlet = true;
			}
			else if (suggestion.person.equals("Mrs. Peacock")) {
				suggestPeacock = true;
			}
			else if (suggestion.weapon.equals("Heavy Plate")) {
				suggestPlate = true;
			}
			else if (suggestion.weapon.equals("Knife")) {
				suggestKnife = true;
			}
		}
		// Ensure each target was never selected.
		assertFalse(suggestGreen);
		assertFalse(suggestWhite);
		assertFalse(suggestLibrary);
		assertFalse(suggestKitchen);
		assertFalse(suggestSpatula);
		assertFalse(suggestMallet);		
		// Check that the suggestion was valid
		assertTrue(suggestKnife);
		assertTrue(suggestPlate);
		assertTrue(suggestPeacock);
		assertTrue(suggestScarlet);

		//Double  check  that if only 1 item is available, it is selected (Peacock & George Foreman Grill)
		card = new Card("Knife", CardType.WEAPON);
		player.addCardToSeen(card);
		card = new Card("Heavy Plate", CardType.WEAPON);
		player.addCardToSeen(card);
		card = new Card("Tea Kettle", CardType.WEAPON);
		player.addCardToSeen(card);
		card = new Card("Mr. Green", CardType.PERSON);
		player.addCardToSeen(card);
		card = new Card("Mrs. White", CardType.PERSON);
		player.addCardToSeen(card);
		card = new Card("Professor Plum", CardType.PERSON);
		player.addCardToSeen(card);
		card = new Card("Miss Scarlet", CardType.PERSON);
		player.addCardToSeen(card);
		card = new Card("Colonel Mustard", CardType.PERSON);
		player.addCardToSeen(card);

		//loop large number of times and flag if we see anything other than these 2
		for (int i=0; i<100; i++) {
			Solution suggestion = player.createSuggestion();
			if (!suggestion.person.equals("Mrs. Peacock")) {
				fail("Invalid person selected");
			}
			else if(!suggestion.weapon.equals("George Foreman Grill")){
				fail("Invalid weapon selected");
			}	
		}
	}

	@Test
	public void testDisprovingSuggestion() {
		//If a player has a single matching card, return it
		//Create a player
		ComputerPlayer player = new ComputerPlayer("A", 7, 5, Color.BLACK, true);
		Card playerCard = new Card("Professor Plum", CardType.PERSON);
		Card weaponCard = new Card("Spatula", CardType.WEAPON);
		Card roomCard = new Card("Kitchen", CardType.ROOM);
		//Add cards to hand
		player.addCardToHand(playerCard);
		player.addCardToHand(weaponCard);
		player.addCardToHand(roomCard);

		//3 different solutions, each with 1 match
		Solution playerMatch = new Solution("Professor Plum", "Mallet", "Garage");
		Solution weaponMatch = new Solution("Mr. Green", "Spatula", "Garage");
		Solution roomMatch = new Solution("Miss Scarlet", "Mallet", "Kitchen");

		//get the return values
		Card expectPlayer = player.disproveSuggestion(playerMatch);
		Card expectWeapon = player.disproveSuggestion(weaponMatch);
		Card expectRoom = player.disproveSuggestion(roomMatch);

		//test that the 1 returned is as expected
		assertEquals(playerCard, expectPlayer);
		assertEquals(weaponCard, expectWeapon);
		assertEquals(roomCard, expectRoom);

		//If a player has no matching cards, return null
		Solution noMatches = new Solution("Mr. Green", "Mallet", "Garage");
		Card expectNull = player.disproveSuggestion(noMatches);
		assertEquals(null, expectNull);

		//If a player has multiple matching cards, return should be random
		Solution twoMatches = new Solution("Mr. Green", "Spatula", "Kitchen");
		boolean oneCard = false;
		boolean twoCard = false;

		//loop many times and set a flag when the expected cards are hit. 
		for(int i = 0; i < 100; i++) {
			Card result = player.disproveSuggestion(twoMatches);
			if(result == null) {
				break;
			}
			if(result.equals(weaponCard)) {
				oneCard = true;
			}
			else if(result.equals(roomCard)) {
				twoCard = true;
			}
		}
		assertTrue(oneCard);
		assertTrue(twoCard);
	}

	@Test
	public void testHandleSuggestion() {
		//Player 0
		ComputerPlayer player0 = new ComputerPlayer("0", 7, 5, Color.BLACK, true);
		Card playerCard = new Card("Mr. Green", CardType.PERSON);
		Card weaponCard = new Card("Spatula", CardType.WEAPON);
		Card roomCard = new Card("Bowling Alley", CardType.ROOM);
		//Add cards to hand
		player0.addCardToHand(playerCard);
		player0.addCardToHand(weaponCard);
		player0.addCardToHand(roomCard);

		//Player 1
		ComputerPlayer player1 = new ComputerPlayer("1", 7, 5, Color.BLACK, false);
		playerCard = new Card("Miss Scarlet", CardType.PERSON);
		weaponCard = new Card("Mallet", CardType.WEAPON);
		roomCard = new Card("Library", CardType.ROOM);
		//Add cards to hand
		player1.addCardToHand(playerCard);
		player1.addCardToHand(weaponCard);
		player1.addCardToHand(roomCard);

		//Player 2
		ComputerPlayer player2 = new ComputerPlayer("2", 7, 5, Color.BLACK, true);
		playerCard = new Card("Mrs. White", CardType.PERSON);
		weaponCard = new Card("Knife", CardType.WEAPON);
		roomCard = new Card("Dining Room", CardType.ROOM);
		//Add cards to hand
		player2.addCardToHand(playerCard);
		player2.addCardToHand(weaponCard);
		player2.addCardToHand(roomCard);

		//player 3
		Player humPlayer = new HumanPlayer("3", 7, 5, Color.BLACK, false);
		playerCard = new Card("Mrs. Peacock", CardType.PERSON);
		weaponCard = new Card("Heavy Plate", CardType.WEAPON);
		roomCard = new Card("Garage", CardType.ROOM);
		//Add cards to hand
		humPlayer.addCardToHand(playerCard);
		humPlayer.addCardToHand(weaponCard);
		humPlayer.addCardToHand(roomCard);

		//replace the default array of players with these hardcoded players;
		final int MAX_PLAYER = 6;
		Player[] testPlayers = new Player[MAX_PLAYER];
		testPlayers[0] = player0;
		testPlayers[1] = player1;
		testPlayers[2] = player2;
		testPlayers[3] = humPlayer;

		board.setPlayers(testPlayers);

		//Do a query that no players can disprove, ensure null
		Solution testSuggestion = new Solution("Professor Plum", "Mom's Room", "Tea Kettle");
		//Get the card used to disprove the suggestion from the method
		Card cardToDisprove = board.handleSuggestion(humPlayer, testSuggestion);
		assertEquals(null, cardToDisprove);

		//Do a query that only the accuser can disprove, ensure null
		testSuggestion = new Solution("Miss Scarlet", "Mom's Room", "Tea Kettle");
		cardToDisprove = board.handleSuggestion(player1, testSuggestion);
		assertEquals(null, cardToDisprove);

		//Do a query that only the human can disprove, AND is not the accuser (verify we can random all cards for now)
		//All three of these cards are in the human players hand
		testSuggestion = new Solution("Mrs. Peacock", "Heavy Plate", "Garage");
		boolean choosePeacock = false;
		boolean choosePlate = false;
		boolean chooseGarage = false;
		for(int i = 0 ; i < 100; i++) {
			cardToDisprove = board.handleSuggestion(player2, testSuggestion);
			if(cardToDisprove.equals(roomCard)) {
				chooseGarage = true;
			}
			else if(cardToDisprove.equals(weaponCard)) {
				choosePlate = true;
			}
			else if(cardToDisprove.equals(playerCard)) {
				choosePeacock = true;
			}
			else {
				fail("That card isn't in the player's hand!");
			}
		}
		assertTrue(chooseGarage);
		assertTrue(choosePeacock);
		assertTrue(choosePlate);

		//Do a query that only only the human can disprove, AND the human is the accuser, ensure null
		testSuggestion = new Solution("Mrs. Peacock", "Mom's Room", "Tea Kettle");
		cardToDisprove = board.handleSuggestion(humPlayer, testSuggestion);
		assertEquals(null, cardToDisprove);

		//Do several queries with player 0 as accuser, that 1 and 2 can disprove. Ensure never player 2.
		testSuggestion = new Solution("Professor Plum", "Library", "Knife");
		Card failingCard = new Card("Knife", CardType.WEAPON);
		Card passingCard = new Card("Library", CardType.ROOM);
		for(int i = 0; i < 100; i ++) {
			cardToDisprove = board.handleSuggestion(player0, testSuggestion);
			//make sure it is never this card
			assertNotEquals(cardToDisprove, failingCard);
			//Make sure however, it is this card
			assertEquals(cardToDisprove, passingCard);
		}

		//Do a query the human and another player can disprove, ensure correct response
		testSuggestion = new Solution("Professor Plum", "Garage", "Knife");
		passingCard = new Card("Knife", CardType.WEAPON);
		failingCard = new Card("Garage", CardType.ROOM);
		for(int i = 0; i < 100; i ++) {
			cardToDisprove = board.handleSuggestion(player0, testSuggestion);
			//make sure it is never this card
			assertNotEquals(cardToDisprove, failingCard);
			//Make sure however, it is this card
			assertEquals(cardToDisprove, passingCard);
		}

		


	}
}


