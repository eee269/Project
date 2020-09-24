package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
//	DB에 권한부여
//	grant all privileges on jspyj.* to 'testid'@'localhost'
//	identified by 'testpass';
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		Connection con = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		String dbUrl = "jdbc:mysql://localhost:3306/jspyj?useSSL=false";
		String dbUser = "root";
		String dbPass = "l8426k";
		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		
		return con;
	}
	
	public int userCheck(String id, String pass) {
		int check = -1;
		try {
			Connection con = getConnection();
			String sql = "SELECT * FROM member where id = ?";
			PreparedStatement pr = con.prepareStatement(sql);
			pr.setString(1, id);
			ResultSet rs = pr.executeQuery();

			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					check = 1;
				} else check = 0;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return check;
	}

	public void joinMember(MemberBean mb) {
		try {
			Connection con = getConnection();

			String sql = "INSERT INTO member(pass, id, name, date, age, gender, email, phone, postcode, address1, address2) " +
					"values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement pr = con.prepareStatement(sql);


			pr.setString(1, mb.getPass());
			pr.setString(2, mb.getId());
			pr.setString(3, mb.getName());
			pr.setTimestamp(4, mb.getDate());
			pr.setInt(5, mb.getAge());
			pr.setString(6, mb.getGender());
			pr.setString(7, mb.getEmail());
			pr.setString(8, mb.getPhone());
			pr.setString(9, mb.getPostcode());
			pr.setString(10, mb.getAddress1());
			pr.setString(11, mb.getAddress2());

			pr.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
