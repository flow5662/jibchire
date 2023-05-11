package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Bachi_info;
import dto.Bachi_market;
import dto.Gosu_market;
import dto.Bachi_product;


public class Gosu_mark {
	
	Connection conn = null;
	Statement stmt = null;
	Bachi_info bachi_info = new Bachi_info();
	Bachi_product bachi_product = new Bachi_product();
	
	
	void conn() {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/interior?useUnicode=true&characterEncoding=utf8","root","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void diconn() {
		try {
			 conn.close();
			 stmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void gosu_pro_add(Bachi_product gosu_pro_add){ //입력
		//게시글 작성

		try{
			this.conn();
			if(conn == null)
					throw new Exception("데이터베이스에 접근할 수 없습니다.");			
			// select
			stmt = conn.createStatement();
			String command = String.format("insert into gosu_product(cust_id,gosu_text,gosu_price)"+"values('%s','%s',%s);",
				gosu_pro_add.getCust_id(),gosu_pro_add.getGosu_text(),gosu_pro_add.getGosu_price());
				//gosu_info 
			int rowNum = stmt.executeUpdate(command);
			
			if(rowNum < 1)
				throw new Exception("데이터베이스에 접근할 수 없습니다.");
	
			
			this.diconn();
			}catch(Exception ignored) {
				ignored.printStackTrace();
			}
	
	}
	
	
	public ArrayList<Bachi_product> gosu_pro_sel(String cust_id){ 
		
		
		ArrayList<Bachi_product> pro_list = new ArrayList<Bachi_product>();
		try {
			this.conn();
			if(conn == null)
					throw new Exception("데이터베이스에 접근할 수 없습니다.");			
			// 상품에 대한 값
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select* from gosu_market where cust_id ='"+cust_id+"';");
			while(rs.next()){							
				//return 해야함
				Bachi_product gosu_pro = new Bachi_product();
				gosu_pro.setGosu_id(rs.getString("gosu_id"));
				gosu_pro.setCust_id(rs.getString("cust_id"));
				gosu_pro.setGosu_text(rs.getString("gosu_text"));
				gosu_pro.setGosu_price(rs.getString("gosu_price"));
				
				
				pro_list.add(gosu_pro);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}	
		return pro_list;
	}
	public void gosu_pro_del(String gosu_id) { 
		try {
			this.conn();
			if(conn == null)
				throw new Exception("데이터베이스를 사용할 수 없습니다.");
			stmt = conn.createStatement();
			stmt.executeUpdate("delete from gosu_product where gosu_id='"+gosu_id+"';");
			this.diconn();
		
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	public ArrayList<Bachi_market> gosu_mark_sel(){
	    ArrayList<Bachi_market> market_list = new ArrayList<Bachi_market>();

	    try{
	        this.conn();
	        if(conn == null)
	            throw new Exception("데이터베이스에 접근할 수 없습니다.");			

	        stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery("select market_id,gosu_market.cust_id,gosu_market.gosu_id,market_picture,market_text,market_title,gosu_menu1,gosu_menu2,gosu_price from gosu_product inner join gosu_market ON gosu_product.gosu_id = gosu_market.gosu_id;");

	        while(rs.next()){
	            Bachi_market mark = new Bachi_market();
	            
	        
	            // gosu_market 테이블의 데이터를 Gosu_market 객체에 저장
	            mark.setMarket_id(rs.getInt("market_id"));
	            mark.setCust_id(rs.getString("cust_id"));

	            mark.setGosu_id(rs.getString("gosu_id"));
	            mark.setMarket_picture(rs.getString("market_picture"));
	            mark.setMarket_text(rs.getString("market_text"));
	            mark.setMarket_title(rs.getString("market_title"));
	            mark.setGosu_menu1(rs.getString("gosu_menu1"));
				mark.setGosu_menu2(rs.getString("gosu_menu2"));
	            // gosu_product 테이블의 데이터를 Gosu_product 객체에 저장
	            mark.setGosu_price(rs.getString("gosu_price"));
	            
	            // 두 객체를 함께 ArrayList에 추가
	            market_list.add(mark);
	        }
	        this.diconn();
	    } catch(Exception ignored) {
	        ignored.printStackTrace();
	    }

	    return market_list;
	}

	
	
	public ArrayList<Bachi_market> gosu_mark_sel_custom(String serch_id,String serch_title,String serch_text){
		
		
		ArrayList<Bachi_market> market_list = new ArrayList<Bachi_market>();
		
		
		try{
			this.conn();
			if(conn == null)
					throw new Exception("데이터베이스에 접근할 수 없습니다.");			
			
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select market_id,gosu_market.cust_id,gosu_market.gosu_id,market_picture,market_text,market_title,gosu_menu1,gosu_menu2,gosu_price from gosu_market inner join gosu_product on gosu_market.gosu_id = gosu_product.gosu_id where gosu_market.cust_id like '%"+serch_id+"%' or market_title like '%"+serch_title+"%' or market_text like'%"+serch_text+"%';");
			while(rs.next()){
				
				Bachi_market mark = new Bachi_market();
				mark.setMarket_id(rs.getInt("market_id"));
				mark.setCust_id(rs.getString("cust_id"));
				mark.setGosu_id(rs.getString("gosu_id"));
				mark.setMarket_picture(rs.getString("market_picture"));
				mark.setMarket_text(rs.getString("market_text"));
				mark.setMarket_title(rs.getString("market_title"));
				mark.setGosu_price(rs.getString("gosu_price"));
				mark.setGosu_menu1(rs.getString("gosu_menu1"));
				mark.setGosu_menu2(rs.getString("gosu_menu2"));
				
				market_list.add(mark);
			}
			this.diconn();
			}catch(Exception ignored) {
				ignored.printStackTrace();
			}

		return market_list;
		}	
	
	public ArrayList<Bachi_market> gosu_mark_sel_det(int market_id){
		// 상세 페이지
		
		ArrayList<Bachi_market> market_list_cust = new ArrayList<Bachi_market>();
		
		
		try{
			this.conn();
			if(conn == null)
					throw new Exception("데이터베이스에 접근할 수 없습니다..");			
			
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select market_id,gosu_market.cust_id,gosu_market.gosu_id,market_picture,market_text,market_title,gosu_menu1,gosu_menu2,gosu_price from gosu_product inner join gosu_market on gosu_product.gosu_id = gosu_market.gosu_id where market_id="+market_id);
			while(rs.next()){
			
				Bachi_market mark = new Bachi_market();
				
				
				mark.setMarket_id(rs.getInt("market_id"));
				mark.setCust_id(rs.getString("cust_id"));
				mark.setGosu_id(rs.getString("gosu_id"));
				mark.setMarket_picture(rs.getString("market_picture"));
				mark.setMarket_text(rs.getString("market_text"));
				mark.setMarket_title(rs.getString("market_title"));
				mark.setGosu_menu1(rs.getString("gosu_menu1"));
				mark.setGosu_menu2(rs.getString("gosu_menu2"));
				mark.setGosu_price(rs.getString("gosu_price"));
				
				market_list_cust.add(mark);
			}
			this.diconn();
			}catch(Exception ignored) {
				ignored.printStackTrace();
			}

		return market_list_cust;
		}	
	
	public void gosu_mark_add(Bachi_market gosu_mark_add){


		try{
			this.conn();
			if(conn == null)
					throw new Exception("데이터베이스에 접근할 수 없습니다.");			
			
			stmt = conn.createStatement();
			String command = String.format("insert into gosu_market(cust_id,gosu_id,market_picture,market_text,market_title,gosu_menu1,gosu_menu2) values('%s',%s,'%s','%s','%s','%s','%s');",
					gosu_mark_add.getCust_id(),gosu_mark_add.getGosu_id(),gosu_mark_add.getMarket_picture(),gosu_mark_add.getMarket_text(),gosu_mark_add.getMarket_title(),gosu_mark_add.getGosu_menu1(),gosu_mark_add.getGosu_menu2());
				
			int rowNum = stmt.executeUpdate(command);
			
			if(rowNum < 1)
				throw new Exception("DB에 연결할 수 없습니다.");
	
			
			this.diconn();
			}catch(Exception ignored) {
				ignored.printStackTrace();
			}
	
	}
	public void gosu_mark_update(Bachi_market gosu_mark_update){ 
		

		try{
			this.conn();
			if(conn == null)
					throw new Exception("데이터베이스에 접근할 수 없습니다.");			
			
			stmt = conn.createStatement();
			String command = String.format("update gosu_market set gosu_id=%s,market_picture='%s',market_text='%s',market_title='%s',gosu_menu1='%s',gosu_menu2='%s'where market_id = %s",
					gosu_mark_update.getGosu_id(),gosu_mark_update.getMarket_picture(),gosu_mark_update.getMarket_text(),gosu_mark_update.getMarket_title(),gosu_mark_update.getGosu_menu1(),gosu_mark_update.getGosu_menu2(),gosu_mark_update.getMarket_id());
			
			int rowNum = stmt.executeUpdate(command);
			
			if(rowNum < 1)
				throw new Exception("데이터베이스에 접근할 수 없습니다.");
	
			
			this.diconn();
			}catch(Exception ignored) {
				ignored.printStackTrace();
			}
	
	}
	
	
	public void gosu_mark_del(int market_id) {
	    try {
	        this.conn();
	        if(conn == null)
	            throw new Exception("데이터베이스에 접근할 수 없습니다.");
	        stmt = conn.createStatement();
	        stmt.executeUpdate("delete from gosu_market where market_id="+ market_id);
	        
	        this.diconn();

	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}

	
	
	
	
	
	

}
