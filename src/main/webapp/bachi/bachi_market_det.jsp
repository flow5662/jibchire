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
String cust_id = (String)session.getAttribute("ID");
String cust_pw = (String)session.getAttribute("cust_pw");
%>



<head>


<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="style/bachi_market_det.css">
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