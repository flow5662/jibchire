<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.warp{
margin:0 auto;
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
<form method="post" action="bachi_info.bc"> 
<input type="hidden" name="cust_id" value="<%=id%>">

대분류<select name="gosu_menu1">
	<option value="취미">취미</option>
</select>

중분류<select name="gosu_menu2">
	<option value="요리">요리</option>
</select>

소개글<input type="text" name="gosu_intro">
<input type="text" name="gosu_car" placeholder="숫자만 입력해주세요." oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
<input type="text" name="gosu_reg">
<input type="text" name="gosu_comp">
<input type="time" name="worktime_s"> <!-- 스크립트 기능 중 e가 s보다 시간이 빠르면 안됨. -->
<input type="time" name="worktime_e">

<input type="submit" value="바치등록">

</form>


    <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>
</body>

</html>