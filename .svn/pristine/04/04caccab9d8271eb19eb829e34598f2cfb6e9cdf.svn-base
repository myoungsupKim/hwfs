<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * SAP 전표 전송
   * - jstl tag를 이용 (표준)
   * @ClassName SapSlipSendRept.jsp
   * @Description SapSlipSendRept.jsp
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.06.19.   JUN          최초생성
   *
   * @author FC종합전산구축 : 통합영업
   * @since 2015.06.19.
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
    long cAmt = 0;
    long dAmt = 0;
    
%>

<!-- fn:replace 의 \n <br> 변환하기위한 세팅 -->
<jsp:scriptlet>
pageContext.setAttribute("newline", "\n");
</jsp:scriptlet>


<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <DIV class=clear></DIV>
        <DIV style="TEXT-ALIGN: center;">
            <H3 style="TEXT-ALIGN: left;">● 아래와 같이 대체전표 승인 요청합니다.</H3>
        </DIV>
        <BR>
        <DIV class=clear></DIV>
        <DIV style="TEXT-ALIGN: left;">
            <H3>● 전표 내역</H3>
        </DIV>

        <DIV class=clear></DIV>
        <DIV class="acc_table_basic style1 list">
            <TABLE border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 13%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 22%">
                </COLGROUP>
                <TBODY>
                    <TR>
                    	<TH style="TEXT-ALIGN: center;" rowspan="2">전표번호</TH>
                        <TH style="TEXT-ALIGN: center;" colspan="2">계정과목</TH>
                        <TH style="TEXT-ALIGN: center;" >전표일자</TH>
                        <TH style="TEXT-ALIGN: center;" >증빙일자</TH>
                        <TH style="TEXT-ALIGN: center;" >지불예정일</TH>
                        <TH style="TEXT-ALIGN: center;" >귀속부서</TH>
                        <TH style="TEXT-ALIGN: center;" rowspan="2">적요</TH>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">차변</TH>
                        <TH style="TEXT-ALIGN: center;">대변</TH>
                        <TH style="TEXT-ALIGN: center;">금액</TH>
                        <TH style="TEXT-ALIGN: center;">공급가</TH>
                        <TH style="TEXT-ALIGN: center;">부가세</TH>
                        <TH style="TEXT-ALIGN: center;">거래처명</TH>
                    </TR>
                    <c:forEach var="record" items="${gwDraftList}" varStatus="status">
                    <c:set var="camt" value="${camt + record.cSlipAmt}"/>
                    <c:set var="damt" value="${damt + record.dSlipAmt}"/>
                    <TR>
                        <TD style="TEXT-ALIGN: center" class=rbnone rowspan="2"><c:out value="${record.slipNum}"/></TD><!-- 전표번호 -->
                        <TD style="TEXT-ALIGN: center" class=rbnone rowspan="2"><c:if test="${record.drCrClass == '1'}"><c:out value="${record.acctNm}"/></c:if></TD><!-- 차변 -->
                        <TD style="TEXT-ALIGN: center" class=rbnone rowspan="2"><c:if test="${record.drCrClass == '2'}"><c:out value="${record.acctNm}"/></c:if></TD><!-- 대변 -->
                        <TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.slipDate}"/></TD><!-- 전표일자 -->
                        <TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.slipEvidenceDate}"/></TD><!-- 증빙일자 -->
                        <TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.expireCalBasisDate}" /></TD><!-- 지불예정일 -->
                        <TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.ccNm}" /></TD><!-- 팀명 -->
                        <TD style="TEXT-ALIGN: left" class=rbnone rowspan="2"><c:out value="${record.remark}"/></TD><!-- 적요 -->
                    </TR>
                    <TR>          
                        <TD style="TEXT-ALIGN: right" class=rbnone><c:if test="${record.drCrClass == '1'}"><fmt:formatNumber value="${record.dSlipAmt}" type="number"/></c:if>
                        											<c:if test="${record.drCrClass == '2'}"><fmt:formatNumber value="${record.cSlipAmt}" type="number"/></c:if>
                        </TD><!-- 금액 -->
                        <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.lcalAmt}" type="number"/></TD><!-- 공급가 -->
                        <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.taxAmt}" type="number"/></TD><!-- 부가세 -->
                        <TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.supplyplceNm}"/></TD><!-- 거래처명 -->
                    </TR>
                    </c:forEach>
                </TBODY>
            </TABLE>
            </DIV>
            <DIV class="acc_table_basic style1 list">
            <TABLE border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 20%">
                	<COL style="WIDTH: 40%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY>
                    <TR>
                    	<TH style="TEXT-ALIGN: center;" rowspan="2">합계</TH>
                        <TH style="TEXT-ALIGN: center;">차변 합계</TH>
                        <TH style="TEXT-ALIGN: center;">대변 합계</TH>
                    </TR>
                    <TR>          
                        <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${damt}" type="number"/></TD><!-- 공급가 -->
                        <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${camt}" type="number"/></TD><!-- 부가세 -->
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>
