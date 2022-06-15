<%@page import="service.serviceDTO"%>
<%@page import="service.serviceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));
String PageNum = request.getParameter("page");


serviceDAO dao = new serviceDAO();
serviceDTO dto = dao.selectBoard(num);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice_write.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img_center"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href="mailForm.jsp">Address</a></li>
				<li><a href="service.jsp">Service center</a></li>
				<li><a href="#">Newsroom</a></li>
				<li><a href="#">Public Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Service_Center</h1>
			<form action="service_updatePro.jsp" method="post">
				<input type="hidden" name="num" value="<%=num %>" >
				<input type="hidden" name="page" value="<%=PageNum %>" >
				<table id="notice">
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="name" value=" <%=dto.getName() %>" required="required"></td>
					</tr>
						<td>비밀번호</td>
						<td><input type="password" name="pass" value=" <%=dto.getPass() %>"required="required"></td>
					<tr>
						<td>제목</td>
						<td><input type="text" name="subject" value=" <%=dto.getSubject() %>" required="required"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea rows="10" cols="20" name="content" required="required"> <%=dto.getContent() %></textarea></td>
					</tr>
				</table>
				<div id="table_search">
					<input type="submit" value="글수정" class="btn">
				</div>
			</form>
			<div class="clear"></div>
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


