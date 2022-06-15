<%@page import="public_news.publicDAO"%>
<%@page import="public_news.publicDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
  request.setCharacterEncoding("utf-8");
 
 publicDTO board = new publicDTO();
 board.setName(request.getParameter("name"));
 board.setPass(request.getParameter("pass"));
 board.setSubject(request.getParameter("subject"));
 board.setContent(request.getParameter("content"));
 
 
 publicDAO dao = new publicDAO();
 
 int insertCount=dao.insertPublic(board);
 
 
 if(insertCount>0){
	 response.sendRedirect("public.jsp");
 }else{%>
	 <script>
	 alert("글 작성 실패");
	 
	 </script>
 <%}%>
 
 
 
 
 
  
