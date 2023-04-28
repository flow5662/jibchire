package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ActionForward;

public class BachiMatchAnsAction implements Action{
	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
	ActionForward forward= new ActionForward(); //이동 클래스
		forward.setPath("bachi_match_ans.jsp");
	return forward;
	}
}
