package photo;

import drive.DriveBean;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhotoDAO {
    Connection con = null;
    String sql = null;
    PreparedStatement pr = null;
    ResultSet rs = null;

    public Connection getConnection() throws SQLException, NamingException {
        Context init = new InitialContext();
        DataSource dataSource = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
        con = dataSource.getConnection();
        return con;
    }

    public List getPhotoList(int startRow, int pageSize) {
        List photoList = new ArrayList();
        try {
            con = getConnection();

            sql = "select * from photo order by num desc limit ?,?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, startRow-1);
            pr.setInt(2, pageSize);
            rs = pr.executeQuery();

            while (rs.next()) {
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
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
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
                if(rs != null) try {rs.close();} catch(SQLException exception) {}
                if(pr != null) try {pr.close();} catch(SQLException exception) {}
                if(con != null) try {con.close();} catch(SQLException exception) {}
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
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
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
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
        return photoBean;
    }

    public void deletePhoto(int num, String id) {
        try {
            con = getConnection();

            sql = "DELETE FROM photo where num = ? and id = ?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, num);
            pr.setString(2, id);
            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
    }

    public int getPhotoCount() {
        int count = 0;
        try {
            con = getConnection();
            sql = "SELECT count(*) FROM photo";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();
            if(rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
        return count;
    }
}
