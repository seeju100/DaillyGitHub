<%@page import="public_news.publicDTO"%>
<%@page import="public_news.publicDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Array"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
<title>main/main.jsp</title>
var index = 0;   //이미지에 접근하는 인덱스
window.onload = function(){
    slideShow();
}

function slideShow() {
var i;
var x = document.getElementsByClassName("slide1");  //slide1에 대한 dom 참조
for (i = 0; i < x.length; i++) {
   x[i].style.display = "none";   //처음에 전부 display를 none으로 한다.
}
index++;
if (index > x.length) {
    index = 1;  //인덱스가 초과되면 1로 변경
}   
x[index-1].style.display = "block";  //해당 인덱스는 block으로
setTimeout(slideShow, 4000);   //함수를 4초마다 호출

}
</script>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<%@ include file="../inc/top.jsp" %>
		<!-- 헤더 들어가는곳 -->
		  
		<div class="clear"></div>   
		<!-- 본문들어가는 곳 -->
		<div id="main_img">
<!--          <img src="../images/1.jpg" width="970" height="300"> -->
         <img class="slide1" src="../images/just_doIt.jpg"  width="975" height="300">
           <img class="slide1" src="../images/project1.png" width="975" height="300">
           <img class="slide1" src="../images/project1.png" width="975" height="300">
      </div>
		
        	<img id="img1" src="../images/just_doIt.jpg" width="971 px" height= "308px">
       		<img id="img2" src="../images/project1.png" width="971 px" height= "308px">
        	<img id="img3" src="../images/project2.jpg" width="971 px" height= "308px">
    	
		
		<article id="front">
		  	<div id="solution">
		  		<div id="hosting">
		  			<h3>Web Hosting Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="security">
		  		  	<h3>Web Security Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  		<div id="payment">
		  			<h3>Web Payment Solution</h3>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
		  		</div>
		  	</div>
			<%
			publicDAO publicdao = new publicDAO();
			publicDTO dto = new publicDTO();
			ArrayList<publicDTO> pulicList = publicdao.selectRecentPublicList();
			
			%>
		  	<div class="clear"></div>
			<div id="news_notice">
				<h3><span class="orange">Security</span> News</h3>
				<table>
				<% for(publicDTO publicdto : pulicList){%>
					 <tr onclick="location.href='../center/public_content.jsp?num=<%=publicdto.getNum()%>&page=1'" >
					 	 <td  width="320" class="contxt"><%=publicdto.getSubject()%> </td> 
						 <td width="80"><%=publicdto.getName() %></td> 
						 <td width="80"><%=publicdto.getDate() %></td> 
					 </tr>	
					 <% } %>	
				</table>
			</div>
		
			<div id="news_notice">
		  		<h3 class="brown">News &amp; Notice</h3>
				<table>
			<%
			
			BoardDAO dao= new BoardDAO();
			BoardBean board = new BoardBean();
			ArrayList<BoardBean> boardList = dao.selectRecentBoardList();
			
			%>
			<% for(BoardBean board2 : boardList){%>
					 <tr onclick="location.href='../center/notice_content.jsp?num=<%=board2.getNum()%>&page=1'" >
					 	 <td  width="320" class="contxt"><%=board2.getSubject()%> </td> 
						 <td width="80"><%=board2.getName() %></td> 
						 <td width="80"><%=board2.getDate() %></td> 
					 </tr>	
					 <% } %>	
				</table>
		  	</div>
	  	</article>
		  
		<div class="clear"></div>  
		<!-- 푸터 들어가는곳 -->
		<%@ include file="../inc/bottom.jsp" %>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>