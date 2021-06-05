<%@ page contentType="text/html; charset=UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

	// 체크!!
	response.setContentType("text/xml");
	//-- AJAX 객체에 데이터를 돌려줄 때
	//   클라이언트의 브라우저가 이 데이터를 XML로 인식할 수 있도록 처리해야하는 과정
	//   MIME 타입(contentType)을 XML로 선언한다.
	
	//※ (수신해서 처리해야하는) 데이터가 1개 이상일 경우
	//   XML 이나 JSON과 같이 '구조화 시킬 수 있는 데이터'로 전달하는 것이
	//   처리 과정에서 데이터를 다룰 때 용이하다.
	//   우편 번호에 대한 검색 결과는
	//   당연히 다량의 데이터를 전송해야하므로 텍스트가 아닌 XML 형태로 반환한다.
%><?xml version="1.0" encoding="UTF-8"?>
<list>
	<c:forEach var="item" items="${lists }">
	<item>
		<zipcode>${item.zipCode }</zipcode>
		<address>${item.address }</address>
	</item>
	</c:forEach>
</list>