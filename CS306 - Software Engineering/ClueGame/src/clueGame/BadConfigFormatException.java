// authors: Cat de Frates and Nic Mcclellan
package clueGame;

public class BadConfigFormatException extends Exception {

	public BadConfigFormatException() {
		super("Error: Bad config format");
	}
	
	public BadConfigFormatException(String fileName) {
		super(fileName + " is not a valid config file.");
	}
	
}
