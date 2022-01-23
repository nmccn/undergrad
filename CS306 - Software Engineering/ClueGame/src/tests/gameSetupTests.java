package tests;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.awt.Color;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Set;

//authors: Cat de Frates and Nic Mcclellan
import org.junit.BeforeClass;
import org.junit.Test;

import clueGame.Board;
import clueGame.Card;
import clueGame.CardType;
import clueGame.Player;
import clueGame.Solution;

public class gameSetupTests {
	// Constants that I will use to test whether the file was loaded correctly
	public static final int MAX_PLAYER= 6;
	public static final int MAX_WEAPON= 6;
	public static final int MAX_CARDS= 21;
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
	//test method for loading people
	public void testLoadingPeople() {
		Player[] players = board.getPlayers();
		// Ensure we read the correct number of players
		assertEquals(MAX_PLAYER, players.length);

		//check that there is 1 (and only 1) human
		int humanCount = 0;
		for(Player p: players) {
			if(!p.isComputer()) {
				humanCount++;
			}
		}
		assertEquals(1, humanCount);

		//Test : Professor Plum, purple, player, 8, 6
		assertEquals("Professor Plum", players[0].getPlayerName());
		assertEquals(Color.MAGENTA, players[0].getColor());
		assertFalse(players[0].isComputer());
		assertEquals(8, players[0].getRow());
		assertEquals(6, players[0].getColumn());

		//Test : Mr. Green, green, computer, 21, 14
		assertEquals("Mr. Green", players[2].getPlayerName());
		assertEquals(Color.GREEN, players[2].getColor());
		assertTrue(players[2].isComputer());
		assertEquals(21, players[2].getRow());
		assertEquals(14, players[2].getColumn());

		//Test : Colonel Mustard, yellow, computer, 9, 9
		assertEquals("Colonel Mustard", players[5].getPlayerName());
		assertEquals(Color.YELLOW, players[5].getColor());
		assertTrue(players[5].isComputer());
		assertEquals(9, players[5].getRow());
		assertEquals(9, players[5].getColumn());
	}
	
	@Test
	//test method for loading weapons
	public void testLoadingWeapons() {
		String[] weapons = board.getWeapons();
		// Ensure we read the correct number of weapons
		assertEquals(MAX_WEAPON, weapons.length);
		//Ensure that we read the correct weapons
		assertEquals("Mallet", weapons[0]);
		assertEquals("Knife", weapons[1]);
		assertEquals("Heavy Plate", weapons[2]);
		assertEquals("Tea Kettle", weapons[3]);
		assertEquals("Spatula", weapons[4]);
		assertEquals("George Foreman Grill", weapons[5]);
	}
	
	@Test
	//test method for creating the deck of cards
	public void testLoadingDeck() {
		Set<Card> deck = board.getDeckOfCards();
		// Ensure that there is the correct number of cards.
		//assertEquals(MAX_CARDS, deck.size());
		
		// Ensure there is the correct number of each type of card
		int numPeople = 0;
		int numWeapons = 0;
		int numRooms = 0;
		for(Card c: deck) {
			if(c.getCardtype() == CardType.PERSON) {
				numPeople ++;
			} else if(c.getCardtype() == CardType.WEAPON) {
				numWeapons ++;
			} else {
				numRooms ++;
			}
		}
		assertEquals(MAX_PLAYER, numPeople);
		assertEquals(MAX_WEAPON, numWeapons);
		assertEquals(MAX_CARDS - (MAX_PLAYER + MAX_WEAPON), numRooms);
		
		// Ensure that the names of each type of card work correctly
		boolean foundPerson = false;
		boolean foundWeapon = false;
		boolean foundRoom = false;
		for(Card c: deck) {
			if(c.getCardName().equals("Mr. Green") && c.getCardtype() == CardType.PERSON) {
				foundPerson = true;
			}
			if(c.getCardName().equals("Mallet") && c.getCardtype() == CardType.WEAPON) {
				foundWeapon = true;
			}
			if(c.getCardName().equals("Kitchen") && c.getCardtype() == CardType.ROOM) {
				foundRoom = true;
			}
		}
		assertTrue(foundPerson);
		assertTrue(foundWeapon);
		assertTrue(foundRoom);
	}
	
	@Test
	//test method for dealing the cards
	public void testDealingCards() {
		Solution answer = board.getSolution();
		// make sure the solution has been picked
		assertFalse(answer.person.equals(""));
		assertFalse(answer.weapon.equals(""));
		assertFalse(answer.room.equals(""));
		
		int numCards = 0;
		int count = 0;
		ArrayList<Integer> handSizes = new ArrayList<Integer>();
		Player[] players = board.getPlayers();
		for(Player p: players) {
			// getting all the hand sizes to sum and add to the handSizes arrayList
			int handSize = p.getMyCards().size();
			handSizes.add(handSize);
			numCards += handSize;
			
			// iterating trough each players cards
			ArrayList<Card> cards = new ArrayList<Card>();
			cards = p.getMyCards();
			for(Card c: cards) {
				if(c.getCardName().equals("Mallet") && c.getCardtype() == CardType.WEAPON) {
					count ++;
				}
			}
		}
		// make sure that the deck holds the correct number of cards
		assertEquals(MAX_CARDS - 3, numCards);
		
		// make sure there aren't duplicate cards dealt
		assertTrue(count <= 1);
		
		// the difference between the biggest hand and smallest hand should be <= one
		int min = Collections.min(handSizes);
		int max = Collections.max(handSizes);
		assertTrue((max - min) <= 1);
		
	}



}
