package frontend;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

import Utils.JdbcUltils;
import backend.datalayer.UserResponsitory;

public class run {

	public static void main(String[] args) throws SQLException, FileNotFoundException, ClassNotFoundException, IOException {
		// TODO Auto-generated method stub
		JdbcUltils jdbcUltils = new JdbcUltils();
		jdbcUltils.connect();
		System.out.println("connect success");
		UserResponsitory user = new UserResponsitory();
		user.inthongtinasid(3);
//		user.inthongtinManager();
		
	}

}
