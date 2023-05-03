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
<style>
.wrap{
margin:0 auto;
}
.cust_section{
width:1280px;
margin:0 auto;
}
.list{
  display: flex;
  align-items: center;
  flex-direction: column;
}

</style>
<body>
<%
ArrayList<Bachi_match_Been> article_match = (ArrayList<Bachi_match_Been>)request.getAttribute("been");
String est_id = request.getParameter("est_id");

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
<div class="cust_section">
<div class="list">
<table>
<% 
	if(article_match != null){
		for(int i=0;i<article_match.size();i++){
			%>	
			<tr> 
			<td><%=article_match.get(i).getCust_id()%></a></td>
			</tr>
			<tr>
			<td><%=article_match.get(i).getGosu_menu1() %>/<%=article_match.get(i).getGosu_menu2() %></a></td>
			</tr>
			<tr>
			<td><%=article_match.get(i).getEst_q1()%></a></td></tr>
			<tr>
			<td><%=article_match.get(i).getEst_q2()%></a></td></tr>
			<tr>
			<td><%=article_match.get(i).getEst_q3() %></a></td>
			
		</tr>
			
			<%
			}
		}
	%>
	
	</table>
	
	<br>
답변하기<br>
----------------------<br>
<br>
<form action="bachi_match_ans.bc">
<input type="hidden" name="est_id" value="<%=est_id%>">
<input type="hidden" name="cust_id" value="<%=id%>">
질문1<input type="text" name="est_a1"><br>
질문2<input type="text" name="est_a2"><br>
질문3<input type="text" name="est_a3"><br>
<!-- const_date, payment는 답변 이후에 같이 db에 (update)입력되도록 -->
<input type="submit" value="답변하기">
</form>
</div>
 
</div>
   <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>

</body>
</html>