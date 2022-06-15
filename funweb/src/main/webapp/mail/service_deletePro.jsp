
<%@page import="service.serviceDAO"%>
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
 
  serviceDAO dao = new serviceDAO();
  int deleteCount =dao.deleteBoard(num,pass);

 
 if(deleteCount>0){
	 response.sendRedirect("service.jsp?page=" + pageNum);
	 
  }else{%>  
  	<script type="text/javascript">  
	alert(" 글 삭제 실패"); 
	history.back(); 
  	</script>  
   <%}%>  