<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	
	 String uploadPath= new File("C:/Temp/FileUpload").getAbsolutePath();

	int maxSize =10*1024*1024;
	MultipartRequest mr =new MultipartRequest(request,
			uploadPath,
			maxSize,
			"UTF-8",
			new DefaultFileRenamePolicy());
	
	//클라이언트가 업로드한 파일명을 MultipartRequest 객체를 통해서 얻음 
	
	//1.<form> 태그의 <input type="file">의 이름들(uploadFile,...)을 반환받음
	
	Enumeration fileTypeNames = mr.getFileNames();
	
	//2.<input type="file"> 태그의 name을 이용해 value값(업로드한 파일명)을 얻음
			
	String fileName=(String)fileTypeNames.nextElement();
	
	String systemFileName = mr.getFilesystemName(fileName);
	String originalFileName = mr.getOriginalFileName(fileName);
	
	out.println("<h3>서버에 저장된 파일명 :"+systemFileName+"</h3>");
	out.println("<h3>클라이언트가 업로드한 파일명 :"+originalFileName+"</h3>");
	

%>

	<form name="downloadForm" action="process_download.jsp" method="post">
		<input type="hidden" name="sys_file value="<%= systemFileName %>"/>
		<button onclick="javascript:downloadForm.submit()">다운받기</button>		
	</form>
</body>
</html>