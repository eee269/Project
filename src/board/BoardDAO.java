package board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection con = null;

        Class.forName("com.mysql.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/jspyj";
        String dbUser = "testid";
        String dbPass = "testpass";
        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        return con;
    }

    public BoardBean getBoard(int num) {
        BoardBean bb = null;
        try{
            Connection con = getConnection();

            String sql = "select * from board where num = ?";
            PreparedStatement pr = con.prepareStatement(sql);
            pr.setInt(1, num);

            ResultSet rs = pr.executeQuery();

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
        }
        return bb;
    }

    public List getBoardList() {
        List boardList = new ArrayList();
        try {
            Connection con = getConnection();

            String sql = "select * from board order by num desc";
            PreparedStatement pr = con.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();

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
        }
        return boardList;

    }

    public void insertBoard(BoardBean bb) {
        try {
            Connection con = getConnection();

            String sql = "select max(num) from board";
            PreparedStatement pr = con.prepareStatement(sql);
            ResultSet rs = pr.executeQuery();

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
        }
    }

    public void updateReadcount(int num) {
        try {
            Connection con = getConnection();

            String sql = "update board set readcount=readcount+1 where num=?";
            PreparedStatement pr = con.prepareStatement(sql);
            pr.setInt(1, num);

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateBoard(BoardBean bb) {
        try {
            Connection con = getConnection();

            String sql = "update board set title=?, content=?, date=? where num=?";
            PreparedStatement pr = con.prepareStatement(sql);

            pr.setString(1, bb.getTitle());
            pr.setString(2, bb.getContent());
            pr.setTimestamp(3, bb.getDate());
            pr.setInt(4, bb.getNum());

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
