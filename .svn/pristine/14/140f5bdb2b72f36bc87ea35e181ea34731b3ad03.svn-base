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

	PreparedStatement pstmt6= null;
	ResultSet rs6 = null;
	
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
    
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> searchId = " + searchId);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strUpjang = " + strUpjang);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckType = " + strCheckType);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckDate = " + strCheckDate);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strImgRoot = " + strImgRoot);

    int i = 0;
    
    // 1. 점검정보
    StringBuffer sbSql = new StringBuffer();
    sbSql.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, TO_CHAR(TO_DATE(A.CHECK_DATE), 'YYYY-MM-DD') AS CHECK_DATE		   /* 점검일자 */                                                                           \n");
    sbSql.append("    , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0041' AND A.TABLE_TYPE = CODE) AS TABLE_TYPE_NM                                                                                    \n");
    sbSql.append("    , A.TM_CD                                                                                                                                                                                         \n");
    sbSql.append("    , (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = A.UPJANG) AS UPJANGNM                                                                                                                     \n");    
    sbSql.append("    , (SELECT DISTINCT TM_NM FROM HLDC_SC_DEPT_V WHERE TM_CD = A.TM_CD) AS TM_NM		 /* 운영부서 */                                                                                                 \n");
    sbSql.append("    , (SELECT JOB_NAME FROM FSA_UPJANG_V WHERE UPJANG = A.UPJANG) AS JOB_NAME			 /* 직군 */                                                                                                     \n");
    sbSql.append("    , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.TEAM_MST_SABUN) AS TEAM_MST_NM  /* 팀장명 */                                                                                              \n");
    sbSql.append("    , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.SUBTEAM_MST_SABUN) AS SUBTEAM_MST_NM	   /* 소팀장명 */                                                                                   \n");
    sbSql.append("    , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.LEADER_SABUN) AS LEADER_NM				   /* 리더명 */                                                                                 \n");
    sbSql.append("    , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM				   /* 점장명 */                                                                                 \n");
    sbSql.append("    , (SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE A.CHECK_SABUN = SABUN) AS CHECK_SABUN_NM		   /* 점검자 */                                                                                         \n");
    sbSql.append("    , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0042' AND CODE = A.CHECK_TYPE) AS CHECK_TYPE_NM	 /* 점검구분 */                                                                 \n");
    sbSql.append("    , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0043' AND CODE = A.LEAD_CHECK_TYPE) AS LEAD_CHECK_TYPE_NM	 /* 지도점검구분 */                                                     \n");
    sbSql.append("    , SUBSTR(A.CHECK_START_TIME,0,2) || ':' || SUBSTR(A.CHECK_START_TIME,3,2) || ' ~ ' || SUBSTR(A.CHECK_END_TIME,0,2) || ':' || SUBSTR(A.CHECK_END_TIME,3,2) AS CHECK_TIME	 /* 점검시간 */         \n");
    sbSql.append("    , A.AVG_MEAL_QTY  /* 일평균식수 */                                                                                                                                                                \n");
    sbSql.append("    , A.MEAL_CNT	   /* 운영끼니 */                                                                                                                                                                   \n");
    sbSql.append("    , A.MENU_CNT	   /* 제공식단수 */                                                                                                                                                                 \n");
    sbSql.append("    , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'MA0005' AND CODE =A.DIST_TYPE) AS DIST_TYPE_NM				 /* 배식형태 */                                                         \n");
    sbSql.append("    , A.PERSON_CNT		 /* 근무인원 */                                                                                                                                                             \n");
    sbSql.append("    , A.WATER_IRRIGATION	/* 용수 */                                                                                                                                                                  \n");
    sbSql.append("    , FSC_COMMA_NAME_FUN(A.PERMISSION_TYPE, 'MA0004') AS PERMISSION_TYPE /* 인허가형태 */                                                            \n");
    sbSql.append("    , A.SPECIAL_FACT                                                                                                                                                                                  \n");
    sbSql.append(" FROM FSC_SAFE_RESULT_MST A                                                                                                                                                                                \n");
    sbSql.append("WHERE A.TABLE_TYPE = '" + strTableType + "'                                                                                                                                                           \n");
    sbSql.append("  AND A.FORM_CD = '" + strFormCd + "'                                                                                                                                                                 \n");
    sbSql.append("  AND A.UPJANG = '" + strUpjang + "'                                                                                                                                                                  \n");
    sbSql.append("  AND A.CHECK_DATE = '" + strCheckDate + "'                                                                                                                                                               \n");
    
    // 2. 점검결과
    StringBuffer sbSql1 = new StringBuffer();
    sbSql1.append("SELECT SUM(DECODE(SUBSTR(A.CLASS_CD,1,2),'01',A.SCORE,0)) AS LRG_CLASS_MARK1     \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2),'02',A.SCORE,0)) AS LRG_CLASS_MARK2     \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2),'03',A.SCORE,0)) AS LRG_CLASS_MARK3     \n");
    sbSql1.append("     , SUM(A.SCORE) AS TOTAL_MARK                                                \n");
    sbSql1.append("     --중점항목:부적합관리 소분류항목의 지적건수                                 \n");
    sbSql1.append("     , SUM(DECODE(B.NOT_FIT_YN,'Y',NVL(A.INDICATE_CNT,0),0)) AS NOT_FIT_CNT1     \n");
    sbSql1.append("     --법규항목:관리항목 중분류에 속한 최고점이 아닌 소분류항목의 갯수           \n");
    sbSql1.append("     , SUM(DECODE(A.MAX_YN||C.MNGM_FLAG,'NY',1,0)) AS NOT_FIT_CNT2               \n");
    sbSql1.append("     , DECODE(D.NOT_FIT_YN, 0, '적합', '부적합') AS NOT_FIT_YN                   \n");
    sbSql1.append("     , D.THEME_MGMT                                                              \n");
    sbSql1.append("  FROM FSC_SAFE_RESULT_DTL A, FSC_SAFE_FORM_DTL B, FSC_SAFE_CLASS_MST C                         \n");
    sbSql1.append("     , FSC_SAFE_RESULT_MST D                                                          \n");
    sbSql1.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                               \n");
    sbSql1.append("   AND A.FORM_CD = B.FORM_CD                                                     \n");
    sbSql1.append("   AND A.CLASS_CD = B.CLASS_CD                                                   \n");
    sbSql1.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                               \n");
    sbSql1.append("   AND A.FORM_CD = C.FORM_CD                                                     \n");
    sbSql1.append("   AND SUBSTR(A.CLASS_CD,1,5)||'000' = C.CLASS_CD                                \n");
    sbSql1.append("   AND A.TABLE_TYPE = D.TABLE_TYPE                                               \n");
    sbSql1.append("   AND A.FORM_CD = D.FORM_CD                                                     \n");
    sbSql1.append("   AND A.UPJANG = D.UPJANG                                                       \n");
    sbSql1.append("   AND A.CHECK_DATE = D.CHECK_DATE   AND A.TABLE_TYPE = '" + strTableType + "'   \n");
    sbSql1.append("   AND A.FORM_CD = '" + strFormCd + "'                                           \n");
    sbSql1.append("   AND A.UPJANG = '" + strUpjang + "'                                            \n");
    sbSql1.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                     \n");
    sbSql1.append(" GROUP BY D.NOT_FIT_YN, D.THEME_MGMT                                             \n");
    
    // 3. 점검결과 누계
    StringBuffer sbSql2 = new StringBuffer();
    sbSql2.append("SELECT A.UPJANG_CHECK_CNT                                                                                                                                     \n");
    sbSql2.append("    , A.UPJANG_AVG_SCORE                                                                                                                                      \n");
    sbSql2.append("    , A.UPJANG_NOT_FIT_CNT                                                                                                                                    \n");
    sbSql2.append("    , TO_CHAR(TO_DATE(SUBSTR('" + strCheckDate + "', 1, 4) || '0101'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE('" + strCheckDate + "'), 'YYYY.MM.DD') AS UPJANG_DATE  \n");
    sbSql2.append("    , B.CHARGE_SABUN                                                                                                                                          \n");
    sbSql2.append("    , B.CHARGE_NM_KOR                                                                                                                                         \n");
    sbSql2.append("    , B.CHARGE_CHECK_CNT                                                                                                                                      \n");
    sbSql2.append("    , B.CHARGE_AVG_SCORE                                                                                                                                      \n");
    sbSql2.append("    , B.CHARGE_NOT_FIT_CNT                                                                                                                                    \n");
    sbSql2.append("    , B.RESP1_SABUN                                                                                                                                           \n");
    sbSql2.append("    , B.RESP1_NM_KOR                                                                                                                                          \n");
    sbSql2.append("    , B.RESP1_NOT_FIT_CNT                                                                                                                                     \n");
    sbSql2.append("    , B.RESP2_SABUN                                                                                                                                           \n");
    sbSql2.append("    , B.RESP2_NM_KOR                                                                                                                                          \n");
    sbSql2.append("    , B.RESP2_NOT_FIT_CNT                                                                                                                                     \n");
    sbSql2.append("    , B.RESP3_SABUN                                                                                                                                           \n");
    sbSql2.append("    , B.RESP3_NM_KOR                                                                                                                                          \n");
    sbSql2.append("    , B.RESP3_NOT_FIT_CNT                                                                                                                                     \n");
    sbSql2.append("    , CASE WHEN SUBSTR('" + strCheckDate + "', 5, 4) < '0701' THEN                                                                                            \n");
    sbSql2.append("                TO_CHAR(TO_DATE(TO_CHAR(ADD_MONTHS('" + strCheckDate + "', -12), 'YYYY') || '0701'), 'YYYY.MM.DD')                                            \n");
    sbSql2.append("           ELSE                                                                                                                                               \n");
    sbSql2.append("                TO_CHAR(TO_DATE(SUBSTR('" + strCheckDate + "', 1, 4) || '0101'), 'YYYY.MM.DD')                                                                \n");
    sbSql2.append("      END || '~' || TO_CHAR(TO_DATE('" + strCheckDate + "'), 'YYYY.MM.DD') AS RESP_DATE                                                                       \n");
    sbSql2.append(" FROM (                                                                                                                                                       \n");
    sbSql2.append("       SELECT COUNT(1) AS UPJANG_CHECK_CNT                                                                                                                    \n");
    sbSql2.append("            , DECODE(SUM(A.AVG_CNT), 0, 0, ROUND(SUM(A.SCORE) / SUM(A.AVG_CNT), 1)) AS UPJANG_AVG_SCORE                                                       \n");
    sbSql2.append("            , SUM(NOT_FIT_YN) AS UPJANG_NOT_FIT_CNT                                                                                                           \n");
    sbSql2.append("         FROM (                                                                                                                                               \n");
    sbSql2.append("               SELECT UPJANG                                                                                                                                  \n");
    sbSql2.append("                    , DECODE(B.SET1, 'Y', 0, 1) AS AVG_CNT                                                                                                    \n");
    sbSql2.append("                    , DECODE(B.SET1, 'Y', 0, A.SCORE) AS SCORE                                                                                                \n");
    sbSql2.append("                    , NOT_FIT_YN                                                                                                                              \n");
    sbSql2.append("                 FROM FSC_SAFE_RESULT_MST A                                                                                                                        \n");
    sbSql2.append("                    , SCC_COMMON_CODE B                                                                                                                       \n");
    sbSql2.append("                WHERE A.UPJANG = '" + strUpjang + "'                                                                                                          \n");
    sbSql2.append("                  AND A.TABLE_TYPE = '" + strTableType + "'                                                                                                   \n");
    sbSql2.append("                  AND A.CHECK_DATE BETWEEN SUBSTR('" + strCheckDate + "', 1, 4) || '0101' AND '" + strCheckDate + "'                                          \n");
    sbSql2.append("                  AND A.CHECK_TYPE <> '002' -- 진단은 제외                                                                                                    \n");
    sbSql2.append("                  AND B.GROUP_CODE = 'FS0042'                                                                                                                 \n");
    sbSql2.append("                  AND A.CHECK_TYPE = B.CODE                                                                                                                   \n");
    sbSql2.append("              ) A                                                                                                                                             \n");
    sbSql2.append("        GROUP BY UPJANG                                                                                                                                       \n");
    sbSql2.append("      ) A                                                                                                                                                     \n");
    sbSql2.append("    , (                                                                                                                                                       \n");
    sbSql2.append("       SELECT MAX(A.CHARGE_SABUN) AS CHARGE_SABUN                                                                                                             \n");
    sbSql2.append("            , MAX(B.NM_KOR) AS CHARGE_NM_KOR                                                                                                                  \n");
    sbSql2.append("            , SUM(A.CHARGE_CHECK_CNT) AS CHARGE_CHECK_CNT                                                                                                     \n");
    sbSql2.append("            , DECODE(SUM(A.CHARGE_AVG_CNT), 0, 0, ROUND(SUM(A.CHARGE_SCORE) / SUM(A.CHARGE_AVG_CNT), 1)) AS CHARGE_AVG_SCORE                                  \n");
    sbSql2.append("            , SUM(A.CHARGE_NOT_FIT_YN) AS CHARGE_NOT_FIT_CNT                                                                                                  \n");
    sbSql2.append("            , MAX(A.RESP1_SABUN) AS RESP1_SABUN                                                                                                               \n");
    sbSql2.append("            , MAX(C.NM_KOR) AS RESP1_NM_KOR                                                                                                                   \n");
    sbSql2.append("            , SUM(A.RESP1_NOT_FIT_YN) AS RESP1_NOT_FIT_CNT                                                                                                    \n");
    sbSql2.append("            , MAX(A.RESP2_SABUN) AS RESP2_SABUN                                                                                                               \n");
    sbSql2.append("            , MAX(D.NM_KOR) AS RESP2_NM_KOR                                                                                                                   \n");
    sbSql2.append("            , SUM(A.RESP2_NOT_FIT_YN) AS RESP2_NOT_FIT_CNT                                                                                                    \n");
    sbSql2.append("            , MAX(A.RESP3_SABUN) AS RESP3_SABUN                                                                                                               \n");
    sbSql2.append("            , MAX(E.NM_KOR) AS RESP3_NM_KOR                                                                                                                   \n");
    sbSql2.append("            , SUM(A.RESP3_NOT_FIT_YN) AS RESP3_NOT_FIT_CNT                                                                                                    \n");
    sbSql2.append("         FROM (                                                                                                                                               \n");
    sbSql2.append("               SELECT CASE WHEN A.CHARGE_SABUN = C.SABUN THEN C.SABUN ELSE '' END AS CHARGE_SABUN                                                             \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN THEN 1 ELSE 0 END AS CHARGE_CHECK_CNT                                                                \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN THEN DECODE(B.SET1, 'Y', 0, 1) ELSE 0 END AS CHARGE_AVG_CNT                                          \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN THEN DECODE(B.SET1, 'Y', 0, A.SCORE) ELSE 0 END AS CHARGE_SCORE                                      \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN THEN NOT_FIT_YN ELSE 0 END AS CHARGE_NOT_FIT_YN                                                      \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN1 = C.SABUN THEN C.SABUN ELSE '' END AS RESP1_SABUN                                                               \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN1 = C.SABUN THEN NOT_FIT_YN ELSE 0 END AS RESP1_NOT_FIT_YN                                                        \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN2 = C.SABUN THEN C.SABUN ELSE '' END AS RESP2_SABUN                                                               \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN2 = C.SABUN THEN NOT_FIT_YN ELSE 0 END AS RESP2_NOT_FIT_YN                                                        \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN3 = C.SABUN THEN C.SABUN ELSE '' END AS RESP3_SABUN                                                               \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN3 = C.SABUN THEN NOT_FIT_YN ELSE 0 END AS RESP3_NOT_FIT_YN                                                        \n");
    sbSql2.append("                 FROM FSC_SAFE_RESULT_MST A                                                                                                                        \n");
    sbSql2.append("                    , SCC_COMMON_CODE B                                                                                                                       \n");
    sbSql2.append("                    ,(SELECT SABUN_TYPE                                                                                                                       \n");
    sbSql2.append("                           , SABUN                                                                                                                            \n");
    sbSql2.append("                        FROM (                                                                                                                                \n");
    sbSql2.append("                              SELECT DECODE(lv, 1, '01', 2, '02', 3, '03', 4, '04') AS SABUN_TYPE                                                             \n");
    sbSql2.append("                                   , DECODE(lv, 1, CHARGE_SABUN, 2, RESP_SABUN1, 3, RESP_SABUN2, 4, RESP_SABUN3) AS SABUN                                     \n");
    sbSql2.append("                                FROM (SELECT CHARGE_SABUN                                                                                                     \n");
    sbSql2.append("                                           , RESP_SABUN1                                                                                                      \n");
    sbSql2.append("                                           , RESP_SABUN2                                                                                                      \n");
    sbSql2.append("                                           , RESP_SABUN3                                                                                                      \n");
    sbSql2.append("                                        FROM FSC_SAFE_RESULT_MST                                                                                                   \n");
    sbSql2.append("                                       WHERE TABLE_TYPE = '" + strTableType + "'                                                                              \n");
    sbSql2.append("                                         AND FORM_CD = '" + strFormCd + "'                                                                                    \n");
    sbSql2.append("                                         AND CHECK_DATE = '" + strCheckDate + "'                                                                              \n");
    sbSql2.append("                                         --AND CONFIRM_YN = 'Y'                                                                                               \n");
    sbSql2.append("                                         AND UPJANG = '" + strUpjang + "')                                                                                    \n");
    sbSql2.append("                                   , (SELECT LEVEL lv                                                                                                         \n");
    sbSql2.append("                                        FROM DUAL                                                                                                             \n");
    sbSql2.append("                                      CONNECT BY LEVEL <= 4)                                                                                                  \n");
    sbSql2.append("                             )                                                                                                                                \n");
    sbSql2.append("                       WHERE SABUN IS NOT NULL                                                                                                                \n");
    sbSql2.append("                      ) C                                                                                                                                     \n");
    sbSql2.append("                WHERE A.TABLE_TYPE = '" + strTableType + "'                                                                                                   \n");
    sbSql2.append("                  AND A.CHECK_DATE BETWEEN CASE WHEN SUBSTR('" + strCheckDate + "', 5, 4) < '0701' THEN                                                       \n");
    sbSql2.append("                                                     TO_CHAR(ADD_MONTHS('" + strCheckDate + "', -12), 'YYYY') || '0701'                                       \n");
    sbSql2.append("                                                ELSE                                                                                                          \n");
    sbSql2.append("                                                     SUBSTR('" + strCheckDate + "', 1, 4) || '0101'                                                           \n");
    sbSql2.append("                                           END                                                                                                                \n");
    sbSql2.append("                                           AND '" + strCheckDate + "'                                                                                         \n");
    sbSql2.append("                  AND A.CHECK_TYPE <> '002' -- 진단은 제외                                                                                                    \n");
    sbSql2.append("                  AND B.GROUP_CODE = 'FS0042'                                                                                                                 \n");
    sbSql2.append("                  AND A.CHECK_TYPE = B.CODE                                                                                                                   \n");
    sbSql2.append("              ) A                                                                                                                                             \n");
    sbSql2.append("            , HLDC_HR_PERSONAL B                                                                                                                              \n");
    sbSql2.append("            , HLDC_HR_PERSONAL C                                                                                                                              \n");
    sbSql2.append("            , HLDC_HR_PERSONAL D                                                                                                                              \n");
    sbSql2.append("            , HLDC_HR_PERSONAL E                                                                                                                              \n");
    sbSql2.append("        WHERE A.CHARGE_SABUN = B.SABUN(+)                                                                                                                     \n");
    sbSql2.append("          AND A.RESP1_SABUN = C.SABUN(+)                                                                                                                      \n");
    sbSql2.append("          AND A.RESP2_SABUN = D.SABUN(+)                                                                                                                      \n");
    sbSql2.append("          AND A.RESP3_SABUN = E.SABUN(+)                                                                                                                      \n");
    sbSql2.append("      ) B                                                                                                                                                     \n");

    // 3. 주요지적사항
    StringBuffer sbSql3 = new StringBuffer();
    sbSql3.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD                  \n");
    sbSql3.append("     , B.LRG_CLASS_NAME, B.MIDDLE_CLASS_NAME, B.CLASS_NAME, A.EVAL_CONTENTS         \n");
    sbSql3.append("  FROM FSC_SAFE_RESULT_DTL A, FSC_SAFE_FORM_DTL B                                             \n");
    sbSql3.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                  \n");
    sbSql3.append("   AND A.FORM_CD = B.FORM_CD                                                        \n");
    sbSql3.append("   AND A.CLASS_CD = B.CLASS_CD                                                      \n");
    sbSql3.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                        \n");
    sbSql3.append("   AND A.FORM_CD = '" + strFormCd + "'                                              \n");
    sbSql3.append("   AND A.UPJANG = '" + strUpjang + "'                                               \n");
    sbSql3.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                        \n");
    sbSql3.append("   /* 최고점이 아닌 배점을 받은 항목 OR 부적합관리 소분류 항목중 지적체크된 항목 */ \n");
    sbSql3.append("   AND (A.MAX_YN = 'N' OR (B.NOT_FIT_YN = 'Y' AND NVL(A.INDICATE_CNT,0) > 0))       \n");
    sbSql3.append(" ORDER BY A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD               \n");

    // 4. 지적 이미지 
    StringBuffer sbSql4 = new StringBuffer();
    sbSql4.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM AS SEQ                 \n");
    sbSql4.append("     , B.CLASS_NAME, A.EVAL_CONTENTS, C.ORGNL_IMGE AS PHOTO                                         \n");
    sbSql4.append("     , DECODE(C.SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(C.SVR_IMGE),'=','%')) AS SPHOTO   \n");
    sbSql4.append("  FROM FSC_SAFE_RESULT_DTL A, FSC_SAFE_FORM_DTL B, FSC_SAFE_CHK_IMGE C                                             \n");
    sbSql4.append(" WHERE A.TABLE_TYPE = '" + strTableType + "'                                                        \n");
    sbSql4.append("   AND A.FORM_CD = '" + strFormCd + "'                                                              \n");
    sbSql4.append("   AND A.UPJANG = '" + strUpjang + "'                                                               \n");
    sbSql4.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                                        \n");
    sbSql4.append("   AND A.TABLE_TYPE = B.TABLE_TYPE                                                                  \n");
    sbSql4.append("   AND A.FORM_CD = B.FORM_CD                                                                        \n");
    sbSql4.append("   AND A.CLASS_CD = B.CLASS_CD                                                                      \n");
    sbSql4.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                                  \n");
    sbSql4.append("   AND A.FORM_CD = C.FORM_CD                                                                        \n");
    sbSql4.append("   AND A.UPJANG = C.UPJANG                                                                          \n");
    sbSql4.append("   AND A.CHECK_DATE = C.CHK_DD                                                                      \n");
    sbSql4.append("   AND A.CLASS_CD = C.CLASS_CD                                                                      \n");
    sbSql4.append("   AND C.PHOTO_TYPE = '0' /* 사진유형(0:지적,1:우수) */                                             \n");
    sbSql4.append(" ORDER BY A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM                     \n");
    
    // 5. 우수 이미지
    StringBuffer sbSql5 = new StringBuffer();
    sbSql5.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM AS SEQ                 \n");
    sbSql5.append("     , B.CLASS_NAME, A.EVAL_CONTENTS, C.ORGNL_IMGE AS PHOTO                                         \n");
    sbSql5.append("     , DECODE(C.SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(C.SVR_IMGE),'=','%')) AS SPHOTO   \n");
    sbSql5.append("  FROM FSC_SAFE_RESULT_DTL A, FSC_SAFE_FORM_DTL B, FSC_SAFE_CHK_IMGE C                                             \n");
    sbSql5.append(" WHERE A.TABLE_TYPE = '" + strTableType + "'                                                        \n");
    sbSql5.append("   AND A.FORM_CD = '" + strFormCd + "'                                                              \n");
    sbSql5.append("   AND A.UPJANG = '" + strUpjang + "'                                                               \n");
    sbSql5.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                                        \n");
    sbSql5.append("   AND A.TABLE_TYPE = B.TABLE_TYPE                                                                  \n");
    sbSql5.append("   AND A.FORM_CD = B.FORM_CD                                                                        \n");
    sbSql5.append("   AND A.CLASS_CD = B.CLASS_CD                                                                      \n");
    sbSql5.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                                  \n");
    sbSql5.append("   AND A.FORM_CD = C.FORM_CD                                                                        \n");
    sbSql5.append("   AND A.UPJANG = C.UPJANG                                                                          \n");
    sbSql5.append("   AND A.CHECK_DATE = C.CHK_DD                                                                      \n");
    sbSql5.append("   AND A.CLASS_CD = C.CLASS_CD                                                                      \n");
    sbSql5.append("   AND C.PHOTO_TYPE = '1' /* 사진유형(0:지적,1:우수) */                                             \n");
    sbSql5.append(" ORDER BY A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM                     \n");
    
    // 6. 확인 이미지
    StringBuffer sbSql6 = new StringBuffer();
    sbSql6.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM AS SEQ                 \n");
    sbSql6.append("     , B.CLASS_NAME, A.EVAL_CONTENTS, C.ORGNL_IMGE AS PHOTO                                         \n");
    sbSql6.append("     , DECODE(C.SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(C.SVR_IMGE),'=','%')) AS SPHOTO   \n");
    sbSql6.append("  FROM FSC_SAFE_RESULT_DTL A, FSC_SAFE_FORM_DTL B, FSC_SAFE_CHK_IMGE C                                             \n");
    sbSql6.append(" WHERE A.TABLE_TYPE = '" + strTableType + "'                                                        \n");
    sbSql6.append("   AND A.FORM_CD = '" + strFormCd + "'                                                              \n");
    sbSql6.append("   AND A.UPJANG = '" + strUpjang + "'                                                               \n");
    sbSql6.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                                        \n");
    sbSql6.append("   AND A.TABLE_TYPE = B.TABLE_TYPE                                                                  \n");
    sbSql6.append("   AND A.FORM_CD = B.FORM_CD                                                                        \n");
    sbSql6.append("   AND A.CLASS_CD = B.CLASS_CD                                                                      \n");
    sbSql6.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                                  \n");
    sbSql6.append("   AND A.FORM_CD = C.FORM_CD                                                                        \n");
    sbSql6.append("   AND A.UPJANG = C.UPJANG                                                                          \n");
    sbSql6.append("   AND A.CHECK_DATE = C.CHK_DD                                                                      \n");
    sbSql6.append("   AND A.CLASS_CD = C.CLASS_CD                                                                      \n");
    sbSql6.append("   AND C.PHOTO_TYPE = '2' /* 사진유형(0:지적,1:우수,2:확인) */                                            \n");
    sbSql6.append(" ORDER BY A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM                     \n");
    
    try {

      pstmt = conn.prepareStatement(sbSql.toString());
      rs = pstmt.executeQuery();
      rs.next();
      
      pstmt1 = conn.prepareStatement(sbSql1.toString());
      rs1 = pstmt1.executeQuery();
      rs1.next();
      
      pstmt2 = conn.prepareStatement(sbSql2.toString());
      rs2 = pstmt2.executeQuery();
      rs2.next();
      
      pstmt3 = conn.prepareStatement(sbSql3.toString());
      rs3 = pstmt3.executeQuery();

      pstmt4 = conn.prepareStatement(sbSql4.toString());
      rs4 = pstmt4.executeQuery();

      pstmt5 = conn.prepareStatement(sbSql5.toString());
      rs5 = pstmt5.executeQuery();

      pstmt6 = conn.prepareStatement(sbSql6.toString());
      rs6 = pstmt6.executeQuery();
      
%>
<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <DIV style="TEXT-ALIGN: center; margin-top:20px;">
            <SPAN STYLE="font-size:20px;"><b>(<%=nullToBlank(rs.getString("UPJANGNM"))%>) 안전점검 보고서</b></SPAN>
        </DIV>
        <H3><DIV class=title><SPAN>1. 점검정보</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 25%">
                    <COL style="WIDTH: 25%">
                    <COL style="WIDTH: 25%">
                    <COL style="WIDTH: 25%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">영업팀</TH>
                        <TH style="TEXT-ALIGN: center">직군</TH>
                        <TH style="TEXT-ALIGN: center">팀장명</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">소팀장명</TH>                        
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TM_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("JOB_NAME"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TEAM_MST_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SUBTEAM_MST_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점장명</TH>
                        <TH style="TEXT-ALIGN: center">점검자</TH>
                        <TH style="TEXT-ALIGN: center">점검구분</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">지도점검구분</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHARGE_NM"))%></TD>                    
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_SABUN_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_TYPE_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("LEAD_CHECK_TYPE_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">사업장구분</TH>
                        <TH style="TEXT-ALIGN: center">점검일자</TH>
                        <TH style="TEXT-ALIGN: center">점검시간</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">용수</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TABLE_TYPE_NM"))%></TD>                    
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_DATE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_TIME"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("WATER_IRRIGATION"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">일평균식수</TH>
                        <TH style="TEXT-ALIGN: center">운영끼니</TH>
                        <TH style="TEXT-ALIGN: center">제공식단수</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">배식형태</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("AVG_MEAL_QTY"))%></TD>                    
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("MEAL_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("MENU_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("DIST_TYPE_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">근무인원</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8" colspan="3">인허가형태</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("PERSON_CNT"))%></TD>                    
                    	<TD style="TEXT-ALIGN: center" colspan="3"><%=nullToBlank(rs.getString("PERMISSION_TYPE"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>2. 점검결과</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 11%">
                    <COL style="WIDTH: 12%">                    
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">위생</TH>
                        <TH style="TEXT-ALIGN: center">안전</TH>
                        <TH style="TEXT-ALIGN: center">테마관리</TH>
                        <TH style="TEXT-ALIGN: center">점수합계</TH>
                        <TH style="TEXT-ALIGN: center">점검등급</TH>
                        <TH style="TEXT-ALIGN: center">중점항목</TH>
                        <TH style="TEXT-ALIGN: center">법규항목</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">부적합판정</TH>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점수</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("LRG_CLASS_MARK1"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("LRG_CLASS_MARK2"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("LRG_CLASS_MARK3"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("TOTAL_MARK"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=getGrade(nullToBlank(rs1.getString("TOTAL_MARK")))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("NOT_FIT_CNT1"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("NOT_FIT_CNT2"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("NOT_FIT_YN"))%></TD>                    	
                    </TR>
                    <TR>
                    	<TH style="TEXT-ALIGN: center">테마관리</TH>
                    	<TD style="TEXT-ALIGN: left" COLSPAN="8"><%=nullToBlank(rs1.getString("THEME_MGMT"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>                    
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>3. 점검결과 누계</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 9%">
                    <COL style="WIDTH: 10%">                    
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center" colspan="4">사업장기준</TH>
                        <TH style="TEXT-ALIGN: center" colspan="3">실무담당자(부적합누적)</TH>
                        <TH style="TEXT-ALIGN: center" colspan="4" style="border-right:1px solid #9ea2a8">점장</TH>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center" colspan="4">평가기간 : <%=nullToBlank(rs2.getString("UPJANG_DATE"))%></TH>
                        <TH style="TEXT-ALIGN: center" colspan="7" style="border-right:1px solid #9ea2a8">평가기간 : <%=nullToBlank(rs2.getString("RESP_DATE"))%></TH>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점검<br/>횟수</TH>
                        <TH style="TEXT-ALIGN: center">평균<br/>점수</TH>
                        <TH style="TEXT-ALIGN: center">등급</TH>
                        <TH style="TEXT-ALIGN: center">부적합<br/>누계</TH>
                        <TH style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP1_NM_KOR"))%></TH>
                        <TH style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP2_NM_KOR"))%></TH>
                        <TH style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP3_NM_KOR"))%></TH>
                        <TH style="TEXT-ALIGN: center">점검<br/>횟수</TH>
                        <TH style="TEXT-ALIGN: center">평균<br/>점수</TH>
                        <TH style="TEXT-ALIGN: center">등급</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">부적합<br/>누적</TH>                        
                    </TR>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("UPJANG_CHECK_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("UPJANG_AVG_SCORE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=getGrade(nullToBlank(rs2.getString("UPJANG_AVG_SCORE")))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("UPJANG_NOT_FIT_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP1_NOT_FIT_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP2_NOT_FIT_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP3_NOT_FIT_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("CHARGE_CHECK_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("CHARGE_AVG_SCORE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=getGrade(nullToBlank(rs2.getString("CHARGE_AVG_SCORE")))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("CHARGE_NOT_FIT_CNT"))%></TD>                    	
                    </TR>
                </TBODY>
            </TABLE>                    
        </DIV>  
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>4. 주요 지적사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 10%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 35%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">대분류</TH>
                        <TH style="TEXT-ALIGN: center">중분류</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">평가내용</TH>                        
                    </TR>
                    <%
                    	while(rs3.next()) {
                    %>
                    <TR>
                        <TH style="TEXT-ALIGN: left"><%=nullToBlank(rs3.getString("LRG_CLASS_NAME"))%></TH>
                    	<TD style="TEXT-ALIGN: left"><%=nullToBlank(rs3.getString("MIDDLE_CLASS_NAME"))%></TD>
                    	<TD style="TEXT-ALIGN: left"><%=nullToBlank(rs3.getString("CLASS_NAME"))%></TD>
                    	<TD style="TEXT-ALIGN: left"><%=nullToBlank(rs3.getString("EVAL_CONTENTS"))%></TD>
                    </TR>
                    <%
                    	}
                    %>                    
                </TBODY>
            </TABLE>                    
        </DIV>         
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>5. 총평 및 특이사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0 height="50">
                <COLGROUP>
                    <COL style="WIDTH: 100%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs.getString("SPECIAL_FACT")).replace("\r\n", "<br/>")%></TD>
                    </TR>
                </TBODY>
            </TABLE>                    
        </DIV>
		<DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>6. 사진첨부</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: left" style="border-right:1px solid #9ea2a8" colspan="4"><b>■ 지적사항</b></TH>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>                        
                    </TR>
                    <%
                    	int imgCnt = 0;
                    	while(rs4.next()) {
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs4.getString("CLASS_NAME"))%></TD>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs4.getString("EVAL_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        	<div style="width: 100%; height: 50px; line-height: 50px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs4.getString("SPHOTO"))%>" style="width: 100%; height: 50px; vertical-align: middle"/>
                        	</div>
                        </TD>
                    </TR>
                    <%
                    		imgCnt++;
                    	}
                    	
                    	if(imgCnt == 0)
                    	{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center" colspan="3">등록된 내용이 없습니다.</TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>                    
        </DIV> 
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: left" style="border-right:1px solid #9ea2a8" colspan="4"><b>■ 우수사항</b></TH>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>                        
                    </TR>
                    <%
                    	imgCnt = 0;
                    	while(rs5.next()) {
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs5.getString("CLASS_NAME"))%></TD>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs5.getString("EVAL_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        	<div style="width: 100%; height: 80px; line-height: 80px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs5.getString("SPHOTO"))%>" style="width: 100%; height: 80px; vertical-align: middle"/>
                        	</div>
                        </TD>
                    </TR>
                    <%
               				imgCnt++;
                		}
                	
                		if(imgCnt == 0)
                		{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center" colspan="3">등록된 내용이 없습니다.</TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>                    
        </DIV> 
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: left" style="border-right:1px solid #9ea2a8" colspan="4"><b>■ 확인사항</b></TH>                        
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>                        
                    </TR>
                    <%
                		imgCnt = 0;                    
                    	while(rs6.next()) {
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs6.getString("CLASS_NAME"))%></TD>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs6.getString("EVAL_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        	<div style="width: 100%; height: 80px; line-height: 80px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs6.getString("SPHOTO"))%>" style="width: 100%; height: 80px; vertical-align: middle"/>
                        	</div>
                        </TD>
                    </TR>
                    <%
               				imgCnt++;
                		}
                	
                		if(imgCnt == 0)
                		{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center" colspan="3">등록된 내용이 없습니다.</TD>
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

		pstmt3.close();
		rs3.close();

		pstmt4.close();
		rs4.close();

		pstmt5.close();
		rs5.close();

		pstmt6.close();
		rs6.close();
		
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
        if (rs4 != null) {
            try {
                rs4.close();
            } catch(Exception e) {}
        }
        if (pstmt4 != null) {
            try {
                pstmt4.close();
            } catch(Exception e) {}
        }        
        if (rs5 != null) {
            try {
                rs5.close();
            } catch(Exception e) {}
        }
        if (pstmt5 != null) {
            try {
                pstmt5.close();
            } catch(Exception e) {}
        }
        if (rs6 != null) {
            try {
                rs6.close();
            } catch(Exception e) {}
        }
        if (pstmt6 != null) {
            try {
                pstmt6.close();
            } catch(Exception e) {}
        }        
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>
