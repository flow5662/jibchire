package svc;

import static db.JdbcUtil.*;
import java.sql.Connection;
import java.util.ArrayList;

import dao.CmtSns;
import dto.Cust_houseinfo;
import dto.Feed;

public class MyRecommendListService {
	
	public Cust_houseinfo getcustinfo(String cust_id) throws Exception{
		//db커넥과 객체 초기화
		Connection con = getConnection();
		CmtSns sns = CmtSns.getInstance();
		sns.setConnection(con);  
		Cust_houseinfo houseinfo = sns.selectCustinfo(cust_id);
		
		return houseinfo;
	}
	
	public void gethouseinfo(Cust_houseinfo houseinfo) { 
		
		Connection con = getConnection();
		CmtSns sns = CmtSns.getInstance();
		sns.setConnection(con);  
		sns.selectHouseinfo(houseinfo);
		
		
	}

	public ArrayList<Feed> getHeartArticleList(int page, int limit, String cust_id) throws Exception{
		
		//db커넥과 객체 초기화		
		ArrayList<Feed> articleList = null; 
		Connection con = getConnection();
		CmtSns sns = CmtSns.getInstance();
		sns.setConnection(con);
		
		// dao 패키지에 연결
		articleList = sns.selectHeartArticleList(page,limit,cust_id);
		// 닫기
		close(con);
		return articleList;
		
	}

}
