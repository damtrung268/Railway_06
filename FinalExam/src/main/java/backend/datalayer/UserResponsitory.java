package backend.datalayer;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import Utils.JdbcUltils;

import entity.Employee;
import entity.Manager;
import entity.User;

public class UserResponsitory {

	JdbcUltils jdbcUltils;
	Connection connection;

	public UserResponsitory() throws FileNotFoundException, ClassNotFoundException, IOException, SQLException {
		// TODO Auto-generated constructor stub
		jdbcUltils = new JdbcUltils();
		connection = jdbcUltils.connect();
	

	}

	public List<User> users = new ArrayList<User>();

	// Question2 : Viết function để user nhập vào id project, sau đó in ra tất cả các employee &
//	Manager trong project đó (in ra dạng table)

	public void inthongtinasid(int ProjectId) throws SQLException {

		users = new ArrayList<User>();
	
		Statement statement = connection.createStatement();

		String querry = "SELECT * FROM User " + "WHERE ProjectId = " + ProjectId +";";
		ResultSet resultSet = statement.executeQuery(querry);
		while (resultSet.next()) {
			if (resultSet.getString("role").equals("Manager")) {
				users.add(new Manager(resultSet.getInt("id"), resultSet.getString("Fullname"),
						resultSet.getString("Email"), resultSet.getString("password"), resultSet.getInt("expInYear")));
			} else {
				users.add(new Employee(resultSet.getInt("id"), resultSet.getString("Fullname"),
						resultSet.getString("Email"), resultSet.getString("password"), resultSet.getInt("projectId"),
						resultSet.getString("proSkill")));
			}
		}
		System.out.println(users);
	}
	// Question 4:Viết chức năng login, User sẽ nhập Email và Password trên giao diện login
//	Chương trình phải kiểm tra được các hợp lệ của các thuộc tính
//	 Email: đúng định dạng email. (VD: nguyen.vannam@vti.com.vn)
//	 Password: nhập từ 6 tới 12 ký tự, có ít nhất 1 ký tự viết hoa
	public boolean ktraEmail(String Email) {
		boolean checkInEmail = false;
		for (int i = 0; i < Email.length(); i++) {
			if (Email.charAt(i) == '@') {
				checkInEmail = true;
			}
		}
		if (Email.length() >= 2 && checkInEmail) {
			return true;
		} else {
			return false;
		}
	}

	public boolean ktraPassword(String Password) {
		boolean checkPassword = false;
	
		for (int i = 0; i < Password.length(); i++) {
			if (Password.charAt(i) >= 'A' && Password.charAt(i) <= 'Z') {
				checkPassword = true;
			}
		}
		if (Password.length() >= 6 && Password.length() <= 12 && checkPassword) {
			return true;
		} else {
			return false;
		}
	}
	public void login() throws SQLException{
		Scanner scanner = new Scanner(System.in);
		String email="";
		while(true){
		System.out.println("Mời bạn nhập email:");
		email = scanner.nextLine();
		if(ktraEmail(email)){
		break;
		}
		}
		String password="";
		while(true){
		System.out.println("Mời bạn nhập password:");
		password = scanner.nextLine();
		if(ktraPassword(password)){
		break;
		}
		}
		
		for (User user : users) {
		if(user.getEmail().equals(email) &&
		user.getPassWord().equals(password)){
		System.out.println("login thành công");
		return;
		}
		}
		System.out.println("login thất bại!");
		}

	//Question 3: Viết function để user có thể lấy ra tất cả Manager của các project (in ra dạng table)



	public void inthongtinManager() throws SQLException {
		users = new ArrayList<User>();
		Statement statement = connection.createStatement();

		String querry = "SELECT * FROM User " + "WHERE `role`= Manager ";
		ResultSet resultSet = statement.executeQuery(querry);
		while (resultSet.next()) {
			users.add(new Manager(resultSet.getInt("id"), resultSet.getString("Fullname"),
					resultSet.getString("Email"), resultSet.getString("password"), resultSet.getInt("expInYear")));
		}
		for (User user : users)
			System.out.println(user);
	
}
}