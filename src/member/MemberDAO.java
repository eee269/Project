package member;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.lang.reflect.Member;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

public class MemberDAO {
//	DB에 권한부여
//	grant all privileges on jspyj.* to 'testid'@'localhost'
//	identified by 'testpass';

	Connection con;
	String sql;
	PreparedStatement pr;
	ResultSet rs;

	public Connection getConnection() throws ClassNotFoundException, SQLException, NamingException {
		Context init = new InitialContext();
		DataSource dataSource = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
		con = dataSource.getConnection();
//		Class.forName("com.mysql.jdbc.Driver");
//		String dbUrl = "jdbc:mysql://localhost:3306/jspyj";
//		String dbUser = "root";
//		String dbPass = "l8426k";
//		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		
		return con;
	}
	
	public int userCheck(String id, String pass) {
		int check = -1;
		try {
			con = getConnection();
			sql = "SELECT * FROM member where id = ?";
			pr = con.prepareStatement(sql);
			pr.setString(1, id);
			rs = pr.executeQuery();

			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					check = 1;
				} else check = 0;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{ rs.close(); } catch (SQLException s) {}
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
		return check;
	}

	public int dupCheck(String id) {
		int check = 0;
		try {
			con = getConnection();
			sql = "SELECT id FROM member where id = ?";
			pr = con.prepareStatement(sql);
			pr.setString(1, id);
			rs = pr.executeQuery();

			if(rs.next())		check = 1;
			else 				check = 0;

		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{ rs.close(); } catch (SQLException s) {}
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
		return check;
	}

	public void joinMember(MemberBean mb) {
		try {
			con = getConnection();

			sql = "INSERT INTO member(pass, id, name, date, age, gender, email, phone, postcode, address1, address2, emailHash, emailChecked) " +
					"values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pr = con.prepareStatement(sql);


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
			pr.setInt(12, mb.getEmailHash());
			pr.setBoolean(13, false);

			pr.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
	}

    public MemberBean getMember(String id) {
		MemberBean mb = null;
		try{
			con = getConnection();

			sql = "select * from member where id=?";
			pr = con.prepareStatement(sql);
			pr.setString(1, id);
			rs = pr.executeQuery();

			if(rs.next()) {
				mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setPostcode(rs.getString("postcode"));
				mb.setAddress1(rs.getString("address1"));
				mb.setAddress2(rs.getString("address2"));
				mb.setEmail(rs.getString("email"));
				mb.setPhone(rs.getString("phone"));
				mb.setGender(rs.getString("gender"));
				mb.setEmailHash(rs.getInt("emailHash"));
				mb.setEmailChecked(rs.getBoolean("emailChecked"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{ rs.close(); } catch (SQLException s) {}
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
		return mb;
    }

    public void updateMember(MemberBean mb) {
		try{
			con = getConnection();

			sql = "update member " +
					"set name=?, postcode=?, address1=?, address2=?, email=?, age=?, phone=?, gender=?, date=?" +
					"where id=? and pass=?";
			pr = con.prepareStatement(sql);
			pr.setString(1, mb.getName());
			pr.setString(2, mb.getPostcode());
			pr.setString(3, mb.getAddress1());
			pr.setString(4, mb.getAddress2());
			pr.setString(5, mb.getEmail());
			pr.setInt(6, mb.getAge());
			pr.setString(7, mb.getPhone());
			pr.setString(8, mb.getGender());
			pr.setTimestamp(9, mb.getDate());
			pr.setString(10, mb.getId());
			pr.setString(11, mb.getPass());

			pr.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
	}

	public void deleteMember(String id, String pass) {
		try {
			con = getConnection();

			sql = "delete from member where id = ? and pass = ?";
			pr = con.prepareStatement(sql);
			pr.setString(1, id);
			pr.setString(2, pass);

			pr.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
	}

	public int getUserEmailHash(String id) {
		try{
			con = getConnection();

			sql = "select emailHash from member where id=?";
			pr = con.prepareStatement(sql);
			pr.setString(1, id);
			rs = pr.executeQuery();

			if(rs.next()) {
				return rs.getInt("emailHash");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{ rs.close(); } catch (SQLException s) {}
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
		return 0;
	}


	public boolean getUserEmailChecked(String id) {
		try{
			con = getConnection();

			sql = "select emailChecked from member where id=?";
			pr = con.prepareStatement(sql);
			pr.setString(1, id);
			rs = pr.executeQuery();

			if(rs.next()) {
				return rs.getBoolean("emailChecked");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{ rs.close(); } catch (SQLException s) {}
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
		return false;
	}

	public boolean setUserEmailChecked(String id) {
		try{
			con = getConnection();

			sql = "UPDATE member SET emailChecked = true where id=?";
			pr = con.prepareStatement(sql);
			pr.setString(1, id);
			pr.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pr!=null) try{ pr.close(); } catch (SQLException s) {}
			if(con!=null) try{ con.close(); } catch (SQLException s) {}
		}
		return false;
	}
}
