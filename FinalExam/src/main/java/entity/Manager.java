package entity;

public class Manager extends User{
	private int expInYear;

	public Manager(int id, String fullName, String email, String passWord, int expInYear) {
		super(id, fullName, email, passWord);
		this.expInYear = expInYear;
	}

	public Manager(int id, String fullName, String email, String passWord) {
		super(id, fullName, email, passWord);
	}

	public int getExpInYear() {
		return expInYear;
	}

	public void setExpInYear(int expInYear) {
		this.expInYear = expInYear;
	}

	@Override
	public String toString() {
		return "Manager [expInYear=" + expInYear + ", toString()=" + super.toString() + "]";
	}
	

}
