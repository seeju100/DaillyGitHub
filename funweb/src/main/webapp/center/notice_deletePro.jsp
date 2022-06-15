<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("page");

 String pass = request.getParameter("pass");

//BoardBean board = new BoardBean();
// board.setNum(num);
//  board.setPass(pass);
 
  BoardDAO dao = new BoardDAO();
  int deleteCount =dao.deleteBoard(num,pass);

 
 if(deleteCount>0){
	 response.sendRedirect("notice.jsp?page=" + pageNum);
	 
  }else{%>  
  	<script type="text/javascript">  
	alert(" 글 삭제 실패"); 
	history.back(); 
  	</script>  
   <%}%>  