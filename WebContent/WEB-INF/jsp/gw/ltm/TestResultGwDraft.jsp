<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 시험접수결과 / 성적서 발급에 대한 Groupware Draft JSP
   * - jstl tag를 이용 (표준)
   * @ClassName TestResultGwDraft.jsp
   * @Description TestResultGwDraft JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.04.14.   jshoon        시험결과 결재 상신
   *
   * @author FC종합전산구축 : LIMS jshoon
   * @since 2015.04.14.
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
            <H2><c:out value="${gwDraftTitle}"/>&nbsp;결과보고</H2>
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
				<c:if test="${gwDraftMaster.approvalClass == '101'}">
                <TBODY id=tbdArea>
                    <TR>
                        <TD>&nbsp;가. 검사분류</TD>
                        <TD><c:out value="${gwDraftMaster.insptObj}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;나. 검사목적</TD>
                        <TD><c:out value="${gwInsptPurp}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;다. 검사시료</TD>
                        <TD><c:out value="${gwDraftMaster.specmNm}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;라. 검사유형</TD>
                        <TD><c:out value="${gwDraftMaster.insptObj3}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;마. 검사방법</TD>
                        <TD>식품공전 시험법 및 내부시험법에 의거</TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;바. 접수일자</TD>
                        <TD><c:out value="${gwDraftMaster.acceptdd}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;사. 완료일자</TD>
                        <TD><c:out value="${gwDraftMaster.completeDd}" escapeXml="false"/></TD>
                    </TR>
                </TBODY>
				</c:if>
				<c:if test="${gwDraftMaster.approvalClass == '102'}">
                <TBODY id=tbdArea>
                    <TR>
                        <TD>&nbsp;가. 검사목적</TD>
                        <TD><c:out value="${gwInsptPurp}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;나. 검사시료</TD>
                        <TD><c:out value="${gwDraftMaster.specmNm}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;다. 검사유형</TD>
                        <TD><c:out value="${gwDraftMaster.insptObj3}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;라. 검사방법</TD>
                        <TD>식품공전 시험법 및 내부시험법에 의거</TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;마. 접수일자</TD>
                        <TD><c:out value="${gwDraftMaster.acceptdd}" escapeXml="false"/></TD>
                    </TR>
                    <TR>
                        <TD>&nbsp;바. 완료일자</TD>
                        <TD><c:out value="${gwDraftMaster.completeDd}" escapeXml="false"/></TD>
                    </TR>
                </TBODY>
				</c:if>
            </TABLE>
        </DIV>
  
        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>2. 검사결과</SPAN></DIV></H3>
		
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD COLSPAN="2">&nbsp;최종 판정&nbsp;:&nbsp;적합(${gwDraftMaster.fitCnt}),&nbsp;부적합(${gwDraftMaster.notFitCnt}),&nbsp;진행중(${gwDraftMaster.holdCnt})</TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2" style="padding-top:12px;">
                            <DIV class="acc_table_basic style1 list">
							<c:if test="${gwDraftMaster.approvalClass == '101'}">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 16%;" rowspan="2">시료명</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%;" rowspan="2">코드명</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 8%;" rowspan="2">검사<BR/>항목수</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%;" rowspan="2">검사<BR/>항목</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 7%;" rowspan="2">판정</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 44%;" colspan="4">부적합</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 13%;"  rowspan="2" style="border-right:1px solid #9ea2a8;">부적합<BR/>누적</TH>
                                        </TR>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 14%;">항목</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 12%;">기준</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%;">결과</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 8%;">구분</TH>
                                        </TR>
                                        <c:set var="tSpecmCd" value="" />
                                        <c:forEach var="result" items="${gwDraftDetail}" varStatus="status">
                                        <%-- 부적합결재 상신 --%>
                                      
                                 <c:if test="${draftGubun == '2' && not empty result.articleCd}">
                                        <TR>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                            <TD style="TEXT-ALIGN: left;" class=rbnone rowspan="${result.rowSpanCnt}">${result.specmNm}</TD>
                                            </c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.specmCd}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.testCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.articleInfo}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.lastDecisionNm}</TD></c:if>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.articleNm}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.basisStand}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.result}</TD>
                                            <TD style="TEXT-ALIGN: center;" class=rbnone>${result.notFitClsfiNm}</TD>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" rowspan="${result.rowSpanCnt}">${result.notFitCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                                <c:set var="tSpecmCd" value="${result.specmCd}" />
                                            </c:if>
                                        </TR>
                                </c:if>
                                        <%-- 결재 상신 --%>
                                        <c:if test="${draftGubun != '2'}">
                                        <TR>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                            <TD style="TEXT-ALIGN: left;" class=rbnone rowspan="${result.rowSpanCnt}">${result.specmNm}</TD>
                                            </c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.specmCd}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.testCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.articleInfo}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.lastDecisionNm}</TD></c:if>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.articleNm}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.basisStand}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.result}</TD>
                                            <TD style="TEXT-ALIGN: center;" class=rbnone>${result.notFitClsfiNm}</TD>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" rowspan="${result.rowSpanCnt}">${result.notFitCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                                <c:set var="tSpecmCd" value="${result.specmCd}" />
                                            </c:if>
                                        </TR>
                                        </c:if>
                                        </c:forEach>
                                    </TBODY>
                                </TABLE>
                            </c:if>
							<c:if test="${gwDraftMaster.approvalClass == '102'}">
                                <TABLE border=0 cellSpacing=0>
                                    <TBODY>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 16%;" rowspan="2">시료명</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 8%;" rowspan="2">검사<BR/>항목수</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 11%;" rowspan="2">검사<BR/>항목</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 8%;" rowspan="2">판정</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 46%;" colspan="3">부적합</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%;"  rowspan="2" style="border-right:1px solid #9ea2a8;">부적합<BR/>누적</TH>
                                        </TR>
                                        <TR>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 20%;">항목</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 15%;">기준</TH>
                                            <TH style="TEXT-ALIGN: center; WIDTH: 10%;">결과</TH>
                                        </TR>
                                        <c:set var="tSpecmCd" value="" />
                                        <c:forEach var="result" items="${gwDraftDetail}" varStatus="status">
                                        <%-- 부적합결재 상신 --%>
                                       
                                 <c:if test="${draftGubun == '2' && not empty result.articleCd}">
                                        <TR>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                            <TD style="TEXT-ALIGN: left;" class=rbnone rowspan="${result.rowSpanCnt}">${result.specmNm}</TD>
                                            </c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.testCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.articleInfo}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.lastDecisionNm}</TD></c:if>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.articleNm}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.basisStand}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.result}</TD>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" rowspan="${result.rowSpanCnt}">${result.notFitCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                                <c:set var="tSpecmCd" value="${result.specmCd}" />
                                            </c:if>
                                        </TR>
                                </c:if>
                                        <%-- 결재 상신 --%>
                                        <c:if test="${draftGubun != '2'}">
                                        <TR>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                            <TD style="TEXT-ALIGN: left;" class=rbnone rowspan="${result.rowSpanCnt}">${result.specmNm}</TD>
                                            </c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.testCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.articleInfo}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" class=rbnone rowspan="${result.rowSpanCnt}">${result.lastDecisionNm}</TD></c:if>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.articleNm}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.basisStand}</TD>
                                            <TD style="TEXT-ALIGN: left;" class=rbnone>${result.result}</TD>
                                            <c:if test="${tSpecmCd != result.specmCd}"><TD style="TEXT-ALIGN: center;" rowspan="${result.rowSpanCnt}">${result.notFitCnt}</TD></c:if>
                                            <c:if test="${tSpecmCd != result.specmCd}">
                                                <c:set var="tSpecmCd" value="${result.specmCd}" />
                                            </c:if>
                                        </TR>
                                        </c:if>
                                        </c:forEach>
                                    </TBODY>
                                </TABLE>
                            </c:if>
                            </DIV>
                        </TD>
                    </TR>
                    <TR>
                        <TD COLSPAN="2">&nbsp;※부적합 누적기간 : 1년(조회시점 기준 과거 1년 누적)</TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
					 
		<DIV class=clear></DIV>
		<c:if test="${gwDraftMaster.approvalClass == '101'}">
		<H3><DIV class=title><SPAN>3. 사후처리</SPAN></DIV></H3>
		<DIV class="acc_table_basic style1">
			<TABLE style="TABLE-LAYOUT: fixed;" border=0 cellSpacing=0>
				<COLGROUP>
					<COL style="WIDTH: 15%">
					<COL>
				</COLGROUP>
				<TBODY id=tbdArea>
					<c:if test="${not empty limsAfterProc}">
					<TR>
						<TD COLSPAN="2" style="padding-left:5px;">
							<c:out value="${fn:replace(fn:replace(limsAfterProc, newline, '<br/>'), ' ', '&nbsp;')}" escapeXml="false"/>
						</TD>
					</TR>
					</c:if>   
					<c:if test="${empty limsAfterProc}">
					<TR>
						<TD COLSPAN="2" style="padding-left:5px;">無.</TD>
					</TR>
					</c:if>  
				</TBODY>
			</TABLE>
		</DIV>
		</c:if>
	
        <DIV class=clear></DIV> 
  
		<c:if test="${gwDraftMaster.approvalClass == '101'}">
        <H3><DIV class=title><SPAN>4. 부적합 이력</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed;" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 100%;">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
					<c:if test="${ gwDraftMaster.allNotFitCnt > 0}">   
                    <TR>
                       <TD> 
                           <c:forEach var="result" items="${gwDraftDetail}" varStatus="status">
                              <c:if test="${ result.notFitCnt > 0}"> 
                                  <c:out value="${result.notFitHis}" escapeXml="false"/><br> 
                              </c:if> 
                           </c:forEach>
                       </TD>
                    </TR> 
					</c:if>  
                    <c:if test="${gwDraftMaster.allNotFitCnt == 0}">
                    <TR>
                        <TD>無.</TD>
                    </TR>
                    </c:if>  
                </TBODY>
            </TABLE>
        </DIV> 
        </c:if>  
	
        <DIV class=clear></DIV>
		<c:if test="${gwDraftMaster.approvalClass == '101'}">
        <H3><DIV class=title><SPAN>5. 첨부</SPAN></DIV></H3>
		</c:if>
		<c:if test="${gwDraftMaster.approvalClass == '102'}">
        <H3><DIV class=title><SPAN>3. 첨부</SPAN></DIV></H3> 
		</c:if>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed;" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
                    <c:if test="${gwDraftMaster.insptRptCnt > 0 || not empty attachFileNm}">
                    <TR>
                        <TD COLSPAN="2" style="padding-left:5px;">
                            <c:if test="${not empty attachFileNm}">
                                <c:out value="${fn:replace(fn:replace(attachFileNm, newline, '<br/>'), ' ', '&nbsp;')}" escapeXml="false"/>
                            </c:if>
                            <c:if test="${gwDraftMaster.insptRptCnt > 0 && not empty attachFileNm}">
                                <br />
                            </c:if>
                            <c:if test="${gwDraftMaster.insptRptCnt > 0}">
                                ${gwFileName}. 시험성적서 1부. 끝
                            </c:if>
                        </TD>
                    </TR>
                    </c:if>
                    <c:if test="${gwDraftMaster.insptRptCnt == 0 && empty attachFileNm}">
                    <TR>
                        <TD COLSPAN="2" style="padding-left:5px;">無.</TD>
                    </TR>
                    </c:if>
                </TBODY>
            </TABLE>
        </DIV>

        <DIV class=clear></DIV>
		<c:if test="${gwDraftMaster.approvalClass == '101'}">
        <H3><DIV class=title><SPAN>6. 비고</SPAN></DIV></H3>  
		</c:if>
		<c:if test="${gwDraftMaster.approvalClass == '102'}">
        <H3><DIV class=title><SPAN>4. 비고</SPAN></DIV></H3>  
		</c:if>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed;" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL>
                </COLGROUP>
                <TBODY id=tbdArea>
					<c:if test="${not empty limsBigo}">
                    <TR>
                        <TD COLSPAN="2" style="padding-left:5px;">
                            <c:out value="${fn:replace(fn:replace(limsBigo, newline, '<br/>'), ' ', '&nbsp;')}" escapeXml="false"/>
                        </TD>
                    </TR>
					</c:if>  
					<c:if test="${empty limsBigo}">
                    <TR>
                        <TD COLSPAN="2" style="padding-left:5px;">無.</TD>
                    </TR>
                    </c:if>     
                </TBODY>
            </TABLE>
        </DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none;"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>

