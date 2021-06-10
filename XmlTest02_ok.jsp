<%@ page contentType="text/html; charset=UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	response.setContentType("text/xml");
%><?xml version="1.0" encoding="UTF-8"?>
<%-- 
<lists>
	<%
	for(int i=1; i<=2; i++)
	{
	%>
	<body>
		<id>>> id=<%=i %></id>
		<title>- title=<%=title + i %></title>
		<content>- content=<%=content + i %></content>
	</body>
	<%
	}
	%>
</lists> 
--%>

<root>
	<status>true</status>
	<records id="1">
		<title>${param.title }1</title>
		<content>${param.content }1</content>
	</records>
</root>