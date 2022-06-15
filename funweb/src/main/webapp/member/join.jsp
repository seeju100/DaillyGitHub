<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/join.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function AddressDaumPostcode() {			//----도로명주소-----
        new daum.Postcode({
            oncomplete: function(data) {	
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
//                     if(extraAddr !== ''){
//                         extraAddr = ' (' + extraAddr + ')';
//                     }
//                     // 조합된 참고항목을 해당 필드에 넣는다.
//                     document.getElementById("sample6_extraAddress").value = extraAddr;
                
//                 } else {
//                     document.getElementById("sample6_extraAddress").value = '';
//                 }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("postcode").value = data.zonecode;
                document.getElementById("address1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();
            }}
        }).open();
    }
</script>
<script type="text/javascript">
var checkIdResult = false, checkRetypePassResult = false;
var checkPassResult = false; checkRetypeEmailResult = false;

function checkpasswd(pass){			//패스워드 체크
	
	//영문,숫자,특수문자 8~16글자
	var lengthRegex=/^[a-zA-Z0-9!@#$%]{8,16}$/;
	var engUpperRegex = /[A-Z]/; //대문자규칙
	var engLowerrRegex = /[a-z]/; //대문자규칙
	var numRegex = /[0-9]/; //대문자규칙
	var spcRegex = /[!@#$%]/; //대문자규칙
	var count =0;
	if(lengthRegex.exec(pass)) { // 정규표현식과 일치하는 데이터일 경우
		

		if(engUpperRegex.exec(pass)) count++;
		if(engLowerrRegex.exec(pass)) count++;
		if(numRegex.exec(pass)) count++;
		if(spcRegex.exec(pass)) count++;

		switch(count){
			case 4:passResult.innerHTML = "사용 가능(안전)";
					passResult.style.color = "GREEN";
					checkPassResult =true;
					break;
			case 3:passResult.innerHTML = "사용 가능(보통)";
					passResult.style.color = "PUPLE";
					checkPassResult =true;
					break;
			case 2:passResult.innerHTML = "사용 가능(위험)";
					passResult.style.color = "ORANGE";
					checkPassResult =true;
					break;
			
			default:passResult.innerHTML = "영문자,숫자,특수문자 중 2가지 이상 조합 필수!";
					passResult.style.color = "RED";
					checkPassResult =true;
					break;
						 
						 break;
		}

	}
	 else {		 // 정규표현식과 일치하지 않는 데이터일 경우
		passResult.innerHTML = "사용 불가능 :영문,숫자,특수문자(!@#$%) 8~16글자 ";
		passResult.style.color = "RED";
		checkPassResult =false;
	}
	
}


function checkRetypePass(pass2) {		//패스워드일치(체크)
   var pass1 = document.fr.pass.value;
   var spanElem  = document.getElementById("checkRetypePassResult");   
   
   if(pass1 == pass2) { 
	   spanElem.innerHTML = "비밀번호 일치";
	   spanElem.style.color = "GREEN";
      checkRetypePassResult = true;
      
   } else { 
	   spanElem.innerHTML = "비밀번호 불일치";
      spanElem.style.color = "RED";
      checkRetypePassResult = false;
   }
}



function checkEmail(email2){
		var email1 = document.fr.email.value;
		
		var spanElemEmail  = document.getElementById("checkRetypeEmailResult"); 
		// 정규표현식을 통해 id 규칙 판별
		var regex = /^[A-Za-z0-9@]{4,16}$/;
		
		if(email1 !=  email2) {  // 규칙에 맞지 않는 아이디일 경우
			spanElemEmail.innerHTML = "불일치";
			spanElemEmail.style.color = "RED";
			checkRetypeEmailResult =true;
		} else {
			spanElemEmail.innerHTML = "일치";
			spanElemEmail.style.color = "GREEN";
			checkRetypeEmailResult=false;
		}
	}




function openCheckIdWindow() {
   window.open('check_id.jsp',"","width=400,height=250");
}

function checkSubmit(){
	if(checkIdResult == false) { // 아이디 중복확인을 수행하지 않았을 경우
		// alert() 함수를 통해 "중복 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
		alert("아이디 중복확인 필수!");
		document.fr.id.focus();
		return false; // 현재 함수 종료
	} else if(checkPassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
		// alert() 함수를 통해 "올바른 패스워드 입력 필수!" 메세지 출력 후 아이디 창에 포커스 요청
		alert("올바른 패스워드 입력 필수!");
		document.fr.pass.focus();
		return false; // 현재 함수 종료
	} else if(checkRetypePassResult == false) { // 패스워드 확인을 수행하지 않았을 경우
		// alert() 함수를 통해 "패스워드 확인 필수!" 메세지 출력 후 아이디 창에 포커스 요청
		alert("패스워드 확인 필수!");
		document.fr.pass2.focus();
		return false; // 현재 함수 종료
	} else if(spanElemEmail==false){
		alert("패스워드 확인 필수!");
		document.fr.email.focus();
	}

	
} 
</script>
</head>
<body>
   <div id="wrap">
      <!-- 헤더 들어가는곳 -->
      <jsp:include page="../inc/top.jsp"></jsp:include>

      <!-- 헤더 들어가는곳 -->
        
      <!-- 본문들어가는 곳 -->
        <!-- 본문 메인 이미지 -->
        <div id="sub_img_member"></div>
        <!-- 왼쪽 메뉴 -->
        <nav id="sub_menu">
           <ul>
              <li><a href="#">Join us</a></li>
              <li><a href="#">Privacy policy</a></li>
           </ul>
        </nav>
        <!-- 본문 내용 -->
        <article>
           <h1>Join Us</h1>
           <form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return checkSubmit()">
              <fieldset>
                 <legend>Basic Info</legend>
                 <label>User Id</label>
                 <input type="text" name="id" class="id" id="id" required="required" placeholder="    Click this ->" readonly="readonly">
                 <input type="button" value="dup. check" class="dup" id="btn" onclick="openCheckIdWindow()"><br>
                 
                 <label>Password</label>
                 <input type="password" name="pass" id="pass" required="required" onblur="checkpasswd(this.value)"  placeholder="영문,숫자,특수문자 8~16글자" >
                 <span id="passResult"></span><br>          
                 
                 <label>Retype Password</label>
                 <input type="password" name="pass2" required="required" onkeyup="checkRetypePass(this.value)">
                <span id="checkRetypePassResult"></span><br>
                 
                 <label>Name</label>
                 <input type="text" name="name" id="name" required="required"><br>
                 
                 <label>E-Mail</label>
                 <input type="email" name="email" id="email" required="required"   ><br>
                 
                 <label>Retype E-Mail</label>
                 <input type="email" name="email2" id="email2"  required="required" onblur="checkEmail(this.value)" >
                 	<span id="checkRetypeEmailResult"></span><br>
              </fieldset>
              


<!-- <input type="text" id="sample6_postcode" placeholder="우편번호"> -->
<!-- <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br> -->
<!-- <input type="text" id="sample6_address" placeholder="주소"><br> -->
<!-- <input type="text" id="sample6_detailAddress" placeholder="상세주소"> -->
<!-- <input type="text" id="sample6_extraAddress" placeholder="참고항목"> -->

<!-- 					<input type="text" name="address1" id="address1" readonly="readonly"> -->
<!-- 		  			<input type="text" name="address2" id="address2" placeholder="상세주소 입력"><br> -->


              <fieldset>
		  			<legend>Optional</legend>
		  			<label>Post code</label>
		  			<input type="text"  name="postcode" id="postcode"  readonly="readonly"  placeholder="  Click this->">
		  			<input type="button" onclick="AddressDaumPostcode()" value="우편번호 찾기"><br>
		  			<label>Address</label>
		  			<input type="text"   name="address1" id="address1"  placeholder="주소">
		  			<input type="text"   name="address2" id="address2" placeholder="상세주소"><br>
<!-- 		  			<input type="text" id="sample6_extraAddress" placeholder="참고항목"> -->
		  			<label>Phone Number</label>
		  			<input type="text" name="phone" ><br>
		  			<label>Mobile Phone Number</label>
		  			<input type="text" name="mobile" ><br>
		  		</fieldset>

              <div class="clear"></div>
              <div id="buttons">
                 <input type="submit" value="Submit" class="submit">
                 <input type="reset" value="Cancel" class="cancel">
              </div>
           </form>
        </article>
        
        
      <div class="clear"></div>  
      <!-- 푸터 들어가는곳 -->
      <jsp:include page="../inc/bottom.jsp"></jsp:include>
      <!-- 푸터 들어가는곳 -->
   </div>
</body>
</html>
