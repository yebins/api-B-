<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDao" %>
<%@ page import="bbs.bbsDto" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.bbsDto" scope="page"/>
<jsp:setProperty name="bbs" property="*" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		int res=Integer.parseInt(request.getParameter("bbsID"));
		
		bbsDao bbsDao= new bbsDao();
		
		int result=bbsDao.updateUpCountsDown(res);
		

	%>
		<script>
		alert('비추천하셨습니다.');
		history.back();
		</script>
</body>
</html>