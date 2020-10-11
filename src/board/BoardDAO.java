package board;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    Connection con = null;
    String sql = null;
    PreparedStatement pr = null;
    ResultSet rs = null;

    public Connection getConnection() throws SQLException, ClassNotFoundException, NamingException {
        Context init = new InitialContext();
        DataSource dataSource = (DataSource) init.lookup("java:comp/env/jdbc/MysqlDB");
        con = dataSource.getConnection();
//        Class.forName("com.mysql.jdbc.Driver");
//        String dbUrl = "jdbc:mysql://localhost:3306/jspyj";
//        String dbUser = "testid";
//        String dbPass = "testpass";
//        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        return con;
    }

    public BoardBean getBoard(int num) {
        BoardBean bb = null;
        try{
            con = getConnection();

            sql = "select * from board where num = ?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, num);

            rs = pr.executeQuery();

            if(rs.next()) {
                bb = new BoardBean();
                bb.setNum(rs.getInt("num"));
                bb.setId(rs.getString("id"));
                bb.setPass(rs.getString("pass"));
                bb.setReadcount(rs.getInt("readcount"));
                bb.setDate(rs.getTimestamp("date"));
                bb.setTitle(rs.getString("title"));
                bb.setContent(rs.getString("content"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
        return bb;
    }

    public List getBoardList() {
        List boardList = new ArrayList();
        try {
            con = getConnection();

            sql = "select * from board order by num desc";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();

            while(rs.next()) {
                BoardBean bb = new BoardBean();
                bb.setNum(rs.getInt("num"));
                bb.setId(rs.getString("id"));
                bb.setPass(rs.getString("pass"));
                bb.setTitle(rs.getString("title"));
                bb.setContent(rs.getString("content"));
                bb.setReadcount(rs.getInt("readcount"));
                bb.setDate(rs.getTimestamp("date"));

                boardList.add(bb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
        return boardList;

    }

    public List getBoardList(int startRow, int pageSize) {
        List boardList = new ArrayList();
        try {
            con = getConnection();

            sql = "select * from board order by num desc limit ?,?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, startRow-1);
            pr.setInt(2, pageSize);
            rs = pr.executeQuery();

            while (rs.next()) {
                BoardBean boardBean = new BoardBean();
                boardBean.setNum(rs.getInt("num"));
                boardBean.setId(rs.getString("id"));
                boardBean.setPass(rs.getString("pass"));
                boardBean.setTitle(rs.getString("title"));
                boardBean.setContent(rs.getString("content"));
                boardBean.setReadcount(rs.getInt("readcount"));
                boardBean.setDate(rs.getTimestamp("date"));

                boardList.add(boardBean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
        return boardList;

    }

    public void insertBoard(BoardBean bb) {
        try {
            con = getConnection();

            sql = "select max(num) from board";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();

            int num=0;
            if(rs.next()) {
                num = rs.getInt("max(num)")+1;
            }

            String sql2 = "insert into board(num, id, pass, title, content, readcount, date) " +
                    "values(?, ?, ?, ?, ?, ?, ?)";
            pr = con.prepareStatement(sql2);

            pr.setInt(1, num);
            pr.setString(2, bb.getId());
            pr.setString(3, bb.getPass());
            pr.setString(4, bb.getTitle());
            pr.setString(5, bb.getContent());
            pr.setInt(6, bb.getReadcount());
            pr.setTimestamp(7, bb.getDate());

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

            sql = "update board set readcount=readcount+1 where num=?";
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

    public void updateBoard(BoardBean bb) {
        try {
            con = getConnection();

            sql = "update board set title=?, content=?, date=? where num=?";
            pr = con.prepareStatement(sql);

            pr.setString(1, bb.getTitle());
            pr.setString(2, bb.getContent());
            pr.setTimestamp(3, bb.getDate());
            pr.setInt(4, bb.getNum());

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(rs != null) try {rs.close();} catch(SQLException exception) {}
            if(pr != null) try {pr.close();} catch(SQLException exception) {}
            if(con != null) try {con.close();} catch(SQLException exception) {}
        }
    }

    public void deleteBoard(int num, String id) {
        try {
            con = getConnection();

            sql = "DELETE FROM board WHERE num=? and id = ?";
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

    public int getBoardCount() {
        int count = 0;
        try {
            con = getConnection();
            sql = "SELECT count(*) FROM board";
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

    public int getBoardReplyCount(int brdno) {
        int count = 0;
        try {
            con = getConnection();
            sql = "SELECT count(reno) FROM board_reply WHERE brdno = ?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, brdno);
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
