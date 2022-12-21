<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
<%
  /**
   * 협력업체위생관리 개선결과 상신
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
    String strImgRoot = LimsUtil.checkNull(request.getAttribute("gwStrImgRoot"));   // 위생
    //2018.05.25 김명섭 하위공장명 추가
    String strSubCompNm   = LimsUtil.checkNull(request.getAttribute("gwStrSubCompNm"));
    
/*
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> searchId = " + searchId);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strUpjang = " + strUpjang);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckType = " + strCheckType);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckDate = " + strCheckDate);
    System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strImgRoot = " + strImgRoot);
*/
    StringBuffer sbSql = new StringBuffer();
    sbSql.append("SELECT TO_CHAR(TO_DATE(A.CHK_DD, 'YYYYMMDD'), 'YYYY-MM-DD') AS CHK_DD -- 점검일자                                                                   \n");
    sbSql.append("     , (SELECT TM_NM FROM HLDC_SC_DEPT_V WHERE TM_CD = A.TM_CD AND ROWNUM = 1) AS TM_NM -- 소속                                                     \n");
    sbSql.append("     , D.NM_KOR AS INSPECTOR_NM -- 점검자                                                                                                           \n");
    sbSql.append("     , C.CODE_NAME AS CHK_CLASS_NM  -- 점검구분                                                                                                     \n");
    sbSql.append("     , A.DEAL_CLASS  -- 거래구분                                                                                                                    \n");
    sbSql.append("     , (SELECT MGRP_NM                                                                                                                              \n");
    sbSql.append("          FROM LCM_SPECM_TYPE_MGRP                                                                                                                  \n");
    sbSql.append("         WHERE MGRP_CD = A.FOOD_TYPE_MGRP                                                                                                           \n");
    sbSql.append("           AND SPECM_TYPE = A.SPECM_TYPE) || '>' ||  -- 식품의유형(대)                                                                                     \n");
    sbSql.append("       (SELECT MCALSS_NM                                                                                                                            \n");
    sbSql.append("          FROM LCM_SPECM_TYPE_MCALSS                                                                                                                \n");
    sbSql.append("         WHERE MCALSS_CD = A.FOOD_TYPE_MCALSS                                                                                                       \n");
    sbSql.append("           AND SPECM_TYPE = A.SPECM_TYPE) || '>' ||  -- 식품의유형(중)                                                                                     \n");
    sbSql.append("       (SELECT SCLASS_NM                                                                                                                            \n");
    sbSql.append("          FROM LCM_SPECM_TYPE_SCLASS                                                                                                                \n");
    sbSql.append("         WHERE SCLASS_CD = A.FOOD_TYPE_SCLASS                                                                                                       \n");
    sbSql.append("           AND SPECM_TYPE = A.SPECM_TYPE) AS FOOD_CLASS_NM  -- 식품의유형                                                                                  \n");
    sbSql.append("     , NVL(FSC_COMMA_NAME_FUN(NVL(A.FOOD_TYPE_CLASS, ''), 'PICK_STATUS'), ' ') AS FOOD_TYPE_CLASS -- 유형구분                                       \n");
    sbSql.append("     , FSC_COMMA_NAME_FUN(NVL(A.PASS_CENTER, ''), 'FS0116') AS PASS_CENTER  -- 경유센터                                                             \n");
    sbSql.append("     , FSC_COMMA_NAME_FUN(NVL(A.DELIVERY_PLCE, ''), 'FS0115') AS DELIVERY_PLCE  -- 납품처                                                           \n");
    sbSql.append("     , F.VD_NM  -- 업체명                                                                                                                           \n");
    sbSql.append("     , F.REP_NM -- 대표자                                                                                                                           \n");
    sbSql.append("     , F.ADDR -- 소재지                                                                                                                             \n");
    sbSql.append("     , LPAD(A.CHK_START_TIME, 4) AS CHK_START_TIME -- 심사시간 시작                                                                                 \n");
    sbSql.append("     , LPAD(A.CHK_END_TIME, 4) AS CHK_END_TIME -- 심사시간 종료                                                                                     \n");
    sbSql.append("     , ROUND(A.SCORE, 1) AS SCORE      -- 평가점수                                                                                                  \n");
    sbSql.append("     , A.GRADE_CD   -- 위생등급                                                                                                                     \n");
    sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0117' AND CODE = A.CHK_RESULT) AS CHK_RESULT  -- 심사판정                       \n");
    sbSql.append("     , DECODE(A.CHK_RESULT, 1, '거래가능', '거래불가') AS DEAL_YN  -- 거래유무                                                                      \n");
    sbSql.append("     , TO_CHAR(TO_DATE(Z.CHK_DD, 'YYYYMMDD'), 'YYYY-MM-DD') AS PREV_CHK_DD -- 전기평가일                                                            \n");
    sbSql.append("     , ROUND(Z.SCORE, 1) AS PREV_SCORE  -- 전기평가점수                                                                                             \n");
    sbSql.append("     , Z.GRADE_CD AS PREV_GRADE_CD  -- 전기평가등급                                                                                                 \n");
    sbSql.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0117' AND CODE = Z.CHK_RESULT) AS PREV_CHK_RESULT  -- 전기심사판정              \n");
    sbSql.append("     , DECODE(Z.CHK_RESULT, 1, '거래가능', '거래불가') AS PREV_DEAL_YN  -- 거래유무                                                                      \n");
    sbSql.append("     , A.REMARK  -- 총평                                                                                                                            \n");
    sbSql.append("     , A.ATTR01  -- 주요납품품목                                                                                                                    \n");
    sbSql.append("     , A.ATTR02  -- 인증현황/인증일자                                                                                                               \n");
    sbSql.append("     , A.ATTR03  -- 주요납품처                                                                                                                      \n");
    sbSql.append("     , A.ATTR04  -- 영업의종류                                                                                                                      \n");
    sbSql.append("     , A.ATTR05  -- 총 매출액(년)                                                                                                                   \n");
    sbSql.append("     , A.ATTR06  -- 매출점유율(%)                                                                                                                   \n");
    sbSql.append("     , A.ATTR07  -- 연락처/메일                                                                                                                     \n");
    sbSql.append("     , A.ATTR08  -- 소재지                                                                                                                          \n");
    sbSql.append("     , A.ATTR09  -- 사용용수                                                                                                                        \n");
    sbSql.append("     , A.ATTR10  -- 정수처리시설                                                                                                                    \n");
    sbSql.append("     , A.ATTR11  -- 담당MD                                                                                                                          \n");
    sbSql.append("     , A.ATTR12  -- 수검자                                                                                                                          \n");
    sbSql.append("     , A.ATTR13  -- 금번평가 비고                                                                                                                   \n");
    sbSql.append("     , A.ATTR14  -- 전기평가 비고                                                                                                                   \n");
    sbSql.append("     , A.SUB_COMP_NM  -- 하위공장명                                                                                                                 \n");
    sbSql.append("  FROM FSC_CONTRT_RESULT A                                                                                                                          \n");
    sbSql.append("     , (SELECT *                                                                                                                                    \n");
    sbSql.append("          FROM FSC_CONTRT_RESULT                                                                                                                    \n");
    sbSql.append("         WHERE CUSTCD = '" + strCustcd + "'                                                                                                         \n");
    sbSql.append("           AND CHK_DD < '" + strChkDd + "'                                                                                                          \n");
    sbSql.append("           AND SUB_COMP_NM = NVL('" + strSubCompNm + "',' ')                                                                                        \n");
    sbSql.append("           AND ROWNUM = 1                                                                                                                           \n");
    sbSql.append("         ORDER BY CHK_DD DESC) Z                                                                                                                    \n");
    sbSql.append("     , FSC_CONTRT_FORM B                                                                                                                            \n");
    sbSql.append("     , SCC_COMMON_CODE C                                                                                                                            \n");
    sbSql.append("     , SCC_COMMON_CODE E                                                                                                                            \n");
    sbSql.append("     , HLDC_HR_PERSONAL D                                                                                                                           \n");
    sbSql.append("     , HLDC_PO_VENDOR_AUDIT F                                                                                                                       \n");
    sbSql.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                                                                                  \n");
    sbSql.append("   AND A.FORM_CD = B.FORM_CD                                                                                                                        \n");
    sbSql.append("   AND A.CUSTCD = F.VD_SN                                                                                                             \n");
    sbSql.append("   AND A.TABLE_TYPE = Z.TABLE_TYPE(+)                                                                                                               \n");
    sbSql.append("   AND A.FORM_CD = Z.FORM_CD(+)                                                                                                                     \n");
    sbSql.append("   AND A.CUSTCD = Z.CUSTCD(+)                                                                                                                       \n");
    sbSql.append("   AND C.GROUP_CODE = 'FS0106'                                                                                                                      \n");
    sbSql.append("   AND A.CHK_CLASS = C.CODE                                                                                                                         \n");
    sbSql.append("   AND E.GROUP_CODE = 'FS0117'                                                                                                                      \n");
    sbSql.append("   AND A.CHK_RESULT = E.CODE                                                                                                                        \n");
    sbSql.append("   AND A.INSPECTOR = D.SABUN                                                                                                                        \n");
    sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                                                                                        \n");
    sbSql.append("   AND A.CUSTCD = '" + strCustcd + "'                                                                                                               \n");
    sbSql.append("   AND A.FORM_CD = '" + strFormCd + "'                                                                                                              \n");
    sbSql.append("   AND A.CHK_DD = '" + strChkDd + "'                                                                                                                \n");
    sbSql.append("   AND A.SUB_COMP_NM = NVL('" + strSubCompNm + "',' ')                                                                                              \n");

    StringBuffer sbSql1 = new StringBuffer();
    sbSql1.append("SELECT C.CLASS_CD                                                                      \n");
    sbSql1.append("     , C.CLASS_NM                                                                      \n");
    sbSql1.append("     , A.CHK_CONTENTS                                                                  \n");
    sbSql1.append("     , TO_CHAR(TO_DATE(A.IMPROV_MRMT_DD, 'YYYYMMDD'), 'YYYY-MM-DD') AS IMPROV_MRMT_DD  \n");
    sbSql1.append("     , DECODE(B.VISIBLE_YN,'Y',B.SVR_IMGE,'') AS SVR_IMGE                              \n");
    sbSql1.append("     , B.IMPROV_SVR_IMGE                                                               \n");
    sbSql1.append("     , A.IMPROV_MRMT_CONTENTS                                                          \n");
    sbSql1.append("  FROM FSC_CONTRT_RESULT_DTL A                                                         \n");
    sbSql1.append("     , FSC_CONTRT_CHK_IMGE B                                                           \n");
    sbSql1.append("     , FSC_CONTRT_FORM_DTL C                                                           \n");
    sbSql1.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                     \n");
    sbSql1.append("   AND A.FORM_CD = B.FORM_CD                                                           \n");
    sbSql1.append("   AND A.CUSTCD = B.CUSTCD                                                             \n");
    sbSql1.append("   AND A.CLASS_CD = B.CLASS_CD                                                         \n");
    sbSql1.append("   AND A.CHK_DD = B.CHK_DD                                                             \n");
    sbSql1.append("   AND A.SUB_COMP_NM = B.SUB_COMP_NM                                                   \n");
    sbSql1.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                     \n");
    sbSql1.append("   AND A.FORM_CD = C.FORM_CD                                                           \n");
    sbSql1.append("   AND A.CLASS_CD = C.CLASS_CD                                                         \n");
    sbSql1.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                           \n");
    sbSql1.append("   AND A.FORM_CD = '" + strFormCd + "'                                                 \n");
    sbSql1.append("   AND A.CUSTCD = '" + strCustcd + "'                                                  \n");
    sbSql1.append("   AND A.CHK_DD = '" + strChkDd + "'                                                   \n");
    sbSql1.append("   AND A.SUB_COMP_NM = NVL('" + strSubCompNm + "',' ')                                 \n");
    sbSql1.append("   AND A.IMPROV_MRMT_DD IS NOT NULL                                                    \n");
    sbSql1.append(" ORDER BY C.CLASS_CD                                                                   \n");

    try {

      pstmt = conn.prepareStatement(sbSql.toString());
      rs = pstmt.executeQuery();
      rs.next();

      pstmt1 = conn.prepareStatement(sbSql1.toString());
      rs1 = pstmt1.executeQuery();
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
                    <COL style="WIDTH: 34%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">평가일자</TH>
                        <TH style="TEXT-ALIGN: center">소속/평가자</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">평가구분</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHK_DD"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHK_DD"))%> / <%=nullToBlank(rs.getString("INSPECTOR_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHK_CLASS_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">거래구분</TH>
                        <TH style="TEXT-ALIGN: center">식품의유형</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">유형구분</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("DEAL_CLASS"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("FOOD_CLASS_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("FOOD_TYPE_CLASS"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">경유센터</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8" COLSPAN=2>납품처</TH>
                    </TR>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PASS_CENTER"))%></TD>
                    	<TD style="TEXT-ALIGN: center" COLSPAN=2><%=nullToBlank(rs.getString("DELIVERY_PLCE"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>2. 개선계획 및 개선실적</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 8%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 19%">
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 18%">
                    <COL style="WIDTH: 18%">
                    <COL style="WIDTH: 17%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">문항</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">지적사항</TH>
                        <TH style="TEXT-ALIGN: center">개선일정</TH>
                        <TH style="TEXT-ALIGN: center">개선전(사진)</TH>
                        <TH style="TEXT-ALIGN: center">개선후(사진)</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">개선내용</TH>
                    </TR>
                    <%
                    	while(rs1.next()) {
                    %>
                    <TR>
                        <TH style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("CLASS_CD"))%></TH>
                        <TD><%=nullToBlank(rs1.getString("CLASS_NM"))%></TD>
                        <TD><%=nullToBlank(rs1.getString("CHK_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("IMPROV_MRMT_DD"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs1.getString("SVR_IMGE") == null || rs1.getString("SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs1.getString("SVR_IMGE")%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    		}
                        %>
                        </TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs1.getString("IMPROV_SVR_IMGE") == null || rs1.getString("IMPROV_SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs1.getString("IMPROV_SVR_IMGE")%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    		}
                        %>
                        </TD>
                        <TD><%=nullToBlank(rs1.getString("IMPROV_MRMT_CONTENTS"))%></TD>
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
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>
