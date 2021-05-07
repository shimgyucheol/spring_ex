<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title> JARDIN SHOP </title>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content="JARDIN SHOP" />
<meta name="keywords" content="JARDIN SHOP" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scaleable=no" />
<link rel="stylesheet" type="text/css" href="../css/reset.css?v=Y" />
<link rel="stylesheet" type="text/css" href="../css/layout.css?v=Y" />
<link rel="stylesheet" type="text/css" href="../css/content.css?v=Y" />
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="../js/top_navi.js"></script>
<script type="text/javascript" src="../js/left_navi.js"></script>
<script type="text/javascript" src="../js/main.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="../js/idangerous.swiper-2.1.min.js"></script>
<script type="text/javascript" src="../js/jquery.anchor.js"></script>
<!-- 날짜 변환하는 메소드 사용하게 해주는 스크립트 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>

<script type="text/javascript">
/* 댓글삭제 체크 */
function commentDelete(commentNo){
	alert("삭제버튼클릭");
	if(confirm("삭제하시겠습니까?")){
		
		$.ajax({
			url:"/event/commentDelete",
			type:"post",
			data:{
				"commentNo":commentNo
			},
			success:function(data){ //data.dto.id
				
				alert(data.msg);
					//해당 태그 삭제
				$('#'+commentNo).remove();
				
			},
			error:function(){
				alert("에러");
			}
			
		});
	}else{
		return false;
	}
	
}



/* 댓글수정 저장버튼클릭 */
function commentUpdate_check(commentNo){
	alert("수정 저장 버튼 클릭");
	alert(commentNo);
	var html="";
	
	$.ajax({
		url:"/event/commentUpdate_check",
		type:"post",
		data:{
			"commentNo":commentNo,"commentContent":$("#commentContentUpdate").val()
		},
		success:function(data){ //data.dto.id
			
			alert("data:"+data.dto.id);
			
			html +='<li class="name">'+data.dto.id+'<span>&nbsp;&nbsp;['+moment(data.dto.commentDate).format('YYYY-MM-DD HH:mm:ss')+']</span></li>';
			html +='<li class="txt">'+data.dto.commentContent+'</li>';
			html +='<li class="btn">';
			html +='<a href="#" class="rebtn"'; 
			/*  \' 는 글자로 인식하게 하라 '가 문자를 나누는 역할을 없애게함 
				\의 범위는 뒤에꺼 딱한개
			*/
			html +='onclick="commentUpdate('+data.dto.commentNo+',\''+data.dto.id+'\',\''+data.dto.commentDate+'\',\''+data.dto.commentContent+'\')">';
			/* html +='onclick="commentUpdate('+data.commentNo+','+data.id+','+data.commentDate+','+data.commentContent+')">'; */
			html +='수정</a>';
			html +='<a href="#" class="rebtn" onclick="commentDelete('+data.dto.commentNo+')">삭제</a>';
			html +='</li>';
			
			$('#'+commentNo).html(html);
			
		},
		error:function(){
			alert("에러");
		}
		
		
		
		
	});
	
	
}


/* 댓글수정 */
function commentUpdate(commentNo,id,commentDate,commentContent){
	alert("수정버튼클릭");
	alert("commentNo"+commentNo);
	alert("id"+id);
	var html="";
	
	html +='<li class="name">'+id+'<span>&nbsp;&nbsp;['+moment(commentDate).format('YYYY-MM-DD HH:mm:ss')+']</span></li>';
	html +='<li class="txt"><textarea class="replyType" id="commentContentUpdate" name="commentContentUpdate">'+commentContent+'</textarea></li>';
	html +='<li class="btn">';
	html +='<a href="#" class="rebtn" onclick="commentUpdate_check('+commentNo+')">저장</a>';
	html +='<a href="/event/event_view" class="rebtn">취소</a>';
	html +='</li>';
	/* #1은 <ul id="1"> 이므로 거기에 html(html)으로 넣게되면
	   ul에 있던 데이터는 다 날라가고 그 위에 덮어 쓰게됨
	*/
	$('#'+commentNo).html(html);
}


/* 댓글등록 */
function commentWrite(){
	alert("등록버튼클릭");
	
	var html="";
	var id = "${session_id}";
	
	$.ajax({
		url:"/event/commentWrite_check",
		type:"post",
		data:{
			"bid":217,"id":id,"commentPw":$("#commentPw").val(),"commentContent":$("#commentContent").val()
		},
		success:function(data){ //data.dto.id
			alert(data);
			
			
			/* alert("data:"+data.dto.id);
			
			html +='<ul id="'+data.dto.commentNo+'">';
			html +='<li class="name">'+data.dto.id+' <span>&nbsp;&nbsp;['+moment(data.dto.commentDate).format('YYYY-MM-DD HH:mm:ss')+']</span></li>';
			html +='<li class="txt">'+data.dto.commentContent+'</li>';
			html +='<li class="btn">';
			html +='<a href="#" class="rebtn"'; 
			
			html +='onclick="commentUpdate('+data.dto.commentNo+',\''+data.dto.id+'\',\''+data.dto.commentDate+'\',\''+data.dto.commentContent+'\')">';
			html +='수정</a>';
			html +='<a href="#" class="rebtn" onclick="commentDelete('+data.dto.commentNo+')">삭제</a>';
			html +='</li>';
			html +='</ul>';
			
			$('.replyBox').prepend(html);
			$('#commentPw').val('');
			$('#commentContent').val('');		
			 */
		},
		error:function(){
			alert("에러");
		}
		
		
		
		
	});
	
	
}
    
</script>

<div id="allwrap">
<div id="wrap">

	<div id="header">
		
		<div id="snbBox">
			<h1><img src="../images/txt/logo.gif" alt="JARDIN SHOP" /></h1>
			<div id="quickmenu">
				<div id="mnaviOpen"><img src="../images/btn/btn_mnavi.gif" width="33" height="31" alt="메뉴열기" /></div>
				<div id="mnaviClose"><img src="../images/btn/btn_mnavi_close.gif" width="44" height="43" alt="메뉴닫기" /></div>
				<ul>
					<li><a href="#">EVENT</a></li>
					<li><a href="#">CUSTOMER</a></li>
					<li><a href="#">COMMUNITY</a></li>
				</ul>
			</div>
			<div id="snb">
				<ul>
					<li><a href="#">LOGIN</a></li>
					<li><a href="#">JOIN</a></li>
					<li><a href="#">MY PAGE</a></li>
					<li><a href="#">CART</a></li>
				</ul>

				<div id="search">
					<input type="text" class="searchType" />
					<input type="image" src="../images/btn/btn_main_search.gif" width="23" height="20" alt="검색하기" />
				</div>
			</div>
		</div>
	</div>


	<!-- GNB -->
	<div id="gnb">
		
		<div id="top">
			<ul>
				<li class="brand t1"><a href="#" id="topNavi1">JARDIN’s BRAND</a>
					<ul id="topSubm1">
						<li><a href="#">클래스</a></li>
						<li><a href="#">홈스타일 카페모리</a></li>
						<li><a href="#">드립커피백</a></li>
						<li><a href="#">카페리얼 커피</a></li>
						<li><a href="#">오리지널커피백</a></li>
						<li><a href="#">카페리얼 음료</a></li>
						<li><a href="#">마일드커피백</a></li>
						<li><a href="#">워터커피</a></li>
						<li><a href="#">카페포드</a></li>
						<li><a href="#">모히또파티</a></li>
						<li><a href="#">테이크아웃 카페모리</a></li>
						<li><a href="#">포타제</a></li>
					</ul>
				</li>
				<li class="t2"><a href="#" id="topNavi2">원두</a>
					<ul id="topSubm2">
						<li><a href="#">클래스</a></li>
						<li><a href="#">로스터리샵</a></li>
						<li><a href="#">커피휘엘</a></li>
						<li><a href="#">산지별 생두</a></li>
					</ul>
				</li>
				<li class="t1"><a href="#" id="topNavi3">원두커피백</a>
					<ul id="topSubm3">
						<li><a href="#">드립커피 로스트</a></li>
						<li><a href="#">오리지널커피백</a></li>
						<li><a href="#">마일드커피백</a></li>
					</ul>
				</li>
				<li class="t2"><a href="#" id="topNavi4">인스턴트</a>
					<ul id="topSubm4">
						<li><a href="#">까페모리</a></li>
						<li><a href="#">홈스타일카페모리</a></li>
						<li><a href="#">포타제</a></li>
					</ul>
				</li>
				<li class="t1"><a href="#" id="topNavi5">음료</a>
					<ul id="topSubm5">
						<li><a href="#">까페리얼</a></li>
						<li><a href="#">워터커피</a></li>
						<li><a href="#">모히또</a></li>
					</ul>
				</li>
				<li class="t2"><a href="#" id="topNavi6">커피용품</a>
					<ul id="topSubm6">
						<li><a href="#">종이컵</a></li>
						<li><a href="#">커피필터</a></li>
						<li><a href="#">머신 등</a></li>
					</ul>
				</li>
				<li class="t1"><a href="#" id="topNavi7">선물세트</a></li>
				<li class="t2"><a href="#" id="topNavi8">대량구매</a></li>
			</ul>
		</div>

		<script type="text/javascript">initTopMenu();</script>
	</div>
	<!-- //GNB -->

	<!-- container -->
	<div id="container">

		<div id="location">
			<ol>
				<li><a href="#">HOME</a></li>
				<li><a href="#">EVENT</a></li>
				<li class="last">진행중 이벤트</li>
			</ol>
		</div>
		
		<div id="outbox">		
			<div id="left">
				<div id="title2">EVENT<span>이벤트</span></div>
				<ul>	
					<li><a href="#" id="leftNavi1">진행중 이벤트</a></li>
					<li><a href="#" id="leftNavi2">종료된 이벤트</a></li>
					<li class="last"><a href="#" id="leftNavi3">당첨자 발표</span></a></li>
				</ul>			
			</div><script type="text/javascript">initSubmenu(1,0);</script>


			<!-- contents -->
			<div id="contents">
				<div id="mypage">
					<h2><strong>진행중 이벤트</strong><span>쟈뎅샵의 특별한 혜택이 가득한 이벤트에 참여해 보세요.</span></h2>
					
					<div class="viewDivMt">
						<div class="viewHead">
							<div class="subject">
								<ul>
									<li>까페모리 봄바람 커피한잔 30% 할인 이벤트!!</li>
								</ul>
							</div>
							<div class="day">
								<p class="txt">이벤트 기간<span>2014-04-01 ~ 2014-04-29</span></p>
							</div>
						</div>

						<div class="viewContents">
							<img src="../images/img/sample_event_view.jpg" alt="" />
						</div>
					</div>


					<!-- 이전다음글 -->
					<div class="pnDiv web">
						<table summary="이전다음글을 선택하여 보실 수 있습니다." class="preNext" border="1" cellspacing="0">
							<caption>이전다음글</caption>
							<colgroup>
							<col width="100px" />
							<col width="*" />
							<col width="100px" />
							</colgroup>
							<tbody>
								<tr>
									<th class="pre">PREV</th>
									<td><a href="#">상품 재입고는 언제 되나요?</a></td>
									<td>&nbsp;</td>
								</tr>

								<tr>
									<th class="next">NEXT</th>
									<td>다음 글이 없습니다.</td>
									<td>&nbsp;</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- //이전다음글 -->




					<!-- 댓글-->
					<div class="replyWrite">
						<ul>
							<li class="in">
								<p class="txt">총 <span class="orange">${map.count }</span> 개의 댓글이 달려있습니다.</p>
								<p class="password">비밀번호&nbsp;&nbsp;<input type="password" class="replynum" id="commentPw" name="commentPw"/></p>
								<textarea class="replyType" name="commentContent" id="commentContent"></textarea>
							</li>
							<li class="btn"><a href="#" class="replyBtn" onclick="commentWrite()">등록</a></li>
						</ul>
						<p class="ntic">※ 비밀번호를 입력하시면 댓글이 비밀글로 등록 됩니다.</p>
					</div>





					<div class="replyBox">
						<!-- 댓글이 여기서부터 추가됨. -->
						
						<!-- <ul>
							<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
							<li class="txt"><textarea class="replyType"></textarea></li>
							<li class="btn">
								<a href="#" class="rebtn">저장</a>
								<a href="#" class="rebtn">취소</a>
							</li>
						</ul> -->
						<!-- 댓글이 여기에 추가 -->
						<c:forEach var="dto" items="${map.list }">
							<ul id="${dto.commentNo }">
								<li class="name">${dto.id} <span>&nbsp;&nbsp;[${dto.commentDate }]</span></li>
								<li class="txt">${dto.commentContent } </li>
								<li class="btn">
								    
								    <!-- if -->
								    <c:if test="${session_id eq dto.id}">
										<a href="#" class="rebtn" onclick="commentUpdate(${dto.commentNo},'${dto.id}','${dto.commentDate }','${dto.commentContent }')">수정</a>
										<a href="#" class="rebtn" onclick="commentDelete(${dto.commentNo})">삭제</a>
								    </c:if>
								
							</ul>
						</c:forEach>
						
						
						<ul>
							<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
							<li class="txt">대박!!! 이거 저한테 완전 필요한 이벤트였어요!!</li>
							<li class="btn">
								<a href="#" class="rebtn">수정</a>
								<a href="#" class="rebtn">삭제</a>
							</li>
						</ul>

						<ul>
							<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
							<li class="txt">
								<a href="password.html" class="passwordBtn"><span class="orange">※ 비밀글입니다.</span></a>
							</li>
						</ul>
					</div>
					<!-- //댓글 -->


					<!-- Btn Area -->
					<div class="btnArea">
						<div class="bRight">
							<ul>
								<li><a href="#" class="sbtnMini mw">목록</a></li>
							</ul>
						</div>
					</div>
					<!-- //Btn Area -->
					
				</div>
			</div>
			<!-- //contents -->


<script type="text/javascript" src="../js/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="../css/jquery.fancybox-1.3.4.css" />
<script type="text/javascript">
$(function(){
	
	var winWidth = $(window).width();
	if(winWidth > 767){
		var layerCheck = 540;
	}else{
		var layerCheck = 320;
	}

	$(".passwordBtn").fancybox({
		'autoDimensions'    : false,
		'showCloseButton'	: false,
		'width' : layerCheck,
		'padding' : 0,
		'type'			: 'iframe',
		'onComplete' : function() {
			$('#fancybox-frame').load(function() { // wait for frame to load and then gets it's height
			$('#fancybox-content').height($(this).contents().find('body').height());
			});
		}
	});


});
</script>

		</div>
	</div>
	<!-- //container -->




	<div id="footerWrap">
		<div id="footer">
			<div id="fnb">
				<ul>
					<li class="left"><a href="#">개인정보취급방침</a></li>
					<li><a href="#">이용약관</a></li>
					<li class="left"><a href="#">이메일무단수집거부</a></li>
					<li><a href="#">고객센터</a></li>
					<li class="left brand"><a href="#">쟈뎅 브랜드 사이트</a></li>
				</ul>
			</div>
			
			<div id="finfo">
				<div id="flogo"><img src="../images/txt/flogo.gif" alt="JARDIN THE COFFEE CREATOR, SINCE 1984" /></div>
				<address>
					<ul>
						<li>㈜쟈뎅</li>
						<li>대표자 윤영노</li>
						<li class="tnone">주소 서울시 강남구 논현동 4-21번지 영 빌딩</li>
						<li class="webnone">소비자상담실 02)546-3881</li>
						<li>사업자등록번호 211-81-24727</li>
						<li class="tnone">통신판매신고 제 강남 – 1160호</li>
						<li class="copy">COPYRIGHT © 2014 JARDIN <span>ALL RIGHTS RESERVED.</span></li>
					</ul>
				</address>

				<div id="inicis"><img src="../images/ico/ico_inicis.png" alt="이니시스 결제시스템" /></div>
			</div>
		</div>
	</div>



</div>
</div>
</body>
</html>