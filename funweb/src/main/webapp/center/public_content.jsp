<%@page import="public_news.publicDAO"%>
<%@page import="public_news.publicDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");

	int num =Integer.parseInt(request.getParameter("num"));
	String PageNum = request.getParameter("page");

	publicDTO dto = new publicDTO();
	publicDAO dao = new publicDAO();

	dto =dao.selectBoard(num);
	dao.updateReadCount(num);


%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/public_content.jsp</title>
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
				<li><a href="notice.jsp">Notice</a></li>
				<li><a href="public.jsp">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->

		<article>
			<h1>Public Content</h1>
			<table id="notice">
				<tr>
					<td>글번호</td>
						<td><%=dto.getNum() %></td>
					<td>글쓴이</td>
					<td><%=dto.getName() %></td>	
				</tr>
				<tr>
					<td>작성일</td>
					<td><%=dto.getDate() %></td>
					<td>조회수</td>
					<td><%=dto.getReadcount() %></td>	
				</tr>
				<tr>
					<td>제목</td>
					
					<td colspan="3"><%=dto.getSubject() %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="3"><%=dto.getContent() %></td>
				</tr>
			</table>

			<div id="table_search">
				<!-- 글 수정 클릭 시 notice_update.jsp 페이지로 이동(글번호, 페이지번호 전달) -->
				<input type="button" value="글수정" class="btn" 
				onclick="location.href='public_update.jsp?num=<%=dto.getNum()%>&page=<%=PageNum%>'">
				<!-- 글 수정 클릭 시 notice_delete.jsp 페이지로 이동(글번호, 페이지번호 전달) -->
				<input type="button" value="글삭제" class="btn"
				onclick="location.href='public_delete.jsp?num=<%=dto.getNum()%>&page=<%=PageNum%>'" >
				<!-- 글목록 버튼 클릭 시 notice.jsp 페이지로 이동(페이지번호 전달) --> 
				<input type="button" value="글목록" class="btn" 
				onclick="location.href='public.jsp?page=<%=PageNum%>'">
			</div>


			<div class="clear"></div>
		</article>

		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>