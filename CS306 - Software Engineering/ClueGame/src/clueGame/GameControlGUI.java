// authors: Cat de Frates and Nic Mcclellan
package clueGame;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenuBar;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EtchedBorder;
import javax.swing.border.TitledBorder;

public class GameControlGUI extends JPanel{
	private JTextField guess;
	private JTextField whoseTurn;
	private JTextField guessResult;
	private JTextField dieRoll;
	

	public GameControlGUI()
	{
		// Create a layout with 2 rows
		setLayout(new GridLayout(2,1));
		JPanel panel = createTopPanel();
		add(panel);
		panel = createBottomPanel();
		add(panel);
	}

	//For the top panel (2 buttons + whose turn)
	private JPanel createTopPanel() {
		JPanel panel = new JPanel();
		JPanel nestedPanel = createWhoseTurnPanel();
		panel.setLayout(new GridLayout(1,3));
		panel.add(nestedPanel);
		nestedPanel = createNextPlayer();
		panel.add(nestedPanel);
		nestedPanel = createMakeAccusation();
		panel.add(nestedPanel);
		return panel;
	}

	//For the bottom panel (die, guess, guess result)
	private JPanel createBottomPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new FlowLayout());
		JPanel nestedPanel = createDieRollPanel();
		panel.add(nestedPanel);
		nestedPanel = createGuessPanel();
		panel.add(nestedPanel);
		nestedPanel = createGuessResultPanel();
		panel.add(nestedPanel);
		return panel;
	}


	//To create the Next Player button
	private JPanel createNextPlayer() {
		// no layout specified, so this is flow
		JButton nextPlayerButton = new JButton("Next Player");
		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout());
		panel.add(nextPlayerButton);
		return panel;
	}

	//To create the Make Accusation
	private JPanel createMakeAccusation() {
		// no layout specified, so this is flow
		JButton accusationButton = new JButton("Make an accusation");
		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout());
		panel.add(accusationButton);
		return panel;
	}

	//Create Guess Frame
	private JPanel createGuessPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout(2,1));
		JLabel nameLabel = new JLabel("Guess");
		guess = new JTextField(40);
		panel.add(nameLabel);
		panel.add(guess);
		panel.setBorder(new TitledBorder (new EtchedBorder(), "Guess"));
		return panel;
	}

	//Create Guess Result Frame
	private JPanel createGuessResultPanel() {
		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout(1,2));
		JLabel nameLabel = new JLabel("Response");
		guessResult = new JTextField(10);
		panel.add(nameLabel);
		panel.add(guessResult);
		panel.setBorder(new TitledBorder (new EtchedBorder(), "Guess Result"));
		return panel;
	}

	//Create Whose Turn ? Frame
	private JPanel createWhoseTurnPanel() {
		JPanel panel = new JPanel();
		JPanel nestedPanel = new JPanel();
		JLabel nameLabel = new JLabel("Whose turn?");
		whoseTurn = new JTextField(12);
		panel.setLayout(new FlowLayout());
		nestedPanel.setLayout(new GridLayout(2,1));
		nestedPanel.add(nameLabel);
		nestedPanel.add(whoseTurn);
		panel.add(nestedPanel);
		//panel.setBorder(new TitledBorder (new EtchedBorder(), "Whose Turn?"));
		return panel;
	}

	//Create the Die Roll Frame
	private JPanel createDieRollPanel() {
		JPanel panel = new JPanel();
		// Use a grid layout, 1 row, 2 elements (label, text)
		panel.setLayout(new GridLayout(1,2));
		JLabel nameLabel = new JLabel("Roll");
		dieRoll = new JTextField(5);
		panel.add(nameLabel);
		panel.add(dieRoll);
		panel.setBorder(new TitledBorder (new EtchedBorder(), "Die"));
		return panel;
	}

	public static void main(String[] args) {
		// Create a JFrame with all the normal functionality
		JFrame gameWindow = new JFrame();
		
		JMenuBar fileOptions = DetectiveNotesGUI.createMenuBar();
		gameWindow.add(fileOptions, BorderLayout.NORTH);

		gameWindow.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		gameWindow.setTitle("Clue Game");
		gameWindow.setSize(1920, 1080);	
		// Create the JPanel and add it to the JFrame
		GameControlGUI gameControl = new GameControlGUI();
		gameWindow.add(gameControl, BorderLayout.SOUTH);
		// Now let's view it
		gameWindow.setVisible(true);
	}

}


