package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import action.Action;
import action.SnsDeleteAction;
import action.SnsListAction;
import action.SnsReadAction;
import action.SnsUpdateAction;
import action.SnsWriteAction;
import action.SnsWriteAction2;
import dto.ActionForward;

@WebServlet("*.bo")
public class CmtController extends javax.servlet.http.HttpServlet 
{
	protected void doProcess(HttpServletRequest request, HttpServletResponse response)  /*jsp는 request와 response를 server page에서 객체를 사용할 수 있는게 이미 약속이 되어있기 때문에 괜찮지만
																							servlet은 java를 통해 사용할 부분을 import를 해왔기 때문에
																							method에서 request와 response를 parameter로 가져와야만 사용이 가능한 것.*/
		throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String RequestURI=request.getRequestURI();   //project와 파일경로
		String contextPath=request.getContextPath(); //project이름만
		String command=RequestURI.substring(contextPath.length()); //substring=>문자열자르기
		ActionForward forward=null; 							
		Action action=null;  									
		System.out.println("이번 요청 path는 : "+command);
		
		if(command.equals("/sns/snsWriteAction.bo")){
			action  = new SnsWriteAction(); 		    // 클래스가 상속관계일때 다형성 성립
			System.out.println("글쓰기 완료 및 컨트롤러도착");
			try {
				forward=action.execute(request, response ); // 메소드 호출 후 리턴 받음
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/sns/snsListAction.bo")) {
			System.out.println("insert 완료 및 List 화면으로 ");
			action = new SnsListAction();
			try {
				forward=action.execute(request, response ); // forward는 요청path를 받아오는 객체다
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/sns/snsReadAction.bo")){
			System.out.println("글읽기 컨트롤러 실행");
			action = new SnsReadAction();		    	// 클래스가 상속관계일때 다형성 성립
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/sns/snsDeleteAction.bo")){  //글삭제
			System.out.println("글삭제 컨트롤러 실행");
			action = new SnsDeleteAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		else if(command.equals("/sns/snsUpdateAction.bo")){  //글삭제
			System.out.println("글수정 컨트롤러 실행");
			action = new SnsUpdateAction();
			try{
				forward=action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(forward != null){		
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatcher=
						request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}

		}
		
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response); //doGet 메소드를 호출했을 때 doProcess 실행
	}  	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response); //doPost 메소드를 호출했을 때 doProcess 실행
	}   
	
}