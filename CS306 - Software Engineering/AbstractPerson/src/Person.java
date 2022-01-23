public abstract class Person {
	
	private String myName;
	private String occupation;
	
	void askName() {
		System.out.println("What is your name?");
	}
	
	void giveName() {
		System.out.println("My name is " + myName);
	}
	
	void whatDoYouDo() {
		System.out.println("I am a " + occupation);
	}
	
	public Person(String myName, String occupation) {
		super();
		this.myName = myName;
		this.occupation = occupation;
	}

	abstract void askQuestion();
	abstract void answerQuestion();
	
}
