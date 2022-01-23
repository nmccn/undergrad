// authors: Cat de Frates and Nic Mcclellan
package clueGame;

import java.awt.Color;
import java.lang.reflect.Field;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;



public class Board {
	//member variables for Adjacency Map, targeted/visited cells, the grid itself, and various config files.
	private int numRows;
	private int numColumns;
	public static final int MAX_BOARD_SIZE = 50;
	public static final int MAX_PLAYERS = 6;
	public static final int MAX_WEAPONS = 6;
	private BoardCell[][] board;
	private Map<Character, String> legend;
	private Map<BoardCell, Set<BoardCell>> adjMtx;
	private Set<BoardCell> adjList;
	private Set<BoardCell> targets;
	private String boardConfigFile;
	private String roomConfigFile;
	private String playerConfigFile;
	private String weaponConfigFile;

	//Variable for the solution
	private Solution theAnswer;

	//Collection of all 6 players
	private Player[] players;

	public void setPlayers(Player[] players) {
		this.players = players;
	}

	//Collection of all 6 weapons
	private String[] weapons;

	//Collection of all rooms (not including closet or walkways)
	private ArrayList<String> rooms;

	//Collection for all cards
	private Set<Card> deckOfCards;

	private ArrayList<Card> toBeDealt;

	//for keeping track of the initials used in the legend and door directions
	private ArrayList<String> validInitials; 

	//for the recursive function
	private Set<BoardCell> visited;

	// variable used for singleton pattern
	private static Board theInstance = new Board();
	// constructor is private to ensure only one can be created
	private Board() {}
	// this method returns the only Board
	public static Board getInstance() {
		return theInstance;
	}

	//allocates space to our collections and sets up the board
	public void initialize() {

		//loading the config file to make legend
		try {
			theInstance.loadRoomConfig();
			theInstance.loadBoardConfig();
			theInstance.loadPlayerConfig();
			theInstance.loadWeaponConfig();
			theInstance.calcAdjacencies();
			theInstance.createDeck();
			dealCards();
		} catch (BadConfigFormatException e) {
			System.out.print(e);
		}
	}

	private void dealCards() {
		this.toBeDealt = new ArrayList<Card>();
		Random r = new Random();
		int rand1 = r.nextInt(MAX_PLAYERS);
		int rand2 = r.nextInt(MAX_WEAPONS);
		int rand3 = r.nextInt(rooms.size());

		selectAnswer(rand1, rand2, rand3);

		// populates the cards to-be-dealt still
		for(int i = 0; i < players.length; i ++) {
			if(i != rand1) {
				Card card = new Card(players[i].getPlayerName(), CardType.PERSON);
				toBeDealt.add(card);
			}
		}
		for(int i = 0; i < weapons.length; i ++) {
			if(i != rand2) {
				Card card = new Card(weapons[i], CardType.WEAPON);
				toBeDealt.add(card);
			}
		}
		for(int i = 0; i < rooms.size(); i ++) {
			if(i != rand3) {
				Card card = new Card(rooms.get(i), CardType.ROOM);
				toBeDealt.add(card);
			}
		}

		// shuffle and deal the cards
		Collections.shuffle(toBeDealt);
		int counter = 0;
		while(!toBeDealt.isEmpty()) {
			players[counter].addCardToHand(toBeDealt.get(0));
			toBeDealt.remove(0);
			counter ++;
			counter = counter % 6;
		}


	}
	// Populates the deck and to-be-dealt deck with cards of each type
	private void createDeck() {
		this.deckOfCards = new HashSet<>();
		for(String w: weapons) {
			Card card = new Card(w, CardType.WEAPON);
			deckOfCards.add(card);
		}
		for(Player p: players) {
			Card card = new Card(p.getPlayerName(), CardType.PERSON);
			deckOfCards.add(card);
		}
		for(String r: rooms) {
			Card card = new Card(r, CardType.ROOM);
			deckOfCards.add(card);
		}

	}

	// Loads the board with new BoardCells
	public void loadBoardConfig() throws BadConfigFormatException{
		this.board = new BoardCell[MAX_BOARD_SIZE][MAX_BOARD_SIZE];	
		try {
			BufferedReader fr = new BufferedReader(new FileReader(boardConfigFile));
			String s;

			int columns = 0;
			int rows = 0;

			while((s = fr.readLine())  != null) {

				String eachLine[] = s.split(",");
				if(rows == 0) {
					columns = eachLine.length;
				}

				if(eachLine.length != columns) {
					throw new BadConfigFormatException(boardConfigFile);
				}

				for(int j = 0; j < columns; j++) {
					if(!validInitials.contains(eachLine[j].charAt(0) + "")) {
						throw new BadConfigFormatException(boardConfigFile);
					}
					else {
						this.board[rows][j] = new BoardCell(rows ,j , eachLine[j].charAt(0));
						if(eachLine[j].length() > 1 && eachLine[j].charAt(1) != 'N' ) {
							this.board[rows][j].setDoor();
							board[rows][j].setDirection(eachLine[j].charAt(1));
						}
					}
				}

				rows++;
			}
			this.numRows = rows;
			this.numColumns = columns;
		}catch (FileNotFoundException e) {
			System.out.print(e.getMessage());
		} catch (IOException e) {
			System.out.print(e.getMessage());
		}
	}


	//Reading in from the legend.txt and building the map -- legend
	public void loadRoomConfig() throws BadConfigFormatException {
		this.legend = new HashMap<Character, String>();
		this.rooms = new ArrayList<String>();
		this.validInitials = new ArrayList<String>();
		// adding door labels to validInitials
		validInitials.add("D");
		validInitials.add("U");
		validInitials.add("R");
		validInitials.add("L");

		try {
			BufferedReader fr = new BufferedReader(new FileReader(roomConfigFile));
			String s;
			int lineLength = 0;
			int lineNumber = 0;

			while((s = fr.readLine())  != null) {
				//check if Other or Card is somewhere on the line
				if(!s.contains("Other") && !s.contains("Card")) {
					throw new BadConfigFormatException(boardConfigFile);
				}

				//breaking down by line
				String eachLine[] = s.split(",");

				//get initial line length
				if (lineNumber == 0) {
					lineLength = eachLine.length;
					lineNumber++;

				}
				//throw the exception if line lengths differ
				if(lineLength != eachLine.length) {
					throw new BadConfigFormatException(roomConfigFile);
				}

				//populate map with character and room name
				char mapKey = eachLine[0].charAt(0);
				validInitials.add(mapKey + "");
				String mapValue = "";
				mapValue = eachLine[1].trim();
				legend.put(mapKey, mapValue);

				if(eachLine[2].trim().equals("Card")) {
					rooms.add(eachLine[1].trim());
				}
			}

		} catch (FileNotFoundException e) {
			System.out.print(e.getMessage());
		} catch (IOException e) {
			System.out.print(e.getMessage());
		}
	}

	//method to read in the player/computer character config. file
	public void loadPlayerConfig() throws BadConfigFormatException {
		this.players = new Player[MAX_PLAYERS];
		int playerIndex = 0;
		try {
			BufferedReader fr = new BufferedReader(new FileReader(playerConfigFile));
			int lineNumber = 0;
			int lineLength = 0;
			String s;

			while((s = fr.readLine())  != null) {
				//variables for each player
				String name = "";
				Color color;
				boolean isComputer = false;
				int row;
				int col;

				//check if Other or Card is somewhere on the line
				if(!s.contains("player") && !s.contains("computer")) {
					throw new BadConfigFormatException(playerConfigFile);
				}
				//breaking down by line
				String eachLine[] = s.split(",");

				//get initial line length
				if (lineNumber == 0) {
					lineLength = eachLine.length;
					lineNumber++;
				}
				//throw the exception if line lengths differ
				if(lineLength != eachLine.length) {
					throw new BadConfigFormatException(roomConfigFile);
				}

				//populate each player line by line
				//get the name
				name = eachLine[0];
				//convert the color
				color = convertColor(eachLine[1].trim());
				//computer versus player
				if(eachLine[2].trim().equals("computer")) {
					isComputer = true;
				}
				//row
				row = Integer.parseInt(eachLine[3].trim());
				//col
				col = Integer.parseInt(eachLine[4].trim());
				//call constructor with each of the params.
				//check if computer or human player
				Player tempPlayer;
				if(isComputer) {
					tempPlayer = new ComputerPlayer(name, row, col, color, isComputer);
				}
				else {
					tempPlayer = new HumanPlayer(name, row, col, color, isComputer);
				}

				players[playerIndex] = tempPlayer;
				playerIndex++;
			}
		} catch (FileNotFoundException e) {
			System.out.print(e.getMessage());
		} catch (IOException e) {
			System.out.print(e.getMessage());
		}
	}

	//method to read in the weapon card config. file
	private void loadWeaponConfig() throws BadConfigFormatException {
		this.weapons = new String[MAX_WEAPONS];
		try {
			BufferedReader fr = new BufferedReader(new FileReader(weaponConfigFile));
			int lineNumber = 0;
			String s;

			while((s = fr.readLine())  != null) {
				if(lineNumber > 6) {
					throw new BadConfigFormatException(weaponConfigFile);
				}
				weapons[lineNumber] = s;
				lineNumber++;
			}
		} catch (FileNotFoundException e) {
			System.out.print(e.getMessage());
		} catch (IOException e) {
			System.out.print(e.getMessage());
		}	
	}

	//set config files
	public void setConfigFiles(String boardConfig, String roomConfig, String playerConfig, String weaponConfig) {
		this.boardConfigFile = "./data/" + boardConfig;
		this.roomConfigFile = "./data/" + roomConfig;
		this.playerConfigFile = "./data/" + playerConfig;
		this.weaponConfigFile = "./data/" + weaponConfig;
	}

	//functions for pathing
	public void calcAdjacencies() {
		//map for the cell and their assosciated adjacency list
		this.adjMtx = new HashMap<BoardCell, Set<BoardCell>>();

		//populate with adjacencies
		//for each row in the grid
		for(int row = 0; row < numRows; row ++) {
			//for each cell in the row
			for(int column = 0; column <  numColumns; column ++) {
				//create the adjList to be the value of our map.
				this.adjList = new HashSet<BoardCell>();
				BoardCell currentCell = getCellAt(row, column);

				//if current cell is a room
				if(currentCell.isRoom()) {
					adjList.clear();
				}

				//if the current cell is a walkway
				else if (currentCell.isWalkway()) {
					//check all directions
					//down
					if(row - 1 >= 0 && !getCellAt(row - 1, column).isRoom()) {
						adjList.add(getCellAt(row - 1, column));
					}
					//up
					if(row + 1 < numRows && !getCellAt(row + 1, column).isRoom()) {
						adjList.add(getCellAt(row + 1, column));
					}
					//left
					if(column - 1 >= 0 && !getCellAt(row, column - 1).isRoom()) {
						adjList.add(getCellAt(row, column - 1));
					}
					//right
					if(column + 1 < numColumns && !getCellAt(row, column + 1).isRoom()) {
						adjList.add(getCellAt(row, column + 1));
					}

					//call to remove the doors from adjList
					removeDoors(currentCell);
				}
				//otherwise, on a doorway
				else {
					if(currentCell.getDoorDirection() == DoorDirection.UP) {
						adjList.add(getCellAt(row - 1, column));
					} else if(currentCell.getDoorDirection() == DoorDirection.DOWN) {
						adjList.add(getCellAt(row + 1, column));
					} else if(currentCell.getDoorDirection() == DoorDirection.LEFT) {
						adjList.add(getCellAt(row, column - 1));
					} else if(currentCell.getDoorDirection() == DoorDirection.RIGHT) {
						adjList.add(getCellAt(row, column + 1));
					}
				}
				//put into the map
				adjMtx.put(currentCell, adjList); 
			}
		}
	}

	//Custom helper function to remove the invalid doors from the AdjList set.
	private void removeDoors(BoardCell currentCell) {
		//set of cells to remove from the adjList
		Set<BoardCell> removeDoors = new HashSet<BoardCell>();
		//check the adjList for a door, and then compare with the current cell.
		for(BoardCell adjCell: adjList) {
			//if the adjacent cell is a door, check if the direction it came from is valid
			if(adjCell.isDoorway()) {
				switch(adjCell.getDoorDirection()) {
				case RIGHT:
					if(currentCell.getColumn() - 1 != adjCell.getColumn()) {
						removeDoors.add(adjCell);
					}
					break;
				case LEFT:
					if(currentCell.getColumn() + 1 != adjCell.getColumn()) {
						removeDoors.add(adjCell);
					}
					break;
				case UP:
					if(currentCell.getRow() + 1 != adjCell.getRow()) {
						removeDoors.add(adjCell);
					}
					break;
				case DOWN:
					if(currentCell.getRow() - 1 != adjCell.getRow()) {
						removeDoors.add(adjCell);							
						break;
					}
				}
			}
		}
		//remove the doors from the set
		adjList.removeAll(removeDoors);
	}

	//Method to calc the targets from the target cell & a given pathlength
	//Sets up recursive call
	public void calcTargets(int row, int column, int pathLength) {
		this.targets = new HashSet<>();
		this.visited = new HashSet<>();
		visited.add(getCellAt(row, column));
		//recursive call
		findAllTargets(row, column, pathLength);
	}


	//Given a starting point and a dice roll, determine the viable spots the player can visit
	public void findAllTargets(int row, int column, int pathLength) {
		//Get the list of adj cells to iterate over
		Set<BoardCell> tempAdj = adjMtx.get(getCellAt(row, column));
		for(BoardCell cell : tempAdj) {
			if(!visited.contains(cell)) {
				//add cell to set of visited cells
				visited.add(cell);
				//if numsteps == 1
				if(pathLength == 1 || cell.isDoorway()) {
					targets.add(cell);
				}
				else {
					//recursive call
					findAllTargets(cell.getRow(), cell.getColumn(), pathLength-1);
				}
				//remove the cell from visited list
				visited.remove(cell);
			}
		}
	}

	// Be sure to trim the color, we don't want spaces around the name
	public Color convertColor(String strColor) {
		Color color;
		try {
			// We can use reflection to convert the string to a color
			Field field = Class.forName("java.awt.Color").getField(strColor.trim());
			color = (Color)field.get(null);
		} catch (Exception e) {
			color = null; // Not defined
		}
		return color;
	}

	//Sets the answer
	public void selectAnswer(int i, int j, int k) {
		this.theAnswer = new Solution(players[i].getPlayerName(), weapons[j], rooms.get(k));
	}

	//Board operation to query players to disprove suggestion.
	public Card handleSuggestion(Player accuser, Solution suggestion) {
		//Card variable to be returned
		Card counterCard = null;
		int indexOf = 0;
		//grab index of element in the player array
		for(int i = 0; i < players.length; i++) {
			if(players[i].equals(accuser)) {
				indexOf = i;
				break;
			}
		}
		for(int i = indexOf+1; i != indexOf; i = (i + 1) % players.length) {
			//if the counterCard has been updated
			if(counterCard != null) {
				break;
			}
			//if the player is the accuser, do nothing
			if(players[i] == accuser) {
				//do nothing
			}
			//otherwise,
			if(players[i] == null) {
				//do nothing?
			}
			else {
				//update the counterCard (either null or an actual card)
				counterCard = players[i].disproveSuggestion(suggestion);
			}
	}
	return counterCard;
}

public boolean checkAccusation(Solution accusation) {
	return this.theAnswer.equals(accusation);
}

//////////////////////////////////////
//getter functions for the Board class
//////////////////////////////////////
public Map<Character, String> getLegend() {
	return legend;
}

public int getNumRows() {
	return numRows;
}

public int getNumColumns() {
	return numColumns;
}

public BoardCell getCellAt(int row, int column) {
	return board[row][column];
}

public Set<BoardCell> getTargets() {
	return targets;
}

public Set<BoardCell> getAdjList(int row, int column) {
	return adjMtx.get(getCellAt(row, column));
}

public Player[] getPlayers() {
	return players;
}

public String[] getWeapons() {
	return weapons;
}
public Set<Card> getDeckOfCards() {
	return deckOfCards;
}
public Solution getSolution() {
	return theAnswer;
}

public Solution getTheAnswer() {
	return theAnswer;
}

public void setTheAnswer(String person, String room, String weapon) {
	this.theAnswer = new Solution(person, room, weapon);
}

}
