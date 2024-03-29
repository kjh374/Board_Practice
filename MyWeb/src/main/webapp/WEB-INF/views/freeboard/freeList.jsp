﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    
    <%@ include file="../include/header.jsp" %>
   
<html>
	<head>
	<style type="text/css">
 		.board-title {
 			width: 70%;
 		}

        .table-bordered {
            overflow: hidden;
            white-space:nowrap;
            text-overflow: ellipsis;       
        }
 		
 		.table-bordered>thead>tr>th {
			background-color: #E7F2F9;
			color: #003366;
			text-align: center;
		}
		
		tbody>tr>td:first-child, tbody>tr>td:nth-child(3), tbody>tr>td:last-child {
			text-align: center;
		}
 	</style> 
	</head>
</html>
    
    <section>
        <div class="container-fluid">
            <div class="row">
                <!--lg에서 9그리드, xs에서 전체그리드-->   
                <div class="col-lg-9 col-xs-12 board-table">
                    <div class="titlebox">
                        <p>자유게시판</p>
                    </div>
                    <hr>
                    
                    <!--form select를 가져온다 -->
            <form action="${pageContext.request.contextPath}/freeboard/freeList" name="searchForm">
		    		<div class="search-wrap">
                        <span><a href="${pageContext.request.contextPath}/freeboard/freeList">Home</a><c:if test="${pc.page.keyword != null}"> > 총 ${pc.articleTotalCount} 건의 검색결과가 있습니다.</c:if> </span>
                       <button type="button" class="btn btn-info search-btn" id="search">검색</button>
                       <input type="text" name="keyword" id="keyword" class="form-control search-input" value="${pc.page.keyword}">
                       <select name="condition" class="form-control search-select">
                            <option value="title" ${pc.page.condition == 'title' ? 'selected' : ''}>제목</option>
                            <option value="writer" ${pc.page.condition == 'writer' ? 'selected' : ''}>글쓴이</option>
                            <option value="content" ${pc.page.condition == 'content' ? 'selected' : ''}>내용</option>
                            <option value="titleContent" ${pc.page.condition == 'titleContent' ? 'selected' : ''}>제목+내용</option>
                       </select>
                    </div>
		    </form>
                   
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th class="board-title">제목</th>
                                <th>글쓴이</th>
                                <th>등록일</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach var="vo" items="${boardList}">
	                            <tr>
	                                <td>${vo.rn}</td>
	                                <td><a href="${pageContext.request.contextPath}/freeboard/content?bno=${vo.bno}&pageNo=${pc.page.pageNo}&amount=${pc.page.amount}&keyword=${pc.page.keyword}&condition=${pc.page.condition}"><c:out value="${vo.title}"></c:out></a>
	                                <c:if test="${vo.count != 0}">
	                                	<span>(${vo.count})</span></td>
	                                </c:if>
	                                <td><c:out value="${vo.writer}"></c:out></td>
	                                <td>${vo.date}</td>
	                            </tr>
                            </c:forEach>
                        </tbody>
                        
                    </table>


                    <!--페이지 네이션을 가져옴-->
		    <form action="${pageContext.request.contextPath}/freeboard/freeList" name="pageForm">
                    <div class="text-center">
                    <hr>
                    <ul id="pagination" class="pagination pagination-sm">
                    	<c:if test="${pc.prev}">                    	
                        	<li><a href="#" data-pagenum="${pc.first}">처음</a></li>
                        	<li><a href="#" data-pagenum="${pc.begin-1}">이전</a></li>
                    	</c:if>
                   		
                   		<c:forEach var="num" begin="${pc.begin}" end="${pc.end}">
                        	<li class="${pc.page.pageNo == num ? 'active' : ''}"><a href="#" data-pagenum="${num}">${num}</a></li>
                        </c:forEach>

                        <c:if test="${pc.next}">
	                        <li><a href="#" data-pagenum="${pc.end+1}">다음</a></li>
	                        <li><a href="#" data-pagenum="${pc.last}">끝</a></li>
                        </c:if>
                    </ul>
                    <button type="button" class="btn btn-info" onclick="location.href='${pageContext.request.contextPath}/freeboard/freeRegist'">글쓰기</button>
                    </div>

                    <input type="hidden" name="pageNo" value="${pc.page.pageNo}">
                    <input type="hidden" name="amount" value="${pc.page.amount}">
                    <input type="hidden" name="keyword" value="${pc.page.keyword}">
                    <input type="hidden" name="condition" value="${pc.page.condition}">
		    </form>

                </div>
            </div>
        </div>
	</section>
	
	<%@ include file="../include/footer.jsp" %>

    <script>
        //브라우저 창이 로딩이 완료된 후에 실행할 것을 보장하는 이벤트.
        window.onload = function(){

            //사용자가 페이지 관련 버튼을 클릭했을 때 (이전, 다음, 1, 2, 3....)
            //a태그의 href에다가 각각 다른 url을 작성해서 요청을 보내기가 귀찮다.
            //클릭한 버튼이 무엇인지를 확인해서 그 버튼에 맞는 페이지 정보를
            //자바스크립트로 끌고 와서 요청을 보내 주겠다.
            document.getElementById('pagination').addEventListener('click', e => {
                if(!e.target.matches('a')){
                    return;
                };

                e.preventDefault(); //a태그의 고유 기능 중지

                //현재 이벤트가 발생한 요소(버튼)의
                //data-pagenum의 값을 얻어서 변수에 저장.
                //data- 으로 시작하는 속성값을 dataset 프로퍼티로 쉽게 끌고 올 수 있습니다.
                const value = e.target.dataset.pagenum;

                //페이지 버튼들을 감싸고 있는 form태그를 지목하여
                //그 안에 숨겨져 있는 input태그의 value에
                //위에서 얻은 data-pagenum의 값을 삽입한 후 submit
                document.pageForm.pageNo.value = value;
                document.pageForm.submit();

            });

            //검색 유효성 검사
            document.getElementById('search').onclick = () => {
                if(document.getElementById('keyword').value === ''){
                    alert('검색어를 입력해주세요.');
                    document.getElementById('keyword').focus();
                    return;
                }
                document.searchForm.submit();
            }

        }
    </script>

