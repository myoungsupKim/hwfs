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
		<H3><DIV class=title><SPAN>기본정보</SPAN></DIV></H3>
		<DIV class="acc_table_basic style1">
			<TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
				<COLGROUP>
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 20%">
					<COL style="WIDTH: 15%">
					<COL style="WIDTH: 20%">
				</COLGROUP>
				<TBODY id=tbdArea>
					<TR>
						<TH>카테고리ID</TH>
						<TD><c:out value="${gwDraftInfo.id}"/></TD>
						<TH>카테고리명</TH>
						<TD><c:out value="${gwDraftInfo.name}"/></TD>
						<TH>사용여부</TH>
						<TD><c:out value="${gwDraftInfo.useYn}"/></TD>
					</TR>
					<TR>
						<TH>금액</TH>
						<TD><fmt:formatNumber value="${gwDraftInfo.amt}" type="number"/></TD>
						<TH>비율</TH>
						<TD><fmt:formatNumber value="${gwDraftInfo.ratio}" type="percent"/></TD>						
						<TH>등록일자</TH>
						<fmt:parseDate var="workDate" value="${gwDraftInfo.workDate}" pattern="yyyyMMdd"/>
						<TD><fmt:formatDate value="${workDate}" pattern="yyyy-MM-dd"/></TD>
					</TR>
					<TR>
						<TH>설명</TH>
						<TD colspan=5><c:out value="${fn:replace(gwDraftInfo.description, newline, '<br />')}" escapeXml="false"/></TD>
					</TR>
				</TBODY>
			</TABLE>
		</DIV>
		<DIV class=hgtSplit10></DIV>
		<H3>
		<DIV class=title><SPAN>세부항목</SPAN></DIV>
		</H3>
		<DIV class="acc_table_basic style1 list">
			<TABLE border=0 cellSpacing=0>
				<TBODY>
					<TR>
						<TH style="TEXT-ALIGN: center; WIDTH: 5%">No.</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 10%">ID</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 10%">NAME</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 20%">DESCRIPTION</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 5%">USE YN</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 10%">AMT</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 10%">RATIO</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 15%">WORK DATE</TH>
						<TH style="TEXT-ALIGN: center; WIDTH: 5%">REF SEQ</TH>
						<TH style="TEXT-ALIGN: center">적요</TH></TR>
					<c:forEach var="record" items="${gwDraftList}" varStatus="status">	
					<TR>
						<TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${status.count}"/></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.id}"/></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.name}"/></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.description}"/></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><c:out value="${record.useYn}"/></TD>
						<TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.amt}" type="number"/></TD>
						<TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value="${record.ratio}" type="percent"/></TD>
						<fmt:parseDate var="workDate" value="${record.workDate}" pattern="yyyyMMdd"/>
						<TD style="TEXT-ALIGN: center" class=rbnone><fmt:formatDate value="${workDate}" pattern="yyyy-MM-dd"/></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><c:out value='${record.refSeq}'/></TD>
						<TD style="TEXT-ALIGN: left">GW테스트</TD>
					</TR>
					</c:forEach>
				</TBODY>
			</TABLE>
		</DIV>
	</DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>

