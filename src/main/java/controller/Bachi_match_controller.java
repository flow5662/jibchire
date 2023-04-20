package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.BachiMatchCateAction;
import action.BachiQuestionsAction;
import dto.ActionForward;

@WebServlet("*.bc")//��� �� ��Ʈ�ѷ��� Ÿ�� ���ڴ�
public class Bachi_match_controller extends javax.servlet.http.HttpServlet 
{
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		String RequestURI=request.getRequestURI();
		String contextPath=request.getContextPath();
		String command=RequestURI.substring(contextPath.length());
		ActionForward forward = null;
		Action action=null;
		System.out.println(command);
		if(command.equals("/bachi/bachi_match.bc")){
			action= new BachiMatchCateAction();	
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/bachi/bachi_question.bc")) {
			action  = new BachiQuestionsAction();
			try {
				forward = action.execute(request, response);
				
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		//System.out.println(forward.getPath());
		
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
		doProcess(request,response);
	}  	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doProcess(request,response);
	} 
}		