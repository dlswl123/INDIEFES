<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>

<style>
#logo font {
	font-family: blox;
	font-size: 3.5rem;
	margin-left: 30px;
}
#dgm {
	font-family: dgm;
	font-size: 2rem;
	margin-left: 20px;
}
#logo {
/* 	background-color:rgba(255,255,255,0.7); */
}
#art1sec, #art2sec {
	background-color:rgba(255,255,255,0.7);padding-bottom:20px;
}
/* 탭 */
ul.tabs {
    margin: 0;
    padding: 0;
    float: left;
    list-style: none;
    height: 32px;
    border-bottom: 1px solid #eee;
    border-left: 1px solid #eee;
    width: 100%;
    font-family:"dotum";
    font-size:12px;
}
ul.tabs li {
    float: left;
    text-align:center;
    cursor: pointer;
    width:82px;
    height: 31px;
    line-height: 31px;
    border: 1px solid #eee;
    border-left: none;
    font-weight: bold;
    background: #fafafa;
    overflow: hidden;
    position: relative;
}
ul.tabs li.active {
    background: #FFFFFF;
    border-bottom: 1px solid #FFFFFF;
}
.tab_container {
    border: 1px solid #eee;
    border-top: none;
    clear: both;
    width: 100%;
    background: #FFFFFF;
}
.tab_content {
    padding: 5px;
    display: none;
}
.tab_container .tab_content ul {
    width:100%;
    margin:0px;
    padding:0px;
}
.tab_container .tab_content ul li {
    padding:5px;
    list-style:none;
}
 #container {
    width: auto;
    margin: 0 auto;
}
</style>

		<script>
			$(document).ready(function() {
			
			var message = "${message}";
			if (message == "success") {
				alert("회원정보가 수정되었습니다 재로그인 해주십시오");
			}
			else if(message == "delete-success"){
				alert("회원탈퇴가 완료되었습니다");
			}
			$(function () {

			    $(".tab_content").hide();
			    $(".tab_content:first").show();

			    $("ul.tabs li").click(function () {
			        $("ul.tabs li").removeClass("active").css("color", "#333");
			        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
			        $(this).addClass("active").css("color", "darkred");
			        $(".tab_content").hide()
			        var activeTab = $(this).attr("rel");
			        $("#" + activeTab).fadeIn()
			    });
			});
		});
			
		</script>
<div class="col-md-10" style="margin:auto;padding:50px;" id="container">
	<section id="logo">
		<div class="row">
			<font>InDiEFeS</font>
			<span style="font-size:1.25rem;font-family:hss;margin-bottom: 15px;margin-top: auto;margin-left: 10px;margin-right: auto;">
			매일매일 인디축제</span>
		</div>
    </section>
				
    <ul class="tabs">
        <li class="active" rel="tab1">최신앨범</li>
        <li rel="tab2">인기앨범</li>
    </ul>
    
	<div class="tab_container">
        <div id="tab1" class="tab_content">
			<section id="art1sec">
				<font id="dgm">
					최신 앨범
				</font>
				<article class="art1">
				<%@ include file="include/home_today_list.jsp" %>
				</article>
			</section>
        </div>
        
  		<div id="tab2" class="tab_content">
        	<section id="art2sec">
				<font id="dgm">
					인기 앨범
				</font>
				<article class="art2">
				<%@ include file="include/home_good_list.jsp" %>
				</article>
			</section>
        </div>
    </div>
</div> <!-- col-md-10 / main -->
		
<%@ include file="include/sidebar.jsp" %>

<%@ include file="include/footer.jsp" %>
