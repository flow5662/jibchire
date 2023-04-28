<%@page import="java.util.ArrayList"%>
<%@page import="dto.Bachi_match_Been"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변하기</title>
</head>
<body>
<%
ArrayList<Bachi_match_Been> article_match = (ArrayList<Bachi_match_Been>)request.getAttribute("been");


%>

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
			<tr> 
			<td><%=article_match.get(i).getEst_id() %></a></td>
			<td><%=article_match.get(i).getCust_id()%></a></td>
			<td><%=article_match.get(i).getGosu_menu1() %></a></td>
			<td><%=article_match.get(i).getGosu_menu2() %></a></td>
			<td><%=article_match.get(i).getEst_q1()%></a></td>
			<td><%=article_match.get(i).getEst_q2()%></a></td>
			<td><%=article_match.get(i).getEst_q3() %></a></td>
			
		</tr>
			
			<%
			}
		}
	%>
	
	
	<br>
답변하기<br>
----------------------<br>
<br>
<form>

제목<input type="text"><br>
질문1<input type="text"><br>
질문2<input type="text"><br>
질문3<input type="text"><br>

<input type="submit" value="답변하기">
</form>

    <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>

</div>
</body>
</html>