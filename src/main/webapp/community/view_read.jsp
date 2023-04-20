<%@ page import="dao.CmtHousewarming" %>
<%@ page import="dto.Post_house" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 읽기</title>
	<link rel="stylesheet" type="text/css" href="style/view_read.css">
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/view_read.js"> </script>
<%
 request.setCharacterEncoding("utf-8");
%>
<%
	CmtHousewarming sl = new CmtHousewarming();
	int pid = Integer.parseInt(request.getParameter("post_id"));
	Post_house po = sl.select_one(pid);
%>
<body>
 	<!-- header -->
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
		<div id="wrap">

			<%
			String savePath = "/community/communityPic";
			ServletContext context = getServletContext();
			String sDownloadPath = context.getRealPath(savePath);
			String sFilePath = sDownloadPath + "\\" + po.getPost_pics();
			//out.println("<section id='mainpic'><img src='"+sFilePath+"'> </section>");
			//out.println(sFilePath);
			%>
			<!-- 사진 슬라이더 -->
			<div id="sliderwrap">
				<div id="slider">
					<a href="#" class="control_next">>></a>
					<a href="#" class="control_prev"><<</a>
					<ul>
						<li><img src="postPics/<%=po.getPost_pics() %>" style="width: 860px; height: 500px;">></li>
						<li><img src="postPics/<%=po.getPost_pic1() %>" style="width: 860px; height: 500px;"></li>
						<li><img src="postPics/<%=po.getPost_pic2() %>" style="width: 860px; height: 500px;"></li>
						<li><img src="postPics/<%=po.getPost_pic3() %>" style="width: 860px; height: 500px;"></li>
					</ul>  
				</div>
			</div>
			<!-- 사진
			<section >
				<div id="mainpic">
				<img src="postPics/<%=po.getPost_pics() %>" id="mainpicimg"></div>
			</section>-->
			<!-- 제목 -->
		   	<div id="title"> 
		   		<h1><%=po.getPost_title() %></h1>
		   		<!-- //현재 session에서 저장된 ID값과 db에서 가져온 id 값이 일치한다면 버튼생성 -->
		   		<%
		   		//글의 데이터에서 작성자의 아이디와, 현제 로그인한 사람의 아이디가 동일하면 삭제, 수정버튼 생성
			   	String id2 = po.getCust_id();
				if(!(id==null) && id.equals(id2)){ 
					out.println("<input type='button' value='삭제' onclick="+"location.href='delete_write.jsp?post_id="+po.getPost_id()+"'>"); //삭제버튼 누르면 그 글을 바로 삭제
					out.println("<input type='button' value='수정' onclick="+"location.href='view_update.jsp?post_id="+po.getPost_id()+"'>"); //수정버튼 누르면 그 글의 수정페이지로
					out.println("<input type = 'hidden' name ='post_id' id='post_id' value = "+po.getPost_id()+">");
				}	
				%>   	
		   	</div>	
			<!-- 세부내용박스(집특징, 평수 등등) -->	   	
		   	<div id="info">
		   		<table>
		   			<tr><td>주거형태</td>
		   				<td><%=po.getPost_house()%> </td>
		   				<td>방개수</td>
		   				<td><%=po.getPost_rooms()%>개</td>
		   				<td>집 평수</td>
		   				<td><%=po.getPost_m2()%>평</td>
		   			</tr><tr>	
		   				<td>집 연식</td>
		   				<td><%=po.getPost_houseold()%>년 이상</td>
		   				<td>스타일</td>
		   				<td><%=po.getPost_style()%></td>
		   				<td>색상 톤</td>
		   				<td><%=po.getPost_color()%></td>
		   			</tr><tr>
		   				<td>가족 인원</td>
		   				<td><%=po.getPost_fam()%>명</td>
		   				<td>가족형태</td>
		   				<td><%=po.getPost_family()%></td>
		   				<td>반려동물</td>
		   				<td><%=po.getPost_pet()%></td>
   					</tr><tr>
		   				<td>지역</td>
		   				<td><%=po.getPost_region()%></td>
		   				<td>예산</td>
		   				<td><%=po.getPost_budget()%>만원</td>
		   				<td></td>
		   				<td></td>
   					</tr><tr>
		   				<td>공사시작일</td>
		   				<td><%=po.getPost_startdate()%></td>
		   				<td>공사마감일</td>
		   				<td><%=po.getPost_enddate()%></td>
		   				<td></td>
		   				<td></td>
		   			</tr>
		   		</table>
					
			</div >
			<!-- 내용 -->
    		<div id="content">
    			<%= po.getPost_txt() %>
    		</div>
		</div>
	<!-- footer -->
	<footer>
		<jsp:include page="footer.jsp" />
	</footer>
<script>
$(function(){
	/*slider 관련 기능*/
	$("subnav").hide();
	setInterval(function () {
	    moveRight();
	}, 3000);
	
	var slideCount = $('#slider ul li').length;
	var slideWidth = $('#slider ul li').width();
	var slideHeight = $('#slider ul li').height();
	var sliderUlWidth = slideCount * slideWidth;
	
	$('#slider').css({ width: slideWidth, height: slideHeight });
	
	$('#slider ul').css({ width: sliderUlWidth, marginLeft: - slideWidth });
	
	$('#slider ul li:last-child').prependTo('#slider ul');
	
	function moveLeft() {
	    $('#slider ul').animate({
	        left: + slideWidth
	    }, 200, function () {
	        $('#slider ul li:last-child').prependTo('#slider ul');
	        $('#slider ul').css('left', '');
	    });
	};
	
	function moveRight() {
	    $('#slider ul').animate({
	        left: - slideWidth
	    }, 200, function () {
	        $('#slider ul li:first-child').appendTo('#slider ul');
	        $('#slider ul').css('left', '');
	    });
	};
	
	$('a.control_prev').click(function () {
	    moveLeft();
	});
	
	$('a.control_next').click(function () {
	    moveRight();
	});
	
});
</script>
</body>
</html>