<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
<%
  /**
   * CS진단 진단결과 등록 - 점검결과 상신
   * - 서버 scriptlet 이용 (비표준)
   * @ClassName SampleGwDraft2.jsp
   * @Description SampleGwDraft2 JSP
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
    , hone.core.util.record.*
    , com.hwfs.ls.cmn.util.LimsUtil"%>
<%
    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

    //Controller에서 전달된 Model을 얻는다.
    //RecordSet rs = (RecordSet)request.getAttribute("gwDraftInfo");

    String gwDraftTitle = LimsUtil.checkNull(request.getAttribute("gwDraftTitle"));
    String searchId     = LimsUtil.checkNull(request.getAttribute("gwSearchId"));
    String strFormCd    = LimsUtil.checkNull(request.getAttribute("gwStrFormCd"));
    String strUpjang    = LimsUtil.checkNull(request.getAttribute("gwStrUpjang"));          // CS, 위생
    String strCustcd    = LimsUtil.checkNull(request.getAttribute("gwStrCustcd"));          // 협력업체
    String strChkDd     = LimsUtil.checkNull(request.getAttribute("gwStrChkDd"));
    String strTableType = LimsUtil.checkNull(request.getAttribute("gwStrTableType"));
    String strCheckType = LimsUtil.checkNull(request.getAttribute("gwStrCheckType"));   // 위생
    String strCheckDate = LimsUtil.checkNull(request.getAttribute("gwStrCheckDate"));   // 위생

    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> searchId = " + searchId);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strUpjang = " + strUpjang);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckType = " + strCheckType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckDate = " + strCheckDate);

    int i = 0;
    StringBuffer sbSql = new StringBuffer();
    sbSql.append("SELECT CODE \n");
    sbSql.append("     , CODE_NAME \n");
    sbSql.append("  FROM SCC_COMMON_CODE \n");
    sbSql.append(" WHERE GROUP_CODE = 'ACCEPT_CLASS' \n");

    try {

      pstmt = conn.prepareStatement(sbSql.toString());
      rs = pstmt.executeQuery();
%>
<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <DIV class=clear></DIV>
        <H3><DIV class=title><SPAN>기본정보</SPAN></DIV></H3>
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
                        <TD COLSPAN="3">[<%= (searchId.equals("1")?"점검결과":"개선결과") %>] 공통코드 [ACCEPT_CLASS] 조회</TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center; WIDTH: 5%">No.</TH>
                        <TH style="TEXT-ALIGN: center; WIDTH: 10%">CODE</TH>
                        <TH style="TEXT-ALIGN: center; WIDTH: 10%" style="border-right:1px solid #9ea2a8">CODE_NAME</TH>
                    <% while(rs.next()) {%>
                    <TR>
                        <TD style="TEXT-ALIGN: center" class=rbnone><%=i++%></TD>
                        <TD style="TEXT-ALIGN: center" class=rbnone><%=rs.getString("CODE")%></TD>
                        <TD style="TEXT-ALIGN: center"><%=rs.getString("CODE_NAME")%></TD>
                    </TR>
                    <% } %>
                </TBODY>
            </TABLE>
        </DIV>
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>
<%
    } catch(Exception ex) {
        //ex.printStackTrace();
        //jsp 로그남기기
        logger.debug(ex.getMessage(), ex);
    } finally {
        if (rs != null) {
            try {
                rs.close();
            } catch(Exception e) {}
        }
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch(Exception e) {}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>
