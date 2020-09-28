package board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardReplyDAO {
    Connection con;
    String sql;
    PreparedStatement pr;
    ResultSet rs;

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        con = null;

        Class.forName("com.mysql.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/jspyj";
        String dbUser = "testid";
        String dbPass = "testpass";
        con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        return con;
    }

    public BoardReplyBean getBoardReply(int reno) {
        BoardReplyBean brb = null;
        try{
            con = getConnection();

            sql = "select * from board_reply where reno = ?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, reno);

            rs = pr.executeQuery();

            if(rs.next()) {
                brb = new BoardReplyBean();
                brb.setBrdno(rs.getInt("brdno"));
                brb.setReno(rs.getInt("reno"));
                brb.setRememo(rs.getString("rememo"));
                brb.setRewriter(rs.getString("rewriter"));
                brb.setRedate(rs.getTimestamp("redate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return brb;
    }

    public List getBoardReplyList() {
        List boardReplyList = new ArrayList();
        try {
            con = getConnection();

            sql = "select * from board_reply order by reno";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();

            while(rs.next()) {
                BoardReplyBean brb = new BoardReplyBean();
                brb.setBrdno(rs.getInt("brdno"));
                brb.setReno(rs.getInt("reno"));
                brb.setRewriter(rs.getString("rewriter"));
                brb.setRedate(rs.getTimestamp("redate"));
                brb.setRememo(rs.getString("rememo"));

                boardReplyList.add(brb);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return boardReplyList;

    }

    public void insertBoardReply(BoardReplyBean brb) {
        try{
            con = getConnection();

            sql="select max(reno) from board_reply";
            pr = con.prepareStatement(sql);
            rs = pr.executeQuery();

            int num=0;
            if(rs.next()) {
                num = rs.getInt("max(reno)")+1;
            }

            sql = "INSERT INTO board_reply(brdno, reno, rewriter, rememo, redate)" +
                    "values(?, ?, ?, ?, ?)";
            pr = con.prepareStatement(sql);
            pr.setInt(1, brb.getBrdno());
            pr.setInt(2, num);
            pr.setString(3, brb.getRewriter());
            pr.setString(4, brb.getRememo());
            pr.setTimestamp(5, brb.getRedate());

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateBoardReply(BoardReplyBean brb) {
        try{
            con = getConnection();

            sql = "UPDATE board_reply SET rememo = ? WHERE reno = ? and rewriter = ?";
            pr = con.prepareStatement(sql);
            pr.setString(1, brb.getRememo());
            pr.setInt(2, brb.getReno());
            pr.setString(3, brb.getRewriter());

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteBoardReply(int reno, String rewriter) {
        try{
            con = getConnection();

            sql = "DELETE FROM board_reply WHERE reno=? and rewriter=?";
            pr = con.prepareStatement(sql);
            pr.setInt(1, reno);
            pr.setString(2, rewriter);

            pr.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
