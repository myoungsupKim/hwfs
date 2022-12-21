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
   * @ClassName TestGwDraft.jsp
   * @Description TestGwDraft JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.03.18.   kksoo        프로젝트에 맞게 수정
   *
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.03.18.
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
    String filePath = propertiesService.getString("ft.file.path")+"/ftp";

    //Controller에서 전달된 Model을 얻는다.
    //RecordSet rs = (RecordSet)request.getAttribute("gwDraftMst");
    RecordSet rs2 = (RecordSet)request.getAttribute("gwDraftList");

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
            <H2>전표</H2>
        </DIV>
        </c:if>

        <!-- 본문 제목 표시 -->
        <DIV class=clear></DIV>
        <DIV style="TEXT-ALIGN: center;">
            <H3 style="TEXT-ALIGN: left;">● 아래와 같이 대체전표 승인 요청합니다.</H3>
        </DIV>
        <BR>

        <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
            <TBODY id=tbdArea>
                <TR>
                    <TD>
                        <DIV class="acc_table_basic style1 list">
                            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0 width="100%">
                                <TBODY>
                                    <TR>
                                        <TH style="TEXT-ALIGN: center; WIDTH: 15%">제목</TH>
                                        <TD style="TEXT-ALIGN: left; WIDTH: 85%"><c:out value="${fn:replace(gwDraftMst.workClass, newline, '<br />')}" escapeXml="false"/> <c:out value="${fn:replace(gwDraftMst.itemText, newline, '<br />')}" escapeXml="false"/></TD>
                                    </TR>
                                </TBODY>
                            </TABLE>
                        </DIV>
                    </TD>
                </TR>
            </TBODY>
        </TABLE>


        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>기본정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH>&nbsp;전표번호 </TH>
                        <TD><c:out value="${fn:replace(gwDraftMst.slipNum, newline, '<br />')}" escapeXml="false"/></TD>
                        <TH>&nbsp;전표유형 </TH>
                        <TD><c:out value="${fn:replace(gwDraftMst.workClass, newline, '<br />')}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH>&nbsp;전표증빙일자 </TH>
                        <TD><c:out value="${fn:replace(gwDraftMst.slipEvidenceDate, newline, '<br />')}" escapeXml="false"/></TD>
                        <TH>&nbsp;전표전기일자 </TH>
                        <TD><c:out value="${fn:replace(gwDraftMst.slipPeriodDate, newline, '<br />')}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH>&nbsp;부서 </TH>
                        <TD><c:out value="${fn:replace(gwDraftMst.buNm, newline, '<br />')}" escapeXml="false"/></TD>
                        <TH>&nbsp;작성자 </TH>
                        <TD><c:out value="${fn:replace(gwDraftMst.uuser, newline, '<br />')}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TH>&nbsp;작성일 </TH>
                        <TD><c:out value="${fn:replace(gwDraftMst.pidate, newline, '<br />')}" escapeXml="false"/></TD>
                        <TH>&nbsp;금액 </TH>
                        <TD><fmt:formatNumber value="${gwDraftMst.slipCurrencyAmt}" type="number" pattern="#,##0"/></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>세부사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD COLSPAN="2">
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 30%" colspan=2>계정과목</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">증빙일자</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">전표일자</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">지불예정일</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%">귀속부서</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 15%" style="border-right:1px solid #9ea2a8" rowspan=2>적요</TH>
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
                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone rowspan=2><c:out value="${record.drAcctNm}"/></TD>

                                            <TD style="TEXT-ALIGN: left" class=rbnone rowspan=2><c:out value="${record.crAcctNm}"/></TD>

                                            <TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.slipEvidenceDate}"/></TD>

                                            <TD style="TEXT-ALIGN: center"><c:out value="${record.slipPeriodDate}"/></TD>
                                            <TD style="TEXT-ALIGN: center"><c:out value="${record.expireCalBasisDate}"/></TD>
                                            <TD style="TEXT-ALIGN: left"><c:out value="${record.ccNm}"/></TD>
                                            <TD style="TEXT-ALIGN: left" rowspan=2 ><c:out value="${record.itemText}"/></TD>
                                        </TR>
                                        <TR>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.slipCurrencyAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.stdAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.taxAmt}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: left"><c:out value="${record.supplyplceNm}"/></TD>
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
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>


