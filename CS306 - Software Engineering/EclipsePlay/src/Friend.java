/**
 * @author Mark Baldwin
 *
 */
public class Friend {
	private String name;
	private String email;
	
	
	//default constructor
	public Friend() {
		super();
	}
	//parameterized constructor
	public Friend(String name, String email) {
		super();
		this.name = name;
		this.email = email;
	}
	
	//Email Field getter/setter
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	//Name field getter
	public String getName() {
		return name;
	}
	
	//@Override
	/*public String toString() {
		return "Friend [name=" + name + ", email=" + email + "]";
	}
	*/
	
	
	
	
	
}

