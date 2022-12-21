<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 시험결과 구매 전송에 대한 Groupware Draft JSP (Q-Pass)
   * - jstl tag를 이용 (표준)
   * @ClassName TestResultItemSendPassGwDraft.jsp
   * @Description TestResultItemSendPassGwDraft JSP
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
                    <COL style="WIDTH: 14%">
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
                        <TH style="TEXT-ALIGN: center;">다. 해재사유</TH>
                        <TD><c:out value="${gwInsptMtod}" escapeXml="false"/></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>2. 시료정보 및 검사정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 14%">
                    <COL style="WIDTH: 43%">
                    <COL style="WIDTH: 43%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">구분</TH>
                        <TH style="TEXT-ALIGN: center;">전기 검사</TH>
                        <TH style="TEXT-ALIGN: center; border-right:1px solid #9ea2a8">재검사(또는 유관부서 요청사항)</TH>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">의뢰번호</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.reqNum}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">검사용도</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.insptPurp3Nm}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제품코드</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.specmCd}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제품명</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.specmNm}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">식품유형</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.specmTypeNm}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제조업체</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.mfgwon}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">유통업체</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.dtrVendor}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">제조일자</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.mfgdd}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">유통기한</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.dtrlimt}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>

                    <TR>
                        <TH style="TEXT-ALIGN: center;">검사항목</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.articleNm}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">검사방법</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.insptMethod}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">기준구분</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.basisGubun}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">기준규격</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.basisStand}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">시험결과</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.result}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">적/부판정</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.lastDecision}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">판정일자</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.lastDecitionDate}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">부적합분류</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD><c:out value="${result.notFitClsfiNm}" escapeXml="false"/></TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>

                    <TR>
                        <TH style="TEXT-ALIGN: center;">중지내역</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD>
                                <c:if test="${result.materialSendResult == 'S'}">
                                    <c:if test="${result.stopHistory == '101'}">직영■</c:if>
                                    <c:if test="${result.stopHistory != '101'}">직영□</c:if>&nbsp;&nbsp;/&nbsp;&nbsp;
                                    <c:if test="${result.stopHistory == '102'}">식재■</c:if>
                                    <c:if test="${result.stopHistory != '102'}">식재□</c:if>&nbsp;&nbsp;/&nbsp;&nbsp;
                                    <c:if test="${result.stopHistory == '103'}">전체■</c:if>
                                    <c:if test="${result.stopHistory != '103'}">전체□</c:if>
                                </c:if>
                                <c:if test="${result.materialSendResult == 'P'}">
                                    직영□&nbsp;&nbsp;/&nbsp;&nbsp;식재□&nbsp;&nbsp;/&nbsp;&nbsp;전체□
                                </c:if>
                            </TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">코드중지일자</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD>
                                <c:if test="${result.materialSendResult == 'S'}">
                                    <c:out value="${result.stopDate}" escapeXml="false"/>
                                </c:if>
                            </TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center;">해재 내역</TH>
                        <c:forEach var="result" items="${gwDraftSpecmInfo}" varStatus="status">
                            <TD>
                                <c:if test="${result.materialSendResult == 'P'}">
                                    <c:if test="${result.stopHistory == '101'}">직영■</c:if>
                                    <c:if test="${result.stopHistory != '101'}">직영□</c:if>&nbsp;&nbsp;/&nbsp;&nbsp;
                                    <c:if test="${result.stopHistory == '102'}">식재■</c:if>
                                    <c:if test="${result.stopHistory != '102'}">식재□</c:if>&nbsp;&nbsp;/&nbsp;&nbsp;
                                    <c:if test="${result.stopHistory == '103'}">전체■</c:if>
                                    <c:if test="${result.stopHistory != '103'}">전체□</c:if>
                                </c:if>
                                <c:if test="${result.materialSendResult == 'S'}">
                                    직영□&nbsp;&nbsp;/&nbsp;&nbsp;식재□&nbsp;&nbsp;/&nbsp;&nbsp;전체□
                                </c:if>
                            </TD>
                        </c:forEach>
                        <c:if test="${fn:length(gwDraftSpecmInfo) == 1}"><TD>&nbsp;</TD></c:if>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>3. 식자재 발주 해재 내역</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 100%" />
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD>&nbsp;가. 해재사유 : <c:out value="${gwInsptMtod}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;나. 적용일시 : 결재 후 즉시. 끝.</TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>

