package board;

import java.sql.Timestamp;

public class BoardReplyBean {
    private int brdno;           // 게시물 번호
    private int reno;            // 댓글 번호
    private String rewriter;        // 작성자
    private String rememo;          // 댓글 내용
    private Timestamp redate;          // 작성 일자

    public int getBrdno() {
        return brdno;
    }

    public void setBrdno(int brdno) {
        this.brdno = brdno;
    }

    public int getReno() {
        return reno;
    }

    public void setReno(int reno) {
        this.reno = reno;
    }

    public String getRewriter() {
        return rewriter;
    }

    public void setRewriter(String rewriter) {
        this.rewriter = rewriter;
    }

    public String getRememo() {
        return rememo;
    }

    public void setRememo(String rememo) {
        this.rememo = rememo;
    }

    public Timestamp getRedate() {
        return redate;
    }

    public void setRedate(Timestamp redate) {
        this.redate = redate;
    }
}
