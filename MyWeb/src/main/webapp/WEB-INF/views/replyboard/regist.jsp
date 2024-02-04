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
	<form action="${pageContext.request.contextPath}/replyboard/regist" method="post" name="registForm">
		<table>
			<tbody>
				<tr>
					<td><label for="title">제목</label></td>
					<td><input type="text" name="title" id="title"></td>
				</tr>
				<c:if test="${parentNo != null}">
					<tr hidden>
						<td><label for="parentNo">부모글번호</label></td>
						<td><input name="parentNo" id="parentNo" value="${parentNo}"></td>
					</tr>
				</c:if>
				<c:if test="${groupOrder != null}">
					<tr hidden>
						<td><label for="groupOrder">부모글번호</label></td>
						<td><input name="groupOrder" id="groupOrder" value="${groupOrder}"></td>
					</tr>
				</c:if>
				<c:if test="${boardLevel != null}">
					<tr hidden>
						<td><label for="boardLevel">글계층</label></td>
						<td><input name="boardLevel" id="boardLevel" value="${boardLevel}"></td>
					</tr>
				</c:if>
				<tr>
					<td><label for="writer">작성자</label></td>
					<td><input type="text" name="writer" id="writer"></td>
				</tr>
				<tr>
					<td><label for="content">내용</label></td>
					<td><input type="text" name="content" id="content"></td>
				</tr>
				<tr>
					<td><label for="password">비밀번호</label></td>
					<td><input type="password" name="password" id="password"></td>
				</tr>
			</tbody>
		</table>
		<button type="button" id="regist">등록</button>
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/replyboard/list'">목록</button>
	</form>
	<script>
		document.getElementById('regist').onclick = () => {


			document.registForm.submit();
		}

	</script>
</body>
</html>