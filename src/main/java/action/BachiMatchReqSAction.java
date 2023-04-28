package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ActionForward;
import dto.Bachi_match_Been;
import svc.Bachi_Match_Req_S_Service;

public class BachiMatchReqSAction implements Action {

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ArrayList<Bachi_match_Been> match_been = new ArrayList<Bachi_match_Been>();
		
		 String id = request.getParameter("est_id");
		int est_id =Integer.parseInt(id);
		
		
		System.out.println(est_id);
		Bachi_Match_Req_S_Service match_req_s = new Bachi_Match_Req_S_Service();
		match_been = match_req_s.select_one(est_id);
		
		request.setAttribute("been", match_been);//key value 설정
		ActionForward forward= new ActionForward(); //이동 클래스
		forward.setPath("bachi_match_req_s.jsp?board="+est_id);	
		return forward;
	}
}
