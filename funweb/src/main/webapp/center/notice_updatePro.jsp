<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
 
 BoardBean board = new BoardBean();
 board.setNum(num);
 board.setName(name);
 board.setPass(pass);
 board.setSubject(subject);
 board.setContent(content);
 
 
 //BoardDAO 객체의 updateBoard() 메서드 호출하여 게시물 수정 작업 요청
 BoardDAO dao = new BoardDAO();
 int updateCount = dao.updateBoard(board);
 
 
 
 if(updateCount>0){
	response.sendRedirect("notice_content.jsp?num="+num+"&page="+PageNum);
  %>
	<%} else{%> 
	 <script>
	 alert("글 수정 실패!");
	 history.back();
	 </script>

 <%}%>
 

    

