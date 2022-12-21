<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>

<%!
public String getGrade(String score)
{
	if(score.equals("")) return "";
	
	double dAvgMark = Double.parseDouble(score);
	
	if( dAvgMark >= 90 ) {
	    return "A";
	} else if( dAvgMark >= 80 && dAvgMark < 90 ) {
		return "B";
	} else if( dAvgMark >= 70 && dAvgMark < 80 ) {
		return "C";
	} else if( dAvgMark >= 60 && dAvgMark < 70 ) {
		return "D";
	} else if( dAvgMark < 60 ) {
		return "E";
	}
	return "";
}
%>

<%
  /**
   * 협력업체위생관리 점검결과 상신
   * - 서버 scriptlet 이용 (비표준)
   * @ClassName SampleGwDraft2.jsp
   * @Description SampleGwDraft2 JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.03.18.   mskim        최초생성
   *
   * @author FC종합전산구축 : mskim
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
	PreparedStatement pstmt1= null;
	ResultSet rs1 = null;

	PreparedStatement pstmt2= null;
	ResultSet rs2 = null;

	PreparedStatement pstmt3= null;
	ResultSet rs3 = null;

	PreparedStatement pstmt4= null;
	ResultSet rs4 = null;

	PreparedStatement pstmt5= null;
	ResultSet rs5 = null;
	
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
    String strImgRoot   = LimsUtil.checkNull(request.getAttribute("gwStrImgRoot"));   // 위생
    
/*     System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> searchId = " + searchId);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strUpjang = " + strUpjang);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckType = " + strCheckType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckDate = " + strCheckDate);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strImgRoot = " + strImgRoot);
 */
    int i = 0;
    
    // 1. 점검정보
    StringBuffer sbSql = new StringBuffer();
    sbSql.append("SELECT A.TABLE_TYPE                                                                                                                 \n");
    sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0041' AND A.TABLE_TYPE = CODE) AS TABLE_TYPE_NM                 \n");
    sbSql.append("     , A.FORM_CD                                                                                                                    \n");
    sbSql.append("     , A.UPJANG                                                                                                                     \n");
    sbSql.append("     , (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = A.UPJANG) AS UPJANGNM                                                  \n");    
    sbSql.append("     , TO_CHAR(TO_DATE(A.CHECK_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS CHECK_DATE                                                       \n");
    sbSql.append("     , A.CHECK_TYPE                                                                                                                 \n");
    sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0042' AND A.CHECK_TYPE = CODE) AS CHECK_TYPE_NM                 \n");
    sbSql.append("     , A.LEAD_CHECK_TYPE                                                                                                            \n");
    sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0043' AND A.LEAD_CHECK_TYPE = CODE) AS LEAD_CHECK_TYPE_NM       \n");
    sbSql.append("     , A.CHECK_SABUN                                                                                                                \n");
    sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.CHECK_SABUN = SABUN) AS CHECK_SABUN_NM                                      \n");
    sbSql.append("     , A.CHECK_DATE || A.CHECK_START_TIME || '00' AS CHECK_START_TIME                                                               \n");
    sbSql.append("     , A.CHECK_DATE || A.CHECK_END_TIME || '00' AS CHECK_END_TIME                                                                   \n");
    sbSql.append("     , A.RPT_DATE                                                                                                                   \n");
    sbSql.append("     , A.THEME_MGMT                                                                                                                 \n");
    sbSql.append("     , A.REMARK                                                                                                                     \n");
    sbSql.append("     , A.TM_CD                                                                                                                      \n");
    sbSql.append("     , (SELECT DISTINCT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD) AS TM_NM                                                   \n");
    sbSql.append("     , A.TEAM_MST_SABUN                                                                                                             \n");
    sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM                                         \n");
    sbSql.append("     , A.SUBTEAM_MST_SABUN                                                                                                          \n");
    sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM                                   \n");
    sbSql.append("     , A.LEADER_SABUN                                                                                                               \n");
    sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.LEADER_SABUN) AS LEADER_NM                                             \n");
    sbSql.append("     , A.CHARGE_SABUN                                                                                                               \n");
    sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM                                             \n");
    sbSql.append("     , A.KUNSOK                                                                                                                     \n");
    sbSql.append("     , A.WATER_IRRIGATION                                                                                                           \n");
    sbSql.append("     , A.OPEN_DATE                                                                                                                  \n");
    sbSql.append("     , A.PERMISSION_TYPE                                                                                                            \n");
    sbSql.append("     , A.PERSON_CNT                                                                                                                 \n");
    sbSql.append("     , A.DIST_TYPE                                                                                                                  \n");
    sbSql.append("     , A.AVG_MEAL_QTY                                                                                                               \n");
    sbSql.append("     , A.MEAL_CNT                                                                                                                   \n");
    sbSql.append("     , A.MENU_CNT                                                                                                                   \n");
    sbSql.append("     , A.SPECIAL_FACT                                                                                                               \n");
    sbSql.append("     , TRUNC(A.SCORE, 2) AS SCORE                                                                                                   \n");
    sbSql.append("     , FSC_GETLAWCNT_FUN(A.TABLE_TYPE,A.FORM_CD,A.UPJANG,A.CHECK_DATE) AS NOT_FIT_TOT_CNT                                           \n");
    sbSql.append("     , A.INDICATE_CNT                                                                                                               \n");
    sbSql.append("     , A.CONFIRM_YN                                                                                                                 \n");
    sbSql.append("     , TO_CHAR(TO_DATE(A.IMPROV_RPT_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS IMPROV_RPT_DATE                                             \n");
    sbSql.append("     , DECODE(A.NOT_FIT_YN, 0, '적합', '부적합') AS NOT_FIT                                                                                              \n");
    sbSql.append("     , A.THEME_MGMT                                                                                                                 \n");
    sbSql.append("  FROM FSC_SAFE_RESULT_MST A                                                                                                             \n");
    sbSql.append(" WHERE A.TABLE_TYPE = '" + strTableType + "'                                                                                        \n");
    sbSql.append("   AND A.FORM_CD = '" + strFormCd + "'                                                                                              \n");
    sbSql.append("   AND A.UPJANG = '" + strUpjang + "'                                                                                               \n");
    sbSql.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                                                                        \n");
    
    // 2. 점검결과
    StringBuffer sbSql1 = new StringBuffer();
    sbSql1.append("SELECT A.TABLE_TYPE                                                                   \n");
    sbSql1.append("     , A.FORM_CD                                                                      \n");
    sbSql1.append("     , A.CLASS_CD                                                                     \n");
    sbSql1.append("     , A.LRG_CLASS_CD                                                                 \n");
    sbSql1.append("     , A.LRG_CLASS_NAME                                                               \n");
    sbSql1.append("     , A.MIDDLE_CLASS_CD                                                              \n");
    sbSql1.append("     , A.MIDDLE_CLASS_NAME                                                            \n");
    sbSql1.append("     , A.CLASS_NAME                                                                   \n");
    sbSql1.append("     , A.MARK_1                                                                       \n");
    sbSql1.append("     , A.MARK_2                                                                       \n");
    sbSql1.append("     , A.MARK_3                                                                       \n");
    sbSql1.append("     , A.MINUS_YN                                                                     \n");
    sbSql1.append("     , A.NOT_FIT_YN                                                                   \n");
    sbSql1.append("     , B.UPJANG                                                                       \n");
    sbSql1.append("     , B.CHECK_DATE                                                                   \n");
    sbSql1.append("     , B.MARK                                                                         \n");
    sbSql1.append("     , B.INDICATE_CNT                                                                 \n");
    sbSql1.append("     , B.NOT_FIT_CNT                                                                  \n");
    sbSql1.append("     , B.EVAL_CONTENTS                                                                \n");
    sbSql1.append("     , B.MAX_YN                                                                       \n");
    sbSql1.append("     , B.INDICATE_PHOTO                                                               \n");
    sbSql1.append("     , B.SINDICATE_PHOTO                                                              \n");
    sbSql1.append("     , B.IMPROV_MGMT                                                                  \n");
    sbSql1.append("     , TO_CHAR(TO_DATE(B.MGMT_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS MGMT_DATE           \n");
    sbSql1.append("     , B.IMPROV_PHOTO                                                                 \n");
    sbSql1.append("     , B.SIMPROV_PHOTO                                                                \n");
    sbSql1.append("     , '' AS PHOTO_URL                                                                \n");
    sbSql1.append("     , ( SELECT COUNT(*)                                                              \n");
    sbSql1.append("           FROM FSC_RESULT_PHOTO                                                      \n");
    sbSql1.append("          WHERE TABLE_TYPE = B.TABLE_TYPE                                             \n");
    sbSql1.append("            AND FORM_CD = B.FORM_CD                                                   \n");
    sbSql1.append("            AND UPJANG = B.UPJANG                                                     \n");
    sbSql1.append("            AND CHECK_DATE = B.CHECK_DATE                                             \n");
    sbSql1.append("            AND CLASS_CD = B.CLASS_CD                                                 \n");
    sbSql1.append("            AND PHOTO_TYPE ='0'                                                       \n");
    sbSql1.append("       ) AS PHOTO_CNT                                                                 \n");
    sbSql1.append("  FROM FSC_SAFE_FORM_DTL A                                                            \n");
    sbSql1.append("     , FSC_SAFE_RESULT_DTL B                                                          \n");
    sbSql1.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                    \n");
    sbSql1.append("   AND A.FORM_CD = B.FORM_CD                                                          \n");
    sbSql1.append("   AND A.CLASS_CD = B.CLASS_CD                                                        \n");
    sbSql1.append("   AND (B.MAX_YN = 'N' OR (A.NOT_FIT_YN = 'Y' AND NVL(B.INDICATE_CNT,0) > 0))         \n");
    sbSql1.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                          \n");
    sbSql1.append("   AND A.FORM_CD = '" + strFormCd + "'                                                \n");
    sbSql1.append("   AND B.UPJANG = '" + strUpjang + "'                                                 \n");
    sbSql1.append("   AND B.CHECK_DATE = '" + strCheckDate + "'                                          \n");
    sbSql1.append(" ORDER BY A.CLASS_CD                                                                  \n");

    // 3. 사진첨부
    StringBuffer sbSql2 = new StringBuffer();
    sbSql2.append("SELECT C.CLASS_CD                                                                      \n");
    sbSql2.append("     , C.CLASS_NAME                                                                    \n");
    sbSql2.append("     , A.EVAL_CONTENTS                                                                 \n");
    sbSql2.append("     , TO_CHAR(TO_DATE(A.MGMT_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS IMPROV_MRMT_DD  \n");
    sbSql2.append("     , B.SVR_IMGE                                                                      \n");
    sbSql2.append("     , B.IMPROV_SVR_IMGE                                                               \n");
    sbSql2.append("     , A.IMPROV_MGMT                                                                   \n");
    sbSql2.append("  FROM FSC_SAFE_RESULT_DTL A                                                                \n");
    sbSql2.append("     , FSC_SAFE_CHK_IMGE B                                                                  \n");
    sbSql2.append("     , FSC_SAFE_FORM_DTL C                                                                  \n");
    sbSql2.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                     \n");
    sbSql2.append("   AND A.FORM_CD = B.FORM_CD                                                           \n");
    sbSql2.append("   AND A.UPJANG = B.UPJANG                                                             \n");
    sbSql2.append("   AND A.CLASS_CD = B.CLASS_CD                                                         \n");
    sbSql2.append("   AND A.CHECK_DATE = B.CHK_DD                                                         \n");
    sbSql2.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                     \n");
    sbSql2.append("   AND A.FORM_CD = C.FORM_CD                                                           \n");
    sbSql2.append("   AND A.CLASS_CD = C.CLASS_CD                                                         \n");
    sbSql2.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                           \n");
    sbSql2.append("   AND A.FORM_CD = '" + strFormCd + "'                                                 \n");
    sbSql2.append("   AND A.UPJANG = '" + strUpjang + "'                                                  \n");
    sbSql2.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                           \n");
    //sbSql2.append("   AND A.MGMT_DATE IS NOT NULL                                                         \n");
    sbSql2.append(" ORDER BY C.CLASS_CD                                                                   \n");
    
    try {

      pstmt = conn.prepareStatement(sbSql.toString());
      rs = pstmt.executeQuery();
      rs.next();
      
      pstmt1 = conn.prepareStatement(sbSql1.toString());
      rs1 = pstmt1.executeQuery();
      
      pstmt2 = conn.prepareStatement(sbSql2.toString());
      rs2 = pstmt2.executeQuery();
      
%>
<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <DIV style="TEXT-ALIGN: center; margin-top:20px;">
            <SPAN STYLE="font-size:20px;"><b>(<%=nullToBlank(rs.getString("UPJANGNM"))%>) 안전점검 개선보고서</b></SPAN>
        </DIV>
        <H3><DIV class=title><SPAN>1. 점검정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 15%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">영업팀</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TM_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">팀장명</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TEAM_MST_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">소팀장명</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SUBTEAM_MST_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점장명</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("CHARGE_NM"))%></TD>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">사업장구분</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TABLE_TYPE_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점검자</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_SABUN_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점검구분</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_TYPE_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">지도점검구분</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("LEAD_CHECK_TYPE_NM"))%></TD>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점검점수</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SCORE"))%></TD>
                        <TH style="TEXT-ALIGN: center">법적관리지적</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("NOT_FIT_TOT_CNT"))%></TD>
                        <TH style="TEXT-ALIGN: center">부적합판정</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("NOT_FIT"))%></TD>
                        <TH style="TEXT-ALIGN: center">점검일자</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("CHECK_DATE"))%></TD>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">테마관리</TH>
                        <TD COLSPAN="5"><%=nullToBlank(rs.getString("THEME_MGMT"))%></TD>
                        <TH style="TEXT-ALIGN: center">보고일자</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("IMPROV_RPT_DATE"))%></TD>                        
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 10%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">대분류</TH>
                        <TH style="TEXT-ALIGN: center">중분류</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center">개선조치</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">조치일자</TH>
                    </TR>
                    <%
                    	while(rs1.next()) {
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("LRG_CLASS_NAME"))%></TD>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("MIDDLE_CLASS_NAME"))%></TD>
                        <TD><%=nullToBlank(rs1.getString("CLASS_NAME"))%></TD>
                        <TD><%=nullToBlank(rs1.getString("EVAL_CONTENTS"))%></TD>
                        <TD><%=nullToBlank(rs1.getString("IMPROV_MGMT"))%></TD>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs1.getString("MGMT_DATE"))%></TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>                    
        </DIV>
        <DIV class=hgtSplit10></DIV>        
        <H3><DIV class=title><SPAN>2. 사진 첨부</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 18%">
                    <COL style="WIDTH: 19%">
                    <COL style="WIDTH: 19%">                    
                    <COL style="WIDTH: 8%">
                    <COL style="WIDTH: 18%">
                    <COL style="WIDTH: 18%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
						<TH style="TEXT-ALIGN: center">개선조치</TH>                        
                        <TH style="TEXT-ALIGN: center">조치일자</TH>
                        <TH style="TEXT-ALIGN: center">개선전(사진)</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">개선후(사진)</TH>
                    </TR>
                    <%
                        int imgCnt = 0;
                    	while(rs2.next()) {
                    %>
                    <TR>
                        <TD><%=nullToBlank(rs2.getString("CLASS_NAME"))%></TD>
                        <TD><%=nullToBlank(rs2.getString("EVAL_CONTENTS"))%></TD>
						<TD><%=nullToBlank(rs2.getString("IMPROV_MGMT"))%></TD>                        
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("MGMT_DATE"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs2.getString("SVR_IMGE") == null || rs2.getString("SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs2.getString("SVR_IMGE")%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    		}
                        %>
                        </TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs2.getString("IMPROV_SVR_IMGE") == null || rs2.getString("IMPROV_SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs2.getString("IMPROV_SVR_IMGE")%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    		}
                        %>
                        </TD>
                    </TR>
                    <%
                            imgCnt++;
                    	}
                    	
                		if(imgCnt == 0)
                		{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center" colspan="6">등록된 내용이 없습니다.</TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>
        </DIV>          
    </DIV>
</DIV>
<DIV style="DISPLAY: none"><IFRAME height=500 width=1200 name=ifrmPrint></IFRAME></DIV>
<%
		pstmt.close();
		rs.close();
		
		pstmt1.close();
		rs1.close();

		pstmt2.close();
		rs2.close();

    } catch(Exception ex) {
        ex.printStackTrace();
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
        if (rs1 != null) {
            try {
                rs1.close();
            } catch(Exception e) {}
        }
        if (pstmt1 != null) {
            try {
                pstmt1.close();
            } catch(Exception e) {}
        }
        if (rs2 != null) {
            try {
                rs2.close();
            } catch(Exception e) {}
        }
        if (pstmt2 != null) {
            try {
                pstmt2.close();
            } catch(Exception e) {}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>
