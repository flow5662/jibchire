package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;


import java.sql.Connection;
import java.util.ArrayList;

import dao.Bachi_match;
import db.JdbcUtil;
import dto.Bachi_match_Been;

public class Bachi_Match_Req_Service {

	public ArrayList<Bachi_match_Been> select_matchReq() throws Exception{
		
		ArrayList<Bachi_match_Been> match_been = null; //ArrayList 초기화
		Connection con = getConnection(); //Conn 호출
		Bachi_match bachi_match_req = Bachi_match.getInstance(); //싱글톤패턴, 하나의 Bachi_match 인스턴스만 사용
		bachi_match_req.setConnection(con);
		match_been = bachi_match_req.selectMatchReq();
		
		close(con);
		return match_been;
	}
}