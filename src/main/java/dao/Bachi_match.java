package dao;
import static db.JdbcUtil.*;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import javax.sql.DataSource;

import dto.Bachi_match_Been;


public class Bachi_match {
	DataSource ds;
	Connection con;
	private static Bachi_match bachi_match;
	
	public static Bachi_match getInstance() {
		if(bachi_match == null) {
			bachi_match = new Bachi_match();
		}
		return bachi_match;
	}
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	public int insertArticle(Bachi_match_Been article) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "";
	    int insertCount = 0;

	    try {
	        pstmt = con.prepareStatement("select max(est_id) from gosu_req");
	        rs = pstmt.executeQuery();

	        sql = "insert into gosu_req(cust_id,gosu_menu1,gosu_menu2,est_q1,est_q2,est_q3) values(?,?,?,?,?,?)";
	        System.out.println("dfsdf");
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, article.getCust_id());
	        pstmt.setString(2, article.getGosu_menu1());
	        pstmt.setString(3, article.getGosu_menu2());
	        pstmt.setString(4,article.getEst_q1());       
	        pstmt.setString(5,article.getEst_q2());
	        pstmt.setString(6,article.getEst_q3());

	        
	     insertCount=pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return insertCount;
	}

	
}
