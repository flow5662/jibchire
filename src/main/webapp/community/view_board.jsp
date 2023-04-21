<%@page import="dto.PageInfo"%>
<%@ page import="dao.CmtHousewarming" %>
<%@ page import="dto.Post_house" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시판 메인화면</title>
		<link rel="stylesheet" type="text/css" href="style/view_board.css">
		<!-- 데이터 처리 기능인 Create(생성), Read(읽기), Update(갱신), Delete(삭제)를 묶어서 일컫는 말이다. -->
	</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- 게시판 메인화면을 위한 전체 데이터 셀렉-->
<%

	ArrayList<Post_house> alist = (ArrayList<Post_house>) request.getAttribute("articleList");
	PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	// "pageInfo"라는 key값에 pageInfo라는 객체를 value값으로 넣었기 때문에 getAttribute할때도 객체로의 형변환이 필요한 것. 
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
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
		<input type="hidden" name="cust_id" value="<%=id%>">
	<%
		}
	%>
	</header>
    <div id="wrap">
    <div class="subtitle">이번주 가장 북마크가 많이 눌린 집들이</div>
   	<%
	if(alist != null && listCount > 0){
	%>
	    <div id="list">
	    	<ul>
	    		<%  
    			for(int i=0; i<3; i++){   //한 줄에 세 칸을 넣을	
    			%>
	    		<li>
	    			<a href = "view_read.jsp?post_id=<%=alist.get(i).getPost_id() %>">
	    				<!-- data 직접 집어넣어서 따로 썸네일 만들지 않고있음, postPics/sm_ 라는 루트가 다름
	    				<div class="thumbnail"> <img src="postPics/sm_%=alist.get(i).getPost_pics() %>"></div> -->
		    			<div class="thumbnail"> <img src="postPics/<%=alist.get(i).getPost_pics() %>"></div>
		    			<div class="title"><%=alist.get(i).getPost_title() %>  </div>
	    			</a>
	    				<!-- 북마크 버튼 -->
	    				<% 
							String bookmark= alist.get(i).getBookmark_time();
							if(bookmark==null){
								%><img src="img/community/png/bookmark-line.png" class="bookmark" value="<%=alist.get(i).getPost_id()%>"><%
							}else{
								%><img src="img/community/png/bookmark-2-fill.png" class="bookmark" value="<%=alist.get(i).getPost_id()%>"><%
							}
						%>
		    			<!-- <img src="img/community/png/book-mark-fill.png" class="bookmark" value=""> -->
		    			<div class="writer"><%=alist.get(i).getCust_id() %> </div>
	    			<div class="view">조회수  북마크 10</div>
	    		</li>
    			<%		
    			
    			}
	    		%>
	    	</ul>
	    </div>
	
			<%
			}
			else
			{
			%>
			<section id="emptyArea">등록된 글이 없습니다.</section>
			<%
			}
			%>
					
	   
	       	<%
	if(alist != null && listCount > 0){
	%>
	    <!-- 참고) section style 분류 탭 : jsp:include page="tap_style.jsp" -->    	
    	<!-- 메뉴 분류 탭 주거형태 방 개수, 집 평수, 가족인원수, 집 연식-->
		<div class="subtitle">최근 집들이</div>
	   	<div class="selectBoxList">
	        <!-- selectBox주거환경-->
	        <div class="box">
	            <div class="selectBox2 ">
	            <button class="label">주거환경</button>
	            <ul class="optionList1" name="box1" value="post_house">
	                <li class="optionItem" value="apart">아파트</li>
	                <li class="optionItem" value="officetel">오피스텔</li>
	                <li class="optionItem" value="house">주택</li>
	                <li class="optionItem" value="villa">빌라</li>
	                <li class="optionItem" value="dorm">기숙사</li>
	            </ul>
	            </div>
	        </div>
	        <!-- selectBox방 개수 -->
	        <div class="box">
	            <div class="selectBox2 ">
	            <button class="label">방 개수</button>
	            <ul class="optionList2" name="box2" value="post_rooms">
	                <li class="optionItem" value="1" >1개</li>
	                <li class="optionItem" value="2" >2개</li>
	                <li class="optionItem" value="3" >3개</li>
	                <li class="optionItem" value="4" >4개 이상</li>
	            </ul>
	            </div>
	        </div>
	        <!-- selectBox집 평수 -->
	        <div class="box">
	            <div class="selectBox2  ">
	            <button class="label">집 평수</button>
	            <ul class="optionList3" name="box3" value="post_m2">
	                <li class="optionItem" value="5">5평 이상</li>
	                <li class="optionItem" value="10">10평 이상</li>
	                <li class="optionItem" value="15">15평 이상</li>
	                <li class="optionItem" value="20">20평 이상</li>
	                <li class="optionItem" value="25">25평 이상</li>
	                <li class="optionItem" value="30">30평 이상</li>
	            </ul>
	            </div>
	        </div>
	        <!-- selectBox집 연식 -->
	        <div class="box">
	            <div class="selectBox2">
	            <button class="label">집 연식</button>
	            <ul class="optionList4" name="box4" value="post_houseold">
	                <li class="optionItem" value="1">신축~ 5년 미만</li>
	                <li class="optionItem" value="5">5년 이상</li>
	                <li class="optionItem" value="10">10년 이상</li>
	                <li class="optionItem" value="15">15년 이상</li>
	                <li class="optionItem" value="20">20년 이상</li>
	            </ul>
	            </div>
	        </div>
	        <!-- selectBox가족형태 -->
	        <div class="box">
	            <div class="selectBox2  ">
	            <button class="label">가족형태</button>
	            <ul class="optionList5" name="box5" value="post_family">
	                <li class="optionItem" value="1인가구">1인가구</li>
	                <li class="optionItem" value="신혼부부">신혼부부</li>
	                <li class="optionItem" value="룸메이트">룸메이트</li>
	                <li class="optionItem" value="부모님과 함께">부모님과 함께</li>
	                <li class="optionItem" value="어린 자녀와 함께">어린 자녀와 함께</li>
	            </ul>
	            </div>
	        </div>
	        <!-- selectBox스타일 -->
	        <div class="box">
	            <div class="selectBox2  ">
	            <button class="label">스타일</button>
	            <ul class="optionList6" name="box6" value="post_style">
	                <li class="optionItem" value="미니멀/심플">미니멀/심플</li>
	                <li class="optionItem" value="내추럴">내추럴</li>
	                <li class="optionItem" value="북유럽">북유럽</li>
	                <li class="optionItem" value="빈티지">빈티지</li>
	                <li class="optionItem" value="유니크">유니크</li>
	                <li class="optionItem" value="프렌치/플로럴">프렌치/플로럴</li>
	                <li class="optionItem" value="믹스매치">믹스매치</li>
	                <li class="optionItem" value="한옥">한옥</li>
	                <li class="optionItem" value="오피스겸용">오피스겸용</li>
	            </ul>
	            </div>
	        </div>
	        <!-- selectBox스타일 -->
	        <div class="box">
	            <div class="selectBox2  ">
	            <button class="label">색상</button>
	            <ul class="optionList7" name="box7" value="post_color">
	                <li class="optionItem" value="black">black</li>
	                <li class="optionItem" value="white">white</li>
	                <li class="optionItem" value="red">red</li>
	                <li class="optionItem" value="orange">orange</li>
	                <li class="optionItem" value="yellow">yellow</li>
	                <li class="optionItem" value="green">green</li>
	                <li class="optionItem" value="blue">blue</li>
	                <li class="optionItem" value="purple">purple</li>
	                <li class="optionItem" value="brown">brown</li>
	                <li class="optionItem" value="pink">pink</li>
	            </ul>
	            </div>
	        </div>
	    </div>
	    <div id="list">
	    	<ul>
	    		<%  
    			for(int i=0; i<alist.size(); i++){   //한 줄에 세 칸을 넣을	
    			%>
	    		<li>
	    			<a href = "view_read.jsp?post_id=<%=alist.get(i).getPost_id() %>">
		    			<!-- data 직접 집어넣어서 따로 썸네일 만들지 않고있음, postPics/sm_ 라는 루트가 다름
	    				<div class="thumbnail"> <img src="postPics/sm_%=alist.get(i).getPost_pics() %>"></div> -->
		    			<div class="thumbnail"> <img src="postPics/<%=alist.get(i).getPost_pics() %>"></div>
		    			<div class="title"><%=alist.get(i).getPost_title() %>  </div>
	    			</a>
	    				<!-- 북마크 버튼 -->
	    				<% 
							String bookmark= alist.get(i).getBookmark_time();
							if(bookmark==null){
								%><img src="img/community/png/bookmark-line.png" class="bookmark" value="<%=alist.get(i).getPost_id()%>"><%
							}else{
								%><img src="img/community/png/bookmark-2-fill.png" class="bookmark" value="<%=alist.get(i).getPost_id()%>"><%
							}
						%>
		    			<!-- <img src="img/community/png/book-mark-fill.png" class="bookmark" value=""> -->
		    			<div class="writer"><%=alist.get(i).getCust_id() %> </div>
	    			<div class="view">조회수  북마크 10</div>
	    		</li>
    			<%		
    			
    			}
	    		%>
	    	</ul>
	    </div>
	    <!-- 페이징 -->
	    <section id="pageList">
			<%if(nowPage<=1){ %>
				[이전]&nbsp;&nbsp;
			<%}else{ %>
				<a href="snsListAction.sns?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
			<%} %>
	
			<%for(int a=startPage;a<=endPage;a++){
					if(a==nowPage){%>
						[<%=a%>]&nbsp;&nbsp;
					<%}else{ %>
					<a href="snsListAction.sns?page=<%=a%>">[<%=a%>]
					</a>&nbsp;
					<%} %>
			<%} %>
			<%if(nowPage>=maxPage){ %>
				[다음]
			<%}else{ %>
				<a href="snsListAction.sns?page=<%=nowPage+1 %>">[다음]</a>
			<%} %>
			</section>
			<%
			}
			else
			{
			%>
			<section id="emptyArea">등록된 글이 없습니다.</section>
			<%
			}
			%>
	 </div>				
<script type="text/javascript">
$(function(){
	/* 북마크 버튼 눌렀을 때 바로 DB작업하기*/
	$(".bookmark").click(function(){  
		//버튼 div의 value값으로 feed_id를 넣어놨음
		var post_id= $(this).attr("value");
		//alert(post_id);
		var cust_id= $("input:hidden[name=cust_id]").val();
		if(cust_id==undefined){
			alert("북마크를 이용하시려면 로그인을 실행해주세요");
		}else{ 
			$.ajax({
				url : "insert_bookmark.jsp?post_id="+post_id+"&cust_id="+cust_id,  
				dataType : "html",
				//data : "post",
				success : function(check){
					//alert("북마크 완료");
				}
			});
			var src1 = $(this).attr("src");
			//alert(src1);
			if(src1=="img/community/png/bookmark-line.png"){
				$(this).attr("src","img/community/png/bookmark-2-fill.png");
			}else{
				$(this).attr("src","img/community/png/bookmark-line.png");
			}
		}
	});
	
	/*select 메뉴*/
	const label = document.querySelectorAll('.label');

	label.forEach(function(lb){
	    lb.addEventListener('click', e => {
	        let optionList = lb.nextElementSibling;
	        let optionItems = optionList.querySelectorAll('.optionItem');
	        clickLabel(lb, optionItems);
	    })
	});
	const clickLabel = (lb, optionItems) => {
	    if(lb.parentNode.classList.contains('active')) {
	        lb.parentNode.classList.remove('active');
	        optionItems.forEach((opt) => {
	            opt.removeEventListener('click', () => {
	                handleSelect(lb, opt)
	            })
	        })
	    } else {
	        lb.parentNode.classList.add('active');
	        optionItems.forEach((opt) => {
	            opt.addEventListener('click', () => {
	                handleSelect(lb, opt)
	            })
	        })
	    }
	}
	const handleSelect = (label, item) => {
	    label.innerHTML = item.textContent;
	    label.parentNode.classList.remove('active');
	}

	$("img").mouseenter(function(){
		$(this).css("scale","1.05");
		$(this).css("cursor","pointer");
	});
	$("img").mouseleave(function(){
		$(this).css("scale","1.0");
	});
	$(".optionList1 .optionItem").click(function(){
		var record = $(this).attr("value");
		var field = $(".optionList1").attr("value");
		var cust_id= $("input:hidden[name=cust_id]").val();
		alert(field);
		location.href= "select_board_list.jsp?field="+field+"&menuword="+record+"&cust_id="+cust_id;
	});
	$(".optionList2 .optionItem").click(function(){
		var record = $(this).attr("value");
		var field = $(".optionList2").attr("value");
		var cust_id= $("input:hidden[name=cust_id]").val();
		alert(field);
		location.href= "select_board_list.jsp?field="+field+"&menuword="+record+"&cust_id="+cust_id;
	});
	$(".optionList3 .optionItem").click(function(){
		var record = $(this).attr("value");
		var field = $(".optionList3").attr("value");
		var cust_id= $("input:hidden[name=cust_id]").val();
		alert(field);
		location.href= "select_board_list.jsp?field="+field+"&menuword="+record+"&cust_id="+cust_id;
	});
	$(".optionList4 .optionItem").click(function(){
		var record = $(this).attr("value");
		var field = $(".optionList4").attr("value");
		var cust_id= $("input:hidden[name=cust_id]").val();
		alert(field);
		location.href= "select_board_list.jsp?field="+field+"&menuword="+record+"&cust_id="+cust_id;
	});
	$(".optionList5 .optionItem").click(function(){
		var record = $(this).attr("value");
		var field = $(".optionList5").attr("value");
		var cust_id= $("input:hidden[name=cust_id]").val();
		alert(field);
		location.href= "select_board_list.jsp?field="+field+"&menuword="+record+"&cust_id="+cust_id;
	});
	$(".optionList6 .optionItem").click(function(){
		var record = $(this).attr("value");
		var field = $(".optionList6").attr("value");
		var cust_id= $("input:hidden[name=cust_id]").val();
		alert(field);
		location.href= "select_board_list.jsp?field="+field+"&menuword="+record+"&cust_id="+cust_id;
	});
	$(".optionList7 .optionItem").click(function(){
		var record = $(this).attr("value");
		var field = $(".optionList7").attr("value");
		var cust_id= $("input:hidden[name=cust_id]").val();
		alert(field);
		location.href= "select_board_list.jsp?field="+field+"&menuword="+record+"&cust_id="+cust_id;
	});
	
});
</script>
	<!-- footer -->
	<footer>
		<jsp:include page="footer.jsp" />
	</footer>
</body>
</html>