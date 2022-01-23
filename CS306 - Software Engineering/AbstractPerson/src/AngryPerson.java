
public class AngryPerson extends Person {
	int nextQuestion = 0;
	int nextAnswer = 0; 

	public AngryPerson(String myName, String occupation) {
		super(myName, occupation);
	}

	@Override
	void askQuestion() {
		String[] questions = {"What's up?", "What do you need?", "What do you want?", "What?"};	
		System.out.println(questions[nextQuestion]);
		nextQuestion = (nextQuestion + 1) % 4;
	}

	@Override
	void answerQuestion() {
		String[] answers = {"Shut up.", "I'm busy.", "Go away.", "Don't talk to me."};
		System.out.println(answers[nextAnswer]);
		nextAnswer = (nextAnswer + 1) % 4;
	}
	
	@Override
	void whatDoYouDo() {
		super.whatDoYouDo();
		System.out.println("I hate my job.");
	}

}
