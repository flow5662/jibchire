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
.menu_all{
display: flex;
    flex-direction: column;
    align-items: center;
    width: 1280px;
    margin: 0 auto;
    padding-top: 20px;
    padding-bottom: 20px;
}


.menu_all .menu_section{
display: flex;
    display: flex;
    align-items: center;
    gap: 10px;
}
.menu_all .input_area input[type="text"]{

}
.menu_all .input_area .intro{
width:300px;
height: 90px;
}
.input_time{
display: flex;
 align-items: center;
   gap: 10px;
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
<input type="hidden" name="cust_id" value="<%=id%>" id="cust_id">

<div class="menu_all">
<div class="menu_section">
<h4>카테고리</h4>
<select name="gosu_menu1" id="gosu_menu1">
	<option value="취미">취미</option>
	<option value="자기계발">자기계발</option>
	<option value="레슨">레슨</option>
	
</select>

<select name="gosu_menu2" id="gosu_menu2">
	<option value="요리">요리</option>
	<option value="컨설팅">컨설팅</option>
	<option value="수학레슨">수학레슨</option>
	<option value="음악레슨">음악레슨</option>
</select>
</div>

<div class="input_area">
<h4>소개글</h4>
<input type="text" name="gosu_intro" class="intro"></div>
<div class="input_area">
<h4>경력</h4>
<input type="text" name="gosu_car" placeholder="숫자만 입력해주세요." oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
</div>
<div class="input_area">
<h4>활동가능지역</h4>
<input type="text" name="gosu_reg"></div>
<div class="input_area">
<h4>사업자번호</h4>
<input type="text" name="gosu_comp"></div>
<div class="input_time">
<h4>활동가능시간</h4>
<input type="time" name="worktime_s"> <!-- 스크립트 기능 중 e가 s보다 시간이 빠르면 안됨. -->
<input type="time" name="worktime_e"></div>

<input type="submit" value="바치등록" id="idcheck">
</div>
</form>


    <div style="margin-left: auto; margin-right: auto;">
	<jsp:include page="footer.jsp" />
	</div>
</div>
</body>
<script>
$(document).ready(function(){
    $("#idcheck").click(function(event) { // id 확인 버튼 클릭 시
        event.preventDefault(); // 기본 이벤트인 submit 막기
        $.ajax({
            url : "bachi_select_id.bc",
            data : {cust_id: $("#cust_id").val() },
            type : "post",
            success: function(result){
                if(result === "false"){ // "false" 값이 반환되면
                    alert("중복된 아이디입니다.");
                } else {
                    $("form").submit(); // 중복되지 않은 경우에만 submit 실행
                }
            }
        });
    });
});


const gosu_menu1 = document.getElementById('gosu_menu1');
const gosu_menu2 = document.getElementById('gosu_menu2');

// 대분류 select 요소의 값이 변경될 때 실행되는 함수
function updateSubMenu() {
  // 선택된 대분류의 값에 따라 중분류 select 요소의 option 값을 변경합니다.
  if (gosu_menu1.value === '취미') {
    gosu_menu2.innerHTML = `
      <option value="요리">요리</option>
      <option value="DIY">DIY</option>
    `;
  } else if (gosu_menu1.value === '자기계발') {
    gosu_menu2.innerHTML = `
      <option value="컨설팅">컨설팅</option>
      <option value="어학">어학</option>
    `;
  } else if (gosu_menu1.value === '레슨'){
	  gosu_menu2.innerHTML = `
	      <option value="수학레슨">수학레슨</option>
	      <option value="음악레슨">음악레슨</option>
	    `;
	  
	  
  }
}

// 대분류 select 요소의 값이 변경될 때 updateSubMenu 함수를 실행합니다.
gosu_menu1.addEventListener('change', updateSubMenu);



</script>
</html>