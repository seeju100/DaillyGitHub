<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();
//response.sendRedirect("../main/main.jsp");

%>
<script>
	alert("정상적으로 로그아웃 되었습니다.");
	location.href="../main/main.jsp";
</script>