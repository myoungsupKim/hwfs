<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 시험결과 구매 전송에 대한 Groupware Draft JSP (Q-Stop)
   * - jstl tag를 이용 (표준)
   * @ClassName TestResultItemSendStopGwDraft.jsp
   * @Description TestResultItemSendStopGwDraft JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.08.20.   jshoon        시험결과 결재 상신
   *
   * @author FC종합전산구축 : LIMS jshoon
   * @since 2015.08.20.
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
                , com.hwfs.cmn.service.PropertiesService
                , hone.core.util.record.*"%>
<%
    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");
    //String filePath = propertiesService.getString("global.filerepository.path");

    //Controller에서 전달된 Model을 얻는다.
    //RecordSet rs2 = (RecordSet)request.getAttribute("gwDraftList");
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
        <DIV style="TEXT-ALIGN: center; margin-top:20px;">
            <H2><c:out value="${gwDraftTitle}"/></H2>
        </DIV>
        </c:if>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>1. 검사개요</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">가. 검사분류</TH>
                        <TD><c:out value="${gwDraftMaster.insptObj}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">나. 검사목적</TH>
                        <TD><c:out value="${gwInsptPurp}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">다. 접수일자</TH>
                        <TD><c:out value="${gwDraftMaster.acceptdd}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">라. 판정일자</TH>
                        <TD><c:out value="${gwDraftMaster.completeDd}" escapeXml="false"/></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>2. 시료정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제품코드</TH>
                        <TD><c:out value="${gwDraftSpecmInfo.specmCd}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제품명</TH>
                        <TD><c:out value="${gwDraftSpecmInfo.specmNm}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">식품유형</TH>
                        <TD><c:out value="${gwDraftSpecmInfo.specmTypeNm}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제조업체</TH>
                        <TD><c:out value="${gwDraftSpecmInfo.mfgwon}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">유통업체</TH>
                        <TD><c:out value="${gwDraftSpecmInfo.dtrVendor}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제조일자</TH>
                        <TD><c:out value="${gwDraftSpecmInfo.mfgdd}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">유통기한</TH>
                        <TD><c:out value="${gwDraftSpecmInfo.dtrlimt}" escapeXml="false"/></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>3. 부적합 내용</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 100%" />
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD style="padding-top:12px;">
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%">검사항목</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%">검사방법</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%">기준구분</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%">기준규격</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 15%">시험결과</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%">적/부 판정</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 15%" style="border-right:1px solid #9ea2a8">부적합분류</TH>
                                        </TR>
                                        <c:forEach var="result" items="${gwDraftTestInfo}" varStatus="status">
                                        <TR>
                                            <TD style="TEXT-ALIGN: center" class=rbnone>${result.articleNm}</TD>
                                            <TD style="TEXT-ALIGN: center" class=rbnone>${result.insptMethod}</TD>
                                            <TD style="TEXT-ALIGN: center" class=rbnone>${result.basisGubun}</TD>
                                            <TD style="TEXT-ALIGN: center" class=rbnone>${result.basisStand}</TD>
                                            <TD style="TEXT-ALIGN: center" class=rbnone>${result.result}</TD>
                                            <TD style="TEXT-ALIGN: center" class=rbnone>${result.lastDecision}</TD>
                                            <TD style="TEXT-ALIGN: center">${result.notFitClsfiNm}</TD>
                                        </TR>
                                        </c:forEach>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>4. 사후조치</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 100%" />
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD>&nbsp;가. 기준 : 식품연구센터 식재료 사후관리 지침 적용</TD>
                    </TR>
                    <TR>
                        <TD style="padding-top:12px;">
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 30%">구분</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 70%; border-right:1px solid #9ea2a8">세부 내용</TH>
                                        </TR>
                                        <TR>
                                            <TD style="TEXT-ALIGN: center" class=rbnone>코드중지대상</TD>
                                            <TD style="TEXT-ALIGN: left">
                                            <c:if test="${gwmaterialUpjangSendResult == '101'}">직영■</c:if>
                                            <c:if test="${gwmaterialUpjangSendResult != '101'}">직영□</c:if>&nbsp;&nbsp;/&nbsp;&nbsp;
                                            <c:if test="${gwmaterialUpjangSendResult == '102'}">식재■</c:if>
                                            <c:if test="${gwmaterialUpjangSendResult != '102'}">식재□</c:if>&nbsp;&nbsp;/&nbsp;&nbsp;
                                            <c:if test="${gwmaterialUpjangSendResult == '103'}">전체■</c:if>
                                            <c:if test="${gwmaterialUpjangSendResult != '103'}">전체□</c:if>
                                            </TD>
                                        </TR>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;나. 적용일시 : 결재 후 즉시</TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;다. 기타사항 : 해당 제품에 대한 대체 제품 부재 등 불가피한 해제 필요 시 별도<br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            전자결재를 통한 식재 차단해제 협조 요청(협조처 : 식품안전팀). 끝.
                        </TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>

