<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%request.setCharacterEncoding("utf-8");%>
   <%@page import="java.util.ArrayList"%>
    <%@page import="dto.Bachi_market"%>
     <%@page import="dto.Bachi_product"%>
<!DOCTYPE html>
<html>
<%
String market_id = request.getParameter("market_id");
String cust_id = (String)session.getAttribute("cust_id");
String cust_pw = (String)session.getAttribute("cust_pw");
%>



<head>

<style>
.wrap{
	width:1900px;
	margin-left:auto;
	margin-right:auto;
}
.market_section{width:1280px;margin-left:auto;margin-right:auto;}
.css-section-market-re{
display: flex;
    margin-top: 0;
    background: none;
    padding-top: 3rem;
    justify-content: space-between;
    flex-wrap: wrap;
}
.css-gosu_menus{font-size: .75rem;
    margin-bottom: 0;}
.css-bord-menu{flex-wrap: wrap;
    display: flex;
    font-size: .875rem;
    margin-left: -40px;
}
.no-space{padding-top: 0;
    padding-bottom: 0;}
.flex-aside-left{  max-width: 60rem;
    padding-bottom: 2rem;}
.flex-aside-right{width: 31rem;
    z-index: 1;}
.product-title{0.75rem 0 1.5rem;}
.flex-controller{}
.product-option{ 
    display: flex;
    height: 300px;
    padding: 0;
    flex-direction: column;
}
.css-option-body{
    padding: 0;
    overflow-y: auto;
}
.css-option-box{
width: 90%;
display: flex;
    flex-direction: column;
    border: 0.0625rem solid #e1e1e1;
    border-radius: 8px;
    margin-bottom: 0.75rem;
    padding: 1rem;
}

.css-option-title{display: flex;}
.css-option-price{margin-top: 1rem;
    font-size: 1.25rem;}
.css-option-text{    display: flex;flex-direction: column;}
.css-button-submit{
display: flex;
justify-content: space-evenly;
    padding-top: 30px;
}
.css-button-sub{
width: 490px;
    height: 60px;
    background-color:#789849;
    color: white;
    border: none;
    border-radius: 10px;
}
.css-button-history-delete{
 padding-top: 30px;
display: flex;
justify-content: space-between;
}
.css-button-his{
width: 230px;
height: 50px;
    border: 1px solid lightgray;
    
    border-radius: 10px;
    }
.css-button-del{
width: 230px;
height: 50px;
    background-color:#b1ac93;
    color: white;
    border: none;
    border-radius: 10px
    
}
.css-section-bottom{
display: flex;
justify-content: space-between;
padding-top: 30px;
}
.css-section-text{
display: flex;
    align-items: center;
    justify-content: center;
    height: 50px;
    border: none;
    padding: 0 98px;
    margin-bottom: 0;
    border-bottom: 2px solid #ddd;
}
.css-text-name{
display: flex;
align-items: center;
}
.text-det{
        font-size: 16pt;
    font-weight: 700;
    color: #323232;
}
.css-section-bottom-area{

height: auto;
padding-bottom: 20px;
}
.css-market-sangse-text{

padding-top:50px;
height: auto;
}
.gosu-user-img{
width: 5rem;
    height: 5rem;
    border-radius: 50px;
    margin-right: 0.75rem;
    background-color: gray;
}
.gosu-user{
display: flex;
align-items: center;
padding-bottom: 50px;

}
.gosu-user-id{
display: flex;
flex-direction: column;
}
.gosu-user-adrress{
display: flex;
align-items: flex-end;
}
.ad{
width: 4.375rem;
    margin-right: 2rem;
    font-size: .875rem;
    color: #737373;
}
.user-text-section-gosu{
margin-bottom: 0;
    font-size: .875rem;
    line-height: 1.71;
    white-space: pre-line;
        width: 750px;
    
}
</style>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<!-- 상세 페이지 -->

<!-- 헤더 -->
    <div class="wrap">
               <header>
    <% 
		request.setCharacterEncoding("utf-8"); 
		String id = (String) session.getAttribute("ID");  //session값에서 아이디 가져올 때 null이면 일반헤더, 아니면 로그인헤더
		if((id==null)){
	%>
		<jsp:include page="header.jsp" />
		<!-- 구매하는 화면으로 강제로 넘겨주기 -->
	<%
		}else{
	%>
		<jsp:include page="header_login.jsp" />
	<%
		}
	%>
	</header>
    <section>
    	<article style="width: 100%; display: inline-block;">
    	 <div class="market_section">
    		<jsp:useBean id="market" class="dao.Gosu_mark">
    		<form action="bachi_det_corr.jsp">
    	
    		<div class="css-section-market-re">
    		<% 
    		int mark = Integer.parseInt(market_id);
    		ArrayList<Bachi_market> market_list_cust = market.gosu_mark_sel_det(mark);
    		%>
    		<div class="flex-aside-left">
    		<%
    		//out.println("<li id='market_id' name='market_id'>"+market_list_cust.get(0).getMarket_id()+"</li>");
	    	//out.println("<li name='cust_id'>"+market_list_cust.get(0).getCust_id()+"</li>");
	    	
	    		String serverImagePath = request.getContextPath() + "/image/sm_" + market_list_cust.get(0).getMarket_picture();
		%>
		
    <img src='<%=serverImagePath%>' style='width:750px;height: 500px; border-radius:8px;'>
		<%
	    	
	    	//out.println("<img src='../"+market_list_cust.get(0).getMarket_picture()+"' style='width:750px;height: 500px; border-radius:8px;'></li>");
	    	//out.println("<li name='gosu_id'>"+market_list_cust.get(0).getGosu_id()+"</li>");
	    	//out.println("<li name='market_text'>"+market_list_cust.get(0).getMarket_text()+"</li>");
	    	//out.println("<li name='title'>"+market_list_cust.get(0).getMarket_title()+"</li>");
	    	
	    	//out.println("<li name='gosu_price'>"+market_list_cust.get(0).getGosu_price()+"원"+"</li>");
	    		
    		
    		%>
    			<div class="css-section-bottom-area">
    		<div class="css-section-bottom">
    		<div class="css-text-name">
    			<div class="css-section-text"><span class="text-det">상세설명</span></div>
    			<div class="css-section-text"><span class="text-det">리뷰</span></div>
    			<div class="css-section-text"><span class="text-det">문의</span></div>
    		</div>
    		</div>
    		
    		<div class="css-market-sangse-text">
    		
    		<div class="gosu-user">
    		<div class="gosu-user-img"></div>
    		<div class="gosu-user-id">
    		
    		<span><%out.println(market_list_cust.get(0).getCust_id()); %></span>
    		<span><font color="#yyycc">★★★★★</font></span>
    		</div>
    	
    		</div>
    		
    			<div class="gosu-user-adrress">
    		<span class="ad">서비스 지역</span><span class="ad">지역</span>
    		</div>
    		
    		<div class="user-text-section-gosu">
    		<%out.println(market_list_cust.get(0).getMarket_text()); %>
    		
    		</div>
    		
    		
    		</div>
    		</div>
    		
    		
    		
    	</div>
    	
    	<div class="flex-aside-right">
    	<div class="flex-controller">
    	<div class="no-space"> 
    	<% 
    	out.println("<ul class='css-gosu_menus css-bord-menu'>"+"<li>"+market_list_cust.get(0).getGosu_menu1()+"</li>"+"/<li>"+market_list_cust.get(0).getGosu_menu2()+"</li></ul>");
    	%>
    	<div class="product-title">
    	<%out.println("<h3>"+market_list_cust.get(0).getMarket_title()+"</h3>"); %>
    	</div>
    	</div>
    	
    	</div>
    	<div class="css-option-body">
    	<div class="css-option-group">
    	<div class="product-option">
    		<div class="css-option-box">
    			<div class="css-option-title">옵션 제목입니다.</div>
    			<div class="css-option-price"><strong><% out.println(market_list_cust.get(0).getGosu_price()); %>원</strong></div>
    			<div class="css-option-text">옵션 텍스트입니다.<br>
    			옵션 내용을 추가합니다.<br>
    			현재는 옵션 기능이 구현되지 않습니다.<br>
 				(마켓)의 게시판용도로 사용됩니다.
    			</div>
    		</div>
    		<div class="css-option-box">
    			<div class="css-option-title">옵션 제목입니다.</div>
    			<div class="css-option-price"><strong>n원</strong></div>
    			<div class="css-option-text">옵션 텍스트입니다.<br>
    			옵션 내용을 추가합니다.<br>
    			현재는 옵션 기능이 구현되지 않습니다.<br>
 				(마켓)의 게시판용도로 사용됩니다.
    			</div>
    		</div>
    		<div class="css-option-box">
    			<div class="css-option-title">옵션 제목입니다.</div>
    			<div class="css-option-price"><strong>n원</strong></div>
    			<div class="css-option-text">옵션 텍스트입니다.<br>
    			옵션 내용을 추가합니다.<br>
    			현재는 옵션 기능이 구현되지 않습니다.<br>
 				(마켓)의 게시판용도로 사용됩니다.
    			</div>
    		</div>
    	</div>
    	</div>
    	</div>
    	<div class="css-button-submit">
    	<input type="submit" value="수정" class="css-button-sub">
    	</div>
    	<div class="css-button-history-delete">
    	<input type="button" value="이전" onclick="window.history.back()" class="css-button-his">
    	<input type="button" value="삭제" onclick="deleteMarket()" class="css-button-del">
    	</div>
    		</div>
    		
    	
    		
    		
    		
    		
    		
    		
    		
    		<input type="hidden" name="market_id" value="<%=market_id %>">
    		<input type="hidden" name="gosu_id" value="<%=market_list_cust.get(0).getGosu_id()%>">
    		<input type="hidden" name="market_picture" value="<%=market_list_cust.get(0).getMarket_picture()%>">
    		<input type="hidden" name="market_text" value="<%=market_list_cust.get(0).getMarket_text()%>">
    		<input type="hidden" name="market_title" value="<%=market_list_cust.get(0).getMarket_title()%>">
    		<input type="hidden" name="gosu_menu1" value="<%=market_list_cust.get(0).getGosu_menu1()%>">
    		<input type="hidden" name="gosu_menu2" value="<%=market_list_cust.get(0).getGosu_menu2()%>">
    		
    		
    		 
    		
    		
    		
<script>
function deleteMarket() {
	  var marketId = '<%=market_list_cust.get(0).getMarket_id()%>';
	  $.ajax({
	    type: "POST",
	    url: "bachi_market_det_del.jsp",
	    data: {market_id: marketId},
	    success: function(response) {
	      // 성공적으로 삭제되면 어떤 작업을 수행하고자 한다면 여기에 작성합니다.
	      alert("상품이 삭제되었습니다.");
	     	location.href="bachi_market.jsp";
	    },
	    error: function() {
	      // 실패 시 처리할 작업을 여기에 작성합니다.
	      alert("상품 삭제에 실패했습니다.");
	    }
	  });
	}

</script>    		
    		

    		
	

    		</form>
    		
    	
    		
    		</jsp:useBean>
    	
    	
    	</div>
    	
    	</article>
    
    
    
    </section>
    
    <div style="margin-left: auto; margin-right: auto;">
        <jsp:include page="footer.jsp" />
    </div>
    
    
    </div>
    
    
    
    
</body>

</html>