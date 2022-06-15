<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
int PageNum=1;

  //현재 페이지 변호를 저장할 변수 선언, 페이지 기본값 1로 설정
 //=>page파라미터가 존재 할 경우에만 가져오기

 if(request.getParameter("page")!=null){
	 PageNum =Integer.parseInt(request.getParameter("page"));
	 
 }
int listLimit = 10;//한 페이지 당 표시할 목록 개수
int pageLimit =5; //한 페이지에서 표시할 페이지 갯수


//BoardDAO 객체의 selectListCount()  메서드를 호출하여 게시물 전체 목록 갯수 조회 작업 요청
BoardBean board = new BoardBean();
BoardDAO	dao = new BoardDAO();

int listCount = dao.selectListCount();
//페이징 처리를 위한 계산 작업
//1.현재 페이지에서 표시할 전체 페이지 수 게산
//=> 총게시물 수 / 페이지당 표시할 게시물 수  +0.9
//int maxPage =    (int)(double)(listCount / 10+0.9);
int maxPage =    (int)Math.ceil((double)(listCount / listLimit));//Math.ceil->매서드 위랑 같음

//2.현재 페이지에서 보여줄 시작 페이지번호(1,11,21,31,41....)ㄱㅖ산
int startPage=((int)((double)PageNum /pageLimit +0.9) -1) * pageLimit +1;
//3.현재 페이지에서 보여줄 끝 페이지 번호(10,20,30,40....) 게산
int endPage = startPage +pageLimit -1;

if(endPage >maxPage){
	endPage =maxPage;
}


 //보드 테이블의 하나씩의 데이터를 받을경우 :boardBean // 보드 전체의 목록을 담을경우 :ArrayList
 //--------------------------------
 
 ArrayList<BoardBean> boardList = dao.selectBoardList(PageNum,listLimit);
 
 
 
%>	
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
				<li><a href="notice.jsp">Notice</a></li>
				<li><a href="public.jsp">Public News</a></li>
				<li><a href="#">Driver Download</a></li>
				<li><a href="#">Service Policy</a></li>
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>Notice</h1>
			<table id="notice">
				<tr>
					<th class="tno" style=" text-align:center;">No.</th>
               <th class="ttitle" style="text-align: left: ;">Title</th>
               <th class="twrite" style=" text-align:center;">Write</th>
               <th class="tdate" style="text-align: center;">Date</th>
               <th class="tread" style=" text-align:center;">Read</th>
				</tr>
				<%
				// 1)ArrayList 크기만큼 일반 for문으로 반복하면서  boardBean
				//1번방법	for (int i = 0; i < boardList.size(); i++) {
				//2번방법 향상된 for
				for(BoardBean board1 : boardList){

			
				%>
				
				<!-- 반복문을 사용하여 ArrayList 객체만큼 반복하면서 -->
				<!-- ArrayList 객체 내의 BoardBean 객체를 꺼내서 저장한 후 -->
				<!-- 각 레코드를 tr 태그의 td 태그에 출력하기-->
				<!-- 밑에 테이블에 이름대신에 변수로 값 확인 -->
				
				<!-- url 파라미터로 글번호와 페이지 번호 전달 -->
				
				<tr onclick="location.href='notice_content.jsp?num=<%=board1.getNum()%>&page=<%=PageNum%>'">
					<td ><%=board1.getNum() %></td>
					<td class="left"><%=board1.getSubject() %></td>
					<td ><%=board1.getName() %></td>
					<td><%=board1.getDate() %></td>
					<td><%=board1.getReadcount() %></td>
				</tr>
				<%
					}
				%>
			</table>
			<div id="table_search">
				<input type="button" value="글쓰기"  class="btn" onclick="location.href='notice_write.jsp'">
			</div>
			<div id="table_search">
				
				<form action="notice_search.jsp" method="get">
					<select name="searchType">
						<option value="subject" >제목</option>
						<option value="name">작성자</option>
					</select>
					<input type="text" name="search"  class="input_box">
					<input type="submit" value="Search" class="btn">
				</form>
			</div>
		
			<div class="clear"></div>
			<div id="page_control">	
			 	<%if(PageNum > 1) {   //이전페이지 존재 할 경우%>
				<a href="notice.jsp?page=<%=PageNum -1 %>" >Prev</a>
			 	<%} else{ 			 // 이전페이지가 존재 하지 않을경우%>
					Prev&nbsp;
				<%} %>
				<!--  페이지 번호 목록은 시작페이지 ~ 끝페이지 까지 표시 -->
				<%for(int i=startPage;i<=endPage;i++) {%>
				<% if(PageNum==i){%>
					<%=i %>
				<%} else{ %>
				<a href="notice.jsp?page=<%=i%>"><%=i %></a>
				<%} %>
				
				<%} %>
				
				<%if(PageNum<maxPage){ %>
				<a href="notice.jsp?page=<%=PageNum +1%>">Next</a>
				
				<%} else{%>
					Next&nbsp;
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


