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
    align-items: flex-start;
    flex-direction: row;
    justify-content: center;
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
	<div>
	<div class="list">
	<table>
	<tr><th style="
    width: 180px;
">아이디</th><th style="
    width: 160px;
">대분류 카테고리</th><th style="width: 190px;">중분류 카테고리</th><th style="width: 200px;">목적</th><th style="
    width: 200px;
">장소</th><th style="
    width: 200px;
">유형</th></tr>
		<!-- 견적리스트, 선택하여 상세 안에서 답변을 줄 수 있음.  -->
		<!-- 구글맵으로 된다면 반경 내 설정으로 바꿀예정. -->
		<!-- 활동가능지역을 기준으로 삼음 -->

<% 
	if(article_match != null){
		for(int i=0;i<article_match.size();i++){
			%>

			<tr> 
			
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getCust_id()%></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getGosu_menu1() %></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getGosu_menu2() %></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getEst_q1()%></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getEst_q2()%></a></td>
			<td><a href="bachi_match_req_s.bc?est_id=<%=article_match.get(i).getEst_id()%>"><%=article_match.get(i).getEst_q3() %></a></td>
			
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
		[이전]&nbsp;
		<%}else{ %>
		<a href="bachi_match_req.bc?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		<a href="bachi_match_req.bc?page=<%=a %>">[<%=a %>]</a>
		<%}else{ %>
		<a href="bachi_match_req.bc?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		[다음]
		<%}else{ %>
		<a href="bachi_match_req.bc?page=<%=nowPage+1 %>">[다음]</a>
		<%} %>
	</section>



    <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>
</body>
</html>