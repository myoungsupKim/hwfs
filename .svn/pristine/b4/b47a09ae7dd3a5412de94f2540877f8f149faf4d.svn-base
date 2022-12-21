<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 시스템 권한변경 요청 그룹웨어 연동을 위해 본문을 생성하는 JSP
   * 김재섭 요청으로 김민수 개발
   * - jstl tag를 이용 (표준)
   * @ClassName UserRoleChngReqGwDraft.jsp
   * @Description UserRoleChngReqGwDraft JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.06.30.   김재섭        최초 생성
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.06.30.
   * @version 1.0
   * @see
   * <pre>
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   * </pre>
   */
%>
<%@ page import= "java.io.*
                , java.util.*
                , org.springframework.web.context.*
                , org.springframework.web.context.support.WebApplicationContextUtils
                , com.hwfs.cmn.service.PropertiesService"%>
<%
    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");
%>

<!-- fn:replace 의 \n <br> 변환하기위한 세팅 -->
<jsp:scriptlet>
pageContext.setAttribute("newline", "\n");
</jsp:scriptlet>


<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <!-- 본문 제목 표시 -->
        <DIV style="TEXT-ALIGN: center;">
            <H2>처리협조</H2>
        </DIV>
        <DIV class="acc_table_basic style1">
        
        <c:forEach var="record" items="${gwDraftList}" varStatus="status">
        
        	<TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 20%;"/>
                    <COL style="WIDTH: 80%"/>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="text-align:center;">제&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;목</TH>
                        <TD><c:out value="${record.title}"/></TD>
                    </TR>
                    <TR>
                        <TH style="text-align:center;">기&nbsp;안&nbsp;자</TH>
                        <TD><c:out value="${record.senderNm}"/></TD>
                    </TR>
                    <TR>
                        <TH style="text-align:center;">수&nbsp;신&nbsp;처</TH>
                        <TD>수신처 별도</TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <br>
        <DIV>
        계약 <c:out value="${record.contractStatsNm}"/>을 아래와 같이 요청드리오니 처리하여 주시기 바랍니다.<br>
        </DIV>
        <br>
        <DIV style="TEXT-ALIGN:center;">
        -&nbsp;&nbsp;아&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;래&nbsp;&nbsp;-
        </DIV>
        <br>
        <DIV class=clear></DIV>
		
		    <div class="hgtSplit10"></div>

            <h3><div class="title">계약사항</span></div></h3>
            <div class="acc_table_basic style1 list">
            <table border="0" cellspacing="0" style="table-layout: fixed">
                <colgroup>
                    <col style="width:10%;" />
                    <col style="width:20%" />
                    <col style="width:10%" />
                    <col style="width:20%;" />
                    <col style="width:10%;" />
                    <col style="width:20%;" />
                </colgroup>
                <tr>
                    <th>계약번호</th><%-- 계약번호 --%>
                    <td><c:out value="${record.contractCd}" /></td>
                    <th id="thBldat" class="lbnone">계약명</th><%-- 계약명 --%>
                    <td id="tdBldat"><c:out value="${record.contractName}" /></td>
                </tr>
                <tr>                    
                    <th id="thBldat">계약구분</th><%-- 계약구분 --%>
                    <td id="tdBldat"><c:out value="${record.contractGbNm}" /></td>
                    <th id="thBldat" class="lbnone">거래처</th><%-- 거래처 --%>
                    <td id="tdBldat"><c:out value="${record.custNm}" /></td>
                </tr>
                <tr>      
                    <th id="thBldat">임차자산특정</th><%-- 임차자산특정 --%>
                    <td id="tdBldat"><c:out value="${record.lentAssetYn}" /></td>
                    <th id="thBldat" class="lbnone">사용수익권</th><%-- 사용수익권 --%>
                    <td id="tdBldat"><c:out value="${record.usufructYn}" /></td>
                </tr>
                <tr>
                    <th id="thBldat">사용지시권</th><%-- 사용지시권 --%>
                    <td id="tdBldat"><c:out value="${record.orderYn}" /></td>
                    <th id="thBldat" class="lbnone">소액자산여부</th><%-- 소액자산여부 --%>
                    <td id="tdBldat"><c:out value="${record.smallAssetYn}" /></td>
                </tr>
                <tr>
                    <th id="thBldat" >기준부서</th><%-- 기준부서 --%>
                    <td id="tdBldat"><c:out value="${record.ccNm}" /></td>
                    <th id="thBldat" class="lbnone">계약기간-기본</th><%-- 계약기간-기본 --%>
                    <td id="tdBldat"><c:out value="${record.startDate}" /> ~ <c:out value="${record.endDate}" /> ( <c:out value="${record.contractPeriod}" /> 개월)</td>
                </tr>
                <tr>    
                    <th id="thBldat" >담보가치</th><%-- 담보가치 --%>
                    <td id="tdBldat"><c:out value="${record.callVal}" /></td>
                    <th id="thBldat" class="lbnone">적용할인,이자율</th><%-- 할인율 --%>
                    <td id="tdBldat"><c:out value="${record.disRate}" /> %, <c:out value="${record.avgRate}" /> %</td>
                </tr>
                <tr>
                    <th id="thBldat">계약기간-판단</th><%-- 계약기간-판단 --%>
                    <td id="tdBldat"><c:out value="${record.rghtUseNm}" /></td>
                    <th id="thBldat" class="lbnone"></th><%--  --%>
                    <td id="tdBldat"></td>
                </tr>
                <tr>
                    <th id="thBldat">기간</th><%-- 기간 --%>
                    <td id="tdBldat" colspan = 3>해지불능기간 : (<c:out value="${record.ncPeriod}" />개월) + 선택권기간 : (<c:out value="${record.roPeriod}" />개월) = 리스기간 : (<c:out value="${record.lsPeriod}" />개월)</td>
                </tr>
                <tr>
                    <th id="thBldat">리스방법</th><%-- 리스방법 --%>
                    <td id="tdBldat"><c:out value="${record.leaseGbNm}" /></td>
                    <th id="thBldat" class="lbnone">월리스료</th><%-- 리스료 --%>
                    <td id="tdBldat"><c:out value="${record.leaseAmt}" /> 원</td>
                </tr>                
                <tr>
                    <th id="thBldat">리스방법2</th><%-- 리스방법 --%>
                    <td id="tdBldat"><c:out value="${record.leaseGb2Nm}" /></td>
                	<th id="thBldat" class="lbnone">월리스료2</th><%-- 리스료 --%>
                    <td id="tdBldat"><c:out value="${record.leaseAmt2}" /> 원</td>
                 </tr>                
                <tr>    
                    <th id="thBldat">보증금금액</th><%-- 보증금액 --%>
                    <td id="tdBldat"><c:out value="${record.dtAmt}" /> 원</td>
                    <th id="thBldat" class="lbnone">보증금현할차</th><%-- 현할차 --%>
                    <td id="tdBldat"><c:out value="${record.dtRealAmt}" /> 원</td>
                </tr>    
                <tr>
                    <th id="thBldat" >예상인수금액</th><%-- 예상인수액 --%>
                    <td id="tdBldat"><c:out value="${record.epToAmt}" /> 원</td>
                    <th id="thBldat" class="lbnone">복구의무추정액</th><%-- 복구의무추정액 --%>
                    <td id="tdBldat"><c:out value="${record.recovExpAmt}" /> 원</td>
                </tr>
                <tr>
                    <th id="thBldat">복구충당부채</th><%-- 복구충당부채 --%>
                    <td id="tdBldat"><c:out value="${record.recovDebAmt}" /> 원</td>
                    <th id="thBldat" class="lbnone">사용권자산계산</th><%-- 사용권자산계산 --%>
                    <td id="tdBldat"><c:out value="${record.useRghtAssetAmt}" /> 원</td>
                </tr>
                <tr>    
                    <th id="thBldat" >리스부채계산</th><%-- 리스부채계산 --%>
                    <td id="tdBldat"><c:out value="${record.leaseDebAmt}" /> 원</td>
                    <th id="thBldat" class="lbnone">리스부채 현할차</th><%-- 리스부채현할차 --%>
                    <td id="tdBldat"><c:out value="${record.leaseDebRealBal}" /> 원</td>
                </tr>
                <tr>
                	<th id="thBldat">종료여부</th><%-- 사용권자산계산 --%>
                    <td id="tdBldat"><c:out value="${record.endYn}" /> </td>
                    <th id="thBldat" class="lbnone"></th><%--  --%>
                    <td id="tdBldat"></td>
                </tr>
            </table>
            </div>
       
        </c:forEach>

        <DIV class=clear></DIV>
        <DIV class=clear></DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>
