<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.UserDto" scope="page"/>
<jsp:setProperty name="user" property="*" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	if(session.getAttribute("userID") !=null){
		out.println("<script>");
		out.println("alert('이미 로그인이 되어있습니다.')");
		out.println("history.back()");			
		out.println("</script>");		
	} else {
	
	
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserGender() == null || user.getUserName() == null || user.getUserEmail() == null ){	
			out.println("<script>");
			out.println("alert('입력하지 않은 사항이 있습니다.')");
			out.println("history.back()");			
			out.println("</script>");
		} else {
			
			UserDao userDao=new UserDao();			
		    int result = userDao.join(user);
		    if(result == 1){
		    session.setAttribute("userID", user.getUserID());
			out.println("<script>");
			out.println("location.href='main.jsp'");
			out.println("</script>");
		 	} else if(result == -1){
				out.println("<script>");
				out.println("alert('아이디가 이미 존재합니다.')");
				out.println("history.back()");			
				out.println("</script>");
			}
		}
	}
	
		
	
		
		
		
	%>

</body>
</html>