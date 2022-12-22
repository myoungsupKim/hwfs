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
    RecordSet rs2 = (RecordSet)request.getAttribute("gwDraftList");

    //Controller에서 전달된 Model을 얻는다.
    RecordSet rs3 = (RecordSet)request.getAttribute("gwDraftSum");
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
            <H2>품의</H2>
        </DIV>
        </c:if>

        <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
            <TBODY id=tbdArea>
                <TR>
                    <TD>
                        <DIV class="acc_table_basic style1 list">
                            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0 width="100%">
                                <TBODY>
                                    <TR>
                                        <TH style="TEXT-ALIGN: center; WIDTH: 15%">제목</TH>
                                        <TD style="TEXT-ALIGN: left; WIDTH: 85%"><c:out value="${fn:replace(gwDraftInfo.proposalTitle, newline, '<br />')}" escapeXml="false"/></TD>
                                    </TR>
                                    <TR>
                                        <TH style="TEXT-ALIGN: center; WIDTH: 15%">기안자</TH>
                                        <TD style="TEXT-ALIGN: left; WIDTH: 85%"><c:out value="${fn:replace(gwDraftInfo.drafterNm, newline, '<br />')}" escapeXml="false"/></TD>
                                    </TR>
                                </TBODY>
                            </TABLE>
                        </DIV>
                    </TD>
                </TR>
            </TBODY>
        </TABLE>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>1.개요 및 규모</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD>&nbsp;(1) 거래개요</TD>
                        <TD>
                            <c:out value="${fn:replace(fn:replace(gwDraftInfo.dealOtln, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                        </TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">&nbsp;(2) 거래규모</TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 30%">품목명</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 7%">단위</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 13%">수량</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">중량</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 15%">매입단가(￦)</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 23%; border-right:1px solid #9ea2a8">매입금액(￦)</TH>
                                        </TR>
                                        <c:forEach var="record" items="${gwDraftList}" varStatus="status">
                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone><c:out value="${record.itemNm}"/></TD>
                                            <TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.unit}"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.quantity}" type="number" pattern="#,##0"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.wgt}" type="number" pattern="#,##0.00"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.buyPrice}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.buyAmt}" type="number"/></TD>
                                        </TR>
                                        </c:forEach>
                                        <%
                                        if ( rs2.size() > 1 ) {
                                        %>
                                        <c:forEach var="record" items="${gwDraftSum}" varStatus="status">
                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone>합계</TD>
                                            <TD style="TEXT-ALIGN: center" class=rbnone></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.quantity}" type="number" pattern="#,##0"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.wgt}" type="number" pattern="#,##0.00"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.buyPrice}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.buyAmt}" type="number"/></TD>
                                        </TR>
                                        </c:forEach>
                                        <%
                                        }
                                        %>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;(3) 비고</TD>
                        <TD>
                            <c:out value="${fn:replace(fn:replace(gwDraftInfo.dealScaleRemark, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                        </TD>
                    </TR>

                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>2. 거래구조 및 거래조건</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD COLSPAN="2">&nbsp;(1) 거래구조</TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">
                            <img width="100%" height="250" src="${svc}upload<c:out value="${gwDraftInfo.imgPath}"/>">
                        </TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;(2) 거래조건</TD>
                        <TD></TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 14%">구분</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 43%">매입처</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 42%" style="border-right:1px solid #9ea2a8">매출처</TH>
                                        </TR>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center" class=rbnone>조건</TH>
                                            <TD style="TEXT-ALIGN: left" class=rbnone>
                                                <c:out value="${fn:replace(fn:replace(gwDraftInfo.splrPayCond, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                                            </TD>
                                            <TD style="TEXT-ALIGN: left" style="border-right:1px solid #9ea2a8">
                                                <c:out value="${fn:replace(fn:replace(gwDraftInfo.salsplcePayCond, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                                            </TD>
                                        </TR>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center" class=rbnone>일정</TH>
                                            <TD style="TEXT-ALIGN: left" style="border-right:1px solid #9ea2a8">
                                                <%-- <fmt:parseDate var="lcIssuingSchdDate" value="${gwDraftInfo.lcIssuingSchdDate}" pattern="yyyyMMdd"/>
                                                - 입고예정일 : <fmt:formatDate value="${deliverSchdDate}" pattern="yyyy-MM-dd"/>
                                                <BR> --%>
                                                <fmt:parseDate var="settleSchdDate" value="${gwDraftInfo.settleSchdDate}" pattern="yyyyMMdd"/>
                                                - 결제예정일 :  <fmt:formatDate value="${settleSchdDate}" pattern="yyyy-MM-dd"/>
                                            </TD>
                                            <TD style="TEXT-ALIGN: left;" VALIGN="TOP" style="border-right:1px solid #9ea2a8">
                                                <fmt:parseDate var="proposalSaleEdate" value="${gwDraftInfo.proposalSaleEdate}" pattern="yyyyMMdd"/>
                                                - 판매기한 :  <fmt:formatDate value="${proposalSaleEdate}" pattern="yyyy-MM-dd"/>
                                            </TD>
                                        </TR>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;(3) 비고</TD>
                        <TD>
                            <c:out value="${fn:replace(fn:replace(gwDraftInfo.dealCondRemark, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                        </TD>

                    </TR>
                </TBODY>
            </TABLE>
        </DIV>



        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>3. 판매 및 이익 계획</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD COLSPAN="2">&nbsp;(1) 판매 계획</TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%" rowspan="2">품목명</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%">매입단가(￦)</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%">매출단가(￦)</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%">매출이익액</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%" style="border-right:1px solid #9ea2a8">직접이익액</TH>
                                        </TR>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center;">매입액</TH>
                                            <TH style="TEXT-ALIGN: center;">매출액</TH>
                                            <TH style="TEXT-ALIGN: center;">매출이익률(%)</TH>
                                            <TH style="TEXT-ALIGN: center;" style="border-right:1px solid #9ea2a8">직접이익률(%)</TH>
                                        </TR>
                                        <c:forEach var="record" items="${gwDraftList}" varStatus="status">
                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone rowspan="2"><c:out value="${record.itemNm}"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.buyPrice}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsUprice}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsGainAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.drctGainAmt}" type="number"/></TD>
                                        </TR>
                                        <TR>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.buyAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsGainRat}" type="number" pattern="#,##0.0"/>%</TD>

                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.drctGainRat}" type="number" pattern="#,##0.0"/>%</TD>
                                        </TR>
                                        </c:forEach>
                                        <%
                                        if ( rs2.size() > 1 ) {
                                        %>
                                        <c:forEach var="record" items="${gwDraftSum}" varStatus="status">
                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone rowspan="2">합계</TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.buyPrice}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsUprice}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsGainAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.drctGainAmt}" type="number"/></TD>
                                        </TR>
                                        <TR>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.buyAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsAmt}" type="number"/></TD>

                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.salsGainRat}" type="number" pattern="#,##0.0"/>%</TD>

                                            <TD style="TEXT-ALIGN: right"><fmt:formatNumber value="${record.drctGainRat}" type="number" pattern="#,##0.0"/>%</TD>
                                        </TR>
                                        </c:forEach>
                                        <%
                                        }
                                        %>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;(2) 비고</TD>
                        <TD>
                            <c:out value="${fn:replace(fn:replace(gwDraftInfo.salGainPlanRemark, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/><br />
                        </TD>
                    </TR>

                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>4. RISK 관리 방안</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD>&nbsp;(1) 채권 관리 </TD>
                        <TD><c:out value="${fn:replace(fn:replace(gwDraftInfo.arMgmtSchm, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">&nbsp;(2) 가격 관리</TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">
                            <DIV class="acc_table_basic style1 list">
                                <TABLE border=0 cellSpacing=0">
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 30%">품목명</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 7%">단위</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">원가(￦/kg)</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">단위당<br>OFFER價</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">단위당<br>OFFER價 比</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%">단위당<br>도매價</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%" style="border-right:1px solid #9ea2a8">단위당<br>도매價 比</TH>
                                        </TR>
                                        <c:forEach var="record" items="${gwDraftList}" varStatus="status">
                                        <TR>
                                            <TD style="TEXT-ALIGN: left" class=rbnone><c:out value="${record.itemNm}"/></TD>
                                            <TD style="TEXT-ALIGN: left" class=rbnone><c:out value="${record.unit}"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.buyPrice}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.offer}" type="number" pattern="#,##0.00"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><c:out value="${record.offer2}"/></TD>
                                            <TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.wholeSale}" type="number"/></TD>
                                            <TD style="TEXT-ALIGN: right" ><c:out value="${record.wholeSale2}"/></TD>
                                        </TR>
                                        </c:forEach>
                                    </TBODY>
                                </TABLE>
                            </DIV>
                        </TD>
                    </TR>

                    <TR>
                        <TD>&nbsp;(3) 품질 관리</TD>
                        <TD>
                            <c:out value="${fn:replace(fn:replace(gwDraftInfo.qualityMgmtSchm, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                        </TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;(4) 비고 </TD>
                        <TD>
                            <c:out value="${fn:replace(fn:replace(gwDraftInfo.priceMgmtRemark, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                        </TD>
                    </TR>

                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
        <c:if test="${not empty gwDraftInfo.remark}">
        <H3><DIV class=title><SPAN>5. 기타</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD>
                            <c:out value="${fn:replace(fn:replace(gwDraftInfo.remark, newline, '<br/>'),' ','&nbsp;')}" escapeXml="false"/>
                        </TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        </c:if>

    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>


