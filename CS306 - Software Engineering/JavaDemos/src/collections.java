/**
 * Collections assignment code
 */
import java.util.*;

public class collections {
	private Set<String> setAnimals;
	public collections() {
		setAnimals = new TreeSet<String>();
	}

	public void GetAnimals() {
		Scanner in = new Scanner(System.in);
		String animal = "";
		do 
		{
			System.out.print("Enter an animal or Q to quit: ");
			animal = in.next();
			if (!(animal.equalsIgnoreCase("Q")))
				setAnimals.add(animal);							
		} while (!(animal.equalsIgnoreCase("Q")));
	}

	public void PrintAnimals() {
		for (String animal : setAnimals)
			System.out.println(animal);
	}	
	
	public static void main(String[] args) {
		SetDemo sd = new SetDemo();
		sd.GetAnimals();
		sd.PrintAnimals();
	}

}
