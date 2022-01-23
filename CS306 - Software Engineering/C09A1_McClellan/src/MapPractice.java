//Author: Nicholas McClellan
//Date Submitted: 2/10/2020
//Assignment: C09A1 Collections Exercises

import java.util.*;


//WHEN CHANGED FROM HashMap -> TreeMap:
///////////////////////////////////////////////////
/*
 *  I tested the output of the maps using
 * the input: cucumber, apple, banana. 
 * When using the HashMap, the outputs
 * were not in any distinguishable order
 * but rather in order based on some unknown
 * hash function. However, when using TreeMap
 * the outputs are ordered, but this requires
 * that the values are comparable. This difference
 * was also touched upon in the videos. 
 * 
 */

//WHEN CHANGED FROM TreeMap -> Map
///////////////////////////////////////////////////
/* The error when using only "Map" is that the comp-
 * iler cannot instantiate this object. The exact error
 * is pasted below.
 * 
 * Exception in thread "main" java.lang.Error: Unresolved compilation problem: 
	Cannot instantiate the type Map<String,String>
	at MapPractice.<init>(MapPractice.java:29)
	at MapPractice.main(MapPractice.java:68)
 * 
 * 
 * Map is an interface and as such cannot be instantiated ?
 * Rather one of the 4 implementations need to be used
 * Hashtable / Linked HashMap / HashMap / TreeMap
 * 
 * Similar to if we were just to say GamePiece() in the last project
 * 
 */
public class MapPractice {
	
	//private member variable for the map
	private Map<String, String> mapCourses;

	//constructor
	public MapPractice() {
		mapCourses = new HashMap<String, String>();
	}

	//Function to generate map based on user inputs.
	public void createMap() {
		//scanner for getting user inputs
		Scanner input = new Scanner(System.in);
		//string for student name + favorite course
		String studentName = "";
		String faveCourse = "";

		//infinite loop with break (definitely could be done better)
		while(true) {
			System.out.println("Enter a name: ");
			studentName = input.next();
			//check if q is input yet
			if(studentName.equalsIgnoreCase("q")) {
				break;
			}
			System.out.println("Enter a favorite course: ");
			faveCourse = input.next();
			mapCourses.put(studentName, faveCourse);
		}

		//close input (Not sure if this is actually needed/good practice)
		input.close();
	}

	public void printMap() {
		//iterate through using the entrySet method (gives access to both key/value)
		if(!mapCourses.isEmpty()) {
			for (Map.Entry entry : mapCourses.entrySet()) {
				System.out.println(entry.getKey() + " likes " + entry.getValue());
			}
		}
	}

	//Main to test the program
	public static void main(String[] args) {
		MapPractice myMap = new MapPractice();
		myMap.createMap();
		myMap.printMap();
	}

}