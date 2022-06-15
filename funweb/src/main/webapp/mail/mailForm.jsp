<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
li{
	color: grey;
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
		<div id="main_img"></div>
		<!-- 본문 메인 이미지 -->
		<div id="sub_img"></div>
		<!-- 왼쪽 메뉴 -->
		
		<nav id="sub_menu">
			<ul>
				<li><a href="mailForm.jsp">Address</a></li>
				<li><a href="service.jsp">Service center</a></li>
				<li><a href="#">Newsroom</a></li>
				<li><a href="#">Public Policy</a></li>
			</ul>
		</nav>
		
<!-- 			<h1>Address</h1> -->
<!-- 			<h3><p>주소:부산광역시 부산진구동천로<br> 109 삼한골든게이트빌딩 7층(아이티윌)</p></h3> -->
<!-- 			<h3><p>전화번호</h3> -->
		<article>
			<h1>Address</h1>
			<ul id="address">
			<div id="map" style="width:600px;height:300px;"></div>
			<figcaption><h3>찾으러 오시는 길</h3></figcaption>
				<li><h3>주소:부산광역시 부산진구동천로 <br>109 삼한골든게이트빌딩 7층(아이티윌)</h3></li>
				<li><h3>전화번호:051-803-0909</h3></li>
				<li><h3>Fax: +82 64 123 4321</h3></li>
				<li><h3>e-mail:eodnddl23@naver.com</h3></li>
				<li><h3>open(09:00)~close(18:30)</h3></li>
	
			</ul>
			<figure class="ceo">
				
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=acba19b45f14af70c97c4990ceaa8bea" ></script>
	<script>
		var container = document.getElementById('map');
		
		
		var options = {
			center: new kakao.maps.LatLng(35.15851068510777, 129.06214389118966),
			level: 1
		};
		var map = new kakao.maps.Map(container, options);
		var markerPosition  = new kakao.maps.LatLng(35.15851068510777, 129.06214389118966 ); 
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		marker.setMap(map);
		var iwContent = '<div style="padding:1px ;"><br> <a href="https://map.kakao.com/link/map/아이티윌 ,35.158510,129.062143" style="color:blue" target="_blank"></a> <a href="https://map.kakao.com/link/to/아이티윌,35.158510,129.062143" style="color:blue" target="_blank">Click! me</a></div>', 
	    iwPosition = new kakao.maps.LatLng(35.15851068510777, 129.06214389118966); //인포윈도우 표시 위치

	// 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	    position : iwPosition, 
	    content : iwContent 
	});
	  
	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
	infowindow.open(map, marker);
	</script>
				
			</figure>
			<p></p>
		</article>
		<div class="clear"></div>
		<!-- 푸터 들어가는곳 -->
		<%@ include file="../inc/bottom.jsp" %>
		<!-- 푸터 들어가는곳 -->
	</div>
</body>
</html>


