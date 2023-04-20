
$(function(){
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
	$(".optionItem").click(function(){
		var aa = $(this).text();
		alert(aa);
		location.href= "view_board_search.jsp?menuword="+aa;
		$.ajax({
			url : "view_board_search.jsp?menuword="+aa,  
			dataType : "html",
			//data : "post",
			success : function(check){
				alert("목록 리체크 완료");
			}
		});
	});
	
	
	/*
	$(".pic").click(function(){ //게시글 누르면 해당 게시글로 이동
		var pid= $("this>input[type=hidden]").val();     // 선택한 td칸의 뒤에 있는(동위) hidden버튼
		location.href="view_read.jsp?post_id="+pid   // 왜 자꾸 3이 나오지?
	});
	*/
	
	
});