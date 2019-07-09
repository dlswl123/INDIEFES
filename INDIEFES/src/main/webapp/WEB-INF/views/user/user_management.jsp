<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>


	<script>
	$(document).ready(function() {
		function setPage() {
			var page = "${pagingDto.page}"
				if (page == "") {
					page = 1;
			}
			$("input[name=page]").val(page);
//	 		$("input[name=perPage]").val(perPage);
		}
		
		function setSearch() {
			var searchType = $("#searchType").val();
			var keyword = $("#keyword").val();
			console.log("searchType:" + searchType);
			console.log("keyword:" + keyword);
			$("input[name=searchType]").val(searchType);
			$("input[name=keyword]").val(keyword);
		}
		
		$("#btnSearch").click(function(){
			setPage();
			setSearch();
			$("input[name=page]").val(1); // 검색시 페이지1로가기
			$("#pageForm").submit();
		});
	});
	</script>
	
	



	
	<form id="pageForm" action="/indiefes/user/user-management">
	<!-- 	<input type="hidden" name="perPage"  -->
	<%-- 		value="${paginationDto.pagingDto.perPage}"> --%>
	<input type="hidden" name="page" 
			value="${paginationDto.pagingDto.page}">
	<input type="hidden" name="searchType" 
		value="${paginationDto.pagingDto.searchType}">
	<input type="hidden" name="keyword" 
		value="${paginationDto.pagingDto.keyword}">
	</form>
	
	<div class="row" style="margin-top:75px;margin-left:auto;margin-right:auto;background-color:rgba(255,255,255,0.7);">
		<div class="col-md-12">
			<table class="table">
				<thead>
					<tr>
						<th>
							아이디
						</th>
						<th>
							이름
						</th>
						<th>
							닉네임
						</th>
						<th>
							email
						</th>
						<th>
							성별
						</th>
						<th>
							유저등급
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="userInfoVo">
					<tr>
						<td>${userInfoVo.user_id}</td>
						<td>${userInfoVo.user_name}</td>
						<td>${userInfoVo.user_nick}</td>
						<td>${userInfoVo.user_email}</td>
						<td>
						<c:if test="${userInfoVo.user_gender eq 'M'}">
						남
						</c:if>
						
						<c:if test="${userInfoVo.user_gender eq 'F'}">
						여
						</c:if>
						
						
						</td>
						<td>
						<c:if test="${userInfoVo.user_level == 0}">
						관리자
						</c:if>
						
						<c:if test="${userInfoVo.user_level == 1}">
						스태프
						</c:if>
						
						<c:if test="${userInfoVo.user_level == 2}">
						인디팀
						</c:if>
						
						<c:if test="${userInfoVo.user_level == 3}">
						일반유저
						</c:if>
						
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
			
		</div>
		
		<div class="row" style="margin: auto;">
		<div class="col-md-12">
			<nav>
				<ul class="pagination">
					<li class="page-item">
						<c:if test="${paginationDto.prev == true }">
							<a class="page-link" 
							href="/indiefes/user/user-management?page=${paginationDto.startPage - 1}">
							Previous</a>
						</c:if>
						
					</li>
					<c:forEach var="i" begin="${paginationDto.startPage}" 
									end="${paginationDto.endPage }">
						<li class="page-item
							<c:if test="${paginationDto.pagingDto.page == i}">active</c:if>	
						">						
							<a class="page-link" 
							href="/indiefes/user/user-management?page=${i}">
							${i}</a>
						</li>			
					</c:forEach>
					
					
					<c:if test="${paginationDto.next == true }">
						<li class="page-item">
							<a class="page-link" 
							href="/indiefes/user/user-management?page=${paginationDto.endPage + 1}">
							Next</a>
						</li>
					</c:if>
					
				</ul>
			</nav>
		</div>
	</div>
	
	<div class="container-fluid">
	<div class="row">
<!-- 		<div class="col-md-12"> -->
<!-- 			<nav class="navbar navbar-expand-lg navbar-light bg-light"> -->
				 
				
<!-- 				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"> -->
					
						
					
				
					<form class="form-inline" style="margin: auto;">
						<select class="form-control" id="searchType">
							<option value="user_id">아이디</option>
							<option value="user_name">이름</option>
							<option value="user_email">email</option>
							<option value="user_nick">닉네임</option>
						</select>
						<input class="form-control mr-sm-2" type="text" id="keyword" value="${paginationDto.pagingDto.keyword}" /> 
						<input type="button" class="btn btn-primary my-2 my-sm-0" id="btnSearch" value="검색" />
						
					</form>
					
<!-- 				</div> -->
<!-- 			</nav> -->
<!-- 		</div> -->
	</div>
</div>
	
	</div>





<%@ include file="../include/footer.jsp" %>