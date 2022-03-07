<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDao" %>
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


	<% if(session.getAttribute("userID") == null){ 
		out.println("<script>");
		out.println("alert('권한이 없습니다.')");
		out.println("location.href ='main.jsp'");
		out.println("</script>");		
	} 	
		
		
		if(bbs.getBbsContent() == null || bbs.getBbsTitle() == null){
			out.println("<script>");
			out.println("alert('입력하지 않은 내용이 있습니다.')");
			out.println("history.back()");
			out.println("</script>");	
		} else {
		
		String userID=(String)session.getAttribute("userID");
		
		bbsDao bbsDao = new bbsDao();
		int result = bbsDao.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
		
		if(result == 1){
			out.println("<script>");
			out.println("alert('글쓰기 성공!')");
			out.println("location.href ='bbs.jsp'");
			out.println("</script>");
		} else {
			
			out.println("<script>");
			out.println("alert('글쓰기 실패!')");
			out.println("location.href ='bbs.jsp'");
			out.println("</script>");
			
		}
		}
	  %>
		
	

</body>
</html>