package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Used_post;

public class Used_dao {
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	public Used_dao() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}catch(Exception e) {
			System.out.println("DB전체연결오류 : " + e);
		}
	}
	
	void db_conn() {
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/interior?useUnicode=true&characterEncoding=utf8", "root", "1111");
		}catch(Exception e) {
			System.out.println("DBConn오류 : " + e);
		}
	}
	
	void db_close() {
		try {
			stmt.close();
			conn.close();
		}catch(Exception e) {
			System.out.println("DBClose오류 : " + e);
		}
		
	}
	
	//게시글 입력
	public void insert(String usedType, int usedIdParam, String custId, String usedRegdate, String usedTitle, String usedPicture, String usedContent) {
		db_conn();
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate("insert into used_post(used_type, used_id, cust_id, used_regdate, used_title, used_picture, used_content)"
			+"values('"+usedType+"', "+usedIdParam+", '"+custId+"', '"+usedRegdate+"', '"+usedTitle+"', '"+usedPicture+"', '"+usedContent+"');");
		}catch(Exception e) {
			System.out.println("Insert예외처리 : " + e);
		}finally {
			try {
				db_close();
			}catch(Exception ignored) {
				System.out.println("Insert 완전 예외처리 : " + ignored);
			}
		}
	}
	
	//게시글 리스트
	public ArrayList<Used_post> select() {
		db_conn();
		ArrayList<Used_post> list = new ArrayList<>();
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from used_post;");
			
			while(rs.next()) {
				Used_post ud = new Used_post();
				
				ud.setUsed_type(rs.getString("used_type"));
				ud.setUsed_id(rs.getInt("used_id"));
				ud.setCust_id(rs.getString("cust_id"));
				ud.setUsed_regdate(rs.getString("used_regdate"));
				ud.setUsed_title(rs.getString("used_title"));
				ud.setUsed_picture(rs.getString("used_picture"));
				ud.setUsed_content(rs.getString("used_content"));
				
				list.add(ud);
			}
		}catch(Exception e) {
			System.out.println("Select예외처리 : " + e);
		}finally{
			try{
				db_close();
		     }catch (Exception ignored){
		    	System.out.println("Select 완전 예외처리 : " + ignored);
		     }
		}return list;
	}
	
	//게시글 삭제
	public void delete(String usedId) {
		db_conn();
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate("delete from used_post where used_id ='" + usedId +"';");
			
		}catch(Exception e) {
			System.out.println("Delete예외처리 : " + e);
		}finally {
			try {
				db_close();
			}catch(Exception ignored) {
				System.out.println("Delete 완전 예외처리 : " + ignored);
			}
		}
	}
	
	//게시글 수정
	public ArrayList<Used_post> update(String usedType, String usedTitle, String usedPicture, String usedContent, int usedId) {
		db_conn();
		ArrayList<Used_post> list = new ArrayList<>();
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate("update used_post set used_type='"+usedType+"', used_title='"+usedTitle
								+"', used_picture='"+usedPicture+"', used_content='"+usedContent+"' where used_id="+usedId+";");
		}catch(Exception e) {
			System.out.println("Update예외처리 : " + e);
		}finally {
			try {
				db_close();
			}catch(Exception ignored) {
				System.out.println("Update 완전 예외처리 : " + ignored);
			}
		}
		return list;
	}
	
	//게시글 내용 아이디 or 제목+내용 검색
	public ArrayList<Used_post> search(String searchSelect, String searchText) {
		db_conn();
		ArrayList<Used_post> list = new ArrayList<>();
		try {
			String sql = "select * from used_post";
			
			if(searchText != null && !searchText.equals("") && searchSelect.equals("all")) {
				sql += " where cust_id like '%" + searchText + "%'"
						+" or used_title like '%" + searchText + "%'"
						+" or used_content like '%" + searchText + "%' order by used_type limit 10;";
			}else if(searchText != null && !searchText.equals("") && searchSelect.equals("id")) {
			    sql += " where cust_id like '%" + searchText + "%' order by cust_id limit 10;";
			}else if(searchText != null && !searchText.equals("") && searchSelect.equals("title")) {
			    sql += " where used_title like '%" + searchText + "%' order by used_title limit 10;";
			}else if(searchText != null && !searchText.equals("") && searchSelect.equals("content")) {
			    sql += " where used_content like '%" + searchText + "%' order by used_content limit 10;";
			}
			/*
			else if(searchSelect.equals("tc")) {
			    sql += " like '%" + searchText + "%' or "+searchSelect+" like '%" + searchText + "%' order by cust_id desc limit 10;";
			}
			*/
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				Used_post ud = new Used_post();
				
				ud.setUsed_type(rs.getString("used_type"));
				ud.setUsed_id(rs.getInt("used_id"));
				ud.setCust_id(rs.getString("cust_id"));
				ud.setUsed_regdate(rs.getString("used_regdate"));
				ud.setUsed_title(rs.getString("used_title"));
				ud.setUsed_picture(rs.getString("used_picture"));
				ud.setUsed_content(rs.getString("used_content"));
				
				list.add(ud);
			}
		}catch(Exception e) {
			System.out.println("Search예외처리 : " + e);
		}finally {
			try {
				db_close();
			}catch(Exception ignored) {
				System.out.println("Search 완전 예외처리 : " + ignored);
			}
		}return list;
	}
}
