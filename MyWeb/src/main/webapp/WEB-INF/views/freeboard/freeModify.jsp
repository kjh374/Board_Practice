<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%@ include file="../include/header.jsp" %>

    <section>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <p>수정하기</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/freeboard/modify" method="post" name="updateForm">
                            <div class="form-group">
                                <input class="form-control" name='bno' value="${article.bno}" style="display: none;" readonly>
                            </div>
                            <div class="form-group">
                                <label>제목</label>
                                <textarea class="form-control a" name='title' id="title" style="resize: none; overflow: hidden; text-overflow: ellipsis;" placeholder="100자 이내로 입력해주세요."><c:out value="${article.title}"></c:out></textarea>
                            </div>
                            <div class="form-group">
                                <label>글쓴이</label>
                                <textarea class="form-control a" name='writer' id="writer" style="resize: none; overflow: hidden;" placeholder="10자 이내로 입력해주세요."><c:out value="${article.writer}"></c:out></textarea>
                            </div>
                            <div class="form-group">
                                <label>내용</label>(<span id="count">0</span> / 1000)
                                <textarea class="form-control a" name='content' id="content" style="resize: none; overflow: hidden;" placeholder="1000자 이내로 입력해주세요."><c:out value="${article.content}" ></c:out></textarea>
                            </div>

                            <button id="list-btn" type="button" class="btn btn-dark">목록</button>    
                            <button id="update-btn" type="button" class="btn btn-primary">변경</button>
                            <button id="del-btn" type="button" class="btn btn-info">삭제</button>
                    </form>
                                    
                </div>
            </div>
        </div>
        </section>
      
      <%@ include file="../include/footer.jsp" %>

      <script>

        window.onload = () => {
            const $title = document.getElementById('title');
            $title.style.height = '1px';
            $title.style.height = (12 + $title.scrollHeight) + 'px';

            const $writer = document.getElementById('writer');
            $writer.style.height = '1px';
            $writer.style.height = (12 + $writer.scrollHeight) + 'px';

            const $content = document.getElementById('content');
            $content.style.height = '1px';
            $content.style.height = (12 + $content.scrollHeight) + 'px';

            document.getElementById('count').innerText=document.getElementById('content').value.length;

        }

        function resize(obj) {
            obj.style.height = '1px';
            obj.style.height = (12 + obj.scrollHeight) + 'px';
        }

          var numberPattern = /[0-9]/gi;
          var blankPattern = /^\s/;
          var anyBlank = /\s/gi;
          var enterBlank = /\n/gi;
          
          const $title = document.getElementById('title');
          const $writer = document.getElementById('writer');
          const $content = document.getElementById('content');
      
        // document.getElementById('title').onkeyup = (e) => {
        //     if(blankPattern.test(e.target.value)){
        //         alert('제목은 공백으로 시작할 수 없습니다.');
        //         document.getElementById('title').value = '';
        //         document.getElementById('title').focus();
        //         resize(e.target);
        //         return;
        //     } 

        //     if(enterBlank.test(e.target.value)){
        //         alert('제목은 줄개행을 포함할 수 없습니다.');
        //         document.getElementById('title').value = '';
        //         document.getElementById('title').focus();
        //         resize(e.target);
        //         return;
        //     } 
        // }

        //제목 유효성 검사(크기제한)
        document.getElementById('title').oninput =(e) => {
            resize(e.target);

            if(blankPattern.test(e.target.value)){
            alert('제목은 공백으로 시작할 수 없습니다.');
            document.getElementById('title').value = '';
            document.getElementById('title').focus();
            resize(e.target)
            return;
            } 

            if(enterBlank.test(e.target.value)){
            alert('제목은 줄개행을 할 수 없습니다.');
            document.getElementById('title').value = '';
            document.getElementById('title').focus();
            resize(e.target);
            return;
            } 

            if(e.target.value.includes('개새끼')) {
                alert('제목는 비속어를 포함할 수 없습니다.')
                document.getElementById('title').value = '';
                document.getElementById('title').focus();
                return;
            }

            if(e.target.value.length > 70) {
                alert('제목은 70자를 초과할 수 없습니다.');
                e.target.value = e.target.value.slice(0, 70);
                resize(e.target);
                return;
            }
        }

        //시작 공백 체크
        document.getElementById('writer').onkeyup = (e) => {

            if(anyBlank.test(e.target.value)){
                alert('글쓴이는 공백을 허용하지 않습니다.');
                document.getElementById('writer').value = '';
                document.getElementById('writer').focus();
                resize(e.target);
                return;
            } 
        }

        //글쓴이 유효성 검사(크기제한)
        document.getElementById('writer').oninput = (e) => {
            resize(e.target);

            if(anyBlank.test(e.target.value)){
                alert('글쓴이는 공백을 허용하지 않습니다.!');
                document.getElementById('writer').value = '';
                document.getElementById('writer').focus();
                resize(e.target);
                return;
            } 
        
            if(e.target.value.length > 10) {
                    alert('글쓴이는 10자를 초과할 수 없습니다.');
                    e.target.value = e.target.value.slice(0, 10);
                    resize(e.target);
                    return;
            }
            
            if(e.target.value.includes('개새끼')) {
                alert('글쓴이는 비속어를 허용하지 않습니다.')
                document.getElementById('writer').value = '';
                document.getElementById('writer').focus();
                return;
            }
        }

            //내용 빈칸 제한
            document.getElementById('content').onkeyup = (e) => {
                console.log(e.target.value);
                resize(e.target);

                if(blankPattern.test(e.target.value)){
                    alert('내용은 공백으로 시작할 수 없습니다.');
                    document.getElementById('content').value = '';
                    document.getElementById('count').innerText = 0;
                    document.getElementById('content').focus();
                    return;
                } 
            }

            //내용 유효성 검사(크기제한)
            document.getElementById('content').oninput = (e) => {
                document.getElementById('count').innerText=e.target.value.length;
                resize(e.target);

                if(e.target.value.length > 1000) {
                    alert('내용은 1000자를 초과할 수 없습니다.');
                    e.target.value = e.target.value.slice(0, 1000);
                    document.getElementById('count').innerText=e.target.value.length;
                    resize(e.target);
                    return;
                }
                
                if(e.target.value.includes('개새끼')) {
                    alert('내용은 비속어를 허용하지 않습니다.')
                    document.getElementById('content').value = '';
                    document.getElementById('content').focus();
                    return;
                }
            }

        document.getElementById('update-btn').onclick = () => {
                const title = document.getElementById('title').value;
                const content = document.getElementById('content').value;
                const $writer = document.getElementById('writer');
                
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
                
                if(document.getElementById('writer').value ===''){
                    alert('글쓴이는 필수 입력값입니다.');
                    document.getElementById('writer').value = '';
                    document.getElementById('writer').focus();
                    return;
                } 

                if(anyBlank.test($writer.value)){
                    alert('글쓴이는 공백을 허용하지 않습니다.');
                    document.getElementById('writer').value = '';
                    document.getElementById('writer').focus();
                    return;
                } 
                
                if($writer.value.includes('개새끼')) {
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

                alert('글이 정상적으로 등록되었습니다.')
                document.updateForm.submit();
            
        }

        //목록 이동 처리
        document.getElementById('list-btn').onclick = function(){
            location.href='${pageContext.request.contextPath}/freeboard/freeList';
        }

        //form 태그는 메서드 없이 form 태그의 name으로 요소를 바로 취득할 수 있습니다.
        const $form = document.updateForm;


        //삭제 버튼 이벤트 처리
        document.getElementById('del-btn').onclick = () => {
            if(confirm('정말 삭제하시겠습니까?')){
                $form.setAttribute('action', '${pageContext.request.contextPath}/freeboard/delete');
                $form.submit();
            }
        }

      </script>