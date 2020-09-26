<%@ page import="member.MemberDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinForm.jsp</title>
    <link rel="stylesheet" href="../css/default.css" type="text/css">
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
                    // 예제를 참고하여 다양한 활용법을 확인해 보세요.
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = data.address; // 주소 변수
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
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        addr += extraAddr;

                    } else {
                        document.getElementById("sample6_extraAddress").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById('address1').value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById('address2').focus();
                }
            }).open();
        }

        function idCheck() {
            var id = document.joinForm.id.value;

            if(!id) {
                alert("ID를 입력하세요");
                return;
            } else if (id.length < 6) {
                alert("ID는 6글자 이상 입력하세요");
                return;
            }
            <%
            String id = request.getParameter("id");
            MemberDAO mdao = new MemberDAO();
            boolean result = mdao.idCheck(id);

            if(result) {%>
                alert("이미 사용중인 ID입니다.");
                return;
            <%} else {%>
                alert("입력하신 " + id + "는 사용할 수 있는 ID입니다.");
                return;
            <%}
%>
        }

    </script>

</head>
<body>
<jsp:include page="../inc/nav.jsp"/>
<section class="join">
    <form action="joinPro.jsp" method="post" name="joinForm">
        <div class="left_notice">
            <h2>JOIN</h2>
            <p>ID는<br> <strong>6글자 이상</strong> 입력해주세요</p>
            <p>PASSWORD는<br> <strong>8글자 이상 12글자 이하</strong>로 입력해주세요</p>
            <p>PASSWORD는<br> <strong>대소문자, 숫자, 특수기호(!, @, #, $)</strong> 중<br>
                <strong>3가지 이상</strong> 써 주세요</p>
        </div>
        <div class="login">
            <fieldset>
                <h2 style="text-align: left; margin-left: 50px">Basic Info</h2><hr>
                <input type="text" name="name" class="text" placeholder="NAME" required><br>

                <input type="text" name="id" placeholder="ID"
                       style="border: none; width: 205px; border-radius: 3px; background-color: lightgray; padding: 10px; color: black;" required>
                <input type="button" value=" ID 중복 체크 " class="button" onclick="idCheck()"><br>

                <input type="password" name="pass1" class="text" placeholder="PASSWORD" required><br>
                <input type="password" name="pass2" class="text" placeholder="PASSWORD CHECK" required><br>
                <input type="text" name="postcode" id="postcode" placeholder="POST CODE" readonly
                    style="border: none; width: 205px; border-radius: 3px; background-color: lightgray; padding: 10px; color: black;" required>
                <input type="button" value="우편번호조회" class="button" onclick="sample()"><br>
                <input type="text" name="address1" id="address1" class="text" placeholder="ADDRESS" readonly><br>
                <input type="text" name="address2" id="address2" class="text" placeholder="SUB ADDRESS" required><br>
                <input type="email" name="email" placeholder="E-MAIL" class="text" required><br>

                <h2 style="text-align: left; margin-left: 50px">Sub Info</h2><hr>
                <input type="text" name="age" placeholder="AGE" class="text"><br>
                <input type="text" name="phone" placeholder="PHONE NUMBER" class="text"><br>
                <input type="radio" value="남" name="gender" checked> 남
                <input type="radio" value="여" name="gender"> 여<br>

                <input type="submit" value="회원가입" class="button">
                <input type="button" value="회원가입 취소" onclick="location.href='main.jsp'" class="button">
            </fieldset>
        </div>
    </form>
</section>
<jsp:include page="../inc/footer.jsp"/>
</body>


</html>
