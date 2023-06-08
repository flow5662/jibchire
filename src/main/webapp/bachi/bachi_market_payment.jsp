<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>바치상점</title>
</head>
<style>
.wrap{margin:0 auto;}
.container-pay{width:70%; margin:0 auto;}
.payment-title{padding: 15px 0px 15px 0px;}
.product{padding: 10px 0px 10px 0px;}
.product-option li{display: flex;flex-direction: row;gap: 50px;}
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
	<div class="container-pay">
	<div class="payment-title">
	<h1>주문결제</h1>
	</div>
	
	<!-- mybatis spring작업 -->
	<div class="product"><strong>주문상품</strong></div>
	<ul class="product-option">
	<li><span>상품명</span>상품~~~~</li>
	<li><span>상품옵션</span>옵션~~~~</li>
	<li><span>상세내용</span>내용~~~</li>
	<li><span>상품가격</span>가격~~~</li>
	</ul>
	<input type="button" value="결제하기" id="paymarket">
	</div>
	
	
	
	    <div style="margin-left: auto; margin-right: auto;">
<jsp:include page="footer.jsp" />
</div>
	</div>

</body>
  <script src="https://js.tosspayments.com/v1/payment"></script>
</head>
<body>
  <script>
    // ------ 클라이언트 키로 객체 초기화 ------
    var clientKey = 'test_ck_ADpexMgkW36yzJOOdW48GbR5ozO0'
    var tossPayments = TossPayments(clientKey)
    
    $("#paymarket").on("click",function(){
    	
    
    // ------ 결제창 띄우기 ------
    tossPayments.requestPayment('카드', { // 결제수단 파라미터 (카드, 계좌이체, 가상계좌, 휴대폰 등)
      // 결제 정보 파라미터
      // 더 많은 결제 정보 파라미터는 결제창 Javascript SDK에서 확인하세요.
      // https://docs.tosspayments.com/reference/js-sdk
      amount: 100, // 결제 금액
      orderId: 'UMFsQ2JkSFSCbec3samPc', // 주문 ID(주문 ID는 상점에서 직접 만들어주세요.)
      orderName: '테스트 결제', // 주문명
      customerName: '김토스', // 구매자 이름
      successUrl: 'https://docs.tosspayments.com/guides/payment/test-success', // 결제 성공 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
      failUrl: 'https://docs.tosspayments.com/guides/payment/test-fail', // 결제 실패 시 이동할 페이지(이 주소는 예시입니다. 상점에서 직접 만들어주세요.)
    })
    // ------결제창을 띄울 수 없는 에러 처리 ------
    // 메서드 실행에 실패해서 reject 된 에러를 처리하는 블록입니다.
    // 결제창에서 발생할 수 있는 에러를 확인하세요. 
    // https://docs.tosspayments.com/reference/error-codes#결제창공통-sdk-에러
    .catch(function (error) {
      if (error.code === 'USER_CANCEL') {
        // 결제 고객이 결제창을 닫았을 때 에러 처리
      } else if (error.code === 'INVALID_CARD_COMPANY') {
        // 유효하지 않은 카드 코드에 대한 에러 처리
      }
    });
   });
  </script>
</html>