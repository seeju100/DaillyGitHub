<%@page import="com.mysql.cj.Session"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");


MemberBean member = new MemberBean();
member.setId("id");
member.setPass("pass");

//로그인은 boolean타입으로 로그인 판별할수있게함

MemberDAO dao = new MemberDAO();
	boolean isLoginSuccess = dao.checkUser(id,pass);
	

	if(isLoginSuccess){
		session.setAttribute("sId", id);
		response.sendRedirect("../main/main.jsp");
	} else{%>
		<script>
		alert("아이디 또는 패스워드 틀림");
		history.back();
		</script>
	<%}%>
