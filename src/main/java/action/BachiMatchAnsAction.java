package action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.ActionForward;
import dto.Bachi_match_AnsBeen;

public class BachiMatchAnsAction implements Action{
	public ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception{
	ActionForward forward = null;
	Bachi_match_AnsBeen bachi_match_been_a = null;
	ServletContext context = request.getServletContext();
	
	bachi_match_been_a = new Bachi_match_AnsBeen();
	bachi_match_been_a.setCust_id_c(request.getParameter("cust_id")); //아이디 가져오기
	
	String title = request.getParameter("title");
	String servs = request.getParameter("serv");
	String places = request.getParameter("place");
	String types = request.getParameter("type");
	
	
	forward= new ActionForward(); //이동 클래스
	forward.setPath("bachi_match_ans.jsp");
	return forward;
	}
}
