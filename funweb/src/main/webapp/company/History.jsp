<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>company/welcome.jsp</title>
<style type="text/css">
p{
	color: grey;
}
</style>
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
				<li><a href="../company/welcome.jsp">value&innovation Strategy</a></li>
				<li><a href="../company/History.jsp">CEO's History</a></li>
				
			</ul>
		</nav>
		<!-- 본문 내용 -->
		<article>
			<h1>CEO's History</h1>
			<figure class="ceo">
				<img src="../images/company/3.png" width="200" height="280">
				<figcaption>DW_market CEO: DAE WOONG LEE</figcaption>
			</figure>
			
			<p ><h3>D.WLEE의 기업의 목표는 수익의 창출이 아닌 고객들의 니즈의 불편함 없는 커뮤니티
			와 많은 고객의 여러 취미를 함께 공유할 수 있는 공간을 만들고자 노력하는 기업입니다.
			추후 고객과의 패션을 장르를 공유하고 손이가지않는 의류를 나눔도 할 수 있는 중고 거래 플랫폼과 패션피플의 필수인 
			다이어트 관련 식품 업체와 연결하여 거래 할 수 있도록 하고 고객과의 원활한 소통을 통하여
			커뮤니티의 적극적으로 활성화 시키는 것이 D.W_market의 궁극적 목표입니다.  
					</h3></p>   

			
		</article>


		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<%@ include file="../inc/bottom.jsp" %>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


