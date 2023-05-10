package svc;

import java.sql.Connection;
import java.util.ArrayList;

import dao.CmtSns;
import dto.Feed;
import dto.Feed_comment;

import static db.JdbcUtil.*;

public class SnsReadService {

	public ArrayList<Feed> getArticle(int feed_id) throws Exception{

		Feed feed = null;
		Connection con = getConnection();
		CmtSns consns = CmtSns.getInstance();
		consns.setConnection(con);
		
		/*조회수 높이기*/
		int updateCount = consns.updateReadCount(feed_id); 
		if(updateCount > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		ArrayList<Feed> articleList = consns.selectArticle(feed_id);
		close(con);
		return articleList;
		
	}
	
	public ArrayList<Feed> getHeartArticle(int feed_id,String cust_id) throws Exception{

		Feed feed = null;
		Connection con = getConnection();
		CmtSns consns = CmtSns.getInstance();
		consns.setConnection(con);
		ArrayList<Feed> articleList = null;
		
		/*조회수 높이기*/
		int updateCount = consns.updateReadCount(feed_id); 
		if(updateCount > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		articleList = consns.selectHeartArticle(feed_id,cust_id);
		close(con);
		return articleList;
		
	}
	
	public ArrayList<Feed_comment> getFeedComment(ArrayList<Feed> articleList) throws Exception{
			
		ArrayList<Feed_comment> commentlist = null;
		Connection con = getConnection();
		CmtSns consns = CmtSns.getInstance();
		consns.setConnection(con);
		commentlist = consns.getFeedComment(articleList);
		
		return commentlist;
	}

}
