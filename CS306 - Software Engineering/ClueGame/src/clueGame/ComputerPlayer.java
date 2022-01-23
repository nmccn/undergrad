// authors: Cat de Frates and Nic Mcclellan
package clueGame;

import java.awt.Color;
import java.util.ArrayList;
import java.util.Map;
import java.util.Random;
import java.util.Set;

public class ComputerPlayer extends Player{

	static final int MAX_SIZE = 6;
	private Solution accusation;
	private Solution suggestion;

	public ComputerPlayer(String playerName, int row, int column, Color color, boolean computer) {
		super(playerName, row, column, color, computer);
	}


	public BoardCell pickLocation(Set<BoardCell> targets) {
		BoardCell location = new BoardCell();

		for(BoardCell c: targets) {
			if(c.isDoorway() && getLastVisited() != c) {
				location = c;
				setLastVisited(location);
				return location;
			}
		}

		Object[] temp = targets.toArray();
		Random rand = new Random();
		int num = rand.nextInt(temp.length);
		location = (BoardCell)temp[num];
		setLastVisited(location);
		return location;

	}

	public Solution makeAccusation(String person, String room, String weapon) {
		this.accusation = new Solution(person, room, weapon);
		return this.accusation;
	}

	public Solution createSuggestion() {
		Random rand = new Random();
		String person = "";
		String weapon = "";

		//get the board and find the room from player location
		Board board = Board.getInstance();
		Player[] players = board.getPlayers();
		String[] weapons = board.getWeapons();
		char initial = board.getCellAt(getRow(), getColumn()).getInitial();
		Map<Character, String> legend = board.getLegend();
		String room = legend.get(initial);

		boolean personSeen = true;
		boolean weaponSeen = true;

		while(personSeen) {
			//get random int
			int randInt = rand.nextInt(MAX_SIZE);
			person = players[randInt].getPlayerName();
			//check if this person is in seen list
			ArrayList<Card> seenCards = getSeenCards();
			for(int i = 0; i < seenCards.size(); i++) {
				if(!seenCards.get(i).getCardName().equals(person)) {
					personSeen = false;
				}
				else {
					personSeen =  true;
					break;
				}
			}
		}
		while(weaponSeen) {
			//get random int
			int randInt = rand.nextInt(MAX_SIZE);
			weapon = weapons[randInt];
			//check if this person is in seen list
			ArrayList<Card> seenCards = getSeenCards();
			for(int i = 0; i < seenCards.size(); i++) {
				if(!seenCards.get(i).getCardName().equals(weapon)) {
					weaponSeen = false;
				}
				else {
					weaponSeen = true;
					break;
				}
			}
		}
		this.suggestion = new Solution(person, room, weapon);
		return this.suggestion;
	}

}
