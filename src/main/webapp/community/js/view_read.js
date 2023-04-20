$(function(){		
		$("input:button[value=삭제]").click(function(){  // 글삭제 버튼 눌렀을 때 한 번 더 의도 체크, 확인버튼 누를 때 삭제
			var num = $("#post_id").val();
			var con = confirm("삭제하시겠습니까?");
			if(con){
				location.href='delete_write.jsp?post_id='+num; //url로 값을 바로 줘서 다음페이지에서 아무런 그거 없어도 되니까
			}
		});
	});