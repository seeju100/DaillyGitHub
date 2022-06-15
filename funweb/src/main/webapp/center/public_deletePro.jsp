<%@page import="public_news.publicDTO"%>
<%@page import="public_news.publicDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
int num =Integer.parseInt(request.getParameter("num"));
String pass =request.getParameter("pass");
String PageNum = request.getParameter("page");

publicDAO dao = new publicDAO();

 	
int deleteCount =dao.deletenews(num,pass);

if(deleteCount>0){
		response.sendRedirect("public.jsp?&page="+PageNum);
 	}else{%>
	<script>
	alert("삭제 실패!");
	history.back();
	</script>
<%}%>