<%@page import="dto.PageInfo"%>
<%@page import="dto.Bachi_match_Been"%>
<%@page import="action.BachiMatchCateAction"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    ArrayList<Bachi_match_Been> article_match = (ArrayList<Bachi_match_Been>)request.getAttribute("match_been");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>견적답변</title>
</head>
<style>
.warp{margin:0 auto;}
.list{
padding-top:20px;
display: flex;
align-items: center;
flex-direction: column;}

#pageList{
    display: flex;
    align-items: center;
    flex-direction: row;
    justify-content: center;
    padding-top: 30px;
    gap: 10px;
    color: #6c7a56;
    font-size:16pt;
}
#pageList a{color: #353c2b;}
.list_section{
    width: 1280px;
    height: auto;
    margin: 0 auto;
    }
th{
font-size: 16pt;
}
img {
    margin-right: 15px;
    height: 70px;
    width: 70px;
    border-radius: 45px;
    border: 3px solid #fff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
.user-info {
    display: flex;
    align-items: center;
}
table{
text-align: center;
    border-spacing: 0 15px;
    border-collapse: separate;
}
.user{
box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
border-radius: 5px;
    
}

</style>

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
	<div class= "list_section">
	<div class="list">
	<table>
	<tr><th style="
    width: 180px;
    height: 90px;
">아이디</th><th style="
    width: 160px;
">대분류 카테고리</th><th style="width: 190px;">중분류 카테고리</th><th style="width: 200px;">목적</th><th style="
    width: 200px;
">장소</th><th style="
    width: 200px;
">유형</th>
<th style="width: 200px;">답변여부</th>
</tr>
		<!-- 견적리스트, 선택하여 상세 안에서 답변을 줄 수 있음.  -->
		<!-- 구글맵으로 된다면 반경 내 설정으로 바꿀예정. -->
		<!-- 활동가능지역을 기준으로 삼음 -->

<% 
	if(article_match != null){
		for(int i=0;i<article_match.size();i++){
			%>
			<tr class="user"> 
			<%
			String serverImagePath = request.getContextPath() + "/img/sm_" + article_match.get(i).getCust_pic();
			
			%>
			<td ><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><div class="user-info"><img src=<%=serverImagePath%> style=""><h5><%=article_match.get(i).getCust_id()%></h5></div></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getGosu_menu1() %></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getGosu_menu2() %></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getEst_q1()%></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getEst_q2()%></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getEst_q3() %></a></td>
			<td>
			<%
			if(article_match.get(i).getEst_id() == article_match.get(i).getAns_est_id()){
				out.print("<font style='color:#6464ad;'>답변완료</font>");
			}else{
				out.print("답변대기중");
			}
			%>
			</td>
			</tr>
			<%
			}

}else{
	%>
	결과값없음
	<%
}
%>


</table>
</div>


	<section id="pageList">
		<%if(nowPage<=1){ %>
		◀
		<%}else{ %>
		<a href="bachi_match_req.bc?page=<%=nowPage-1 %>">◀</a>
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		<a href="bachi_match_req.bc?page=<%=a %>"><%=a %></a>
		<%}else{ %>
		<a href="bachi_match_req.bc?page=<%=a %>"><%=a %>
		</a>
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		▶
		<%}else{ %>
		<a href="bachi_match_req.bc?page=<%=nowPage+1 %>">▶</a>
		<%} %>
	</section>
</div>


    <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>
</body>
</html>