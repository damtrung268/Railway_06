package entity;

public class User extends Project{
	private int id;
	private String fullName;
	private String email;
	private String passWord;
	public User(int id, String fullName, String email, String passWord) {
		super();
		this.id = id;
		this.fullName = fullName;
		this.email = email;
		this.passWord = passWord;
	}
	public User() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", fullName=" + fullName + ", email=" + email + ", passWord=" + passWord + "]";
	}
	

}
