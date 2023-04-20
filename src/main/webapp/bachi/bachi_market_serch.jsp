<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%request.setCharacterEncoding("utf-8");%>
   <%@page import="java.util.ArrayList"%>
    <%@page import="dto.Bachi_market"%>
     <%@page import="dto.Bachi_product"%>
     <%@page import="java.lang.*" %>
      <%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<style>
@import url('https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css');

html{
    font-family: 'NanumSquare';
}

.wrap{
	width:1900px;
	margin:0 auto;
}
#market_picture{
width:480px;
height: 320px;
}
.market{
width:416px;
text-align: left;
float: left;


    font-size: 1rem;
}
article{height: auto;}
.search_mark{display:flex;flex-wrap: wrap;margin-bottom: 50px;border-color: #bdbdbd;border-radius: 3px;padding: 10px; gap: 3px}
.market_section{width:1280px;margin-left:auto;margin-right:auto;}
#market_text{font-size: 16pt;}
.market_re{margin-bottom: 10px;margin-left: 490px}
.css-whide{display: grid;grid-template-columns: repeat(3, 1fr);gap: 16px;}

.page-title{font-size: 1.7rem;
    font-weight: 500;
    line-height: normal;
    margin: 0;}
.css-price{
     display: flex; 
}
.market h3{
    font-weight: 400;
    line-height: normal;
    margin: 0;
    word-break: break-word;
}
.market .css-category{
display:flex;
margin: 0.75rem 0 0;
    color: #737373;
    font-size: .75rem;}
.css-page-head{    margin: 0;}
.search_mark select{-webkit-appearance: none;}
.css-select-box{border-radius: 3px;transition: border-color .2s,box-shadow .2s,background-color .2s;
    display: block;
    box-sizing: border-box;
    padding: 0 15px;
    line-height: 40px;
    border: 1px solid #9E9E9E;
    background-color: #fff;
    color: #9E9E9E;
        width: 120px;
    }
    
select:focus {
  outline: none; /* 포커스 시, 테두리 제거 */
  border-color: #636363; /* 경계선 색 변경 */
}

.select-input__icon{
        position: absolute;
    top: 10px;
    right: 10px;
    padding: 5px;
    font-size: 0;
    cursor: default;
    color: rgba(0,0,0,.3);
    pointer-events: none;
    }
.select-input {
    position: relative;
}
.input-group {
    -webkit-box-flex: 1;}
.css-select-box2 {
    display: inline-block;

    width: auto;
}
option {
    font-weight: normal;
    display: block;
    white-space: nowrap;
    min-height: 1.2em;
    padding: 0px 2px 1px;
}
.css-search-text:focus {
  outline: none; /* 포커스 시, 테두리 제거 */
  border-color: #636363; /* 경계선 색 변경 */
}
.css-search-text{
padding:0 10px;
border: 1px solid #9E9E9E;
width:400px;
height: 40px
}
.css-search-button{
width: 100px;
height: 43px;
color: white;
background-color: #789849;
border-radius: 3px;
    border: none;
    cursor: pointer;
}
.css-search-button:active {
	background-color: #5d433d;
	
}
.css-gosu-id{
display: flex;
align-items: center;
padding-top: 3px;
}
.css-cate-gosu{
display: flex;
justify-content: space-between;
}
.css-search-null{
display: flex;
align-items: center;
width: 1280px;
justify-content: center;
padding-bottom: 13px;
}
</style>
<body>
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
    <div class="market_section">
<jsp:useBean id="market" class="dao.Gosu_mark">

  <div class="css-page-head">
                <div class="page-title"><h1>바치 상점</h1></div>
          </div> 
           <form action="bachi_market_serch.jsp">
           <div class="search_mark">
           
        <div class="input-group select-input css-select-box2">
		<select name="market_tag" class="css-select-box">
		<option value="all">전체</option> <!-- 아이디,게시글제목,게시글내용에 모두 포함하는 검색어 -->
		<option value="cust_id">아이디</option>
		<option value="market_title">게시글 제목</option>
		<option value="market_text">게시글 내용</option>
		</select>
		
		<span class="select-input__icon"><svg class="icon" width="10" height="10" preserveAspectRatio="xMidYMid meet" style="fill: currentcolor;"><path fill-rule="evenodd" d="M0 3l5 5 5-5z"></path></svg></span>
	</div>   	
		<input type="text" name="serch" class="css-search-text" placeholder="검색어를 입력하세요.">
		<input type="submit" value="검색" class="css-search-button">
		<div class="market_re">
		 <input type="button" onclick="location.href='bachi_market_re.jsp'" value="등록하기" class="css-search-button"></div>
		</div>

<div class="css-whide">

 
<%

String serch = request.getParameter("serch");
String value = request.getParameter("market_tag");
String all = request.getParameter("all");

String serch_id = null;
String serch_title = null;
String serch_text = null;



if(value.equals("all")){
	serch_id = serch;
	serch_title = serch;
	serch_text = serch;
	
}else if(value.equals("cust_id")){
	serch_id = serch;
	
}else if(value.equals("market_title")){
	serch_title = serch;
}else if(value.equals("market_text")){
	serch_text = serch;
}

try{

ArrayList<Bachi_market> market_list = market.gosu_mark_sel_custom(serch_id, serch_title, serch_text); 

if(market_list.size() > 0) {

for(int i= 0;i < market_list.size();i++){
	
	//out.println("<tr><a href='bachi_market_det.jsp?market_id="+market_list.get(i).getMarket_id()+"'>");
	
			//out.println("<td id='cust_id'>"+"<a href='bachi_market_det.jsp?market_id="+market_list.get(i).getMarket_id()+"'>"+market_list.get(i).getCust_id()+"</td>");
			out.println("<div class='market'>");
			String serverImagePath = request.getContextPath() + "/image/sm_" + market_list.get(i).getMarket_picture();
			%>
			<a href='bachi_market_det.jsp?market_id=<%=market_list.get(i).getMarket_id()%>'>
	    <img src='<%=serverImagePath%>' style='width:416px;height: 280px; border-radius:8px;'></a>
			<%
			
			//out.println("<a href='bachi_market_det.jsp?market_id="+market_list.get(i).getMarket_id()+"'>"+"<img src='../"+market_list.get(i).getMarket_picture()+"' style='width:416px;height: 280px; border-radius:8px;'></a>");
			out.println("<div class='css-cate-gosu'>");
			out.println("<div class='css-category'><a href='bachi_market_det.jsp?market_id="+market_list.get(i).getMarket_id()+"'>"+market_list.get(i).getGosu_menu1()+"/"+market_list.get(i).getGosu_menu2()+"</a></div>");
			out.println("<div class='css-gosu-id'><a href='bachi_market_det.jsp?market_id="+market_list.get(i).getMarket_id()+"'>"+market_list.get(i).getCust_id()+"</a></div>");
			out.println("</div>");
			out.println("<h3>"+"<a href='bachi_market_det.jsp?market_id="+market_list.get(i).getMarket_id()+"'>"+market_list.get(i).getMarket_title()+"</a></h3>");
			out.println("<div class='css-price'><strong><font size='5pt'><a href='bachi_market_det.jsp?market_id="+market_list.get(i).getMarket_id()+"'>"+market_list.get(i).getGosu_price()+"원~</a></strong></font></div>");
			out.println("</div>");
				}
		
		}else{
			out.println("<div class='css-search-null'>");
			out.println("결과값이 없습니다.");
			out.println("</div>");
		}
	}catch(Exception e){
		e.printStackTrace();
	}

%>



		</form>
		</div>
		</jsp:useBean>

        </article>

        </section>

    
    <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>
</div>
</body>
</html>