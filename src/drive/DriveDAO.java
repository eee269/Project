package drive;

import board.BoardBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriveDAO {
    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection con = null;

        Class.forName("com.mysql.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/jspyj";
        String dbUser = "testid";
        String dbPass = "testpass";
        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        return con;
    }
    public List getDriveList() {
        List boardList = new ArrayList();
        try {
            Connection con = getConnection();

            String sql = "select * from drive order by num desc";
            PreparedStatement pr = con.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();

            while(rs.next()) {

//                수정해야 함

                boardList.add(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return boardList;

    }
}
