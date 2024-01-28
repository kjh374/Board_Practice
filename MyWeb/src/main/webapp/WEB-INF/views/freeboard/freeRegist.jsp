<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@ include file="../include/header.jsp" %>

<html>
    <head>
        <style type="text/css">

            .t-title {
                text-align: center;
            }
            /*input 요소의 넓이만 선택*/
            .t-control input {
                display: inline; /*인라인요소로 변경한다*/
            }

            /*개발자 도구에서 input-sm의 정렬을 푼다*/
            .t-control .input-sm {
                height: auto;
                line-height: normal;
                width: 800px;
            }

            .t-control .input-wr {
                width: 400px;
            }

            .t-control .input-pw {
                width: 400px;
            }

            .t-control .input-co {
                min-height: 5rem;
                overflow-y: hidden;
                resize: none;
            }

        </style>
    </head>
</html>

    <section>
       <div class="container">
            <div class="row">
                <div class="col-xs-12 content-wrap">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    
                    <form method="post" name="registForm">
                        <table class="table">
                            <tbody class="t-control">
                                <tr>
                                    <td class="t-title">TITLE</td>
                                    <td>
                                        <input class="form-control input-sm" name="title" id="title" placeholder="100자 이내로 입력해주세요.">&nbsp;
                                        <span>100자 이내로 입력해주세요.</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t-title">WRITER</td>
                                    <td>
                                        <input class="form-control input-wr" name="writer" id="writer" placeholder="10자 이내로 입력해주세요.">&nbsp;
                                        <span>10자 이내로 입력해주세요. (공백은 허용하지 않습니다.)</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="t-title">CONTENT <br/><span id="count">0</span> / 1000</td>
                                    <td>
                                        <textarea class="form-control input-co" name="content" id="content" placeholder="1000자 이내로 입력해주세요."></textarea>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>PASSWORD</td>
                                    <td>
                                        <input type="password" class="form-control input-pw" name="password" id="password" placeholder="패스워드를 입력해주세요."/>&nbsp;
                                        <span>영문, 숫자, 특수문자를 모두 포함하여 6 ~ 12자를 입력해주세요.</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="titlefoot">
                            <button type="button" class="btn" id="reg">등록</button>
                            <button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/freeboard/freeList'">목록</button>
                        </div>
                    </form>

                </div>
            </div>    
       </div>
      
    </section>
      
  	<%@ include file="../include/footer.jsp" %>
  
      <script>

          
        function resize(obj) {
            obj.style.height = '1px';
            obj.style.height = (12 + obj.scrollHeight) + 'px';
        }

          var passwordPattern = /^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{6,12}$/;
          var englishPattern = /[A-Za-z]/gi;
          var specialPattern = /[`~!@#$%^&*|\\\'\";:\/?-]/gi;
          var numberPattern = /[0-9]/gi;
          var blankPattern = /^\s/;
          var anyBlank = /\s/gi;
          
          const $title = document.getElementById('title');
          const $writer = document.getElementById('writer');
          const $content = document.getElementById('content');
          const $password = document.getElementById('password');
      
        document.getElementById('title').onkeyup = (e) => {
            if(blankPattern.test(e.target.value)){
                alert('제목은 공백으로 시작할 수 없습니다.');
                document.getElementById('title').value = '';
                document.getElementById('title').focus();
                return;
            } 
        }

        //제목 유효성 검사(크기제한)
        document.getElementById('title').oninput =(e) => {

            if(e.target.value.includes('개새끼')) {
                alert('제목는 비속어를 포함할 수 없습니다.')
                document.getElementById('title').value = '';
                document.getElementById('title').focus();
                return;
            }

            if(e.target.value.length > 70) {
                alert('제목은 70자를 초과할 수 없습니다.');
                e.target.value = e.target.value.slice(0, 70);
                return;
            }
        }

        document.getElementById('writer').onkeyup = (e) => {
            if(anyBlank.test(e.target.value)){
                alert('글쓴이는 공백을 허용하지 않습니다.');
                document.getElementById('writer').value = '';
                document.getElementById('writer').focus();
                return;
            } 
        }

        //글쓴이 유효성 검사(크기제한)
        document.getElementById('writer').oninput = (e) => {
            if(anyBlank.test(e.target.value)){
                alert('글쓴이는 공백을 허용하지 않습니다.!');
                document.getElementById('writer').value = '';
                document.getElementById('writer').focus();
                return;
            } 
        
            if(e.target.value.length > 10) {
                    alert('글쓴이는 10자를 초과할 수 없습니다.');
                    e.target.value = e.target.value.slice(0, 10);
                    return;
            }
            
            if(e.target.value.includes('개새끼')) {
                alert('글쓴이는 비속어를 허용하지 않습니다.')
                document.getElementById('writer').value = '';
                document.getElementById('writer').focus();
                return;
            }
        }


            //내용 유효성 검사(크기제한)
            document.getElementById('content').oninput = (e) => {
                document.getElementById('count').innerText=e.target.value.length;
                resize(e.target)

                if(blankPattern.test(e.target.value)){
                    alert('내용은 공백으로 시작할 수 없습니다.');
                    document.getElementById('content').value = '';
                    document.getElementById('count').innerText = 0;
                    document.getElementById('content').focus();
                    resize(e.target);
                    return;
                }

                if(e.target.value.length > 1000) {
                    alert('내용은 1000자를 초과할 수 없습니다.');
                    e.target.value = e.target.value.slice(0, 1000);
                    document.getElementById('count').innerText=e.target.value.length;
                    resize(e.target)
                    return;
                }
                
                if(e.target.value.includes('개새끼')) {
                    alert('내용은 비속어를 허용하지 않습니다.')
                    document.getElementById('content').value = '';
                    document.getElementById('content').focus();
                    return;
                }
            }
            
            document.getElementById('password').onkeyup = (e) => {
                if(anyBlank.test(e.target.value)){
                alert('비밀번호는 공백을 허용하지 않습니다.');
                document.getElementById('password').value = '';
                document.getElementById('password').focus();
                return;
            }
            }
            
        //비밀번호 유효성 검사(크기제한)
            document.getElementById('password').oninput = (e) => {
                if(anyBlank.test(e.target.value)){
                alert('비밀번호는 공백을 허용하지 않습니다.!');
                document.getElementById('password').value = '';
                document.getElementById('password').focus();
                return;
            } 

                if(e.target.value.length > 12){
                    $password.value = $password.value.slice(0,12);
                    document.getElementById('password').focus();
                    alert('비밀번호는 12자를 초과할 수 없습니다.')
                    return;
                }


                if(e.target.value.includes('개새끼')) {
                    alert('비밀번호는 비속어를 허용하지 않습니다.')
                    document.getElementById('password').value = '';
                    document.getElementById('password').focus();
                    return;
                }
            }

        document.getElementById('reg').onclick = () => {
                const title = document.getElementById('title').value;
                const content = document.getElementById('content').value;
                const writer = document.getElementById('writer').value;
                const password = document.getElementById('password').value;
                
                console.log(title.length);

                //유효성 검사
                if(title===''){
                    alert('제목은 필수 입력값입니다.');
                    document.getElementById('title').value = '';
                    document.getElementById('title').focus();
                    return;
                } 
                
                if(title.includes('개새끼')) {
                    alert('제목은 비속어를 허용하지 않습니다.')
                    document.getElementById('title').value = '';
                    document.getElementById('title').focus();
                    return;
                }
                
                if(writer===''){
                    alert('글쓴이는 필수 입력값입니다.');
                    document.getElementById('writer').value = '';
                    document.getElementById('writer').focus();
                    return;
                } 

                if(anyBlank.test(writer)){
                    alert('글쓴이는 공백을 허용하지 않습니다.');
                    document.getElementById('writer').value = '';
                    document.getElementById('writer').focus();
                    return;
                } 
                
                if(writer.includes('개새끼')) {
                    alert('글쓴이는 비속어를 포함할 수 없습니다.')
                    document.getElementById('writer').value = '';
                    document.getElementById('writer').focus();
                    return;
                }

                if(content===''){
                    alert('내용은 필수 입력값입니다.');
                    document.getElementById('content').value = '';
                    document.getElementById('count').innerText = 0;
                    document.getElementById('content').focus();
                    return;
                } 
                
                if(content.trim()===''){
                    alert('내용에는 공백을 허용하지 않습니다.');
                    document.getElementById('content').value = '';
                    document.getElementById('count').innerText = 0;
                    document.getElementById('content').focus();
                    return;
                } 

                if(content.includes('개새끼')) {
                    alert('내용에는 비속어를 포함할 수 없습니다.')
                    document.getElementById('content').value = '';
                    document.getElementById('content').focus();
                    return;
                }

                if(password === ''){
                    alert('비밀번호는 필수 입력값입니다.');
                    document.getElementById('password').value = '';
                    document.getElementById('password').focus();
                    return;
                }
                
                if(password.trim() === ''){
                    alert('비밀번호는 공백을 허용하지 않습니다.');
                    document.getElementById('password').value = '';
                    document.getElementById('password').focus();
                    return;
                }
                
                if(!englishPattern.test(password)) {
                    alert('비밀번호에 영문이 포함되어 있지 않습니다.');
                    document.getElementById('password').value = '';
                    document.getElementById('password').focus();
                    return;
                } 

                if(!numberPattern.test(password)) {
                    alert('비밀번호에 숫자가 포함되어 있지 않습니다.');
                    document.getElementById('password').value = '';
                    document.getElementById('password').focus();
                    return;
                } 

                if(!specialPattern.test(password)) {
                    alert('비밀번호에 특수문자가 포함되어 있지 않습니다.');
                    document.getElementById('password').value = '';
                    document.getElementById('password').focus();
                    return;
                } 

                if(password.length < 6 || password.length > 12){
                    alert('비밀번호의 글자수가 유효하지 않습니다.');
                    document.getElementById('password').value = '';
                    document.getElementById('password').focus();
                    return;
                }

                alert('글이 정상적으로 등록되었습니다.')
                document.registForm.submit();
            
        }


    </script>