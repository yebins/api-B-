<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.bbsDao" %>
<%@ page import="bbs.bbsDto" %>
<%@ page import="java.util.ArrayList" %>
<jsp:useBean id="dao" class="bbs.bbsDao"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<style type="text/css">
	a, a:hover{
		color:#000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<% String userID=null;
	   if(session.getAttribute("userID") != null){
		userID=(String)session.getAttribute("userID");
	}
	   int pageNumber = 1;
	   if(request.getParameter("pageNumber") != null){
		   pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	   }
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
		<div class="col-lg-3"></div>
		<div class="col-lg-6">
			<div class="jumbotron" style="padding-top:20px;">
					<h3 style="text-align:center;"><a href="bbs.jsp">메인게시판</a></h3>
			</div>
		<div class="col-lg-3"></div>
	</div>
	<div class="container">
		<div class="row">
			<table class="table striped" style="text-align:center; border:1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color:#dddddd; text-align:center;">번호</th>
						<th style="background-color:#dddddd; text-align:center;">제목</th>
						<th style="background-color:#dddddd; text-align:center;">작성자</th>
						<th style="background-color:#dddddd; text-align:center;">작성일</th>
						<th style="background-color:#dddddd; text-align:center;">조회수</th>
						<th style="background-color:#dddddd; text-align:center;">추천수</th>
					</tr>
				</thead>
				<tbody>
					<%
						bbsDao bbsDao=new bbsDao();
						ArrayList<bbsDto> list = bbsDao.getList(pageNumber);
						for(int i=0; i<list.size(); i++){
							
					%>
					<tr>
						<td><%= list.get(i).getBbsId() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsId()%>"><%= list.get(i).getBbsTitle() %></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,16) %></td>
						<td><%= list.get(i).getReadCounts() %></td>
						<td><%= list.get(i).getUpCounts() %></td>
					</tr>
					<%  	
						}
					%>
				</tbody>
			</table>
			<% 
				if(pageNumber != 1){
				
			%>	
				<a href="bbs.jsp?pageNumber=<%=pageNumber-1 %>" class="btn btn-success btn-arrow-left">이전</a>	
			<%
				} else if(bbsDao.nextPage(pageNumber +1)){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber+1 %>" class="btn btn-success btn-arrow-left">다음</a>					
			<%
				}
			%>
			<button class="btn btn-primary pull-right"><a href="write.jsp">글쓰기</a></button>
		</div>
	</div>
</body>
</html>