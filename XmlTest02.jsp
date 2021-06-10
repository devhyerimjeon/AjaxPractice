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
<title>XmlTest02.jsp</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">

	$(function()
	{
		$("#sendBtn").click(function()
		{
			var params = "title=" + $.trim($("#title").val())
			  + "&content=" + $.trim($("#content").val());
			
			$.ajax(
			{
				type : "POST"
				, url : "XmlTest02_ok.jsp"
				, data : params
				, dataType : "xml"
				, success : function(xml)
				{
					/* $(xml).find("status").each(function()
					{
						var status = $(this).text();
						alert(status); //-- 확인
					}); */
					
					var str = "";
					
					$(xml).find("records").each(function()
					{
						var records = $(this);
						var id = records.attr("id");
						var title = $(this).find("title").text();
						var content = $(this).find("content").text();
						
						str += ">> id=" + id + "<br> - title=" + title + "<br> - content=" + content + "<br>";
					});
					
					
					// xml 데이터 처리
					/*
					var out = "";
									
					
					$(args).find("body").each(function()
					{
						var item = $(this);
						out += item.find("id").text() + "<br>";
						out += item.find("title").text() + "<br>";
						out += item.find("content").text() + "<br><br>";
					}); 
					*/
					
					/*
					out += $(args).find("id").text() + "<br>";
					out += $(args).find("title").text() + "<br>";
					out += $(args).find("content").text() + "<br><br>";
					
					처럼 묶어주면 id=1 id=2 처럼 한 줄씩 나온다.
					id가 여러 번 반복되므로, body로 묶여진 한 태그 내에서 
					each를 통해 하나씩 가져와 한 줄씩 출력하는 것.
					*/
					
					// 데이터 넣기
					$("#resultDiv").html(str);
					$("#title").val("");
					$("#content").val("");
					$("#title").focus();
				}
				, beforeSend : showRequest
				, error : function(e)
				{
					alert(e.responseText);
				}
				
			});
			
		});
	});
	
	function showRequest()
	{
		var flag = true;
		
		if(!$.trim($("#title").val()))
		{
			alert("제목을 입력하세요.");
			$("#title").focus();
			flag = false;
		}
		
		if(!$.trim($("#content").val()))
		{
			alert("내용을 입력하세요.");
			$("#content").focus();
			flag = false;
		}
		
		return flag;
	}

</script>
</head>
<body>

<div>
	<h1>jQuery Ajax XML 관련 실습</h1>
	<hr>
</div>

<div>
	제목 : <input type="text" id="title" class="txt" /><br>
	내용 : <input type="text" id="content" class="txt" /><br>
	<br>
	<input type="button" id="sendBtn" class="btn" value="전송확인" />
</div>
<br><br>

<div id="resultDiv">
<!--
>> id=1<br>
- title=aaaa1<br>
- content=bbbb1<br>

>> id=2<br>
- title=aaaa2<br>
- content=bbbb2<br>
-->
</div>

</body>
</html>