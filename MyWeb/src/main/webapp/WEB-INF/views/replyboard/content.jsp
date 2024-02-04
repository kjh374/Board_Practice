<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/replyboard/modPage" method="post" name="modForm">
		<table>
			<tbody>
                <tr hidden>
                    <td><label for="bno">번호</label></td>
                    <td><input name="bno" id="bno" value="${board.bno}"></td>
                </tr>
				<tr>
					<td><label for="title">제목</label></td>
					<td><textarea type="text" name="title" id="title" readonly>${board.title}</textarea></td>
				</tr>
				<tr>
					<td><label for="writer">작성자</label></td>
					<td><textarea type="text" name="writer" id="writer" readonly>${board.writer}</textarea></td>
				</tr>
				<tr>
					<td><label for="content">내용</label></td>
					<td><textarea type="text" name="content" id="content" readonly>${board.content}</textarea></td>
				</tr>
				<tr>
					<td><label for="password">비밀번호</label></td>
					<td><input type="password" name="password" id="password"></td>
				</tr>
			</tbody>
		</table>
		<button type="button" id="modify">수정</button>
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/replyboard/list'">목록</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/replyboard/replyRegist?parentNo=${board.parentNo}&groupOrder=${board.groupOrder}&boardLevel=${board.boardLevel}'">답글 달기</button>
	</form>

    <form action="${pageContext.request.contextPath}/myreply/regist">
        
    </form>
	<script>
		document.getElementById('modify').onclick = () => {


			document.modForm.submit();
		}
        window.onload = () => {

            if('${msg}') alert('비밀번호가 틀렸습니다.');
        }


	</script>
</body>
</html>