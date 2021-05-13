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
<title>AjaxTest04.jsp</title>
<link rel="stylesheet" href="<%=cp%>/css/main.css">
<style type="text/css">
	#result
	{
		display: inline-block;
		width: 250px;
		color: #F33;
	}
</style>

<script type="text/javascript" src="<%=cp%>/js/ajax.js"></script>
<script type="text/javascript">

	function check()
	{
		// 데이터 수집
		var id = document.getElementById("id").value;
		
		// URL 준비
		var url = "test03.do?id=" + id;
		
		// XMLHttpRequest 객체 생성
		ajax = createAjax();
		
		//환경 설정('open("페이지요청방식", "URL", 동기/비동기)')
		ajax.open("GET", url, true);
		
		ajax.onreadystatechange = function()
		{
			if(ajax.readyState==4)
			{
				if(ajax.status==200)
				{
					// 업무 처리 -- 외부로 추출
					callBack();
				}
			}
		}
		
		ajax.send("");
	}
	
	// 외부로 추출된 업무 처리 코드
	//-- 아이디 중복 검사의 결과를 통보받아 사용자에게 메시지 출력
	//   → span 영역에 id:result 인 부분에 보여지도록
	function callBack()
	{
		var data = ajax.responseText;
		
		// 있으면 1, 없으면 0으로 보내기로 했으므로 정수형 변환
		data = parseInt(data);
		
		if(data==0)
			document.getElementById("result").innerText = "사용 가능한 아이디입니다.";
		else
			document.getElementById("result").innerText = "이미 사용 중인 아이디입니다.";
	}

</script>

<script type="text/javascript">
	
	function search()
	{
		// 데이터 수집 및 url 설정
		var addr = document.getElementById("addr").value;
		var url = "test04.do?addr=" + addr;
		
		ajax = createAjax();
		
		ajax.onreadystatechange = function()
		{
			if(ajax.readyState==4 && ajax.status==200)
				// 외부 함수에서 작업 처리하도록 콜백함수 호출
				callBack2();
		}
		
		ajax.open("GET", url, true);
		ajax.send("");
		
	}
	
	// 우편 번호 검색 결과를 통보받아 사용자에게 안내해 줄 수 있도록 처리
	function callBack2()
	{
		// XML 문서 전체의 참조 객체(흔히 XML 문서 객체라고 함)
		var doc = ajax.responseXML;
		
		// XML에서 documentElement란 <list></list> 처럼 데이터들이 한 태그에 묶여있어야 한다.
		// well-formed XML은 문법 규칙을 잘 지켜서 만든 것.
		// 그 첫 번째 규칙은 모든 엘리먼트들이 route 엘리먼트라고 부를 수 있는,
		// 전체 엘리먼트를 감싸는 엘리먼트 안에 있어야 한다.
		
		// XML 문서의 최상위 엘리먼트를 가져오는 구문
		//-- 현재는 '<list>' 엘리먼트
		var root = doc.documentElement;
		
		// 반복문에서 구성한 item 가져오기
		// 루트 엘리먼트를 활용하여 모든 <item> 엘리먼트들 반환받기
		var itemList = root.getElementsByTagName("item");
		
		// selectbox 초기화
		document.getElementById("addrResult").innerHTML = "";
		
		// 검색 결과 확인
		if(itemList.length==0)
		{
			// 수신된 주소가 없는 경우
			document.getElementById("addrResult").innerHTML
			 = "<option>주소를 검색하세요</option>";
		}
		else
		{
			document.getElementById("addrResult").innerHTML
			 = "<option value='0'>주소를 선택하세요</option>";
		}
		
		// 검색 결과가 존재할 경우
		// 반복문을 돌며 각 데이터 가져오기
		for(var i=0; i<itemList.length; i++)
		{
			var zipcode = itemList[i].getElementsByTagName("zipcode")[0];
			var address = itemList[i].getElementsByTagName("address")[0];
			
			// ※ 태그가 가지는 텍스트는
			//    태그의 첫 번째 자식이고
			//    텍스트 노드의 값은
			//    nodeValue로 가져온다.
			
			//.nodeValue 붙이면 우편번호 값까지 가져온다.
			var zipcodeText = zipcode.firstChild.nodeValue;
			var addressText = address.firstChild.nodeValue;
			
			// selectbox에 아이템 추가
			// 위에서 한 줄 추가한 옵션에 덧붙이기
			// <option value='06252/서울특별시...'>[06252] 서울특별시 강남구 강남...</option>
			document.getElementById("addrResult").innerHTML
				+= "<option value='" + zipcodeText + "/" + addressText
				+ "'>[" + zipcodeText + "] " + addressText + "</option>";
		}
	}

</script>

</head>
<body>


<div>
	<h1>회원가입</h1>
	<p>- AjaxTest03.jsp</p>
	<p>- ajax.js</p>
	<p>- main.css</p>
	<p>- Test03.java</p>  <!-- url: test03.do -->
	<p>- Test03OK.jsp</p>
	<p>- web.xml</p>
	<!-- dto, dao 대신 편의 상 자료구조 활용 → superman, batman, admin 아이디 있음 가정 -->
	<hr>
</div>

<table class="table">
	<tr>
		<th>아이디</th>
		<td>
		<input type="text" id="id" class="control">
		<input type="button" value="중복검사" class="control" onclick="check()">
		<span id="result"></span>
		</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>
			<input type="text" id="name" class="control">
		</td>
	</tr>
	<tr>
		<th>주소</th>
		<td>
			<input type="text" id="addr" class="control" placeholder="동 입력">
			<input type="button" value="검색하기" class="control" onclick="search()">
			<br>
			<select class="control" id="addrResult">
				<option>주소를 입력하세요</option>
			</select>
		</td>
	</tr>
	<tr>
		<th>주소 검색 결과</th>
		<td>
			<input type="text" id="addr1" class="control" readonly="readonly"
			style="width: 200px;">
			<br>
			<input type="text" id="addr2" class="control" readonly="readonly"
			style="width: 400px;">
			<br>
			<input type="text" id="addr3" class="control" 
			placeholder="상세주소를 입력하세요." style="width: 400px;">
		</td>
	</tr>
	<tr>
		<th>전화</th>
		<td>
			<input type="text" id="tel" class="control">
		</td>
	</tr>
</table>

</body>
</html>