<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
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
    String strImgRoot = LimsUtil.checkNull(request.getAttribute("gwStrImgRoot"));

/*     System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> searchId = " + searchId);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strUpjang = " + strUpjang);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckType = " + strCheckType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckDate = " + strCheckDate); */

    int i = 0;
    // 1. 점검정보
    StringBuffer sbSql = new StringBuffer();
    sbSql.append("SELECT A.UPJANG                                                                                                                                     \n");
    sbSql.append("     , B.UPJANGNM                                                                                                                                   \n");
    sbSql.append("     , TO_CHAR(TO_DATE(A.CHK_DD, 'YYYYMMDD'), 'YYYY.MM.DD') AS CHK_DD                                                                               \n");
    sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0106' AND CODE = CHK_CLASS) AS CHK_CLASS_NM                                     \n");
    sbSql.append("     , (SELECT NM_KOR FROM SCO_FS_HR_PERSONAL_V WHERE A.INSPECTOR = SABUN) AS CHECK_SABUN_NM                                                        \n");
    sbSql.append("     , A.TM_CD                                                                                                                                      \n");
    sbSql.append("     , (SELECT DISTINCT TM_NM FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD) AS TM_NM                                                                   \n");
    sbSql.append("     , A.TEAM_MST_SABUN                                                                                                                             \n");
    sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM                                                         \n");
    sbSql.append("     , A.SUBTEAM_MST_SABUN                                                                                                                          \n");
    sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM                                                   \n");
    sbSql.append("     , A.CHARGE_SABUN                                                                                                                               \n");
    sbSql.append("     , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM                                                             \n");
    sbSql.append("     , A.SCORE                                                                                                                                      \n");
    sbSql.append("     , CASE WHEN A.SCORE >= 70 THEN '적합' ELSE '부적합' END AS NOT_FIT_YN          \n");
    sbSql.append("     , A.REMARK                                                                                                                                     \n");
    sbSql.append("     , TO_CHAR(TO_DATE(A.IMPROV_CONFIRM_DD, 'YYYYMMDD'), 'YYYY.MM.DD') AS IMPROV_CONFIRM_DD                                                                \n");
    sbSql.append("     , CASE WHEN SUBSTR('" + strChkDd + "', 5, 4) < '0701' THEN                                                                                            \n");
    sbSql.append("                 TO_CHAR(TO_DATE(TO_CHAR(ADD_MONTHS('" + strChkDd + "', -12), 'YYYY') || '0701'), 'YYYY.MM.DD')                                            \n");
    sbSql.append("            ELSE                                                                                                                                           \n");
    sbSql.append("                 TO_CHAR(TO_DATE(SUBSTR('" + strChkDd + "', 1, 4) || '0101'), 'YYYY.MM.DD')                                                                \n");
    sbSql.append("       END || '~' || TO_CHAR(TO_DATE('" + strChkDd + "'), 'YYYY.MM.DD') AS CHK_PERIOD                                                                      \n");
    sbSql.append("  FROM FSC_PATL_RESULT A                                                                                                                            \n");
    sbSql.append("     , SCO_UPJANG_MST_V B                                                                                                                           \n");
    sbSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                                          \n");
    sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                                                                                        \n");
    sbSql.append("   AND A.UPJANG = '" + strUpjang + "'                                                                                                               \n");
    sbSql.append("   AND A.FORM_CD = '" + strFormCd + "'                                                                                                              \n");
    sbSql.append("   AND A.CHK_DD = '" + strChkDd + "'                                                                                                                \n");

    // 2. 점검결과
    StringBuffer sbSql1 = new StringBuffer();
    sbSql1.append("SELECT B.HL_CLASS_NM                                                                   \n");
    sbSql1.append("     , B.HM_CLASS_NM                                                                   \n");
    sbSql1.append("     , B.CLASS_NM                                                                      \n");
    sbSql1.append("     , A.CHK_CONTENTS                                                                  \n");
    sbSql1.append("     , A.IMPROV_MRMT_CONTENTS                                                          \n");
    sbSql1.append("     , TO_CHAR(TO_DATE(A.IMPROV_MRMT_DD, 'YYYYMMDD'), 'YYYY.MM.DD') AS IMPROV_MRMT_DD                                                                \n");
    sbSql1.append("  FROM FSC_PATL_RESULT_DTL A                                                           \n");
    sbSql1.append("     , FSC_PATL_FORM_DTL B                                                             \n");
    sbSql1.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                     \n");
    sbSql1.append("   AND A.FORM_CD = B.FORM_CD                                                           \n");
    sbSql1.append("   AND A.CLASS_CD = B.CLASS_CD                                                         \n");
    sbSql1.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                           \n");
    sbSql1.append("   AND A.FORM_CD = '" + strFormCd + "'                                                 \n");
    sbSql1.append("   AND A.UPJANG = '" + strUpjang + "'                                                  \n");
    sbSql1.append("   AND A.CHK_DD = '" + strChkDd + "'                                                   \n");
    sbSql1.append("   AND A.IMPROV_CHECK = 'Y'                                                            \n");

    StringBuffer sbSql2 = new StringBuffer();
    sbSql2.append("SELECT C.CLASS_CD                                                                      \n");
    sbSql2.append("     , C.CLASS_NM                                                                      \n");
    sbSql2.append("     , A.CHK_CONTENTS                                                                  \n");
    sbSql2.append("     , A.CHK_SCORE                                                                     \n");
    sbSql2.append("     , B.SVR_IMGE                                                                      \n");
    sbSql2.append("     , B.IMPROV_SVR_IMGE                                                               \n");
    sbSql2.append("     , A.IMPROV_MRMT_CONTENTS                                                          \n");
    sbSql2.append("     , TO_CHAR(TO_DATE(A.IMPROV_MRMT_DD, 'YYYYMMDD'), 'YYYY.MM.DD') AS IMPROV_MRMT_DD                                                                \n");
    sbSql2.append("  FROM FSC_PATL_RESULT_DTL A                                                           \n");
    sbSql2.append("     , FSC_PATL_CHK_IMGE B                                                             \n");
    sbSql2.append("     , FSC_PATL_FORM_DTL C                                                             \n");
    sbSql2.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE(+)                                                  \n");
    sbSql2.append("   AND A.FORM_CD = B.FORM_CD(+)                                                        \n");
    sbSql2.append("   AND A.UPJANG = B.UPJANG(+)                                                          \n");
    sbSql2.append("   AND A.CLASS_CD = B.CLASS_CD(+)                                                      \n");
    sbSql2.append("   AND A.CHK_DD = B.CHK_DD(+)                                                          \n");
    sbSql2.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                     \n");
    sbSql2.append("   AND A.FORM_CD = C.FORM_CD                                                           \n");
    sbSql2.append("   AND A.CLASS_CD = C.CLASS_CD                                                         \n");
    sbSql2.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                           \n");
    sbSql2.append("   AND A.FORM_CD = '" + strFormCd + "'                                                 \n");
    sbSql2.append("   AND A.UPJANG = '" + strUpjang + "'                                                  \n");
    sbSql2.append("   AND A.CHK_DD = '" + strChkDd + "'                                                   \n");
    sbSql2.append("   AND A.IMPROV_CHECK = 'Y'                                                            \n");
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
            <SPAN STYLE="font-size:20px;"><b>(<%=nullToBlank(rs.getString("UPJANGNM"))%>) CS 개선조치 보고서</b></SPAN>
        </DIV>
        <H3><DIV class=title><SPAN>1. 점검 정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 14%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 20%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">사업장명</TH>
                        <TD COLSPAN="3"><%=nullToBlank(rs.getString("UPJANGNM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점장명</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("CHARGE_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">소속팀</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TM_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">본부팀장</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SUBTEAM_MST_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">팀장/본부장</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("TEAM_MST_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점검구분</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHK_CLASS_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점검자</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_SABUN_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점검일자</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("CHK_DD"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점검점수</TH>
                        <TD style="TEXT-ALIGN: center" colspan="3"><%=nullToBlank(rs.getString("SCORE"))%></TD>
                        <TH style="TEXT-ALIGN: center">보고일자</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("IMPROV_CONFIRM_DD"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>2. 사진 첨부</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH:  3%">
                    <COL style="WIDTH: 17%">
                    <COL style="WIDTH: 18%">
                    <COL style="WIDTH: 18%">
                    <COL style="WIDTH: 8%">
                    <COL style="WIDTH: 18%">
                    <COL style="WIDTH: 18%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                    	<TH style="TEXT-ALIGN: center">No</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
						<TH style="TEXT-ALIGN: center">개선조치</TH>
                        <TH style="TEXT-ALIGN: center">조치일자</TH>
                        <TH style="TEXT-ALIGN: center">개선전(사진)</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">개선후(사진)</TH>
                    </TR>
                    <%
                        int imgCnt = 0;
                        int noCnt = 0;
                    	while(rs2.next()) {
                    		noCnt++;
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=noCnt%></TD>
                        <TD><%=nullToBlank(rs2.getString("CLASS_NM"))%></TD>
                        <TD><%=nullToBlank(rs2.getString("CHK_CONTENTS"))%></TD>
						<TD><%=nullToBlank(rs2.getString("IMPROV_MRMT_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("IMPROV_MRMT_DD"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs2.getString("SVR_IMGE") == null || rs2.getString("SVR_IMGE").equals("")) {
                        %>
                        	    미등록
                        <%
                    		} else {
                    			if(rs2.getString("SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
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
        if (rs3 != null) {
            try {
                rs3.close();
            } catch(Exception e) {}
        }
        if (pstmt3 != null) {
            try {
                pstmt3.close();
            } catch(Exception e) {}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>