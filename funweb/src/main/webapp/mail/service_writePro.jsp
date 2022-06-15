<%@page import="service.serviceDTO"%>
<%@page import="service.serviceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

//name , pass,subject,content
serviceDTO dto = new serviceDTO();
dto.setName(request.getParameter("name"));
dto.setPass(request.getParameter("pass"));
dto.setSubject(request.getParameter("subject"));
dto.setContent(request.getParameter("content"));
serviceDAO dao = new serviceDAO();

int insertCount = dao.insertService(dto);

if(insertCount > 0) {
	response.sendRedirect("service.jsp");
} else {%>
	<script>
		alert("글쓰기 실패!");
		history.back();
	</script>
	<%
}

%>