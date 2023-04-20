<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>집치레</title>
</head>
<style>
.wrap {
	width: 1900px;
	margin-left: auto;
	margin-right: auto;
}

#csBannerFixed {
	height: 100%;
	width: 190px;
	background: #FFFFFF;
	border-left: 1px solid #e1e1e1;
}

.css-main-img {
	width: 1280px;
	height: 550px;
	display: block;
	margin: 0 auto;
}

.css-title {
	display: flex;
	width: 100%;
	padding-top: 20px;
}

.css-section-all {
	width: 1280px;
	height: auto;
	margin: 0 auto;
}

.css-chire-img { /*커뮤니티,고수,스토어 모두의 이미지*/
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 42px;
}

.img-pic {
	width: 400px;
	height: 300px;
}

.css-chire-imgline {
	padding-top: 20px;
}

.css-text {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 42px;
	padding-top: 20px;
}

.css-text-area {
	width: 400px;
	height: 200px;
}

.fixed-banner {
	height: 100%;
	width: 490px;
	background: #FFFFFF;
	border-right: 1px solid #e1e1e1;
}

.fixed-banner {
	position: fixed;
	_position: absolute;
	top: 0px;
	left: 0px;
	z-index: 100000;
}

.sns-screen {
	position: relative;
}

.fixed-sns-img {
	width: 415px;
	height: 550px;
	padding: 20px;
}

.sns-text-title {
	display: flex;
	align-items: center;
	justify-content: space-around;
	padding-top: 30px;
}

.sns-user-area {
	display: flex;
	flex-direction: column;
	justify-content: space-evenly;
	align-items: center;
}

.sns-id-hesh {
	width: 415px;
	height: 100px;
}

.sns-user-img {
	width: 5rem;
	height: 5rem;
	border-radius: 50px;
	margin-right: 0.75rem;
	background-color: gray;
}

.sns-user {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	padding-left: 20px;
}

.sns-like {
	display: flex;
	width: 50px;
	height: 50px;
	padding-top: 20px;
}

.hash-tag {
	display: flex;
}

.sns-text-area {
	display: flex;
	width: 100%;
}

.fixed-banner-scroll {
	overflow-y: auto;
	overflow-x: hidden;
	height: 100%;
}

.fixed-banner-scroll::-webkit-scrollbar {
	display: none;
}

.user {
	display: flex;
	align-items: center;
}

.out {
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
	padding-right: 30px;
	font-size: 50pt;
}

.in {
	position: fixed;
	_position: absolute;
	top: 90px;
	left: 20px;
	z-index: 100000;
	font-size: 50pt;
	background-color: #97939375;
	border-radius: 300px;
	width: 91px;
	height: 91px;
	text-align: center;
	align-items: center;
	line-height: 1.5;
}
</style>
<body>
	<div class="wrap">
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
		<!-- 이미지 영역 -->
		<img src="img/gosu/mainimg.jpg" class="css-main-img" />

		<div class="css-section-all">
			<section>
				<article>
					<div class="css-title">
						<span>집치레에서 이용 할 수 있는 것</span>
					</div>

					<!-- 커뮤니티/스토어/고수의 이미지 및 설명 영역 -->
					<div class="css-chire-imgline">
						<div class="css-chire-img">
							<img src="img/gosu/bestgosu1.jpg" class="img-pic" /> <img
								src="img/gosu/bestgosu2.jpg" class="img-pic" /> <img
								src="img/gosu/bestgosu3.jpg" class="img-pic" />
						</div>
					</div>
				</article>

				<article>


					<div class="css-text">

						<div class="css-text-area">
							<h3>사진설명</h3>
							<li>커뮤니티 안에서는 글을 작성할 수 있으며, 인테리어에 관한 정보를 볼 수 있습니다.<br>
								또한,각종 정보를 공유하고 sns기능과 같이 팔로우를 하고,좋아요 등 많은 기능을 사용할 수 있습니다.
							</li>
						</div>

						<div class="css-text-area">
							<h3>사진설명</h3>
							<li>스토어 안에서는 중고거래 글을 작성할 수 있으며, 상품을 중고거래로 직접 판매할 수 있습니다.<br>
								또한, 인테리어에 관련된 상품을 구매할 수 있습니다.
							</li>
						</div>

						<div class="css-text-area">
							<h3>사진설명</h3>
							<li>바치에서는 바치를 등록하여 직접 서비스 판매자가 될 수 있습니다.<br> 또한,고객으로
								서비스를 구매할 수 있으며 ,견적요청을 통해 많은 정보를 얻을 수 있습니다.
							</li>
						</div>

					</div>


				</article>
			</section>
		</div>


		<div style="margin-left: auto; margin-right: auto;">
			<jsp:include page="footer.jsp" />
		</div>

	</div>
	<div class="in">></div>
	<div class="fixed-banner">
		<div class="fixed-banner-scroll">

			<div class="sns-screen">
				<div class="out">></div>

				<span class="sns-text-title">집치레 sns</span>



				<!-- sns영역 -->
				<div class="sns-user-area">
					<img src="img/gosu/bestserv1.jpg" class="fixed-sns-img" />


					<div class="sns-user">
						<div class="user">
							<div class="sns-user-img"></div>
							<span>아이디</span>
						</div>

						<div>
							<img src="img/store/likes/dislikes.png" class="sns-like">
						</div>
						<div class="hash-tag">#인스타그램</div>
						<div class="sns-text-area">글쓰기영역이 잘 되는지 확인하는 영역입니다.제대로 되는 지
							확인 부탁드립니다.</div>
					</div>
				</div>



				<div class="sns-user-area">
					<img src="img/gosu/bestserv1.jpg" class="fixed-sns-img" />


					<div class="sns-user">
						<div class="user">
							<div class="sns-user-img"></div>
							<span>아이디</span>
						</div>

						<div>
							<img src="img/store/likes/dislikes.png" class="sns-like">
						</div>
						<div class="hash-tag">#인스타그램</div>
						<div class="sns-text-area">글쓰기영역이 잘 되는지 확인하는 영역입니다.제대로 되는 지
							확인 부탁드립니다.</div>
					</div>
				</div>







			</div>










		</div>


	</div>
	<script>
$(document).ready(function(){
$(".out").on("click",function(){
	$(".fixed-banner").css({'left':"-100%"});
	});
$(".in").on("click",function(){
	$(".fixed-banner").css({'left':"0"});
	});
});
</script>
</body>
</html>