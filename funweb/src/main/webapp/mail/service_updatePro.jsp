<%@page import="service.serviceDAO"%>
<%@page import="service.serviceDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 request.setCharacterEncoding("utf-8");
 
 int num = Integer.parseInt(request.getParameter("num"));
 String PageNum = request.getParameter("page");
 String name = request.getParameter("name");
 String pass = request.getParameter("pass");
 String subject = request.getParameter("subject");
 String content = request.getParameter("content");
 
 serviceDTO board = new serviceDTO();
 board.setNum(num);
 board.setName(name);
 board.setPass(pass);
 board.setSubject(subject);
 board.setContent(content);
 
 
 //BoardDAO 객체의 updateBoard() 메서드 호출하여 게시물 수정 작업 요청
 serviceDAO dao = new serviceDAO();
 int updateCount = dao.updateBoard(board);
 
 
 
 if(updateCount>0){
	response.sendRedirect("service_content.jsp?num="+num+"&page="+PageNum);
  %>
	<%} else{%> 
	 <script>
	 alert("글 수정 실패!");
	 history.back();
	 </script>

 <%}%>
 

    

