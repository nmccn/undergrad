public class HappyPerson extends Person{
	String bestFriendName;

	public HappyPerson(String myName, String occupation, String bestFriendName) {
		super(myName, occupation);
		this.bestFriendName = bestFriendName;
	}

	@Override
	void askQuestion() {
		String[] questions = {"How are you?", "How are you, friend?", "What's going through your mind?", "How can I help?"};
		double i = Math.ceil(Math.random() % 4);
		System.out.println(questions[(int) i]);
	}

	@Override
	void answerQuestion() {
		String[] answers = {"I feel alive!", "Everything's great!", "I feel good!",  "I feel great!"};
		double i = Math.ceil(Math.random() % 4);
		System.out.println(answers[(int) i]);
	}

	@Override
	void whatDoYouDo() {
		super.whatDoYouDo();
		System.out.println("I love my job! My best friend is " + bestFriendName);
	}

}
