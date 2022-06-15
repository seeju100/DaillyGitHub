<%@page import="java.util.ArrayList"%>
<%@page import="public_news.publicDAO"%>
<%@page import="public_news.publicDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
publicDTO dto = new publicDTO();
publicDAO dao = new publicDAO();
String search = request.getParameter("search");
String searchType = request.getParameter("searchType");

int PageNum=1;

if(request.getParameter("page") != null) {
	PageNum = Integer.parseInt(request.getParameter("page")); // String -> int 형변환 필요
}

	int PageLimit=5;		//한페이지당 표시할 page 갯수
	int ListLimit=10;		//한페이지당 표시할  list 목록갯수
	
	 int listCount = dao.selectSearchListCount(search,searchType);	 //select  데이터 조회로 num의 최대값을 PageCount에 저장
	int maxPage = (int)Math.ceil((double)(listCount / ListLimit));//Math.ceil->매서드 위랑 같음
	int startPage=((int)((double)PageNum /PageLimit +0.9) -1) * PageLimit +1;
	//3.현재 페이지에서 보여줄 끝 페이지 번호(10,20,30,40....) 게산
	int endPage = startPage +PageLimit -1;

	if(endPage >maxPage){
		endPage =maxPage;
	}
	//보드 테이블의 하나씩의 데이터를 받을경우 :publicDTO // 보드 전체의 목록을 담을경우 :ArrayList
	 //--------------------------------
	
							  //	
	
	 ArrayList<publicDTO> publicList = dao.selectPublicList( PageNum, ListLimit, searchType, search);//search에서 검색한 ArrayList<publicDTO>


	
		
%> 
<%=search %>
<%=searchType %>
<%=listCount %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/notice.jsp</title>
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
				<li><a href="./notice.jsp">Notice</a></li>
				<li><a href="./public.jsp">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Public News</h1>
			<table id="notice">
				<tr>
					<th class="tno" style=" text-align:center;">No.</th>
               <th class="ttitle" style="text-align: left: ;">Title</th>
               <th class="twrite" style=" text-align:center;">Write</th>
               <th class="tdate" style="text-align: center;">Date</th>
               <th class="tread" style=" text-align:center;">Read</th>
				</tr>
				<% 
				
				for(publicDTO publicdto :publicList){
				
				%>
			
				<tr onclick="location.href='public_content.jsp?num=<%=publicdto.getNum()%>&page=<%=PageNum %>' ">
					<td ><%=publicdto.getNum()%></td>
					<td class="left"><%=publicdto.getSubject()%></td>
					<td ><%=publicdto.getName() %></td>
					<td><%=publicdto.getDate() %></td>
					<td><%=publicdto.getReadcount() %></td>
				</tr>
			<%} %>
			</table>
			<div id="table_search">
				<input type="button" value="뉴스작성"  class="btn" onclick="location.href='public_write.jsp'">
			</div>
			<div id="table_search">
				<form action="public_search.jsp" method="get">
					<select name="searchType">
						<option value="subject" >제목</option>
						<option value="name" <% if(searchType.equals("name")){%>selected="selected"<%} %>>작성자</option>
					</select>
					<input type="text" name="search"  class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>
		
			<div class="clear"></div>
			<div id="page_control">
				
				<%if(PageNum > 1) { // 이전페이지가 존재할 경우 %>
					<a href="public_search.jsp?page=<%=PageNum - 1%>&search=<%=search%>&searchType=<%=searchType%>">Prev</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					&nbsp;
				<%} %>
				<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
				<%for(int i = startPage; i <= endPage; i++) { %>
					<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
					<%if(PageNum == i) { %>
						&nbsp;&nbsp;<%=i %>&nbsp;&nbsp;
					<%} else { %>
						<a href="public_search.jsp?page=<%=i%>&search=<%=search%>&searchType=<%=searchType%>"><%=i %></a>
					<%} %>
				<%} %>
				
				<%if(PageNum < maxPage) { // 다음페이지가 존재할 경우 %>
					<a href="public_search.jsp?page=<%=PageNum + 1%>&search=<%=search%>&searchType=<%=searchType%>">Next</a>
				<%} else { // 이전페이지가 존재하지 않을 경우 %>
					&nbsp;Next
				<%} %>
			</div>
		</article>
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>