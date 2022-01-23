package clueGame;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EtchedBorder;
import javax.swing.border.TitledBorder;

public class DetectiveNotesGUI extends JPanel{
	static JMenuItem menuItemNotes;

	public DetectiveNotesGUI() {
		createMenuBar();
	}

	//Create the menu bar
	public static JMenuBar createMenuBar() {
		//Making the entire bar
		JMenuBar fileBar = new JMenuBar();
		JMenu menu = new JMenu("File");
		fileBar.add(menu);
		JDialog notes = createNotes();
		//Making the option to open window
		JMenuItem openNotes = new JMenuItem("Open: Detective Notes");

		openNotes.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent ev) {
				notes.setVisible(true);
			}
		});

		//Make the option to exit, and provide the listener
		JMenuItem exitItem = new JMenuItem("Exit");
		exitItem.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent ev) {
				System.exit(0);
			}
		});
		menu.add(exitItem);
		menu.add(openNotes);
		return fileBar;
	}

	private static JDialog createNotes() {
		JFrame frame = new JFrame();
		JDialog notes = new JDialog(frame, "Detective Notes");
		JLabel label = new JLabel("test");
		notes.add(label);
		return notes;
	}


}
