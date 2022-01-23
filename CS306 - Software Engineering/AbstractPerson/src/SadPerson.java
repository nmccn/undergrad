
public class SadPerson extends Person{

	public SadPerson(String myName, String occupation) {
		super(myName, occupation);
	}

	@Override
	void askQuestion() {
		System.out.println("How is your life?");
	}

	@Override
	void answerQuestion() {
		System.out.println("I don't really know...");
	}
	
	@Override
	void whatDoYouDo() {
		super.whatDoYouDo();
		System.out.println("...");
	}
}
