<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
// 	String pass = request.getParameter("pass");
// 	String name = request.getParameter("name");
// 	String email = request.getParameter("email");
// 	String address = request.getParameter("address");
// 	String phone = request.getParameter("phone");
// 	String mobile = request.getParameter("mobile");
  //---------------------------

	MemberBean member = new MemberBean(); //DTO
  	member.setId(request.getParameter("id"));
	member.setPass(request.getParameter("pass"));
	member.setName(request.getParameter("name"));
	member.setEmail(request.getParameter("email"));
	member.setAddress(request.getParameter("address"));
	member.setPhone(request.getParameter("phone"));
	member.setMobile(request.getParameter("mobile"));

	MemberDAO memberDAO = new MemberDAO();
	int updateCount = memberDAO.updateMember(member);
	
	if(updateCount > 0) {
		%>
		<script>
			alert("수정 완료!");
			location.href = "member_info.jsp";
		</script>
		<%
	} else {
		%>
		<script>
			alert("정보 수정 실패!");
			history.back();
		</script>
		<%
	}
	%>