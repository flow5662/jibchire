<%@page import="dto.Feed"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일상공유 읽기</title>
	<link rel="stylesheet" type="text/css" href="style/snsRead.css">
</head>
<%  //데이터 작업으로 얻은 객체 가져오기
	Feed feed = (Feed)request.getAttribute("Feed");
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
	<div id="wraper">
	<!-- 사진 슬라이더 들어가는 공간 -->
	<section>
		<div id="title"> <h2>#hashtag <%=feed.getFeed_hashtag() %></h2></div>
		<div id="sliderwrap">
			<div id="slider" >
				<a href="#" class="control_next">>></a>
				<a href="#" class="control_prev"><<</a>
				<ul>
				    <li><div class="pics"><img src="feedPics/<%=feed.getFeed_pics() %>"></div></li>
				    <li><div class="pics"><img src="feedPics/<%=feed.getFeed_pic1() %>"></div></li>
				    <li><div class="pics"><img src="feedPics/<%=feed.getFeed_pic2() %>"></div></li>
				    <li><div class="pics"><img src="feedPics/<%=feed.getFeed_pic3() %>"></div></li>
			    </ul>
			</div>
		</div>
	</section>
	<!-- 내용이 들어가는 공간 -->
	<section>
		<div id="text">
			<pre> <%=feed.getFeed_txt()%></pre>
		</div>
	</section>
	<aside>
		<div id="like">
			<ul>
				<li>좋아요</li>
				<li>
				<%
				String like= feed.getLike_time();
				if(like==null){
					%><img src="img/sns/heart-add-line.png" class="buttonlike" value="<%=feed.getFeed_id()%>"><%
				}else{
					%><img src="img/sns/heart-fill.png" class="buttonlike" value="<%=feed.getFeed_id()%>"><%
				}
				%>
				</li>
				<li>42</li>
				<li>팔로우</li>
				<li>
				<%
				String follow = feed.getFollow_time();
				if(follow==null){
					%><img src="img/sns/user-unfollow-line.png" class="buttonfollow" value="<%=feed.getCust_id()%>"><%
				}else{
					%><img src="img/sns/user-follow-fill.png" class="buttonfollow" value="<%=feed.getCust_id()%>"><%
				}
				%>
				</li>
				<li>16</li>
			</ul>
		</div>
	</aside>
	<!-- 글쓴이 정보가 들어가는 공간 -->
	<section>
		<div id ="writerinfo">
			<div id="writerpic"><img src="feedPics/<%=feed.getWriterpic()%>"> </div>
			<ul>
				<li id="writerid"><%=feed.getCust_id()%></li>
				<li id="writerintroduce"><%=feed.getWriterintroduce()%></li>
				<li>
					<%
					if(follow==null){
						%>팔로우 추가<img src="img/sns/user-unfollow-line.png" class="buttonfollow" value="<%=feed.getCust_id()%>"><%
					}else{
						%>팔로우 중 <img src="img/sns/user-follow-fill.png" class="buttonfollow" value="<%=feed.getCust_id()%>"><%
					}
					%>
					팔로우 ~~~명
				</li>
			</ul>

		</div>
	</section>
	<!-- 글쓴이가 조회하면 수정/삭제버튼 -->
	<div id="buttonforid">
		<%
  		//글의 데이터에서 작성자의 아이디와, 현제 로그인한 사람의 아이디가 동일하면 삭제, 수정버튼 생성
	   	String id2 = feed.getCust_id(); 
		int num = feed.getFeed_id(); //value값으로 jsp코드가 가면 안되니까
		if(!(id==null) && id.equals(id2)){ 
			out.println("<input type='button' value='삭제' onclick='return deleteConfirm()'>"); //삭제버튼 누르면 그 글을 바로 삭제
			out.println("<input type='button' value='수정' onclick='return updateConfirm()'>"); //수정버튼 누르면 그 글의 수정페이지로
			out.println("<input type ='hidden' name ='post_id' id='post_id' value ="+feed.getFeed_id()+">");
			out.println("<input type ='hidden' name ='post_id' id='deleteConfirm' value ="+num+">"); //js에 jsp코드를 쓸 수 없으니까
			//out.println("<input type='button' value='수정' onclick="+"location.href='snsUpdateAction.sns?feed_id="+feed.getFeed_id()+"'>"); //수정버튼 누르면 그 글의 수정페이지로
		}
		/*(select date_format(feed_date,'%h:%i %p, %b-%e') from feed;*/
		%>
	</div>
	</div>
</div>	
<script>
	/*slider 관련 기능*/
	setInterval(function () {
	    moveRight();
	}, 3000);
	var slideCount = $('#slider ul li div').width();
	var slideWidth = $('#slider ul li').width();
	var slideHeight = $('#slider ul li').height();
	var sliderUlWidth = slideCount * 5;
	
	$('#slider').css({ width: slideWidth*2 });
	
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
	
	function deleteConfirm(){
		var fid = document.getElementById("deleteConfirm").value;
		var cnfm = confirm("삭제 하시겠습니까?");

		if(cnfm){
			document.location.href = "snsDeleteAction.sns?feed_id="+fid;
		}else{
			return false;
		}
	}
	function updateConfirm(){
		var fid = document.getElementById("deleteConfirm").value;
		var cnfm = confirm("수정 하시겠습니까?");

		if(cnfm){
			document.location.href = "snsUpdateDataAction.sns?feed_id="+fid;
		}else{
			return false;
		}
	}
	$(function(){
		/* 좋아요 버튼 눌렀을 때 바로 DB작업하기*/
		$(".buttonlike").click(function(){  
			//버튼 div의 value값으로 feed_id를 넣어놨음
			var feed_id= $(this).attr("value");
			var cust_id= $("input:hidden[name=cust_id]").val();
			if(cust_id==undefined){
				alert("좋아요를 이용하시려면 로그인을 실행해주세요");
			}else{ //아직 좋아요버튼을 누르지 않은 상태일때
				$.ajax({
					url : "snsHeartAction.sns?feed_id="+feed_id+"&cust_id="+cust_id,  
					dataType : "html",
					//data : "post",
					success : function(check){
						//alert("");
					}
				});

				var src1 = $(this).attr("src");
				//alert(src1);
				if(src1=="img/sns/heart-fill.png"){
					$(this).attr("src","img/sns/heart-add-line.png");
				}else{
					$(this).attr("src","img/sns/heart-fill.png");
				}

			}
		});

		/* 팔로우 버튼 눌렀을 때 바로 DB작업하기*/
		$(".buttonfollow").click(function(){  
			//버튼 div의 value값으로 feed_id를 넣어놨음
			var cust_following= $(this).attr("value");   //로그인 한 사람이 팔로잉하는 아이디
			var cust_id= $("input:hidden[name=cust_id]").val();  //로그인 한 사람의 아이디
			if(cust_id==undefined){
				alert("팔로우를 이용하시려면 로그인을 실행해주세요");
			}else{ //아직 좋아요버튼을 누르지 않은 상태일때
				$.ajax({
					url : "snsFollowAction.sns?cust_following="+cust_following+"&cust_id="+cust_id,  
					dataType : "html",
					//data : "post",
					success : function(check){
						//alert("");
					}
				});
			//내가 누른 버튼의 아이콘 변경. 그리고 같은 글쓴이를 공유하고 있는 다른 버튼들도 팔로우 버튼 자동적으로 변경 
			var src1 = $(this).attr("src");
			if(src1=="img/sns/user-unfollow-line.png"){
				$(this).attr("src","img/sns/user-follow-fill.png");
				$(".buttonfollow[value="+cust_following+"]").attr("src","img/sns/user-follow-fill.png");
			}else{
				$(this).attr("src","img/sns/user-unfollow-line.png");
				$(".buttonfollow[value="+cust_following+"]").attr("src","img/sns/user-unfollow-line.png");
			}
			}
		});
		

	});
</script>	
<!-- footer -->
<footer>
	<jsp:include page="footer.jsp" />
</footer>
</body>
</html>