package photo;

import drive.DriveBean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhotoDAO {
    Connection con = null;
    String sql = null;
    PreparedStatement pr = null;
    ResultSet rs = null;

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection con = null;

        Class.forName("com.mysql.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/jspyj";
        String dbUser = "testid";
        String dbPass = "testpass";
        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        return con;
    }

    public List getPhotoList() {
        List photoList = new ArrayList();
        try {
            con = getConnection();

            sql = "select * from photo order by num desc";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();

            while(rs.next()) {
                PhotoBean photoBean = new PhotoBean();

                photoBean.setNum(rs.getInt("num"));
                photoBean.setId(rs.getString("id"));
                photoBean.setPass(rs.getString("pass"));
                photoBean.setTitle(rs.getString("title"));
                photoBean.setContent(rs.getString("content"));
                photoBean.setReadcount(rs.getInt("readcount"));
                photoBean.setDate(rs.getTimestamp("date"));
                photoBean.setFile(rs.getString("file"));

                photoList.add(photoBean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
        return photoList;
    }

    public void insertPhoto(PhotoBean photoBean) {
        try {
            con = getConnection();

            sql="SELECT max(num) FROM photo";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();

            int num = 0;
            if(rs.next()) {
                num = rs.getInt("max(num)") + 1;
            }

            sql = "INSERT photo(num, id, pass, readcount, title, content, date, file) " +
                    "values(?, ?, ?, ?, ?, ?, ?, ?)";
            pr = con.prepareStatement(sql);
            pr.setInt(1, num);
            pr.setString(2, photoBean.getId());
            pr.setString(3, photoBean.getPass());
            pr.setInt(4, photoBean.getReadcount());
            pr.setString(5, photoBean.getTitle());
            pr.setString(6, photoBean.getContent());
            pr.setTimestamp(7, photoBean.getDate());
            pr.setString(8, photoBean.getFile());

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
    }

    public void updateReadcount(int num) {
        try {
            con = getConnection();

            sql = "UPDATE photo SET readcount = readcount+1 WHERE num = ?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, num);
            pr.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
    }


    public PhotoBean getPhoto(int num) {
        PhotoBean photoBean = null;
        try {
            con = getConnection();

            sql = "SELECT * FROM photo WHERE num = ?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, num);
            rs = pr.executeQuery();

            if(rs.next()) {
                photoBean = new PhotoBean();

                photoBean.setNum(num);
                photoBean.setId(rs.getString("id"));
                photoBean.setPass(rs.getString("pass"));
                photoBean.setTitle(rs.getString("title"));
                photoBean.setContent(rs.getString("content"));
                photoBean.setReadcount(rs.getInt("readcount"));
                photoBean.setDate(rs.getTimestamp("date"));
                photoBean.setFile(rs.getString("file"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

        }
        return photoBean;
    }
}
