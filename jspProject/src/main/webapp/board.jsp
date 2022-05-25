<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="./css/menu.css" rel="stylesheet">
<style type="text/css">
#main{
	margin: 0 auto;
	width: 800px;
	height: 100%;
}
table {
	width: 100%;
	min-height: 200px;
	border-collapse: collapse;
}
th{
	background-color: gray;
}
td{
	border-bottom: 1px solid red;
	text-align: center;
}
tr:hover{
	background-color: #c1c1c1;
}
#col1{
	width: 10%;
}
#col2{
	width: 20%;
}
#col3{
	width: 40%;
}
#tleft{
	text-align: left;
}
a:visited, a:link {
	color: black;
	text-decoration: none;
}
small {
	color: green;
	font-weight: bold;
}
</style>
</head>
<body>
	<%@include file="./menu.jsp"%>
	<div id="main">
		<!-- 이제 JSTL을 씁니다. -->
		<h1>게시판 만들기</h1>
		<table>
			<tr>
				<th id="col1">번호</th>
				<th id="col3">제목</th>
				<th id="col1">쓴사람</th>
				<th id="col2">쓴날짜</th>
				<th id="col1">읽음</th>
				<th id="col1">좋아요</th>
			</tr><c:forEach items="${list }" var="i">
			<tr>
				<td>${i.b_no }</td>
				<td id="tleft"><a href="./detail?b_no=${i.b_no }">${i.b_title  } <c:if test="${i.commentcount gt 0 }"><small>${i.commentcount }</small></c:if></a></td>
				<td>${i.m_name }</td>
				<td>${i.b_date }</td>
				<td>${i.b_count }</td>
				<td>${i.b_like }</td>
			</tr></c:forEach>
		</table>
		<c:choose>
			<c:when test="${sessionScope.m_id ne null }">
				<button onclick="location.href='./write'">글쓰기</button>
			</c:when>
			<c:otherwise>
				<button onclick="location.href='./index.jsp'">글을 쓰러면 로그인하세요</button>
			</c:otherwise>
		</c:choose>
		
		<hr>
		pageNo = ${pageNo }<br>
		totalcount = ${totalcount }<br>
		totalpage = <fmt:parseNumber integerOnly="true" var="totalpage" value="${totalcount / 10 }"/>
		<c:if test="${(totalcount % 10) > 0 }">
			<c:set var="totalpage" value="${totalpage + 1}"/>
		</c:if>
		변환된 : ${totalpage }<br>
		<c:if test="${pageNo % 10 ne 0 }">
				<fmt:parseNumber integerOnly="true" var="startpage" value="${pageNo / 10 }"/>
				<c:set var="startpage" value="${startpage * 10 + 1 }"/>			
		</c:if> 
		<c:if test="${pageNo % 10 eq 0 }">
			<c:set var="startpage" value="${pageNo - 9 }"/>
		</c:if>
		startpage : ${startpage }<br>
		
		<c:set var="endpage" value="${startpage + 9 }"/>
		<c:if test="${startpage + 10 gt totalpage }">
			<c:set var="endpage" value="${totalpage }"/>
		</c:if>
		endpage = ${endpage }<br>
	
	
		<button onclick="location.href='./board?pageNo=1'">앞으로</button>
	
		<c:if test="${pageNo gt 10 }">	
		<button onclick="location.href='./board?pageNo=${pageNo - 10}'">
			<img alt="" src="./img/double_left.png">
		</button>
		</c:if>
		
		
		<c:if test="${pageNo eq 1 }">
			<button disabled="disabled" onclick="location.href='./board?pageNo=${pageNo - 1}'">
				<img alt="left" src="./img/left.png">
			</button>
		</c:if>
		<c:if test="${pageNo ne 1 }">
			<button onclick="location.href='./board?pageNo=${pageNo - 1}'">
				<img alt="left" src="./img/left.png">
			</button> 
		</c:if>
		
		<c:forEach begin="${startpage }" end="${endpage }" var="n">
			<c:if test="${pageNo eq n }">
				<button style="background-color: red;" onclick="location.href='./board?pageNo=${n }'"><b>${n }</b></button>
			 </c:if>
			 <c:if test="${pageNo ne n }">
			 	<button onclick="location.href='./board?pageNo=${n }'">${n }</button>
			 </c:if>
		</c:forEach>
		
		<c:if test="${pageNo eq totalpage }">
			<button disabled="disabled" onclick="location.href='./board?pageNo=${pageNo + 1}'">
				<img alt="right" src="./img/right.png">
			</button>
		</c:if>
		<c:if test="${pageNo ne totalpage }">
			<button onclick="location.href='./board?pageNo=${pageNo + 1}'">
				<img alt="right" src="./img/right.png">
			</button>
		</c:if>
		
		<c:if test="${pageNo lt totalpage - 9 }">
			<button onclick="location.href='./board?pageNo=${pageNo + 10}'">
				<img alt="right" src="./img/double_right.png">
			</button>
		</c:if>
		
		<button onclick="location.href='./board?pageNo=${totalpage}'">뒤로</button>
		
	</div>
</body>
</html>



