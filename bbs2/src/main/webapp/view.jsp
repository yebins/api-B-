<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDao" %>
<%@ page import="bbs.bbsDto" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>

</head>
<body>
	<% String userID=null;
	   if(session.getAttribute("userID") != null){
		userID=(String)session.getAttribute("userID");
		}
		
	   int bbsID=0;
	   if(request.getParameter("bbsID") != null){
		   bbsID=Integer.parseInt(request.getParameter("bbsID"));
	   }
	   
	   if(bbsID == 0){
			out.println("<script>");
			out.println("alert('글이 존재하지 않습니다.')");
			out.println("location.href ='main.jsp'");
			out.println("</script>");
	   }
	   
	   bbsDao dao=new bbsDao();
	  bbsDto bbsDto=dao.getBbsDto(bbsID);
	  
	  dao.updateReadCount(bbsID);
	 	
	
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a> 
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="bbs.jsp">게시판</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
				
				 <% if( userID == null ){%>
					<a href="#" class="dropdwon-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">로그인하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					<%} else {%>
					<a href="#" class="dropdwon-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="info.jsp">내 정보</a></li>
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					 <%} %>
				</li>
			</ul>
		</div>
	</nav>
		<div class="container">
		<div class="row">
				<table class="table striped" style="text-align:center; border:1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2"; style="background-color:#dddddd; text-align:left;"><%=bbsDto.getBbsTitle()%></th>
							<th style="background-color:#dddddd; text-align:right; font-size:9px;"><%=bbsDto.getBbsDate()%></th>
						</tr>	
					</thead>	
					<tbody>		
						<tr>
							<td colspan="2"; style="text-align:left;"><%=bbsDto.getUserID() %></td>
							<td style="text-align:right;">조회수<%=bbsDto.getReadCounts() %> 댓글1 추천수<%=bbsDto.getUpCounts() %></td>
						</tr>
						<tr>
							<td colspan="3" style="text-align:left;"><%=bbsDto.getBbsContent() %></td>
						</tr>
 					</tbody>
				</table>
				<button><a href="viewUp.jsp?bbsID=<%=bbsID%>">추천</a></button>
				<button><a href="viewDown.jsp?bbsID=<%=bbsID%>">비추천</a></button>
				
		</div>
	</div>
</body>
</html>