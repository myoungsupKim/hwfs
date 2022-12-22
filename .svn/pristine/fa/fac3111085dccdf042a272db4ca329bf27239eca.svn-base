<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /**
   * 그룹웨어 연동을 위해 본문을 생성하는 샘플 JSP
   * - 서버 scriptlet 이용 (비표준)
   * @ClassName TestGwDraft2.jsp
   * @Description TestGwDraft2 JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.03.18.   kksoo        최초생성
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

	//Controller에서 전달된 Model을 얻는다.
	RecordSet rs = (RecordSet)request.getAttribute("gwDraftInfo");

%>
<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
	<DIV class=contents>
		<!-- <DIV class="button_basic fr"><SPAN class="button large"><BUTTON id=btnEtaxView type=button>전자세금계산서보기</BUTTON> </SPAN><SPAN class="button large"><BUTTON id=btnAprvReq type=button>결재상신</BUTTON> </SPAN><SPAN class="button large"><BUTTON id=btnPrint type=button>전표출력</BUTTON> </SPAN><SPAN class="button large"><BUTTON id=btnDelete type=button>삭제</BUTTON> </SPAN></DIV> -->
		<DIV class=clear></DIV>
		<H3><DIV class=title><SPAN>기본정보123</SPAN></DIV></H3>
		<DIV class="acc_table_basic style1">
			<TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
				<COLGROUP>
					<COL style="WIDTH: 8%">
					<COL style="WIDTH: 13%">
					<COL style="WIDTH: 14%">
					<COL style="WIDTH: 12%">
					<COL style="WIDTH: 23%">
					<COL style="WIDTH: 9%">
					<COL style="WIDTH: 8%">
					<COL style="WIDTH: 13%">
				</COLGROUP>
				<TBODY id=tbdArea>
					<TR>
						<TH>전표번호</TH>
						<TD><SPAN id=spnXblnr>1409-00419</SPAN></TD>
						<TD class=lbnone><SPAN id=spnArea2>1000043238</SPAN>&nbsp;</TD>
						<TH class=lbnone>전표유형</TH>
						<TD><SPAN id=spnSlipTypeNm>전자세금계산서전표</SPAN></TD>
						<TH class=lbnone>기안일시</TH>
						<TD colSpan=2>2014-09-17 14:34:33</TD>
					</TR>
					<TR>
						<TH>작성부서</TH>
						<TD colSpan=2><SPAN id=spnWrtKostlNm>회계팀담당</SPAN>&nbsp;&nbsp;<SPAN id=spnBukrsNm>한화</SPAN> </TD>
						<TH class=lbnone>작성자</TH>
						<TD><SPAN id=spnWrtNm>홍길동 매니저</SPAN></TD>
						<TH class=lbnone>작성일시</TH>
						<TD colSpan=2><SPAN id=spnWrtDtmFmt>2014-09-17 14:34:12</SPAN></TD>
					</TR>
				</TBODY>
				<TBODY>
					<TR>
						<TH id=thEvidTypeCd>증빙유형</TH>
						<TD id=tdEvidTypeCd colSpan=2>전자-세금계산서</TD>
						<TH id=thStlFgCd class=lbnone>정산구분</TH>
						<TD id=tdStlFgCd>일반</TD>
						<TH id=thBldat class=lbnone>증빙일자</TH>
						<TD id=tdBldat colSpan=2>2014-06-09</TD>
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
					<%for (int i= 0; i < rs.getRowCount(); i++) {%>	
					<TR>
						<TD style="TEXT-ALIGN: center" class=rbnone><%=i+1%></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><%=rs.getRecord(i).getString("id")%></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><%=rs.getRecord(i).getString("name")%></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><%=rs.getRecord(i).getString("description")%></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><%=rs.getRecord(i).getString("useYn")%></TD>
						<TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value='<%=rs.getRecord(i).getString("amt")%>' type="number"/></TD>
						<TD style="TEXT-ALIGN: right" class=rbnone><fmt:formatNumber value='<%=rs.getRecord(i).getString("ratio")%>' type="percent"/></TD>
						<fmt:parseDate var="workDate" value='<%=rs.getRecord(i).getString("workDate")%>' pattern="yyyyMMdd"/>
						<TD style="TEXT-ALIGN: center" class=rbnone><fmt:formatDate value="${workDate}" pattern="yyyy-MM-dd"/></TD>
						<TD style="TEXT-ALIGN: center" class=rbnone><%=rs.getRecord(i).getString("refSeq")%></TD>
						<TD style="TEXT-ALIGN: left">GW테스트</TD>
					</TR>
					<%} %>
				</TBODY>
			</TABLE>
		</DIV>
	</DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>

