import java.util.ArrayList;
/**
 * Party class. 
 *  
 * @author Mark Baldwin
 * @author Cyndi Rader
 * 
 * Purpose. Illustrate use of abstract classes
 */

public class Party {
	// Person is an abstract class
	private ArrayList<Person> people = new ArrayList<Person>();
	
	// Reminder: constant values are typically public and static (only one copy)
	public static final int MAX_QUESTIONS = 15;
	
	/**
	 * Constructor to set up the people in the party
	 */
	public Party() {
		people.add(new HappyPerson ("Bobby", "School Teacher", "Robby"));
		people.add(new HappyPerson ("Robby", "Bus Driver", "Bobby"));
		people.add(new SadPerson ("Abagail", "Medium"));
		people.add(new SadPerson ("Suzan", "Secretary"));
		people.add(new AngryPerson ("Richard", "Unemployed"));
		
		// Add your person objects here. The following are included as examples
		//people.add(new Philosopher("Plato", "Heavy Thinker"));
		//people.add(new PetOwner("Dr. Doolittle", "Vet", "cat", "Mittens"));
		//people.add(new Introvert("Greta Garbo", "Actress"));
		//people.add(new Extrovert("Scooby Doo", "Private Eye"));
		//people.add(new PetOwner("Frazier", "Psychiatrist", "dog", "Eddie"));
		}
	
	/**
	 * Have people in the party ask other people questions
	 * 
	 * For simplicity, we'll just have people "ask" a question of the next
	 * person in the list. 	 
	 * 
	 */
	public void partyTime() {
		// initialize our asker and answerer
		int questionPerson = 0;
		int answerPerson = 1;
		// For simplicity, just doing a fixed number of questions
		int questionsAsked = 0;
		while (questionsAsked < MAX_QUESTIONS) {
			// display the question and answer
			people.get(questionPerson).askQuestion();
			people.get(answerPerson).answerQuestion();
			System.out.println();
			
			// set up for the next round
			questionsAsked++;
			questionPerson = (questionPerson + 1) % people.size();
			answerPerson = (answerPerson + 1) % people.size();			
		}
	}
	
	/**
	 * Allows introduction of all the people
	 * 
	 * Note that this function makes use of methods defined in the parent class
	 */
	public void introductions() {
		for (Person p : people) {
			p.askName();
			p.giveName();
			p.whatDoYouDo();
			System.out.println();
		}
		System.out.println("Welcome to the party, let's chat!\n");
	}
	
	/** 
	 * Main driver for testing
	 * @param args Input arguments for main (unused)
	 */
	public static void main(String[] args) {
		Party party = new Party();
		party.introductions();
		party.partyTime();
	}
	

}
