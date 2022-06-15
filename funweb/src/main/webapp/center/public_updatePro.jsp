<%@page import="public_news.publicDAO"%>
<%@page import="board.BoardDAO"%>
<%@page import="public_news.publicDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String PageNum = request.getParameter("page");

publicDAO dao = new publicDAO();
publicDTO dto = new publicDTO();

dto.setNum( Integer.parseInt(request.getParameter("num")));
dto.setName(request.getParameter("name"));
dto.setPass(request.getParameter("pass"));
dto.setSubject(request.getParameter("subject"));
dto.setContent(request.getParameter("content"));


int updateCount = dao.UpdatePublic(dto);

if(updateCount>0){
	response.sendRedirect("public_content.jsp?num="+num+"&page="+PageNum);
}else{%>
	<script>
	alert("글 수정 실패!");
	history.back();
	</script>
<%}%>

