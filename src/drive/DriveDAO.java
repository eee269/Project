package drive;

import board.BoardBean;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DriveDAO {
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

    public DriveBean getDrive(int num) {
        DriveBean driveBean = null;
        try {
            con = getConnection();

            sql = "SELECT * FROM drive WHERE num = ?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, num);
            rs = pr.executeQuery();

            if(rs.next()) {
                driveBean = new DriveBean();

                driveBean.setNum(num);
                driveBean.setId(rs.getString("id"));
                driveBean.setPass(rs.getString("pass"));
                driveBean.setTitle(rs.getString("title"));
                driveBean.setContent(rs.getString("content"));
                driveBean.setReadcount(rs.getInt("readcount"));
                driveBean.setDate(rs.getTimestamp("date"));
                driveBean.setFile(rs.getString("file"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
        return driveBean;
    }

    public List getDriveList(int startRow, int pageSize) {
        List driveList = new ArrayList();
        try {
            con = getConnection();

            sql = "select * from drive order by num desc limit ?,?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, startRow-1);
            pr.setInt(2, pageSize);
            rs = pr.executeQuery();

            while (rs.next()) {
                DriveBean driveBean = new DriveBean();
                driveBean.setNum(rs.getInt("num"));
                driveBean.setId(rs.getString("id"));
                driveBean.setPass(rs.getString("pass"));
                driveBean.setTitle(rs.getString("title"));
                driveBean.setContent(rs.getString("content"));
                driveBean.setReadcount(rs.getInt("readcount"));
                driveBean.setDate(rs.getTimestamp("date"));
                driveBean.setFile(rs.getString("file"));

                driveList.add(driveBean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
        return driveList;

    }

    public void updateReadcount(int num) {
        try {
            con = getConnection();

            sql = "UPDATE drive SET readcount = readcount+1 WHERE num = ?";
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

    public void insertDrive(DriveBean driveBean) {
        try {
            con = getConnection();

            sql="SELECT max(num) FROM drive";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();

            int num = 0;
            if(rs.next()) {
                num = rs.getInt("max(num)") + 1;
            }

            sql = "INSERT drive(num, id, pass, readcount, title, content, date, file) " +
                    "values(?, ?, ?, ?, ?, ?, ?, ?)";
            pr = con.prepareStatement(sql);
            pr.setInt(1, num);
            pr.setString(2, driveBean.getId());
            pr.setString(3, driveBean.getPass());
            pr.setInt(4, driveBean.getReadcount());
            pr.setString(5, driveBean.getTitle());
            pr.setString(6, driveBean.getContent());
            pr.setTimestamp(7, driveBean.getDate());
            pr.setString(8, driveBean.getFile());

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }

    }

    public void updateDrive(DriveBean driveBean) {
        try {
            con = getConnection();

            sql = "UPDATE drive set title = ?, content = ?, file = ?, date = ? where num = ?";
            pr = con.prepareStatement(sql);
            pr.setString(1, driveBean.getTitle());
            pr.setString(2, driveBean.getContent());
            pr.setString(3, driveBean.getFile());
            pr.setTimestamp(4, driveBean.getDate());
            pr.setInt(5, driveBean.getNum());

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
    }

    public void deleteDrive(int num, String id) {
        try {
            con = getConnection();

            sql = "DELETE FROM drive WHERE num=? and id = ?";
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

    public int getDriveCount() {
        int count = 0;
        try {
            con = getConnection();
            sql = "SELECT count(*) FROM drive";
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
