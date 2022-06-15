<%@page import="public_news.publicDTO"%>
<%@page import="public_news.publicDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main/main.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<script>
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
 
</head>
<body>
   <div id="wrap">
      <!-- 헤더 들어가는곳 -->
      <%--       <jsp:include page="../inc/top.jsp"></jsp:include> --%>
      <!-- 헤더 들어가는곳 -->
      <%@include file="../inc/top.jsp"%>

      <div class="clear"></div>
      <!-- 본문들어가는 곳 -->
      <!-- 메인 이미지 -->
      <div id="main_img">
<!--          <img src="../images/1.jpg" width="970" height="300"> -->
           <img class="slide1" src="../images/project2.jpg"  width="975" height="300">
           <img class="slide1" src="../images/ex5.jpg" width="975" height="300">
           <img class="slide1" src="../images/ex4.png"  width="975" height="300">
      </div>
      <!-- 본문 내용 -->
      <article id="front">
         <div id="solution">
            <div>
               <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Daily Look&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                Best Fashion &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Street Fashion</h3>
               			<!-- DAILY Look -->
               <img src="../images/dailyLook1.jpeg"  width="148" height="290">
               <img src="../images/dailyLook2.jpg"  width="148" height="290">
       					<!-- BEST FASHION -->
                <img src="../images/bestFashion1.jpg"  width="148" height="290">
                <img src="../images/bestFashion2.jpg"  width="148" height="290">
              <!-- Street Fashion -->
               <img src="../images/streetFashion1.jpg"  width="148" height="290">
               <img src="../images/streetFashion2.jpg"  width="147" height="290">
               
            </div>
         </div>
         <div class="clear"></div>
         <div id="news_notice">
            <h3 class="brown"><span class="orange">Public</span>_News</h3>
                <table>
               <%
                publicDAO publicdao = new publicDAO();
   				publicDTO dto = new publicDTO();
   				ArrayList<publicDTO> pulicList = publicdao.selectRecentPublicList();
               %>

               
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
               BoardDAO dao = new BoardDAO();
               BoardBean board = new BoardBean();
               ArrayList<BoardBean> boardList = dao.selectRecentBoardList();
               %>

               <%
               for (BoardBean board2 : boardList) {
               %>
               <tr onclick="location.href='main.jsp?num=<%=board.getNum() %>&page=1'">

                  <td width="320" class="contxt"><a href="../center/notice.jsp?num=<%=page%>"><%=board2.getSubject()%></a></td>
                  <td width="80"><a href="../center/notice.jsp?num=<%=page%>"><%=board2.getName()%></a></td>
                  <td width="80"><a href="../center/notice.jsp?num=<%=page%>"><%=board2.getDate()%></a></td>
               <%
               }
               %>
               </tr>
             </table>
         </div>
         
      </article>

      <div class="clear"></div>
      <!-- 푸터 들어가는곳 -->
      <%-- jsp:include 액션태그의 page 속성으로 포함할 페이지 지정 --%>
      <%--       <jsp:include page="../inc/bottom.jsp"></jsp:include> --%>
      <!-- 푸터 들어가는곳 -->
      <%-- jsp:include 디렉티브의 file 속성으로 포함할 페이지 지정 --%>
      <%@include file="../inc/bottom.jsp"%>
   </div>
</body>
</html>

