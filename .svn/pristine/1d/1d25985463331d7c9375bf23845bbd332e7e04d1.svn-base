<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 그룹웨어 연동을 위해 본문을 생성하는 Template JSP
   * - jstl tag를 이용 (표준)
   * @ClassName salsNonOccurReasonRept.jsp
   * @Description salsNonOccurReasonRept.jsp
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.05.11.   김예진      최초생성
   *
   * @author FC종합전산구축 : 통합영업 김예진
   * @since 2015.05.11.
   * @version 1.0
   * @see
   * <pre>
   *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
   * </pre>
   */
%>
<%@ page import="java.io.*
	, java.util.*
	, org.springframework.web.context.*
	, org.springframework.web.context.support.WebApplicationContextUtils
	, com.hwfs.cmn.service.PropertiesService
	, hone.core.util.record.*"%>                
<%
    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");
    
    RecordSet rs = (RecordSet)request.getAttribute("gwDealDescList");
%>

<!-- fn:replace 의 \n <br> 변환하기위한 세팅 -->
<jsp:scriptlet>
pageContext.setAttribute("newline", "\n");

</jsp:scriptlet>


<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <!-- 본문 제목 표시 -->
        <c:if test="${gwDraftTitle != ''}">
        <DIV style="TEXT-ALIGN: center;">
            <H2><c:out value="${gwDraftTitle}"/></H2>
        </DIV>
        </c:if>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>1. 거래처 현황</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 20%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center;" colspan=2>거래처명</TH>
                        <TH style="TEXT-ALIGN: center;" colspan=2>보고번호</TH>
                        <TH style="TEXT-ALIGN: center;" colspan=2>대표자</TH>
                    </TR>
                    <TR>
                        <TD style="TEXT-ALIGN: center;" colspan=2><c:out value="${gwDraftInfo.custNm}"/></TD>
                        <TD style="TEXT-ALIGN: center;" colspan=2><c:out value="${gwArNonoccurList.accdArNum}"/></TD>
                        <TD style="TEXT-ALIGN: center;" colspan=2><c:out value="${gwDraftInfo.ceoNm}"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;" colspan=3>사업자번호</TH>
                    	<TH style="TEXT-ALIGN: center;" colspan="3">계약기간</TH>
                    </TR>
                    <TR>
                        <TD style="TEXT-ALIGN: center;" colspan=3><c:out value="${gwDraftInfo.bizNum}"/></TD>
                        <fmt:parseDate var="dealSdate" value="${gwDraftInfo.dealSdate}" pattern="yyyyMMdd"/>
                        <fmt:parseDate var="dealEdate" value="${gwDraftInfo.dealEdate}" pattern="yyyyMMdd"/>
                        <TD style="TEXT-ALIGN: center;" colspan="3"><fmt:formatDate value="${dealSdate}" pattern="yyyy-MM-dd"/>
                        ~ <fmt:formatDate value="${dealEdate}" pattern="yyyy-MM-dd"/></TD>
                    </TR>
                </TBODY>
        	</TABLE>
        </DIV>  
        <H3><DIV class=title><SPAN>2. 매출미발생 사유</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 12%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 25%">
                    <COL style="WIDTH: 25%">
                    <COL style="WIDTH: 25%">
                </COLGROUP>   
                <TBODY>  
                    <TR>
                        <TH style="TEXT-ALIGN: center;">거래내역<br/>(단위:천원)</TH>
                        <TD colspan=4>
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center;">채권잔액</TH>
                                            <c:forEach var="hdrDeal" items="${gwHdrDealDescList}" varStatus="status">
                                            <TH style="TEXT-ALIGN: center;">${hdrDeal.krYearMon}</TH>
                                            </c:forEach>
                                        </TR>
                                        <c:forEach var="record" items="${gwDealDescList}" varStatus="status">

                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone>기초잔고</TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gichoAmt01}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gichoAmt02}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gichoAmt03}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gichoAmt04}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gichoAmt05}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gichoAmt06}" type="number"/></TD>
                                        </TR>
                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone>당월매출</TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.machuAmt01}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.machuAmt02}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.machuAmt03}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.machuAmt04}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.machuAmt05}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.machuAmt06}" type="number"/></TD>
                                        </TR>
                                                                                <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone>당월입금</TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.rcpAmt01}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.rcpAmt02}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.rcpAmt03}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.rcpAmt04}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.rcpAmt05}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.rcpAmt06}" type="number"/></TD>
                                        </TR>
                                                                                <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone>기말잔고</TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gimalAmt01}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gimalAmt02}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gimalAmt03}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gimalAmt04}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gimalAmt05}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.gimalAmt06}" type="number"/></TD>
                                        </TR>

                                        </c:forEach>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">매출미발생<br/>사유</TH>
                        <TD colspan=4><c:out value="${fn:replace(gwArNonoccurList.nonoccurReason, newline, '<br />')}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">향후계획</TH>
                        <TD colspan=4><c:out value="${fn:replace(gwArNonoccurList.diffafterPlan, newline, '<br />')}" escapeXml="false"/></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>
