package entity;

public class Employee  extends User{
  private int projectId;
  private String proSkill;
public int getProjectId() {
	return projectId;
}
public Employee(int id, String fullName, String email, String passWord, int projectId,String proSkill) {
	super(id, fullName, email, passWord);
	this.projectId = projectId;
	this.proSkill = proSkill;
}
public void setProjectId(int projectId) {
	this.projectId = projectId;
}
public String getProSkill() {
	return proSkill;
}
public void setProSkill(String proSkill) {
	this.proSkill = proSkill;
}
public Employee() {
	super();
}

public Employee(int projectId, String proSkill) {
	super();
	this.projectId = projectId;
	this.proSkill = proSkill;
}
@Override
public String toString() {
	return "Employee [projectId=" + projectId + ", proSkill=" + proSkill + ", toString()=" + super.toString() + "]";
}
}
