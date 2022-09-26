<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script src="http://code.jquery.com/jquery.js"></script>
    <script>

        // 출처 : http://tonks.tistory.com/79
        // 에러가 나온다면, 여기에 댓글을 남겨주세요.


        /* sortingNumber() : 숫자인 실수만으로 되어있을 때, 적용될 함수 */

        function sortingNumber( a , b ){

            if ( typeof a == "number" && typeof b == "number" ) return a - b;

            // 천단위 쉼표와 공백문자만 삭제하기.
            var a = ( a + "" ).replace( /[,\s\xA0]+/g , "" );
            var b = ( b + "" ).replace( /[,\s\xA0]+/g , "" );

            var numA = parseFloat( a ) + "";
            var numB = parseFloat( b ) + "";

            if ( numA == "NaN" || numB == "NaN" || a != numA || b != numB ) return false;

            return parseFloat( a ) - parseFloat( b );
        }


        /* changeForSorting() : 문자열 바꾸기. */

        function changeForSorting( first , second ){

            // 문자열의 복사본 만들기.
            var a = first.toString().replace( /[\s\xA0]+/g , " " );
            var b = second.toString().replace( /[\s\xA0]+/g , " " );

            var change = { first : a, second : b };

            if ( a.search( /\d/ ) < 0 || b.search( /\d/ ) < 0 || a.length == 0 || b.length == 0 ) return change;

            var regExp = /(\d),(\d)/g; // 천단위 쉼표를 찾기 위한 정규식.

            a = a.replace( regExp , "$1" + "$2" );
            b = b.replace( regExp , "$1" + "$2" );

            var unit = 0;
            var aNb = a + " " + b;
            var numbers = aNb.match( /\d+/g ); // 문자열에 들어있는 숫자 찾기

            for ( var x = 0; x < numbers.length; x++ ){

                var length = numbers[ x ].length;
                if ( unit < length ) unit = length;
            }

            var addZero = function( string ){ // 숫자들의 단위 맞추기

                var match = string.match( /^0+/ );

                if ( string.length == unit ) return ( match == null ) ? string : match + string;

                var zero = "0";

                for ( var x = string.length; x < unit; x++ ) string = zero + string;

                return ( match == null ) ? string : match + string;
            };

            change.first = a.replace( /\d+/g, addZero );
            change.second = b.replace( /\d+/g, addZero );

            return change;
        }


        /* byLocale() */

        function byLocale(){

            var compare = function( a , b ){

                var sorting = sortingNumber( a , b );

                if ( typeof sorting == "number" ) return sorting;

                var change = changeForSorting( a , b );

                var a = change.first;
                var b = change.second;

                return a.localeCompare( b );
            };

            var ascendingOrder = function( a , b ){  return compare( a , b );  };
            var descendingOrder = function( a , b ){  return compare( b , a );  };

            return { ascending : ascendingOrder, descending : descendingOrder };
        }


        /* replacement() */

        function replacement( parent ){
            var tagName = parent.tagName.toLowerCase();
            if ( tagName == "table" ) parent = parent.tBodies[ 0 ];
            tagName = parent.tagName.toLowerCase();
            if ( tagName == "tbody" ) var children = parent.rows;
            else var children = parent.getElementsByTagName( "li" );

            var replace = {
                order : byLocale(),
                index : false,
                array : function(){
                    var array = [ ];
                    for ( var x = 0; x < children.length; x++ ) array[ x ] = children[ x ];
                    return array;
                }(),
                checkIndex : function( index ){
                    if ( index ) this.index = parseInt( index, 10 );
                    var tagName = parent.tagName.toLowerCase();
                    if ( tagName == "tbody" && ! index ) this.index = 0;
                },
                getText : function( child ){
                    if ( this.index ) child = child.cells[ this.index ];
                    return getTextByClone( child );
                },
                setChildren : function(){
                    var array = this.array;
                    while ( parent.hasChildNodes() ) parent.removeChild( parent.firstChild );
                    for ( var x = 0; x < array.length; x++ ) parent.appendChild( array[ x ] );
                },
                ascending : function( index ){ // 오름차순
                    this.checkIndex( index );
                    var _self = this;
                    var order = this.order;
                    var ascending = function( a, b ){
                        var a = _self.getText( a );
                        var b = _self.getText( b );
                        return order.ascending( a, b );
                    };
                    this.array.sort( ascending );
                    this.setChildren();
                },
                descending : function( index ){ // 내림차순
                    this.checkIndex( index );
                    var _self = this;
                    var order = this.order;
                    var descending = function( a, b ){
                        var a = _self.getText( a );
                        var b = _self.getText( b );
                        return order.descending( a, b );
                    };
                    this.array.sort( descending );
                    this.setChildren();
                }
            };
            return replace;
        }

        function getTextByClone( tag ){
            var clone = tag.cloneNode( true ); // 태그의 복사본 만들기.
            var br = clone.getElementsByTagName( "br" );
            while ( br[0] ){
                var blank = document.createTextNode( " " );
                clone.insertBefore( blank , br[0] );
                clone.removeChild( br[0] );
            }
            var isBlock = function( tag ){
                var display = "";
                if ( window.getComputedStyle ) display = window.getComputedStyle ( tag, "" )[ "display" ];
                else display = tag.currentStyle[ "display" ];
                return ( display == "block" ) ? true : false;
            };
            var children = clone.getElementsByTagName( "*" );
            for ( var x = 0; x < children.length; x++){
                var child = children[ x ];
                if ( ! ("value" in child) && isBlock(child) ) child.innerHTML = child.innerHTML + " ";
            }
            var textContent = ( "textContent" in clone ) ? clone.textContent : clone.innerText;
            return textContent;
        }
    </script>
    <style>
    
    @font-face {
	    font-family: 'tway_air';
	    src: url('/tway_air.ttf') format('truetype');
	}
	
	body  {
	    padding-top: 160px;
	    padding-bottom: 120px;
	}
	
	#all {
		margin-left: 220px;
		font-family: 'tway_air';
	}
	
	#myList {
		text-align: center;
	}

    </style>
</head>
<body style="background-color: #E6E6FA;">
<div style="float: top">
    <c:import url="/admin/adminTop"></c:import>
</div>
<div style="float: left">
    <c:import url="/admin/adminPageView"></c:import>
</div>
<section id="all">
    <h3>회원관리</h3><br>
<div>
    <form action="/admin/memberManagement">
        <select id="searchType" name="searchType" class="nav-link dropdown-toggle" style="float:left;" >
            <option id="sName" value="sName" selected>이름</option>
            <option id="sId" value="sId" >아이디</option>
            <option id="sNum" value="sNum">회원번호</option>
        </select>
        <input class="form-control mr-sm-2" type="text" id="searchWord" name="searchWord" style="width: 200px; float:left;" >
        <button class="btn btn-outline-secondary my-2 my-sm-0" type="submit" style="float:left;" >검색</button>&nbsp;
        <button class="btn btn-outline-secondary my-2 my-sm-0" onclick="javascript:window.location='/admin/memberManagement'">검색초기화</button>
    </form>
    <p>
        검색결과 : <span style="color: red">${page.totalCount}</span>명,
        총 회원수 : <span style="color: red">${allMemberCount}</span>명
    </p>
    <table id="myList" border="1">
        <thead>
            <tr>
                <td><button class="btn btn-outline-secondary my-2 my-sm-0" onclick="sortTD(0)" style="outline: none; border: none;">▲</button>번호<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="reverseTD(0)" style="outline: none; border: none;">▼</button></td>
                <td><button class="btn btn-outline-secondary my-2 my-sm-0" onclick="sortTD(1)" style="outline: none; border: none;">▲</button>이름<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="reverseTD(1)" style="outline: none; border: none;">▼</button></td>
                <td><button class="btn btn-outline-secondary my-2 my-sm-0" onclick="sortTD(2)" style="outline: none; border: none;">▲</button>아이디<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="reverseTD(2)" style="outline: none; border: none;">▼</button></td>
                <td><button class="btn btn-outline-secondary my-2 my-sm-0" onclick="sortTD(3)" style="outline: none; border: none;">▲</button>가입일<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="reverseTD(3)" style="outline: none; border: none;">▼</button></td>
                <td><button class="btn btn-outline-secondary my-2 my-sm-0" onclick="sortTD(4)" style="outline: none; border: none;">▲</button>주문수<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="reverseTD(4)" style="outline: none; border: none;">▼</button></td>
                <td><button class="btn btn-outline-secondary my-2 my-sm-0" onclick="sortTD(5)" style="outline: none; border: none;">▲</button>주문총액<button class="btn btn-outline-secondary my-2 my-sm-0" onclick="reverseTD(5)" style="outline: none; border: none;">▼</button></td>
                <td>&nbsp;CRM&nbsp;</td>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="dto">
                <tr>
                    <td>${dto.bcm_num}</td>
                    <td>${dto.bcm_name}</td>
                    <c:choose>
                        <c:when test="${dto.bcm_id != null}">
                            <td>${dto.bcm_id}</td>
                        </c:when>
                        <c:otherwise>
                            <td>sns이용자(아이디 없음)</td>
                        </c:otherwise>
                    </c:choose>
                    <td><fmt:formatDate value="${dto.bcm_joined_on}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>${dto.order_count}</td>
                    <td id="price${dto.bcm_num}">${dto.total_price}</td>
                    <td><button class="btn btn-outline-secondary my-2 my-sm-0" onclick="crm${dto.bcm_num}()">보기</button></td>
                </tr>
                <div id="popupDiv${dto.bcm_num}" style="background-color:#c4c4ff ; display: none; position: absolute; top: 100px;left: 300px;z-index: 999999; padding-left: 20px; padding-top: 30px;">
                    <div style="width: 500px;height: 600px; background-color: #c4c4ff ;color: white; margin: auto;">
                        <h2>회원 기본정보</h2>
                        회원 번호 : ${dto.bcm_num} <br>
                        이름 : ${dto.bcm_name} <br>
                        아이디 : ${dto.bcm_id} <br>
                        구글 id : ${dto.bcm_googleid} <br>
                        페이스북 id : ${dto.bcm_facebookid} <br>
                        네이버 id : ${dto.bcm_naverid} <br>
                        카카오 id : ${dto.bcm_kakaoid} <br>
                        우편번호 : ${dto.bcm_zipcode} <br>
                        주소 : ${dto.bcm_address1} &nbsp;&nbsp; ${dto.bcm_address3} &nbsp;&nbsp; ${dto.bcm_address2} <br>
                        휴대폰 : ${dto.bcm_phonenum1} &nbsp;-&nbsp; ${dto.bcm_phonenum2} &nbsp;-&nbsp; ${dto.bcm_phonenum3} <br>
                        권한 : ${dto.bcm_authority} <button class="btn btn-outline-secondary my-2 my-sm-0" onclick="upgradeAdmin${dto.bcm_num}()">관리자로 승격</button><br>
						<br>
                        <h2>회원 기본정보</h2>
                        가입일 : ${dto.bcm_joined_on} <br>
                        주문횟수 : ${dto.order_count} <br>
                        주문총액 : ${dto.total_price} <br>

                    </div>
                    <div style="background: #c4c4ff;height:20px;">
                        <a href="javascript:clkBtn${dto.bcm_num}()" style="position:absolute;right:5px;color:white;">[닫기]</a>
                    </div>
                </div>
                <script>
                    function crm${dto.bcm_num}(){
                        $("#popupDiv${dto.bcm_num}").css({ 'display' : 'block' });
                    }
                    function clkBtn${dto.bcm_num}(){
                        $("#popupDiv${dto.bcm_num}").css({ 'display' : 'none' });
                    }
                </script>
                <script>
                    var queryString = 'bcm_num='+'${dto.bcm_num}';
                    function upgradeAdmin${dto.bcm_num}() {
                        $.ajax({
                            url : '/admin/upgradeAdmin',
                            type : 'POST',
                            data : queryString,
                            dataType: 'json',
                            success : function(json) {
                                if (json.desc == 1){
                                    alert("승격성공")
                                    window.location.reload();
                                }else {
                                    alert("승격실패")
                                }
                            }
                        });
                    }
                </script>
                <script>
                    var money = $('#price${dto.bcm_num}').text();
                    var money2 = money.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                    $('#price${dto.bcm_num}').text(money2+"원");
                </script>
            </c:forEach>
        </tbody>
            <tr>
                <td colspan="7">
                    <!--처음-->
                    <c:choose>
                        <c:when test="${(page.curPage-1)<1}">
                            &lt;&lt;
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${page.searchType == null}">
                                    <a href="/admin/memberManagement?page=1"> &lt;&lt; </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/admin/memberManagement?page=1&searchType=${page.searchType}&searchWord=${page.searchWord}"> &lt;&lt; </a>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>

                    <!--이전-->
                    <c:choose>
                        <c:when test="${(page.curPage-1) < 1}">
                             &lt; 
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${page.searchType == null}">
                                    <a href="/admin/memberManagement?page=${page.curPage-1}">&lt;</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/admin/memberManagement?page=${page.curPage-1}&searchType=${page.searchType}&searchWord=${page.searchWord}">&lt;</a>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>

                    <!--개별 페이지-->
                    <c:forEach var="fEach" begin="${page.startPage}" end="${page.endPage}" step="1">
                        <c:choose>
                            <c:when test="${page.curPage == fEach}">
                                ${fEach} &nbsp;
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${page.searchType == null}">
                                        <a href="/admin/memberManagement?page=${fEach}">${fEach}</a>&nbsp;
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/admin/memberManagement?page=${fEach}&searchType=${page.searchType}&searchWord=${page.searchWord}">${fEach}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!--다음-->
                    <c:choose>
                        <c:when test="${(page.curPage +1) > page.totalPage}">
                            &gt;
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${page.searchType == null}">
                                    <a href="/admin/memberManagement?page=${page.curPage+1}">&gt;</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/admin/memberManagement?page=${page.curPage+1}&searchType=${page.searchType}&searchWord=${page.searchWord}">&gt;</a>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>

                    <!--끝-->
                    <c:choose>
                        <c:when test="${page.curPage == page.totalPage}">
                            &gt;&gt;
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${page.searchType == null}">
                                    <a href="/admin/memberManagement?page=${page.totalPage}">&gt;&gt;</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/admin/memberManagement?page=${page.totalPage}&searchType=${page.searchType}&searchWord=${page.searchWord}">&gt;&gt;</a>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
    </table>
    <script type="text/javascript">
        var myTable = document.getElementById( "myList" );
        var replace = replacement( myTable );
        function sortTD( index ){    replace.ascending( index );    }
        function reverseTD( index ){    replace.descending( index );    }
    </script>
</div>
</section>
</body>
</html>
