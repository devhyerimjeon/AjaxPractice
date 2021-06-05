<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AjaxTest05.jsp</title>
<link rel="stylesheet" href="<%=cp %>/css/main.css">
<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<style type="text/css">
	#search
	{
		width: 500px;
	}
	#list
	{
		border: 1px solid gray;
		width: 500px;
		
		position: absolute;
		left: 70px;
		top: 134px;
		
		display: none;
	}
	#list .tem { padding: 3px; }
	#list #footer
	{
		background-color: #DDD;
		text-align: right;
		padding: 5px;
		font-size: small;
	}
	
</style>

<script type="text/javascript">

	// 키보드를 누를 때마다 그 때까지의 입력된 단어를 서버로 전송하고,
	// 그에 맞는 추천 검색어를 받아올 수 있다.
	function search()
	{
		// 데이터 수집
		var search = document.getElementById("search").value;
		
		// 테스트
		//alert(search);
		
		// 검색어가 존재할 경우에만 전송하여 ajax 처리할 수 있도록 구성
		// 검색어가 빈칸(" ")이거나 비어있는("") 경우 처리
		// (빈칸인 경우는 비어있는 경우로 replace)
		if(search.replace(" ","") == "")
		{
			document.getElementById("list").style.display="none";
			// 함수 기능 종료
			return;
		}
		
		// 검색어에 입력된 내용이 완성형 한글일 경우에만 키워드 전송하도록 구성
		// (쓰는 도중에 처리되지 않도록) → 정규표현식(/^[가-힣]{1,}$/) 사용
		var regEx = /^[가-힣]{1,}$/;
		
		if(!regEx.test(search))
			return;
		
		// URL 구성
		var url = "test05.do?search=" + search;
		
		// XMLHttpRequest 객체 생성
		ajax = createAjax();
		ajax.open("GET", url, true);
		
		ajax.onreadystatechange = function()
		{
			if(ajax.readyState==4)
			{
				if(ajax.status==200)
				{
					// 업무 내용 추출
					callBack();
				}
			}
		}
		
		ajax.send("");
	}
	
	// 추출된 업무 내용
	//-- XML 목록으로 받아온 검색어들을 적당한 리스트로 생성해서 화면에 출력
	function callBack()
	{
		// XML 문서 객체 수신
		var doc = ajax.responseXML;
		
		// XML 문서의 최상위 엘리먼트 수신 → 지금은 <list>인 상황
		var root = doc.documentElement;
		
		// 하위 엘리먼트 item을 모두 가져옴
		var itemList = root.getElementsByTagName("item");
		
		// items 박스 초기화
		//-- 사용자가 검색어를 지우거나, 키워드 바꿨을 때 이전 것 초기화~~!
		document.getElementById("items").innerHTML = "";
		
		// 추천 검색어 항목에 삽입		
		for(var i=0; i<itemList.length; i++)
		{
			var word = itemList[i].firstChild.nodeValue;
			
			// items 아래에 들어가도록 추가하기
			document.getElementById("items").innerHTML
			 += "<div class='item'>" + word +"</div>";
		}
		
		// 목록을 화면에 보이게 하기 위해 처리
		// (처음에 style에서 설정한 dispaly=none; 해제)
		document.getElementById("list").style.display = "block";
	}

</script>

</head>
<body>

<div>
	<h1>추천 검색어 실습</h1>
	<hr>
</div>

<div>
	검색어
	<input type="text" id="search" class="control" placeholder="검색어를 입력하세요"
	onkeyup="search()">
</div>

<!--
<div id="list">
	<div id="items">
		<div class="item">가사</div>
		<div class="item">가위</div>
		<div class="item">가지</div>
		<div class="item">가방</div>
		<div class="item">가방끈 매듭</div>
		<div class="item">가방끈 매듭 풀기</div>
		<div class="item">가방끈 매듭 만드는 법</div>
		<div class="item">가장자리 다듬기</div>
		<div class="item">가차없이</div>
	</div>
	<div id="footer">
		추천 검색어
	</div>
</div>
-->

<div id="list">
	<div id="items">
		<div class="item"></div>
	</div>
	<div id="footer">
		추천 검색어
	</div>
</div>


</body>
</html>