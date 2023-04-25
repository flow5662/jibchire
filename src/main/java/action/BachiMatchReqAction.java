package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ActionForward;
import dto.Bachi_match_Been;
import svc.Bachi_Match_Req_Service;

public class BachiMatchReqAction implements Action{

	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
		ArrayList<Bachi_match_Been> match_been= new ArrayList<Bachi_match_Been>(); //ArrayList 객체 생성
	
		Bachi_Match_Req_Service match_req = new Bachi_Match_Req_Service();
		match_been = match_req.select_matchReq(); //ArrayList 객체 호출, 서비스 클래스의 메소드의 return값 담기
		
		request.setAttribute("match_been", match_been);//key value 설정
		ActionForward forward= new ActionForward(); //이동 클래스
   		forward.setPath("bachi_match_req.jsp");
   		return forward; //bachi_match_req.jsp 이동
	}
}
