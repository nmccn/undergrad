import java.awt.Point;

public class StringPlay {
	

	public static void main(String[] args) {
		//Part One & Two
		String str1 = "C++ is cool";
		String str2 = "I love Java";
		String str3 = str2.substring(7) + str1.substring(3);
		//testing str3 by printing its output.
		System.out.println(str3);
		
		//Part Three
		Point point1 = new Point(20, 20);
		Point point2 = new Point(20, 20);
		Point point3 = point1;
		
		//Show that == tests an objects address
		//This condition would be true if == checked for the same contents
		if(point1 == point2) {
			System.out.println("These points are equivalent (by ==) ");
		}
		else {
			System.out.println("These points are not equivalent (by ==) ");
		}
		//This condition would be true if == checked for the same address
		if(point1 == point3) {
			System.out.println("These points are equivalent (by ==) ");
		}
		else {
			System.out.println("These points are equivalent (by ==) ");
		}
		
		//Part Four
		String str4 = "Cardiovascular System";
		String str5 = "cArDiOvAsCuLaR sYsTeM";
		
		//Testing equals and equalsIgnoreCase
		if(str4.equals(str5)) {
			System.out.println("The strings are equal");
		}
		if(str4.equalsIgnoreCase(str5)) {
			System.out.println("The strings are equal, ignoring case");
		}
		
	}

}
