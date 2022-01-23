// authors: Cat de Frates and Nic Mcclellan
package clueGame;

import java.awt.Color;
import java.util.*;

public class Player{
	private String playerName;
	private int row;
	private int column;
	private Color color;
	private boolean computer;
	private BoardCell lastVisited;
	
	//arrays for seen cards and currently held cards
	private ArrayList<Card> myCards;
	private ArrayList<Card> seenCards;


	//Constructor for the Player
	public Player(String playerName, int row, int column, Color color, boolean computer) {
		super();
		this.playerName = playerName;
		this.row = row;
		this.column = column;
		this.color = color;
		this.computer = computer;
		this.myCards = new ArrayList<Card>();
		this.seenCards = new ArrayList<Card>();
		this.lastVisited = new BoardCell();
	}
	
	@Override
	public boolean equals(Object a) {
		Player p = (Player) a;
		if (a == this) {
            return true;
        }
		if (a == null) {
            return false;
        }
		return this.playerName == p.playerName && this.row == p.row && this.column == p.column;
	}
	
	public BoardCell getLastVisited() {
		return lastVisited;
	}

	public void setLastVisited(BoardCell lastVisited) {
		this.lastVisited = lastVisited;
	}

	public ArrayList<Card> getMyCards() {
		return myCards;
	}

	public void addCardToHand(Card card) {
		this.myCards.add(card);
	}
	
	public void addCardToSeen(Card card) {
		this.seenCards.add(card);
	}
	
	//Method to disprove suggestions
	public Card disproveSuggestion(Solution solution) {
		//collection of cards that can be used to disprove
		ArrayList<Card> found = new ArrayList<Card>();
		//populate list of cards
		for(Card card: myCards) {
			if(card.getCardName().equals(solution.person) || card.getCardName().equals(solution.weapon)
					|| card.getCardName().equals(solution.room)) {
				//if the name matches, add the card
				found.add(card);
			}
		}
		
		if(found.isEmpty()) {
			return null;
		}
		else{
			Collections.shuffle(found);
			return found.get(0);
		}	
	}
	
	public boolean isComputer() {
		return computer;
	}
	
	public String getPlayerName() {
		return playerName;
	}

	public int getRow() {
		return row;
	}

	public void setRow(int row) {
		this.row = row;
	}

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}

	public Color getColor() {
		return color;
	}

	public void setColor(Color color) {
		this.color = color;
	}

	public void setPlayerName(String playerName) {
		this.playerName = playerName;
	}

	public void setComputer(boolean computer) {
		this.computer = computer;
	}
	
	public ArrayList<Card> getSeenCards() {
		return seenCards;
	}
	

}
