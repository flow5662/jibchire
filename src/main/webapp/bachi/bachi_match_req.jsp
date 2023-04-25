<%@page import="dto.Bachi_match_Been"%>
<%@page import="action.BachiMatchCateAction"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    ArrayList<Bachi_match_Been> article_match = (ArrayList<Bachi_match_Been>)request.getAttribute("match_been");
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	   <!-- 헤더 -->
    <div class="wrap">
        <header>
    <% 
		request.setCharacterEncoding("utf-8"); 
		String id = (String) session.getAttribute("ID");  //session값에서 아이디 가져올 때 null이면 일반헤더, 아니면 로그인헤더
		if((id==null)){
	%>
		<jsp:include page="header.jsp" />
	<%
		}else{
	%>
		<jsp:include page="header_login.jsp" />
	<%
		}
	%>
	</header>
<% 
	if(article_match != null){
		for(int i=0;i<article_match.size();i++){
			%>
			<%=article_match.get(i).getEst_id() %><br>
			<%=article_match.get(i).getCust_id()%><br>
			<%=article_match.get(i).getGosu_menu1() %><br>
			<%=article_match.get(i).getGosu_menu2() %><br>
			<%=article_match.get(i).getEst_q1() %><br>
			<%=article_match.get(i).getEst_q2() %><br>
			<%=article_match.get(i).getEst_q3() %>
			
			
			<%
			}

}else{
	%>
	결과값없음
	<%
}


%>



    <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>
</body>
</html>