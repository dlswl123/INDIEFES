<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<script>
$(document).ready(function() {
	var message = "${message}";
	console.log("message:" + message);
	
	if (message == "success_insert") {
		alert("글이 성공적으로 저장되었습니다")
	} else if (message == "success_delete") {
		alert("글이 성공적으로 삭제되었습니다")
	}
	
	// 글쓰기버튼
	$("#btnRegist").click(function(){
		console.log("regist");
		location.href="/indiefes/board/regist";
	});
	
	// 검색버튼
	$("#btnSearch").click(function(){
		console.log("btnSearch");
		setPage();
		setSearch();
		$("input[name=page]").val(1); // 검색시 페이지1로가기
		$("#pageForm").submit();
	});
	
	// 페이지
	function setPage() {
		var page = "${pagingDto.page}"
			if (page == "") {
				page = 1;
		}
		var perPage = $("#perPage").val();
		console.log(page);
		$("input[name=page]").val(page);
		$("input[name=perPage]").val(perPage);
	}
	
	// 검색
	function setSearch() {
		var searchType = $("#searchType").val();
		var keyword = $("#keyword").val();
		
		console.log("searchType" + searchType);
		console.log("keyword" + keyword);
		$("input[name=searchType]").val(searchType);
		$("input[name=keyword]").val(keyword);
		
	}
	
	//	n줄씩 보기
	$("#perPage").change(function() {
		console.log("perPage");
		setPage();
		setSearch();
		$("#pageForm").submit();
	});
	
	// 제목클릭
	$(".click_subject").click(function(e){
			e.preventDefault(); // 브라우저기능막기, a -링크 기능막기 
			var board_number = $(this).attr("data-board_number");
			$("input[name=board_number]").val(board_number);
			console.log("제목클릭" + board_number);
			
			var href = $(this).attr("href");
			$("#pageForm").attr("action",href).submit();
	}); // $(".click_subject")
	
	// 페이지 번호클릭
	$(".a_pagination").click(function(e){
			e.preventDefault();
//			$(this).text();
			setPage();
			var page = $(this).attr("data-page"); // 페이지 숫자 읽기
			$("input[name=page]").val(page); // 아래쪽 폼의 page에 설정
			$("#pageForm").submit(); // 폼 설정

			
	}); // $(".a_pagination").click
}); // $(document)
</script>
<style>
#logo font {
	font-family: blox;
	font-size: 3.5rem;
	margin-left: 30px;
}
#logo {
	margin-bottom: 30px;
	color: #292929;	
 	text-shadow: 1px 1px 0px lightgrey;
}
</style>
<form id="pageForm" action="/indiefes/board/list">
	<input type="hidden" name="board_number" 
			value="${param.board_number}">
	<input type="hidden" name="page" 
			value="${paginationDto.pagingDto.page}">
	<input type="hidden" name="perPage" 
			value="${paginationDto.pagingDto.perPage}">
	<input type="hidden" name="searchType" 
			value="${paginationDto.pagingDto.searchType}">
	<input type="hidden" name="keyword" 
			value="${paginationDto.pagingDto.keyword}">
</form>

<div class="col-md-10">
	<section id="logo" style="padding:20px;width:100%;">
		<div class="row">
			<font>InDiEFeS</font>
			<span style="font-size:1.25rem;font-family:hss;margin-bottom: 15px;margin-top: auto;margin-left: 10px;margin-right: auto;">
			자유게시판</span>
			<c:if test="${user_level < 3}">
				<div style="float:right;margin-bottom:0px;margin-top:auto;">
					<input type="button" class="btn btn-primary" value="홍보글작성" id="btnWrite" />
				</div>
			</c:if>
			
		</div>
	</section><hr>
<div style="background-color:#292929;font-family:dgm;">
	<div class="col-md-11" style="margin:auto;">
	<br>
	<select id="perPage">
	
		<c:forEach var= "i" begin= "5" end= "10" step= "5">
			<option
			value='<c:out value="${i}"/>'
			<c:if test="${i == pagingDto.perPage}">selected</c:if>
			><c:out value="${i}"/>줄씩 보기</option>
		</c:forEach>
	</select>
	
	<select id="searchType">
		<option value="subject"
		<c:if test="${pagingDto.searchType == 'subject'}">
			selected
		</c:if>
		>제목</option>
		<option value="content"
		<c:if test="${pagingDto.searchType == 'content'}">
			selected
		</c:if>
		>내용</option>
		<option value="user_id"
		<c:if test="${pagingDto.searchType == 'user_id'}">
			selected
		</c:if>
		>작성자</option>
	</select>
	
			<input type="text" id = "keyword"
					placeholder="검색어를 입력하세요"value="${pagingDto.keyword}"/>
			<input type="button" value="검색버튼"id= "btnSearch"
				class= "btn btn-danger"/>
					
				<!-- 로그인시에만 글쓰기버튼을 보여질수있도록 구현 -->
				<c:if test="${user_id != null}">	
				<input type="button" class="btn btn-success" value="글쓰기" id="btnRegist">
			 	</c:if>
			<br><br>
			<div class="row">
				<div class="col-md-12">
				<!-- sytle부분 board_background 이미지사진으로 설정 -->
				<table class="table" style="background:url('${pageContext.request.contextPath}/resources/bg_images/summer.png') no-repeat 0 center;">
					<thead>
						<tr>
							<td>글번호</td>
							<td>글제목</td>
							<td>작성자</td>
							<td>작성일</td>
							<td>조회수</td>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${list}" var="boardVo">
						<tr>
							<!-- 글번호 -->
							<td>${boardVo.board_number}</td>
							<td>
								<a href="/indiefes/board/read?board_number=${boardVo.board_number}">
								<!-- class="click_subject" 
								data-board_number="${boardVo.board_number}" -->
								${boardVo.subject}</a>
								<c:if test="${boardVo.reply_count != 0 }">
								<span style="color: red;">[${ boardVo.reply_count}]</span>
								</c:if>
								
								<c:if test="${boardVo.view_count >= 100 }">
								<img src="<c:url value='/resources/images/heart_fill.png'/>" width="15">
								<span style="color: red;">hot</span>
								</c:if>
							</td>		
							<!-- 회원 -->
							<td>${boardVo.user_nick}</td>
							<%--(${boardVo.user_id}) --%>
							<!-- 작성일 -->
							<td>
							<%-- <fmt:formatDate value=" --%>
							${boardVo.reg_date}
	
							<!-- pattern="yyyy/mm/dd HH:mm/ss"/> -->
							</td>
							<td>${boardVo.view_count}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				</div>
			</div>
			<!--  페이지네이션(페이지클릭창) -->
		<div class="col-md-12 text-center">
			<div class="row">
			<div style="margin-left:auto;margin-right:auto;">
			<nav>
				<ul class="pagination" >
				<!-- 이전 -->
				<c:if test="${paginationDto.prev == true }">
					<li class="page-item">
						<a class="page-link a_pagination" href="#"
						data-page="${paginationDto.startPage - 1}">이전</a>
					</li>
				</c:if>	
				<!-- 페이징 -->
				<c:forEach var="i" begin="${paginationDto.startPage}" 
									end="${paginationDto.endPage }">
					<li class="page-item
					<c:if test="${paginationDto.pagingDto.page == i}">active</c:if>	
					">
						<a class="page-link a_pagination" href="#"
							data-page="${i}">${i}</a>
					</li>
				</c:forEach>
				<c:if test="${paginationDto.next == true }">
					<li class="page-item">
						<a class="page-link a_pagination"  href="#"
						data-page= "${paginationDto.endPage +1}">다음</a>
				</li>		
				</c:if>		
				</ul>
			</nav>
			</div>
			</div>
			</div>
		</div>
		</div>
	</div>
<%@ include file="../include/sidebar.jsp" %>
<%@ include file="../include/footer.jsp" %>