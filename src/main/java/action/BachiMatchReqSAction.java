package action;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Bachi_match;
import dto.ActionForward;
import dto.Bachi_match_Been;
import svc.Bachi_Match_Req_S_Service;

public class BachiMatchReqSAction implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ArrayList<Bachi_match_Been> match_been = new ArrayList<Bachi_match_Been>();
		
		 String id = request.getParameter("est_id");
		int est_id =Integer.parseInt(id);
		//추후 cust_id값에 따라, (로그인 된 고수만)
		String cust_id = request.getParameter("ID");
		//답변이 완료되면 답변완료기능 추가. 05/11
		
		Connection con = getConnection(); //Conn 호출
		Bachi_match bachi_match_req = Bachi_match.getInstance();
		bachi_match_req.setConnection(con);
		int est_id_ans = bachi_match_req.select_answered(est_id); //답변이 되었는지 확인
		close(con);
		
		
		ActionForward forward= new ActionForward(); //이동 클래스
		
		
		if(est_id_ans == est_id) { //이미 답변된 id라면 (추가)현재 로그인한 사용자가 답변을 했는지 안했는지 여부가 필요
			forward.setPath("bachi_match_req_sw.bc?board="+est_id);
			return forward;
		}else {
			System.out.println(est_id);
			Bachi_Match_Req_S_Service match_req_s = new Bachi_Match_Req_S_Service();
			
			match_been = match_req_s.select_one(est_id);
			
			request.setAttribute("been", match_been);//key value 설정
			
			forward.setPath("bachi_match_req_s.jsp?board="+est_id);	
			return forward;
		}
		
	}
}
