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
        <H3><DIV class=title><SPAN>1. 심사구분</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 33%">
                    <COL style="WIDTH: 33%">
                    <COL style="WIDTH: 33%">
                    <COL style="WIDTH: 33%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점검일자</TH>
                        <TH style="TEXT-ALIGN: center">소속/점검자</TH>
                        <TH style="TEXT-ALIGN: center">거래구분</TH>
                        <TH style="TEXT-ALIGN: center">점검구분</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center">2015-07-09</TD>
                    	<TD style="TEXT-ALIGN: center">식품연구소 / 최준열</TD>
                    	<TD style="TEXT-ALIGN: center">PB</TD>
                    	<TD style="TEXT-ALIGN: center">선정</TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">식품의유형</TH>
                        <TH style="TEXT-ALIGN: center">유형구분</TH>
                        <TH style="TEXT-ALIGN: center">납품처</TH>
                        <TH style="TEXT-ALIGN: center">경유센터</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center">과자류 > 캔디 > 젤리</TD>
                    	<TD style="TEXT-ALIGN: center">냉장, 냉동</TD>
                    	<TD style="TEXT-ALIGN: center">급식, 외식, 식재, 63/호텔, 리조트</TD>
                    	<TD style="TEXT-ALIGN: center">경인, 남부, 호남, 직송, 기타</TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>2. 업체현황</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 30%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH>업체명</TH>
                        <TD>(유)다솔건해</TD>
                        <TH>주요 납품품목</TH>
                        <TD>과자류</TD>
                    </TR>
                    <TR>
                        <TH>인증현황/인증일자</TH>
                        <TD></TD>
                        <TH>주요 납품처</TH>
                        <TD></TD>
                    </TR>
                    <TR>
                        <TH>영업의종류</TH>
                        <TD></TD>
                        <TH>총 매출액(년)/매출점유율(%)</TH>
                        <TD></TD>
                    </TR>
                    <TR>
                        <TH>대표자</TH>
                        <TD></TD>
                        <TH>소재지</TH>
                        <TD></TD>
                    </TR>
                    <TR>
                        <TH>연락처/메일</TH>
                        <TD>010-111-1234</TD>
                        <TH>사용용수/저수조유무</TH>
                        <TD>상수, 직수, 저수조, 지하수</TD>
                    </TR>
                    <TR>
                        <TH>담당MD</TH>
                        <TD></TD>
                        <TH>심사시간/수검자</TH>
                        <TD></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>3. 심사결과</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">평가점수</TH>
                        <TH style="TEXT-ALIGN: center">위생등급</TH>
                        <TH style="TEXT-ALIGN: center">심사판정</TH>
                        <TH style="TEXT-ALIGN: center">거래유무</TH>
                        <TH style="TEXT-ALIGN: center">비고</TH>
                    </TR>
                    <TR>
                    	<TH>금번평가</TH>
                    	<TD style="TEXT-ALIGN: center">100.0</TD>
                    	<TD style="TEXT-ALIGN: center">A</TD>
                    	<TD style="TEXT-ALIGN: center">적합</TD>
                    	<TD style="TEXT-ALIGN: center">거래가능</TD>
                    	<TD></TD>
                    </TR>
                    <TR>
                    	<TH>전기평가(2015-01-20)</TH>
                    	<TD style="TEXT-ALIGN: center">92.0</TD>
                    	<TD style="TEXT-ALIGN: center">B</TD>
                    	<TD style="TEXT-ALIGN: center">적합</TD>
                    	<TD style="TEXT-ALIGN: center">거래가능</TD>
                    	<TD></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>  
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>4. 총평</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1 list">
			<TABLE border=0 cellSpacing=0>
	            <TBODY>
	                <TR>
	                    <TD height="100px">&nbsp</TD>
	                </TR>
	            </TBODY>
	        </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>5. 세부 Category별 평가결과</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 20%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">가중치</TH>
                        <TH style="TEXT-ALIGN: center">총점</TH>
                        <TH style="TEXT-ALIGN: center">평가총점</TH>
                        <TH style="TEXT-ALIGN: center">평가점수</TH>
                        <TH style="TEXT-ALIGN: center">백분율</TH>
                        <TH style="TEXT-ALIGN: center">반영점수</TH>
                        <TH style="TEXT-ALIGN: center">평가등급</TH>
                    </TR>
                    <TR>
                        <TH>법규준수</TH>
                        <TD style="TEXT-ALIGN: center">5</TD>
                        <TD style="TEXT-ALIGN: center">50</TD>
                        <TD style="TEXT-ALIGN: center">50</TD>
                        <TD style="TEXT-ALIGN: center">50</TD>
                        <TD style="TEXT-ALIGN: center">100%</TD>
                        <TD style="TEXT-ALIGN: right">5.0</TD>
                        <TD style="TEXT-ALIGN: center">A</TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>  
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>6. 주요지적사항 및 개선요구사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 50%">
                    <COL style="WIDTH: 50%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">주요지적사항</TH>
                        <TH style="TEXT-ALIGN: center">개선요구사항</TH>
                    </TR>
                    <TR>
                        <TD style="HEIGHT: 100px;"></TD>
                        <TD style="HEIGHT: 100px;"></TD>
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
