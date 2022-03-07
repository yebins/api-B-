<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.UserDto" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

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
	
		UserDao userDao=new UserDao();
		int result = userDao.login(user.getUserID(),user.getUserPassword());
		
		if(result == 1){
			session.setAttribute("userID", user.getUserID());
			out.println("<script>");
			out.println("location.href='main.jsp'");
			out.println("</script>");
		}
		else if(result == 0){
			out.println("<script>");
			out.println("alert('비밀번호가 틀렸습니다.')");
			out.println("history.back()");			
			out.println("</script>");
		}
		else if(result == -1){
			out.println("<script>");
			out.println("alert('존재하지않는 아이디입니다.')");
			out.println("history.back()");			
			out.println("</script>");
		}
		else if(result == -2){
			out.println("<script>");
			out.println("alert('데이터베이스 오류가 발생했습니다.')");
			out.println("history.back()");			
			out.println("</script>");
		}
		}
	%>

</body>
</html>