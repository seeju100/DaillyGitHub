<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
ul{
	 list-style:none;
	
}
li{
    color:lightgrey;
    
    font-size:10px;
}
p{
	font-style: italic;
}
</style>
<title>company/welcome.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="wrap">
		<!-- 헤더 들어가는곳 -->
		<%@ include file="../inc/top.jsp" %>
		<!-- 헤더 들어가는곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"></div>
		<!-- 왼쪽 메뉴 -->
		<nav id="sub_menu">
			<ul>
				<li><a href=../company/welcome.jsp>value&innovation Strategy</a></li>
				<li><a href="../company/History.jsp">CEO's History</a></li>

			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>value&innovation Strategy</h1>
			<figure class="ceo">
				<img src="../images/company/3.png" width="200" height="280">
				<figcaption>value&innovation Strategy</figcaption>
			</figure>
			
			<p><h4>우리 DW_Market 은 고객의 가장 신뢰받는 파트너로서, 나아가기 위하여 
활발한 커뮤니케이션과 고객의 편의성,  탁월한 트렌디한 제품의 선택을 위하여 철저한 검수를 하고있는
스타트업 입니다.
우리의 핵심가치는 고객의 편의성,제품의 철저한 검수, 활발한 커뮤니티를 위한 서버 안정화와 개발을 하고있는 신생 기업입니다.
더 나은 서비스를 위하여 항상 노력하겠습니다.  	</h4></p>   
			<ul>
				<li><h2>1.고객지향적 혁신</h2></li>
				<li><h2>2.최고의 품질</h2></li>
				<li><h2>3.민첩한 대응, 유연한 적응력, 스피드</h2></li>
			</ul>

			
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<%@ include file="../inc/bottom.jsp" %>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


