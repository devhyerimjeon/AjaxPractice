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
<title>AjaxTest02.jsp</title>
<style type="text/css">
	.short{ width: 30px; }
</style>

<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript">
	
	function sum()
	{
		// 데이터 수집
		var n1 = document.getElementById("num1").value;
		var n2 = document.getElementById("num2").value;
		
		// URL 구성
		var url = "test02.do?n1=" + n1 + "&n2=" + n2;
		
		// XMLHttpRequest 객체(AJAX 객체) 생성
		// ajax 변수, creatAjax() 메소드 모두 'js/ajax.js' 에서 선언됨 → 가져다 쓰기
		ajax = createAjax();
		
		// 'GET' : 요청 방식(POST 사용 가능, POST 사용 시 헤더 추가)
		// 'url' : AJAX 요청 페이지 = 데이터를 수신하고 응답하는 페이지
		// 'true': boolean → true(비동기), false(동기). 동기 사용하면 AJAX 처리되지 않음
		ajax.open("GET", url, true);
		//-- 실제 서버와의 연결이 아니고 일종의 환경설정 부분으로 이해하는 것이 좋다.
		//   실제 서버 연결은 나중에...
		
		// ajax 객체(XMLHttpRequest 객체)의 readyState 속성은
		// 각 단계별로 변화되며 0 부터 4까지 순차적으로 증가한다.
		// 그 때마다 'readystatechange' 이벤트가 발생한다.
		ajax.onreadystatechange = function()
		{
			// 부르고 싶을 때 부르도록 설계하는 것이 아니라
			// 상황에 따라 '불려지도록' 설정 → '콜백 함수' 라고 한다.
			
			// 그 중에서(0부터 4까지의 상태 중에서)
			// 4가 되는 순간이 요청했던 서버로부터 응답이 완료된 시점이므로 (진동벨이 울리는 순간)
			// 4인 경우 업무를 진행한다.
			if(ajax.readyState==4)
			{
				// 서버로부터 응답이 완료되었다 하더라도
				// 그 과정에서 데이터가 올바른 것인지 or 에러 메세지를 받은 것인지
				// 알 수 없으므로 서버로부터 응답 코드를 확인해야한다.
				if(ajax.status==200)
				{
					// 업무 진행
					//-- 업무 코드를 외부로 추출
					callBack();
				}
			}
		}
		
		// 실제 서버에서 AJAX 요청을 한다. (즉, 이 부분이 진짜 연결 작업이다.)
		// GET 방식으로 데이터를 전송하는 경우 인자값을 "" 로 구성할 것
		// POST 방식으로 데이터를 전송하는 경우 인자값에 데이터를 넣는다.
		// 현재는 GET 방식의 요청이므로 비워두는 대신 ""로 인자값을 구성한다.
		ajax.send("");
	}//end sum()
	
	
	// 추출된 업무 코드
	//-- AJAX 요청이 완료된 후 호출되는 최종적인 업무 처리 함수
	function callBack()
	{
		// 여기서는 두 가지 방법 중 하나로 데이터를 가져온다.
		
		// 1. 서버에서 응답한 데이터가 텍스트일 경우 (주로 단일 데이터)
		var data = ajax.responseText;
		
		// 2. 서버에서 응답한 데이터가 XML일 경우 (주로 다량의 데이터)
		//var data = ajax.responseXML;
		
		// 받아온 데이터를 업무에 적용한다.
		document.getElementById("result").value = data;
	}
	
</script>

</head>
<body>

<div>
	<h1>AJAX 기본 실습</h1>
	<hr>
</div>

<input type="text" id="num1" class="short">
+
<input type="text" id="num2" class="short">
<input type="button" value=" = " onclick="sum()">
<input type="text" id="result" class="short">
<br><br>

<h2>같은 페이지 내에 있는 기타 다른 요소들</h2>

<input type="text">
<br>

<input type="checkbox" name="check" value="check1">
<input type="checkbox" name="check" value="check2">
<br>
<input type="radio" name="rdo" value="rdo1">
<input type="radio" name="rdo" value="rdo2">
<br>
<select id="sel">
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
</select>

<br><br>



</body>
</html>