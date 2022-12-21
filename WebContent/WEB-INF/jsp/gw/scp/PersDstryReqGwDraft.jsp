<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 개인정보 파기요청 그룹웨어 연동을 위해 본문을 생성하는 JSP
   * - jstl tag를 이용 (표준)
   * @ClassName PersDstryReqGwDraft.jsp
   * @Description PersDstryReqGwDraft JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.05.21.   kksoo        최초 생성
   *  
   * @author FC종합전산구축 : AA kksoo
   * @since 2015.05.21.
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
		<c:if test="${gwDraftTitle != ''}">
		<DIV style="TEXT-ALIGN: center;">
			<H2><c:out value="${gwDraftTitle}"/></H2>
		</DIV>
		</c:if>

		<DIV class=clear></DIV>
		<DIV>
		고객이 개인정보 파기요청 시 개인정보취급방침 제4항에 따라 내부 결재를 통해 즉시 개인정보를 파기하도록 되어 있습니다.<br>
		결재 승인이 이루어지면 개인정보는 자동으로 파기됩니다.<br> 
		</DIV>
		<DIV class=clear></DIV>
		<H3><DIV class=title><SPAN>파기요청목록</SPAN></DIV></H3>
		<DIV class="acc_table_basic style1">
			<TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
				<COLGROUP>
					<COL style="WIDTH: 5%">
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 20%">
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 20%">
				</COLGROUP>
				<TBODY id=tbdArea>
				<c:forEach var="record" items="${gwDraftList}" varStatus="status">
					<TR>
						<TH style="TEXT-ALIGN: center" rowspan=3><c:out value="${status.count}"/></TH>
						<TH>파기요청일</TH>
						<fmt:parseDate var="dstryReqDate" value="${record.dstryReqDate}" pattern="yyyy-MM-dd"/>
						<TD style="TEXT-ALIGN: center"><fmt:formatDate value="${dstryReqDate}" pattern="yyyy-MM-dd"/></TD>
						<TH>파기접수자</TH>
						<TD style="TEXT-ALIGN: center"><c:out value="${record.dstryReqUserNm}"/></TD>
						<TD colspan=2></TD>
					</TR>
					<TR>
						<TH>파기대상자ID</TH>
						<TD style="TEXT-ALIGN: center"><c:out value="${record.dstryUserid}"/></TD>
						<TH>파기대상자명</TH>
						<TD style="TEXT-ALIGN: center"><c:out value="${record.dstryUserNm}"/></TD>						
						<TH>파기대상자소속</TH>
						<TD style="TEXT-ALIGN: center"><c:out value="${record.dstryUserCcNm}"/></TD>
					</TR>
					<TR>
						<TH>파기사유</TH>
						<TD colspan=5><c:out value="${fn:replace(record.dstryReason, newline, '<br />')}" escapeXml="false"/></TD>
					</TR>
				</c:forEach>
				</TBODY>
			</TABLE>
		</DIV>
	</DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>