# Personal Project
**2020.09.18 ~ 2020.10.13**

**JSP를 활용한 게시판 구축**  
  ---
- 개발 환경
    - JDK 8
    - Intellij
    - Mysql
    - Tomcat
    - HTML, CSS, JS, JSP
  ---
1. 필수 구현 기술
    1. 회원가입 (완료)
    1. 우편번호 검색 API (완료)
    1. 로그인 (완료)
    1. 회원정보수정 (완료)
    1. 게시판 (완료)
    1. 파일 자료실 (진행)    
        - /drive/driveList.jsp 페이징 (예정)
2. 추가 구현 기술
    1. 사진 게시판 (예정)
        - /photo/photoList.jsp 페이징 (예정)
        - photoDeleteForm, photoDeletePro 작성 (예정)
        - file_down.jsp 세팅 
    1. 메일 보내기 (진행)
        - MailSendServlet.java 수정
    1. 댓글 달기 (진행)
    1. 게시글 좋아요 (예정)
  ---
1. 문제점
    - 회원가입 시 인증메일 에러
        1. SMTP 전송 불가  -> MessagingException 발생
        1. mailCheck.jsp 의 EmailChecked() 함수에서 바로 인증완료로 출력 후 페이지 이동
    - 댓글 수정시 위치, 입력창 나타나지 않음
        1. /board/Contents.jsp 의 replyUpdate() 함수가 잘못된 듯 함  -> 파라미터 받는 것? 그래서 입력창이 나타나지 않는 듯 하다
        1. /board/Contents.jsp 의 replyInputForm 위치가 맨 밑에서만 보인다.
    - 페이징
        1. /board/boardList.jsp의 페이징 for문의 i가 나타나지 않음
        ---
