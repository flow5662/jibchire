<%@page import="java.util.List"%>
<%@page import="dto.Bachi_match_Been"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<% 
ArrayList<Bachi_match_Been> category = (ArrayList<Bachi_match_Been>)request.getAttribute("match_category");

%>
<body>
<%
// 중복 제거된 리스트 생성
List<String> distinctGosuMenu1List = new ArrayList<String>();
for (Bachi_match_Been categoryItem : category) {
    String gosuMenu1 = categoryItem.getGosu_menu1();
    if (!distinctGosuMenu1List.contains(gosuMenu1)) { //중복되면
        distinctGosuMenu1List.add(gosuMenu1);
    }
}
%>

<select name="gosu_menu1" id="gosu_menu1">
<option value="전체">전체</option>
<% for (String gosuMenu1 : distinctGosuMenu1List) { %>
    <option value="<%= gosuMenu1 %>"><%= gosuMenu1 %></option>
<% } %>
</select>

<select name="gosu_menu2" id="gosu_menu2">
<% for(int i=0;i<category.size();i++){
	out.println("<option value="+category.get(i).getGosu_menu2()+">"+category.get(i).getGosu_menu2()+"</option>");
} %>
</select>
<script>
$(document).ready(function(){
	$("#gosu_menu1").on('change',function(){ //gosu_menu1이라는 select 태그가 변동되었을때
		  var gosu_menu1 = $("#gosu_menu1 option:selected").val(); //select된 값
		  
		  $.ajax({
		    url:"bachi_match_req.bc", //해당 경로에 요청
		    data:{gosu_menu1: gosu_menu1}, //값을 해당 경로에 넣기
		    dataType:"html",
		    type:"post",
		    success: function(menu1) {
		    
		    }
		      });
		  return true;
		  });
	

		$("#gosu_menu2").on('change',function(){
		  var gosu_menu2 = $("#gosu_menu2 option:selected").val();
		   $.ajax({
		    url:"bachi_match_req.bc",
		    data:{gosu_menu2: gosu_menu2},
		    dataType:"html",
		    type:"post",
		    success: function(menu2) {
		    
		    }
		      });
		   return true;
		  });

});



</script>

</body>
</html>