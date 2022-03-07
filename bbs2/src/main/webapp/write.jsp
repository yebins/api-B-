<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
						<script>
						alert('로그인하세요.');
						history.back();
						</script>
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
			<form action="writeAction.jsp" method="post">
				<table class="table striped" style="text-align:center; border:1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2"; style="background-color:#dddddd; text-align:center;">게시판 글쓰기 양식</th>
						</tr>	
					</thead>	
					<tbody>	
						<tr>
							<td><input type="text" class="form-control" name="bbsTitle" placeholder="제목" maxlength="50" required)></td>
						</tr>
						<tr>
							<td><textarea class="form-control" name="bbsContent" placeholder="내용" maxlength="2048" style="height:300px; resize:none;")></textarea></td>
						</tr>
 					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>
</body>
</html>