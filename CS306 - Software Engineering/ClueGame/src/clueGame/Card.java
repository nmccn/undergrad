// authors: Cat de Frates and Nic Mcclellan
package clueGame;

public class Card {
	private String cardName;
	CardType cardType;

	public Card(String name, CardType type) {
		this.cardName = name;
		this.cardType = type;
	}

	// equals override function
	@Override
	public boolean equals(Object a) {
		Card card = (Card) a;
		if (a == this) {
			return true;
		}
		if (a == null) {
			return false;
		}
		return this.cardName == card.cardName && this.cardType == card.cardType;
	}

	public CardType getCardtype() {
		return cardType;
	}

	public String getCardName() {
		return cardName;
	}

}


