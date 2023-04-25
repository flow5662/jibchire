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
	    PreparedStatement pstmt = null; //SQL문에 매핑
	    ResultSet rs = null;

	    String sql = "";
	    int insertCount = 0;

	    try {
	        pstmt = con.prepareStatement("select max(est_id) from gosu_req"); //사실상 autoincrement인 key값이기때문에, 필요없는 코드.
	        rs = pstmt.executeQuery();

	        sql = "insert into gosu_req(cust_id,gosu_menu1,gosu_menu2,est_q1,est_q2,est_q3) values(?,?,?,?,?,?)";
	        //System.out.println("dfsdf");
	        pstmt = con.prepareStatement(sql); //sql문 실행할 객체
	        pstmt.setString(1, article.getCust_id()); //각각의 values의 값들 input
	        pstmt.setString(2, article.getGosu_menu1());
	        pstmt.setString(3, article.getGosu_menu2());
	        pstmt.setString(4,article.getEst_q1());       
	        pstmt.setString(5,article.getEst_q2());
	        pstmt.setString(6,article.getEst_q3());

	        
	     insertCount=pstmt.executeUpdate(); // SQL문을 실행하고, 삽입된 행의 개수를 insertCount 변수에 저장합니다.
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return insertCount; //삽입된 행의 개수를 반환
	}

	public ArrayList<Bachi_match_Been> selectMatchReq(){
		 PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    String sql = "select * from gosu_req";
		 ArrayList<Bachi_match_Been> match_been = new ArrayList<Bachi_match_Been>();
		
		 try {
			 pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
			 
				while(rs.next()){
					Bachi_match_Been been = new Bachi_match_Been(); //삽입할 객체 생성
				
					
//					been = new Bachi_match_Been();
					been.setEst_id(rs.getInt("est_id")); //객체에 select한 값 담기
					been.setCust_id(rs.getString("cust_id"));
					been.setEst_q1(rs.getString("est_q1"));
					been.setEst_q2(rs.getString("est_q2"));
					been.setEst_q3(rs.getString("est_q3"));
					been.setGosu_menu1(rs.getString("gosu_menu1"));
					been.setGosu_menu2(rs.getString("gosu_menu2"));
					been.setEst_q_date(rs.getString("est_q_date"));

					match_been.add(been); //ArrayList에 담기
				
				}
			 
			 
		 }catch(Exception e){
			 e.printStackTrace();
		 }finally{
				close(rs);
				close(pstmt); //sql 닫기
			}
		 
		return match_been; //프론트 화면에 보낼 ArrayList 반환하기
	}
	
	
	
}
