package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

import dto.Cust_info;
import dto.Gosu_info;
import dto.Gosu_product;


public class Gosu_ch {

		Connection conn = null;
		Statement stmt = null;
		Gosu_info bachi_info = new Gosu_info();
		
		void conn() {
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/interior","root","1234");
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
		public void gosu_ch(Gosu_info bachi_add) { 
			

			try{
				this.conn();
				if(conn == null)
						throw new Exception("");			
				
				stmt = conn.createStatement();
				String command = String.format("insert into student values "+"('%s','%s','%s',%s,'%s','%s','%s','%s','%s');",
					bachi_add.getCust_id(),bachi_add.getGosu_menu1(),bachi_add.getGosu_menu2(),bachi_add.getGosu_intro(),bachi_add.getGosu_car(),bachi_add.getGosu_comp(),bachi_add.getWorktime_s(),bachi_add.getWorktime_e());
					
				int rowNum = stmt.executeUpdate(command);
				
				if(rowNum < 1)
					throw new Exception("�����͸� DB�� �Է��� �� �����ϴ�.");
			
				
				
				this.diconn();
				}catch(Exception ignored) {
					ignored.printStackTrace();
				}
		}
		
		public void gosu_login(String cust_id,String cust_pw) {
			try{
				this.conn();
				if(conn == null)
						throw new Exception("데이터베이스에 접근할 수 없습니다.");
					stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery("select* from cust_info where cust_id='"+cust_id+"' and cust_pw='"+cust_pw+"';");
				
					if(rs.next()){							
						
						Cust_info cust = new Cust_info();
						cust.setCust_id(cust_id);
						cust.setCust_pw(cust_pw);
						
					}
					this.diconn();
		}catch(Exception e) {
			e.printStackTrace();
		}
	
	}
		
}
