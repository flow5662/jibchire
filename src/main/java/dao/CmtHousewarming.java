package dao;

import static db.JdbcUtil.close;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Cust_houseinfo;
import dto.Feed_like;
import dto.Post_bookmark;
import dto.Post_house;

public class CmtHousewarming {
	Connection conn = null;
	Statement stmt = null;
	Post_house po = new Post_house();
	ArrayList<Post_house> alist = new ArrayList<Post_house>(); 
	
	public CmtHousewarming() { //라이브러리 접근하기
		try {
			Class.forName("com.mysql.jdbc.Driver");   			 // 드라이버 작업할거야? 라이브러리 불러오겠음 ! 라이브러리 불러오는 건 이 프로젝트 전체에 한 번만 부르면 된다
		}catch(Exception e){
			System.out.println(e+"라이브러리 연결실패");
		}	
	}
	public void conn() {  // 커넥하는 동작
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/interior?useUnicode=true&characterEncoding=utf8","root","1111"); 
		}catch(Exception e){
			System.out.println(e+"커넥션 연결실패");		
		}
	}
	public void disconn() { // 커넥션, statement 닫기
		try {
			stmt.close();
			conn.close();
		}catch(Exception e) {
			System.out.println(e+"커넥션 닫기 실패");
		}
	}
	public Post_house select_one(int num) { // 게시글 하나 읽는 페이지 
		try {
			conn();
			stmt = conn.createStatement();
			String select = "select*from post_house where post_id ="+num+";";
			ResultSet rs = stmt.executeQuery(select);  //메소드 안에 아직 조건문 넣지 않았음
			if(rs.next()) {
				po.setPost_id(rs.getInt("post_id"));
				po.setCust_id(rs.getString("cust_id"));
				po.setPost_title(rs.getString("post_title"));
				po.setPost_txt(rs.getString("post_txt"));
				po.setPost_house(rs.getString("post_house"));
				
				po.setPost_rooms(rs.getInt("post_rooms"));
				po.setPost_m2(rs.getInt("post_m2"));
				po.setPost_fam(rs.getInt("post_fam"));
				po.setPost_houseold(rs.getInt("post_houseold"));
				po.setPost_budget(rs.getInt("post_budget"));
				
				po.setPost_family(rs.getString("post_family"));
				po.setPost_direc(rs.getString("post_direc"));
				po.setPost_region(rs.getString("post_region"));
				po.setPost_pet(rs.getString("post_pet"));
				po.setPost_startdate(rs.getString("post_startdate"));
				po.setPost_enddate(rs.getString("post_enddate"));
				//po.setPost_pics(rs.getString("post_pics"));
				po.setPost_style(rs.getString("post_style"));
				po.setPost_color(rs.getString("post_color"));
				String feed_pics = rs.getString("post_pics");
				String [] filename = feed_pics.split(",");
				po.setPost_pics(filename[0]);
				po.setPost_pic2(filename[1]);
				po.setPost_pic3(filename[2]);
				po.setPost_pic4(filename[3]);
				po.setPost_writetime(rs.getString("post_writetime"));
			}
			
		}catch(Exception e) {
			System.out.println(e+"select_one() 메소드 오류");
		}finally {
			disconn();
		}
		return po;
	}
	public ArrayList<Post_house> selectArticleList(int page,int limit) { // 게시글 메인화면
		try {
			conn();
			stmt = conn.createStatement();
			int startrow=(page-1)*9; 
			//1페이지는 0~7번(8개), 2페이지는 8~15번(8개), 3페이지는 16~23번(8개)
			String select = "select*from post_house order by post_writetime desc limit "+startrow+",9;";
			ResultSet rs = stmt.executeQuery(select);  
			while(rs.next()) {
				Post_house po = new Post_house();
				
				po.setPost_id(rs.getInt("post_id"));
				po.setCust_id(rs.getString("cust_id"));
				po.setPost_title(rs.getString("post_title"));
				po.setPost_txt(rs.getString("post_txt"));
				po.setPost_txt2(rs.getString("post_txt2"));
				po.setPost_txt3(rs.getString("post_txt3"));
				po.setPost_txt4(rs.getString("post_txt4"));
				po.setPost_house(rs.getString("post_house"));
				
				po.setPost_rooms(rs.getInt("post_rooms"));
				po.setPost_m2(rs.getInt("post_m2"));
				po.setPost_fam(rs.getInt("post_fam"));
				po.setPost_houseold(rs.getInt("post_houseold"));
				po.setPost_budget(rs.getInt("post_budget"));
				
				po.setPost_family(rs.getString("post_family"));
				po.setPost_direc(rs.getString("post_direc"));
				po.setPost_region(rs.getString("post_region"));
				po.setPost_pet(rs.getString("post_pet"));
				po.setPost_startdate(rs.getString("post_startdate"));
				po.setPost_enddate(rs.getString("post_enddate"));
				//po.setPost_pics(rs.getString("post_pics"));
				po.setPost_style(rs.getString("post_style"));
				po.setPost_color(rs.getString("post_color"));
				
				String feed_pics = rs.getString("post_pics");
				String [] filename = feed_pics.split(",");
				po.setPost_pics(filename[0]);
				po.setPost_pic2(filename[1]);
				po.setPost_pic3(filename[2]);
				po.setPost_pic4(filename[3]);
				po.setPost_writetime(rs.getString("post_writetime"));
				//System.out.println("feed_pics=>"+feed_pics);

				System.out.println("filename[0] =>"+filename[0]);
				System.out.println("filename[1] =>"+filename[1]);
				System.out.println("filename[2] =>"+filename[2]);
				System.out.println("filename[3] =>"+filename[3]);

				alist.add(po);
			}
		}catch(Exception e) {
			System.out.println(e+"selectArticleList() 메소드 오류");
		}finally {
			disconn();
		}
		return alist;
	}
	public ArrayList<Post_house> selectLoginArticleList(int page,int limit,String cust_id) { // 로그인 후 북마크 정보까지 가지고 오기
		try {
			conn();
			stmt = conn.createStatement();
			int startrow=(page-1)*9; 
			//1페이지는 0~7번(8개), 2페이지는 8~15번(8개), 3페이지는 16~23번(8개)
			String select = "select * from post_house left outer join post_bookmark on post_house.post_id= post_bookmark.post_id and post_bookmark.cust_id='"+cust_id+"'"
					+ " order by post_writetime  desc limit "+startrow+",9;";
			ResultSet rs = stmt.executeQuery(select);  
			while(rs.next()) {
				Post_house po = new Post_house();
				
				po.setPost_id(rs.getInt("post_id"));
				po.setCust_id(rs.getString("cust_id"));
				po.setPost_title(rs.getString("post_title"));
				po.setPost_txt(rs.getString("post_txt"));
				po.setPost_house(rs.getString("post_house"));
				
				po.setPost_rooms(rs.getInt("post_rooms"));
				po.setPost_m2(rs.getInt("post_m2"));
				po.setPost_fam(rs.getInt("post_fam"));
				po.setPost_houseold(rs.getInt("post_houseold"));
				po.setPost_budget(rs.getInt("post_budget"));
				
				po.setPost_family(rs.getString("post_family"));
				po.setPost_direc(rs.getString("post_direc"));
				po.setPost_region(rs.getString("post_region"));
				po.setPost_pet(rs.getString("post_pet"));
				po.setPost_startdate(rs.getString("post_startdate"));
				po.setPost_enddate(rs.getString("post_enddate"));
				//po.setPost_pics(rs.getString("post_pics"));
				po.setPost_style(rs.getString("post_style"));
				po.setPost_color(rs.getString("post_color"));
				
				String feed_pics = rs.getString("post_pics");
				String [] filename = feed_pics.split(",");
				po.setPost_pics(filename[0]);
				po.setPost_pic2(filename[1]);
				po.setPost_pic3(filename[2]);
				po.setPost_pic4(filename[3]);
				po.setPost_writetime(rs.getString("post_writetime"));
				po.setBookmark_time(rs.getString("bookmark_time"));
				System.out.println("feed_pics=>"+feed_pics);
				/* 실험
				System.out.println("filename[0] =>"+filename[0]);
				System.out.println("filename[1] =>"+filename[1]);
				System.out.println("filename[2] =>"+filename[2]);
				System.out.println("filename[3] =>"+filename[3]);
				*/
				alist.add(po);
			}
		}catch(Exception e) {
			System.out.println(e+"selectArticleList() 메소드 오류");
		}finally {
			disconn();
		}
		return alist;
	}
	public int selectListCount() { //페이징을 위해 feed 테이블의 전체 행 수 구하기

		int listCount= 0;
		ResultSet rs = null;

		try{
			conn();
			stmt = conn.createStatement();
			String select =  "select count(*) from post_house;";
			rs = stmt.executeQuery(select);

			if(rs.next()){
				listCount=rs.getInt(1); //첫번째 값을 listCount에 넣어라 (어차피 하나의 값 밖에 없지만)
				System.out.println("listCount =>" +listCount);
			}
		}catch(Exception ex){

		}finally{
			disconn();
		}

		return listCount;
	}
	public void insert_board(Post_house po) { // 게시판에서 글 쓴 정보 넣기
		try {
			conn();
			stmt = conn.createStatement();
			String insert = String.format("insert into post_house (post_id,cust_id,post_title,post_txt,post_txt2,post_txt3,post_txt4,post_house,"
					+ "post_rooms,post_m2,post_fam,post_houseold,post_budget,post_family,post_direc,post_region,"
					+ "post_pet,post_startdate,post_enddate,post_pics,post_style,post_color,post_writetime)"
					+ "values(%s,'%s','%s','%s','%s',%s,%s,%s,%s,%s,'%s','%s','%s','%s','%s','%s','%s','%s','%s',now());", "default",
					po.getCust_id(),po.getPost_title(),po.getPost_txt(),po.getPost_txt2(),po.getPost_txt3(),po.getPost_txt4(),po.getPost_house(),
					po.getPost_rooms(),po.getPost_m2(),po.getPost_fam(),po.getPost_houseold(),po.getPost_budget(),
					po.getPost_family(),po.getPost_direc(),po.getPost_region(),po.getPost_pet(),po.getPost_startdate(),
					po.getPost_enddate(),po.getPost_pics(),po.getPost_style(),po.getPost_color());
			stmt.executeUpdate(insert);	
		}catch(Exception e){
			System.out.println(e+"insert_board() 메소드에서 오류남");
			
		}finally {
			disconn();
		}		
	}
	public void update_board(Post_house po) { //게시글 수정하는 메소드 
		try {
			conn();
			stmt = conn.createStatement();
			String update = "update post_house set post_title='"+po.getPost_title()+"', post_txt='"+po.getPost_txt()+"',"
					+"post_house='"+po.getPost_house()+"',"+"post_rooms="+po.getPost_rooms()+","+"post_m2="+po.getPost_m2()+","
					+"post_fam="+po.getPost_fam()+","+"post_houseold="+po.getPost_houseold()+","+"post_budget="+po.getPost_budget()+","
					+"post_family='"+po.getPost_family()+"',"+"post_direc='"+po.getPost_direc()+"',"+"post_region='"+po.getPost_region()+"',"
					+"post_pet='"+po.getPost_pet()+"',"+"post_startdate='"+po.getPost_startdate()+"',"+"post_enddate='"+po.getPost_enddate()+"',"
					+"post_pics='"+po.getPost_pics()+"',"+"post_style='"+po.getPost_style()+"',"+"post_color='"+po.getPost_color()+"'"
					+"where post_id="+po.getPost_id()+";";
			stmt.executeUpdate(update);	
		}catch(Exception e){
			System.out.println(e+" update_board() 메소드에서 오류남");
			
		}finally {
			disconn();
		}
	}
	public void insert_houseinfo(Cust_houseinfo cust) { // 고객이 입력한 '집'에 대한 정보를 넣어놓는 테이블
		try {
			conn();
			stmt = conn.createStatement();
			String insert = String.format("insert into Cust_houseinfo (cust_id,cust_house,cust_room,cust_m2,"
					+ "cust_fam,cust_household,cust_family,cust_direc,cust_pet,cust_region"
					+ ") values('%s','%s',%s,%s,%s,%s,'%s','%s','%s','%s');", cust.getCust_id(),cust.getCust_house(),
					cust.getCust_room(),cust.getCust_m2(),cust.getCust_fam(),cust.getCust_houseold(),
					cust.getCust_family(),cust.getCust_direc(),cust.getCust_pet(),cust.getCust_region() );
			stmt.executeUpdate(insert);	
		}catch(Exception e){
			System.out.println(e+"insert_houseinfo() 메소드에서 오류남");
			
		}finally {
			disconn();
		}		
	}
	public void delete(int del) {
		try {
			conn();
			stmt = conn.createStatement();
			String delete = "delete from post_house where post_id ="+del;
			stmt.executeUpdate(delete);	
		}catch(Exception e){
			System.out.println(e+"delete() 메소드에서 오류남");
			
		}finally {
			disconn();
		}	
	}
	public int insertBook(Post_bookmark book){   //북마크 버튼 누르면 insert하는 메소드
		ResultSet rs = null;
		int num =0;
		String sql="";
		int insertCount=0;

		try{
			conn();
			stmt = conn.createStatement();
			sql="insert into Post_bookmark (post_id,cust_id,bookmark_time) values("+book.getPost_id()+",'"+book.getCust_id()+"',now())";
			System.out.println("insertHeart() 수행중"); 

			insertCount=stmt.executeUpdate(sql); //수행하면 insertCount=1

		}catch(Exception ex){
			System.out.println(ex+"=> insertHeard에서 오류");
		}finally{
			disconn();
		}

		return insertCount;

	}
	public Boolean selectBook(Post_bookmark book){  // 북마크 버튼 눌렀을 때 이미 눌렀는지 확인하는 메소드

		ResultSet rs = null;
		Boolean isSelectExist = false;

		try{
			conn();
			stmt = conn.createStatement();
			String select = "select * from Post_bookmark where post_id ="+book.getPost_id()+" and cust_id ='"+book.getCust_id()+"';";
			rs= stmt.executeQuery(select);

			if(rs.next()){
				System.out.println("북마크 결과있음=> 삭제해야함");
				isSelectExist=true;
			}
		}catch(Exception ex){
		}finally{
			disconn();
		}

		return isSelectExist;

	}
	public int deleteBook(Post_bookmark book){  // 북마크 버튼 이미 눌렀다면 삭제하는 메소드

		String delete_sql="delete from Post_bookmark where post_id ="+book.getPost_id()+" and cust_id ='"+book.getCust_id()+"';";
		int deleteCount=0;

		try{
			conn();
			stmt = conn.createStatement();
			deleteCount=stmt.executeUpdate(delete_sql);
		}catch(Exception ex){
		}	finally{
			disconn();
		}

		return deleteCount;
	}
	public ArrayList<Post_house> selectSearchList(int page,int limit,String field,String menuword) { // 검색결과화면 로그인 없는 버전
		try {
			conn();
			stmt = conn.createStatement();
			int startrow=(page-1)*9; 
			//1페이지는 0~7번(8개), 2페이지는 8~15번(8개), 3페이지는 16~23번(8개)
			String select = "select*from post_house where "+field+" like '%"+menuword+"%' order by post_writetime desc limit "+startrow+",9;";
			ResultSet rs = stmt.executeQuery(select);  
			while(rs.next()) {
				Post_house po = new Post_house();
				
				po.setPost_id(rs.getInt("post_id")); 
				po.setCust_id(rs.getString("cust_id"));
				po.setPost_title(rs.getString("post_title"));
				po.setPost_txt(rs.getString("post_txt"));
				po.setPost_house(rs.getString("post_house"));
				
				po.setPost_rooms(rs.getInt("post_rooms"));
				po.setPost_m2(rs.getInt("post_m2"));
				po.setPost_fam(rs.getInt("post_fam"));
				po.setPost_houseold(rs.getInt("post_houseold"));
				po.setPost_budget(rs.getInt("post_budget"));
				
				po.setPost_family(rs.getString("post_family"));
				po.setPost_direc(rs.getString("post_direc"));
				po.setPost_region(rs.getString("post_region"));
				po.setPost_pet(rs.getString("post_pet"));
				po.setPost_startdate(rs.getString("post_startdate"));
				po.setPost_enddate(rs.getString("post_enddate"));
				//po.setPost_pics(rs.getString("post_pics"));
				po.setPost_style(rs.getString("post_style"));
				po.setPost_color(rs.getString("post_color"));
				
				String feed_pics = rs.getString("post_pics");
				String [] filename = feed_pics.split(",");
				po.setPost_pics(filename[0]);
				po.setPost_pic2(filename[1]);
				po.setPost_pic3(filename[2]);
				po.setPost_pic4(filename[3]);
				po.setPost_writetime(rs.getString("post_writetime"));
				System.out.println("feed_pics=>"+feed_pics);
				/* 실험
				System.out.println("filename[0] =>"+filename[0]);
				System.out.println("filename[1] =>"+filename[1]);
				System.out.println("filename[2] =>"+filename[2]);
				System.out.println("filename[3] =>"+filename[3]);
				*/
				alist.add(po);
			}
		}catch(Exception e) {
			System.out.println(e+"selectArticleList() 메소드 오류");
		}finally {
			disconn();
		}
		return alist;
	}
	public ArrayList<Post_house> selectLoginSearchList(int page,int limit,String field, String menuword,String cust_id) { //검색결과 & 로그인 후 북마크 정보까지
		try {
			conn();
			stmt = conn.createStatement();
			int startrow=(page-1)*9; 
			//1페이지는 0~7번(8개), 2페이지는 8~15번(8개), 3페이지는 16~23번(8개)
			String select = "select * from post_house left outer join post_bookmark on post_house.post_id= post_bookmark.post_id and post_bookmark.cust_id='"+cust_id+"'"
					+ "where "+field+" like '%"+menuword+"%' order by post_writetime  desc limit "+startrow+",9;";
			ResultSet rs = stmt.executeQuery(select);  
			while(rs.next()) {
				Post_house po = new Post_house();
				
				po.setPost_id(rs.getInt("post_id"));
				po.setCust_id(rs.getString("cust_id"));
				po.setPost_title(rs.getString("post_title"));
				po.setPost_txt(rs.getString("post_txt"));
				po.setPost_house(rs.getString("post_house"));
				
				po.setPost_rooms(rs.getInt("post_rooms"));
				po.setPost_m2(rs.getInt("post_m2"));
				po.setPost_fam(rs.getInt("post_fam"));
				po.setPost_houseold(rs.getInt("post_houseold"));
				po.setPost_budget(rs.getInt("post_budget"));
				
				po.setPost_family(rs.getString("post_family"));
				po.setPost_direc(rs.getString("post_direc"));
				po.setPost_region(rs.getString("post_region"));
				po.setPost_pet(rs.getString("post_pet"));
				po.setPost_startdate(rs.getString("post_startdate"));
				po.setPost_enddate(rs.getString("post_enddate"));
				//po.setPost_pics(rs.getString("post_pics"));
				po.setPost_style(rs.getString("post_style"));
				po.setPost_color(rs.getString("post_color"));
				
				String feed_pics = rs.getString("post_pics");
				String [] filename = feed_pics.split(",");
				po.setPost_pics(filename[0]);
				po.setPost_pic2(filename[1]);
				po.setPost_pic3(filename[2]);
				po.setPost_pic4(filename[3]);
				po.setPost_writetime(rs.getString("post_writetime"));
				po.setBookmark_time(rs.getString("bookmark_time"));
				System.out.println("feed_pics=>"+feed_pics);
				/* 실험
				System.out.println("filename[0] =>"+filename[0]);
				System.out.println("filename[1] =>"+filename[1]);
				System.out.println("filename[2] =>"+filename[2]);
				System.out.println("filename[3] =>"+filename[3]);
				*/
				alist.add(po);
			}
		}catch(Exception e) {
			System.out.println(e+"selectArticleList() 메소드 오류");
		}finally {
			disconn();
		}
		return alist;
	}
	public ArrayList<Post_house> selectBookmarkList(int page,int limit,String cust_id) { // 북마크 페이지 모아보기
		try {
			conn();
			stmt = conn.createStatement();
			int startrow=(page-1)*9; 
			//1페이지는 0~7번(8개), 2페이지는 8~15번(8개), 3페이지는 16~23번(8개)
			String select = "select * from post_house left outer join post_bookmark on post_house.post_id= post_bookmark.post_id"
			+" where post_bookmark.cust_id='"+cust_id+"' order by post_writetime  desc limit "+startrow+",9";
			ResultSet rs = stmt.executeQuery(select);  
			while(rs.next()) {
				Post_house po = new Post_house();
				
				po.setPost_id(rs.getInt("post_id"));
				po.setCust_id(rs.getString("cust_id"));
				po.setPost_title(rs.getString("post_title"));
				po.setPost_txt(rs.getString("post_txt"));
				po.setPost_house(rs.getString("post_house"));
				
				po.setPost_rooms(rs.getInt("post_rooms"));
				po.setPost_m2(rs.getInt("post_m2"));
				po.setPost_fam(rs.getInt("post_fam"));
				po.setPost_houseold(rs.getInt("post_houseold"));
				po.setPost_budget(rs.getInt("post_budget"));
				
				po.setPost_family(rs.getString("post_family"));
				po.setPost_direc(rs.getString("post_direc"));
				po.setPost_region(rs.getString("post_region"));
				po.setPost_pet(rs.getString("post_pet"));
				po.setPost_startdate(rs.getString("post_startdate"));
				po.setPost_enddate(rs.getString("post_enddate"));
				//po.setPost_pics(rs.getString("post_pics"));
				po.setPost_style(rs.getString("post_style"));
				po.setPost_color(rs.getString("post_color"));
				
				String feed_pics = rs.getString("post_pics");
				String [] filename = feed_pics.split(",");
				po.setPost_pics(filename[0]);
				po.setPost_pic2(filename[1]);
				po.setPost_pic3(filename[2]);
				po.setPost_pic4(filename[3]);
				po.setPost_writetime(rs.getString("post_writetime"));
				po.setBookmark_time(rs.getString("bookmark_time"));
				System.out.println("feed_pics=>"+feed_pics);
				/* 실험
				System.out.println("filename[0] =>"+filename[0]);
				System.out.println("filename[1] =>"+filename[1]);
				System.out.println("filename[2] =>"+filename[2]);
				System.out.println("filename[3] =>"+filename[3]);
				*/
				alist.add(po);
			}
		}catch(Exception e) {
			System.out.println(e+"selectBookmarkList() 메소드 오류");
		}finally {
			disconn();
		}
		return alist;
	}

}
