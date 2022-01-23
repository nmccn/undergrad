// authors: Cat de Frates and Nic Mcclellan
package clueGame;

public class Solution {

	public String person;
	public String room;
	public String weapon;
	public Solution(String person, String room, String weapon) {
		this.person = person;
		this.room = room;
		this.weapon = weapon;
	}

	// equals override function
	@Override
	public boolean equals(Object a) {
		Solution sol = (Solution) a;
		if (a == this) {
			return true;
		}
		if (a == null) {
			return false;
		}
		return this.person == sol.person && this.room == sol.room && this.weapon == sol.weapon;
	}

	@Override
	public String toString() {
		return "Solution [person=" + person + ", room=" + room + ", weapon=" + weapon + "]";
	}
	
	


}
