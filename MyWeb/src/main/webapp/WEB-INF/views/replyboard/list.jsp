<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>등록일</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="vo" items="${boardList}">
				<tr>
					<td>${vo.rno}</td>
					<td><a href="${pageContext.request.contextPath}/replyboard/content?bno=${vo.bno}">
							<c:if test="${vo.parentNo != vo.bno}">
								<c:forEach begin="1" step="1" end="${vo.boardLevel}">
									&nbsp; 
								</c:forEach>
								[답변] 
							</c:if>
							<c:if test="${vo.parentNo == vo.bno}">
							 	${vo.title}
							</c:if>
						 </a></td>
					<td>${vo.writer}</td>
					<td>${vo.date}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/replyboard/regist'">글쓰기</button>
</body>
</html>