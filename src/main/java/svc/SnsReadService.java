package svc;

import java.sql.Connection;
import dao.CmtSns;
import dto.Feed;
import static db.JdbcUtil.*;

public class SnsReadService {

	public Feed getArticle(int feed_id) throws Exception{

		Feed feed = null;
		Connection con = getConnection();
		CmtSns consns = CmtSns.getInstance();
		consns.setConnection(con);
		
		/*조회수 높이기*/
		int updateCount = consns.updateReadCount(feed_id); 
		System.out.println("1이면 조회수 상승=>"+updateCount);
		if(updateCount > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		feed = consns.selectArticle(feed_id);
		close(con);
		return feed;
		
	}
	
	public Feed getHeartArticle(int feed_id,String cust_id) throws Exception{

		Feed feed = null;
		Connection con = getConnection();
		CmtSns consns = CmtSns.getInstance();
		consns.setConnection(con);
		
		/*조회수 높이기*/
		int updateCount = consns.updateReadCount(feed_id); 
		System.out.println("1이면 조회수 상승=>"+updateCount);
		if(updateCount > 0){
			commit(con);
		}
		else{
			rollback(con);
		}
		feed = consns.selectHeartArticle(feed_id,cust_id);
		close(con);
		return feed;
		
	}

}
