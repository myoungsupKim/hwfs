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
   * 위생관리>위생점검관리>점검결과등록및조회
   * - 서버 scriptlet 이용 (비표준)
   * @ClassName SampleGwDraft2.jsp
   * @Description SampleGwDraft2 JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2015.03.18.   mskim        최초생성
   *  2018.09.10.   김명섭       본문타이틀변경: (업장명) 위생 점검 보고서 --> [점검구분] 업장명 - 위생 점검 보고서
   *  20210419078 - 1
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

	PreparedStatement pstmt7= null;
	ResultSet rs7 = null;

	PreparedStatement pstmt8= null;
	ResultSet rs8 = null;
	
	PreparedStatement pstmt9= null;
	ResultSet rs9 = null;

    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

    //Controller에서 전달된 Model을 얻는다.
    //RecordSet rs = (RecordSet)request.getAttribute("gwDraftInfo");

    
    String gwDraftTitle = LimsUtil.checkNull(request.getAttribute("gwDraftTitle"));
    String searchId     = LimsUtil.checkNull(request.getAttribute("gwSearchId"));
    String strFormCd    = LimsUtil.checkNull(request.getAttribute("gwStrFormCd"));
    String strUpjang    = LimsUtil.checkNull(request.getAttribute("gwStrUpjang"));		// CS, 위생
    String strCustcd    = LimsUtil.checkNull(request.getAttribute("gwStrCustcd"));		// 협력업체
    String strChkDd     = LimsUtil.checkNull(request.getAttribute("gwStrChkDd"));
    String strTableType = LimsUtil.checkNull(request.getAttribute("gwStrTableType"));
    String strCheckType = LimsUtil.checkNull(request.getAttribute("gwStrCheckType"));   // 위생
    String strCheckDate = LimsUtil.checkNull(request.getAttribute("gwStrCheckDate"));   // 위생
    String strImgRoot   = LimsUtil.checkNull(request.getAttribute("gwStrImgRoot"));		// 위생
    String strCsabun    = LimsUtil.checkNull(request.getAttribute("gwStrChargeSabun"));	// 위생
	
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> searchId = " + searchId);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strFormCd = " + strFormCd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strUpjang = " + strUpjang);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCustcd = " + strCustcd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strChkDd = " + strChkDd);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strTableType = " + strTableType);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckType = " + strCheckType);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCheckDate = " + strCheckDate);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strImgRoot = " + strImgRoot);
    //System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>> strCsabun = " + strCsabun);

    int i = 0;

    // 1. 점검정보
    StringBuffer sbSql = new StringBuffer();
    sbSql.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, TO_CHAR(TO_DATE(A.CHECK_DATE,'YYYYMMDD'), 'YYYY-MM-DD') AS CHECK_DATE		   /* 점검일자 */                                                                           \n");
    sbSql.append("    , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0041' AND A.TABLE_TYPE = CODE) AS TABLE_TYPE_NM                                                                                    \n");
    sbSql.append("    , A.TM_CD                                                                                                                                                                                         \n");
    sbSql.append("    , (SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = A.UPJANG) AS UPJANGNM                                                                                                                     \n");
    sbSql.append("    , (SELECT MAX(SC_NM) FROM HLDC_SC_SC Z WHERE SUBSTR(A.TM_CD,1,3) = Z.SC_CD)||'/'||(SELECT MAX(TM_NM) FROM HLDC_SC_DEPT_V WHERE A.TM_CD = TM_CD) AS TM_NM		 /* 운영부서 */                     \n");
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
    sbSql.append("    , A.ATTR05                                                                                                                                                                                  \n");
    sbSql.append(" FROM FSC_RESULT_MST A                                                                                                                                                                                \n");
    sbSql.append("WHERE A.TABLE_TYPE = '" + strTableType + "'                                                                                                                                                           \n");
    sbSql.append("  AND A.FORM_CD = '" + strFormCd + "'                                                                                                                                                                 \n");
    sbSql.append("  AND A.UPJANG = '" + strUpjang + "'                                                                                                                                                                  \n");
    sbSql.append("  AND A.CHECK_DATE = '" + strCheckDate + "'                                                                                                                                                               \n");

    // 2. 점검결과
    StringBuffer sbSql1 = new StringBuffer();
    sbSql1.append("SELECT SUM(DECODE(SUBSTR(A.CLASS_CD,1,2),'01',A.SCORE,0)) AS LRG_CLASS_MARK1     \n");
    sbSql1.append("     , CASE WHEN A.CHECK_DATE < '20150921' THEN                                  \n");
    sbSql1.append("                 SUM(DECODE(SUBSTR(A.CLASS_CD,1,2),'02',A.SCORE,0))              \n");
    sbSql1.append("            ELSE 0                                                               \n");
    sbSql1.append("       END AS LRG_CLASS_MARK2                                                    \n");
    sbSql1.append("     , CASE WHEN A.CHECK_DATE < '20150921' THEN                                  \n");
    sbSql1.append("                 SUM(DECODE(SUBSTR(A.CLASS_CD,1,2),'03',A.SCORE,0))              \n");
    sbSql1.append("            ELSE                                                                 \n");
    sbSql1.append("                 SUM(DECODE(SUBSTR(A.CLASS_CD,1,2),'02',A.SCORE,0))              \n");
    sbSql1.append("       END AS LRG_CLASS_MARK3                                                    \n");
    sbSql1.append("     , SUM(A.SCORE) AS TOTAL_MARK                                                \n");
    sbSql1.append("     --중점항목:불합격관리 소분류항목의 지적건수                                 \n");
    //sbSql1.append("     , SUM(DECODE(B.NOT_FIT_YN,'Y',NVL(A.INDICATE_CNT,0),0)) AS NOT_FIT_CNT1     \n");
    sbSql1.append("     , SUM(DECODE(B.MIDDLE_CLASS_CD,'01001000',NVL(A.INDICATE_CNT,0),0)) AS NOT_FIT_CNT1     \n");
    sbSql1.append("     --법규항목:관리항목 중분류에 속한 최고점이 아닌 소분류항목의 갯수           \n");
    //sbSql1.append("     , SUM(DECODE(A.MAX_YN||C.MNGM_FLAG,'NY',1,0)) AS NOT_FIT_CNT2               \n");
    sbSql1.append("     , SUM(DECODE(B.MIDDLE_CLASS_CD,'01002000',NVL(A.INDICATE_CNT,0),0)) AS NOT_FIT_CNT2     \n");
    sbSql1.append("     , DECODE(D.NOT_FIT_YN, 0, '합격', '불합격') AS NOT_FIT_YN                   \n");
    sbSql1.append("     , D.THEME_MGMT                                                              \n");
    sbSql1.append("     , D.NOT_FIT_YN AS NOT_YN                                                    \n");
    sbSql1.append("  FROM FSC_RESULT_DTL A, FSC_FORM_DTL B, FSC_CLASS_MST C                         \n");
    sbSql1.append("     , FSC_RESULT_MST D                                                          \n");
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
    sbSql1.append(" GROUP BY D.NOT_FIT_YN, D.THEME_MGMT, A.CHECK_DATE                               \n");

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
    sbSql2.append("- (SELECT COUNT(*) FROM FSC_EDULIST Z WHERE Z.EDU_SABUN = B.CHARGE_SABUN   \n");
    sbSql2.append("                                              AND Z.LV = '점장'            \n");
    sbSql2.append("                                              AND Z.EDU_APPLY_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.USE_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.EDU_DATE BETWEEN CASE WHEN SUBSTR('" + strCheckDate + "', 5, 4) < '0701' THEN \n");
    sbSql2.append("                                                                               TO_CHAR(ADD_MONTHS('" + strCheckDate + "', -12), 'YYYY') || '0701' \n");
    sbSql2.append("                                                                          ELSE \n");
    sbSql2.append("                                                                               SUBSTR('" + strCheckDate + "', 1, 4) || '0101' \n");
    sbSql2.append("                                                                      END  \n");
    sbSql2.append("                                              AND TO_CHAR(SYSDATE,'YYYYMMDD')   \n");
    sbSql2.append("      ) AS CHARGE_NOT_FIT_CNT                                              \n");
    sbSql2.append("    , B.RESP1_SABUN                                                        \n");
    sbSql2.append("    , B.RESP1_NM_KOR                                                       \n");
    sbSql2.append("    , B.RESP1_NOT_FIT_CNT                                                  \n");
    sbSql2.append("      - (SELECT COUNT(*) FROM FSC_EDULIST Z WHERE Z.EDU_SABUN = B.RESP1_SABUN \n");
    sbSql2.append("                                              AND Z.LV = '책임자1'         \n");
    sbSql2.append("                                              AND Z.EDU_APPLY_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.USE_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.EDU_DATE BETWEEN CASE WHEN SUBSTR('" + strCheckDate + "', 5, 4) < '0701' THEN \n");
    sbSql2.append("                                                                               TO_CHAR(ADD_MONTHS('" + strCheckDate + "', -12), 'YYYY') || '0701' \n");
    sbSql2.append("                                                                          ELSE \n");
    sbSql2.append("                                                                               SUBSTR('" + strCheckDate + "', 1, 4) || '0101' \n");
    sbSql2.append("                                                                      END  \n");
    sbSql2.append("                                              AND TO_CHAR(SYSDATE,'YYYYMMDD')   \n");
    sbSql2.append("      ) AS RESP1_NOT_FIT_CNT                                               \n");
    sbSql2.append("    , B.RESP2_SABUN                                                                                                                                           \n");
    sbSql2.append("    , B.RESP2_NM_KOR                                                                                                                                          \n");
    sbSql2.append("    , B.RESP2_NOT_FIT_CNT                                                                                                                                     \n");
    sbSql2.append("      - (SELECT COUNT(*) FROM FSC_EDULIST Z WHERE Z.EDU_SABUN = B.RESP2_SABUN \n");
    sbSql2.append("                                              AND Z.LV = '책임자2'         \n");
    sbSql2.append("                                              AND Z.EDU_APPLY_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.USE_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.EDU_DATE BETWEEN CASE WHEN SUBSTR('" + strCheckDate + "', 5, 4) < '0701' THEN \n");
    sbSql2.append("                                                                               TO_CHAR(ADD_MONTHS('" + strCheckDate + "', -12), 'YYYY') || '0701' \n");
    sbSql2.append("                                                                          ELSE \n");
    sbSql2.append("                                                                               SUBSTR('" + strCheckDate + "', 1, 4) || '0101' \n");
    sbSql2.append("                                                                      END  \n");
    sbSql2.append("                                              AND TO_CHAR(SYSDATE,'YYYYMMDD')   \n");
    sbSql2.append("      ) AS RESP2_NOT_FIT_CNT                                               \n");
    sbSql2.append("    , B.RESP3_SABUN                                                                                                                                           \n");
    sbSql2.append("    , B.RESP3_NM_KOR                                                                                                                                          \n");
    sbSql2.append("    , B.RESP3_NOT_FIT_CNT                                                                                                                                     \n");
    sbSql2.append("      - (SELECT COUNT(*) FROM FSC_EDULIST Z WHERE Z.EDU_SABUN = B.RESP3_SABUN \n");
    sbSql2.append("                                              AND Z.LV = '책임자3'         \n");
    sbSql2.append("                                              AND Z.EDU_APPLY_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.USE_YN = 'Y'     \n");
    sbSql2.append("                                              AND Z.EDU_DATE BETWEEN CASE WHEN SUBSTR('" + strCheckDate + "', 5, 4) < '0701' THEN \n");
    sbSql2.append("                                                                               TO_CHAR(ADD_MONTHS('" + strCheckDate + "', -12), 'YYYY') || '0701' \n");
    sbSql2.append("                                                                          ELSE \n");
    sbSql2.append("                                                                               SUBSTR('" + strCheckDate + "', 1, 4) || '0101' \n");
    sbSql2.append("                                                                      END  \n");
    sbSql2.append("                                              AND TO_CHAR(SYSDATE,'YYYYMMDD')   \n");
    sbSql2.append("      ) AS RESP3_NOT_FIT_CNT                                               \n");
    sbSql2.append("    , CASE WHEN SUBSTR('" + strCheckDate + "', 5, 4) < '0701' THEN                                                                                            \n");
    sbSql2.append("                TO_CHAR(TO_DATE(TO_CHAR(ADD_MONTHS('" + strCheckDate + "', -12), 'YYYY') || '0701'), 'YYYY.MM.DD')                                            \n");
    sbSql2.append("           ELSE                                                                                                                                               \n");
    sbSql2.append("                TO_CHAR(TO_DATE(SUBSTR('" + strCheckDate + "', 1, 4) || '0101'), 'YYYY.MM.DD')                                                                \n");
    sbSql2.append("      END || '~' || TO_CHAR(TO_DATE('" + strCheckDate + "'), 'YYYY.MM.DD') AS RESP_DATE                                                                       \n");
    sbSql2.append(" FROM (                                                                                                                                                       \n");
    sbSql2.append("       SELECT '1' AS GBN, COUNT(1) AS UPJANG_CHECK_CNT                                                                                                        \n");
    sbSql2.append("            , DECODE(SUM(A.AVG_CNT), 0, 0, ROUND(SUM(A.SCORE) / SUM(A.AVG_CNT), 1)) AS UPJANG_AVG_SCORE                                                       \n");
    sbSql2.append("            , SUM(NOT_FIT_YN) AS UPJANG_NOT_FIT_CNT                                                                                                           \n");
    sbSql2.append("         FROM (                                                                                                                                               \n");
    sbSql2.append("               SELECT UPJANG                                                                                                                                  \n");
    sbSql2.append("                    , DECODE(B.SET1, 'Y', 0, 1) AS AVG_CNT                                                                                                    \n");
    sbSql2.append("                    , DECODE(B.SET1, 'Y', 0, A.SCORE) AS SCORE                                                                                                \n");
    sbSql2.append("                    , NOT_FIT_YN                                                                                                                              \n");
    sbSql2.append("                 FROM FSC_RESULT_MST A                                                                                                                        \n");
    sbSql2.append("                    , SCC_COMMON_CODE B                                                                                                                       \n");
    sbSql2.append("                WHERE A.UPJANG = '" + strUpjang + "'                                                                                                          \n");
    //sbSql2.append("                  AND A.TABLE_TYPE = '" + strTableType + "'                                                                                                   \n");
    sbSql2.append("                  AND A.CHECK_DATE BETWEEN SUBSTR('" + strCheckDate + "', 1, 4) || '0101' AND '" + strCheckDate + "'                                          \n");
    sbSql2.append("                  AND A.CHECK_TYPE <> '002' -- 진단은 제외                                                                                                    \n");
    //2020.03.16
    sbSql2.append("                  AND A.CHECK_TYPE <> '007' -- 기획제외                                                                                                    \n");
    //2021.05.21
    sbSql2.append("                  AND A.CHECK_TYPE <> '006' -- 카페제외                                                                                                    \n");
    sbSql2.append("                  AND B.GROUP_CODE = 'FS0042'                                                                                                                 \n");
    sbSql2.append("                  AND A.CHECK_TYPE = B.CODE                                                                                                                   \n");
    sbSql2.append("              ) A                                                                                                                                             \n");
    sbSql2.append("        GROUP BY UPJANG                                                                                                                                       \n");
    sbSql2.append("      ) A                                                                                                                                                     \n");
    sbSql2.append("    , (                                                                                                                                                       \n");
    sbSql2.append("       SELECT '1' AS GBN, MAX(A.CHARGE_SABUN) AS CHARGE_SABUN                                                                                                 \n");
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
    sbSql2.append("               SELECT CASE WHEN A.CHARGE_SABUN = C.SABUN AND SABUN_TYPE = '01' THEN C.SABUN ELSE '' END AS CHARGE_SABUN                                                             \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN AND SABUN_TYPE = '01' THEN 1 ELSE 0 END AS CHARGE_CHECK_CNT                                                                \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN AND SABUN_TYPE = '01' THEN DECODE(B.SET1, 'Y', 0, 1) ELSE NULL END AS CHARGE_AVG_CNT                                          \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN AND SABUN_TYPE = '01' THEN DECODE(B.SET1, 'Y', 0, A.SCORE) ELSE NULL END AS CHARGE_SCORE                                      \n");
    sbSql2.append("                    , CASE WHEN A.CHARGE_SABUN = C.SABUN AND SABUN_TYPE = '01' THEN NOT_FIT_YN ELSE 0 END AS CHARGE_NOT_FIT_YN                                                      \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN1 = C.SABUN AND SABUN_TYPE = '02' THEN C.SABUN ELSE '' END AS RESP1_SABUN                                                               \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN1 = C.SABUN AND SABUN_TYPE = '02' THEN NOT_FIT_YN ELSE 0 END AS RESP1_NOT_FIT_YN                                                        \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN2 = C.SABUN AND SABUN_TYPE = '03' THEN C.SABUN ELSE '' END AS RESP2_SABUN                                                               \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN2 = C.SABUN AND SABUN_TYPE = '03' THEN NOT_FIT_YN ELSE 0 END AS RESP2_NOT_FIT_YN                                                        \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN3 = C.SABUN AND SABUN_TYPE = '04' THEN C.SABUN ELSE '' END AS RESP3_SABUN                                                               \n");
    sbSql2.append("                    , CASE WHEN A.RESP_SABUN3 = C.SABUN AND SABUN_TYPE = '04' THEN NOT_FIT_YN ELSE 0 END AS RESP3_NOT_FIT_YN                                                        \n");
    sbSql2.append("                 FROM FSC_RESULT_MST A                                                                                                                        \n");
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
    sbSql2.append("                                        FROM FSC_RESULT_MST                                                                                                   \n");
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
    //2020.03.16
    sbSql2.append("                  AND A.CHECK_TYPE <> '007' -- 기획제외                                                                                                    \n");
    //2021.05.21
    sbSql2.append("                  AND A.CHECK_TYPE <> '006' -- 카페제외                                                                                                    \n");
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
    sbSql2.append(" WHERE A.GBN(+) = B.GBN                                                                                                                                       \n");

    // 3. 주요지적사항
    StringBuffer sbSql3 = new StringBuffer();
    sbSql3.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD                                  \n");
    sbSql3.append("     , B.LRG_CLASS_NAME, B.MIDDLE_CLASS_NAME, B.CLASS_NAME, A.EVAL_CONTENTS, C.ORGNL_IMGE AS PHOTO                   \n");
    sbSql3.append("     , DECODE(C.SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(C.SVR_IMGE),'=','%')) AS SPHOTO   \n");
    sbSql3.append("  FROM FSC_RESULT_DTL A, FSC_FORM_DTL B, FSC_CHK_IMGE C                                             \n");
    sbSql3.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                                  \n");
    sbSql3.append("   AND A.FORM_CD = B.FORM_CD                                                                        \n");
    sbSql3.append("   AND A.CLASS_CD = B.CLASS_CD                                                                      \n");
    sbSql3.append("   AND A.TABLE_TYPE = C.TABLE_TYPE(+)                                                               \n");
    sbSql3.append("   AND A.FORM_CD = C.FORM_CD(+)                                                                     \n");
    sbSql3.append("   AND A.UPJANG = C.UPJANG(+)                                                                       \n");
    sbSql3.append("   AND A.CHECK_DATE = C.CHK_DD(+)                                                                   \n");
	sbSql3.append("   AND A.CLASS_CD = C.CLASS_CD(+)                                                                   \n");
    sbSql3.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                                        \n");
    sbSql3.append("   AND A.FORM_CD = '" + strFormCd + "'                                                              \n");
    sbSql3.append("   AND A.UPJANG = '" + strUpjang + "'                                                               \n");
    sbSql3.append("   AND A.CHECK_DATE = '" + strCheckDate + "'                                                        \n");
    sbSql3.append("   /* 최고점이 아닌 배점을 받은 항목 OR 불합격관리 소분류 항목중 지적체크된 항목 */                 \n");
    sbSql3.append("   AND (A.MAX_YN = 'N' OR (B.NOT_FIT_YN = 'Y' AND NVL(A.INDICATE_CNT,0) > 0))                       \n");
    sbSql3.append("   AND C.PHOTO_TYPE(+) = '0' /* 사진유형(0:지적,1:우수) */                                          \n");
    sbSql3.append(" ORDER BY A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM                     \n");

    // 4. 지적 이미지
    StringBuffer sbSql4 = new StringBuffer();
    sbSql4.append("SELECT A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE, A.CLASS_CD, C.SRLNUM AS SEQ                 \n");
    sbSql4.append("     , B.CLASS_NAME, A.EVAL_CONTENTS, C.ORGNL_IMGE AS PHOTO                                         \n");
    sbSql4.append("     , DECODE(C.SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(C.SVR_IMGE),'=','%')) AS SPHOTO   \n");
    sbSql4.append("  FROM FSC_RESULT_DTL A, FSC_FORM_DTL B, FSC_CHK_IMGE C                                             \n");
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
    sbSql5.append("  FROM FSC_RESULT_DTL A, FSC_FORM_DTL B, FSC_CHK_IMGE C                                             \n");
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
    sbSql6.append("     --, DECODE(C.SVR_IMGE,NULL,NULL,REPLACE(utl_encode.text_encode(C.SVR_IMGE),'=','%')) AS SPHOTO   \n");
    sbSql6.append("     , DECODE(C.SVR_IMGE,NULL,NULL,C.SVR_IMGE) AS SPHOTO   \n");
    sbSql6.append("  FROM FSC_RESULT_DTL A, FSC_FORM_DTL B, FSC_CHK_IMGE C                                             \n");
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

    // 불합격 이력 및 불합격 내역(최근 2년간) - 사업장 기준
    StringBuffer sbSql7 = new StringBuffer();
    sbSql7.append("SELECT TO_CHAR(TO_DATE(A.CHECK_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS CHECK_DATE \n");
    sbSql7.append("     , A.CHECK_TYPE \n");
	sbSql7.append("     , (SELECT CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0042' AND CODE = A.CHECK_TYPE) AS CHECK_TYPE_NM \n");
    sbSql7.append("     , A.CHARGE_SABUN \n");
    sbSql7.append("     ,(SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM \n");
    sbSql7.append("     , FSC_CHECK_NUM_FUN(A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE) || '차' AS CHECK_NUM \n");
    sbSql7.append("     , B.CLASS_CD \n");
    sbSql7.append("     , B.LRG_CLASS_CD \n");
    sbSql7.append("     , B.LRG_CLASS_NAME \n");
    sbSql7.append("     , B.MIDDLE_CLASS_CD \n");
    sbSql7.append("     , B.MIDDLE_CLASS_NAME \n");
    sbSql7.append("     , NVL(B.CLASS_NAME, A.ATTR01) AS CLASS_NAME \n");
    sbSql7.append("     , B.EVAL_CONTENTS \n");
    sbSql7.append("  FROM FSC_RESULT_MST A \n");
    sbSql7.append("     , ( \n");
    sbSql7.append("        SELECT A.TABLE_TYPE \n");
    sbSql7.append("             , A.FORM_CD \n");
    sbSql7.append("             , A.UPJANG \n");
    sbSql7.append("             , A.CHECK_DATE \n");
    sbSql7.append("             , B.LRG_CLASS_CD \n");
    sbSql7.append("             , B.LRG_CLASS_NAME \n");
    sbSql7.append("             , B.MIDDLE_CLASS_CD \n");
    sbSql7.append("             , B.MIDDLE_CLASS_NAME \n");
    sbSql7.append("             , A.CLASS_CD \n");
    sbSql7.append("             , B.CLASS_NAME \n");
    sbSql7.append("             , A.EVAL_CONTENTS \n");
    sbSql7.append("          FROM FSC_RESULT_DTL A \n");
    sbSql7.append("             , FSC_FORM_DTL B \n");
    sbSql7.append("         WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
    sbSql7.append("           AND A.FORM_CD = B.FORM_CD \n");
    sbSql7.append("           AND A.CLASS_CD = B.CLASS_CD \n");
    sbSql7.append("           AND A.UPJANG = " + strUpjang + " \n");
    sbSql7.append("           AND A.NOT_FIT_CNT > 0 \n");
    sbSql7.append("           AND A.CHECK_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strCheckDate + "', 'YYYYMMDD'), -12), 'YYYY') || '0101' AND TO_CHAR(TO_DATE('" + strCheckDate + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
    sbSql7.append("       ) B \n");
    sbSql7.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE(+) \n");
    sbSql7.append("   AND A.FORM_CD = B.FORM_CD(+) \n");
    sbSql7.append("   AND A.UPJANG = B.UPJANG(+) \n");
    sbSql7.append("   AND A.CHECK_DATE = B.CHECK_DATE(+) \n");
    sbSql7.append("   AND A.UPJANG = " + strUpjang + " \n");
    sbSql7.append("   AND A.CHECK_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strCheckDate + "', 'YYYYMMDD'), -12), 'YYYY') || '0101' AND TO_CHAR(TO_DATE('" + strCheckDate + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
    sbSql7.append("   AND A.NOT_FIT_YN = 1 \n");
    sbSql7.append("   AND A.CHECK_TYPE IN('001', '004') \n");
    sbSql7.append(" ORDER BY A.CHECK_DATE, B.LRG_CLASS_CD, B.MIDDLE_CLASS_CD, B.CLASS_CD \n");

    // 불합격 이력 및 불합격 내역(최근 2년간) - 점장 기준
    StringBuffer sbSql8 = new StringBuffer();
    sbSql8.append("SELECT TO_CHAR(TO_DATE(A.CHECK_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS CHECK_DATE \n");
    sbSql8.append("     , A.UPJANG \n");
    sbSql8.append("     , (SELECT UPJANGNM FROM ST_UPJANG U WHERE U.UPJANG = A.UPJANG) AS UPJANGNM \n");
    sbSql8.append("     , A.CHARGE_SABUN \n");
    sbSql8.append("     ,(SELECT NM_KOR FROM HLDC_HR_PERSONAL WHERE SABUN =  A.CHARGE_SABUN) AS CHARGE_NM \n");
    sbSql8.append("     , FSC_CHECK_NUM_FUN(A.TABLE_TYPE, A.FORM_CD, A.UPJANG, A.CHECK_DATE) || '차' AS CHECK_NUM \n");
    sbSql8.append("     , B.CLASS_CD \n");
    sbSql8.append("     , B.LRG_CLASS_CD \n");
    sbSql8.append("     , B.LRG_CLASS_NAME \n");
    sbSql8.append("     , B.MIDDLE_CLASS_CD \n");
    sbSql8.append("     , B.MIDDLE_CLASS_NAME \n");
    sbSql8.append("     , NVL(B.CLASS_NAME, A.ATTR01) AS CLASS_NAME \n");
    sbSql8.append("     , B.EVAL_CONTENTS \n");
    sbSql8.append("  FROM FSC_RESULT_MST A \n");
    sbSql8.append("     , ( \n");
    sbSql8.append("        SELECT A.TABLE_TYPE \n");
    sbSql8.append("             , A.FORM_CD \n");
    sbSql8.append("             , A.UPJANG \n");
    sbSql8.append("             , A.CHECK_DATE \n");
    sbSql8.append("             , B.LRG_CLASS_CD \n");
    sbSql8.append("             , B.LRG_CLASS_NAME \n");
    sbSql8.append("             , B.MIDDLE_CLASS_CD \n");
    sbSql8.append("             , B.MIDDLE_CLASS_NAME \n");
    sbSql8.append("             , A.CLASS_CD \n");
    sbSql8.append("             , B.CLASS_NAME \n");
    sbSql8.append("             , A.EVAL_CONTENTS \n");
    sbSql8.append("          FROM FSC_RESULT_DTL A \n");
    sbSql8.append("             , FSC_FORM_DTL B \n");
    sbSql8.append("         WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
    sbSql8.append("           AND A.FORM_CD = B.FORM_CD \n");
    sbSql8.append("           AND A.CLASS_CD = B.CLASS_CD \n");
    sbSql8.append("           AND A.NOT_FIT_CNT > 0 \n");
    sbSql8.append("           AND A.CHECK_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strCheckDate + "', 'YYYYMMDD'), -12), 'YYYY') || '0101' AND TO_CHAR(TO_DATE('" + strCheckDate + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
    sbSql8.append("       ) B \n");
    sbSql8.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE(+) \n");
    sbSql8.append("   AND A.FORM_CD = B.FORM_CD(+) \n");
    sbSql8.append("   AND A.UPJANG = B.UPJANG(+) \n");
    sbSql8.append("   AND A.CHECK_DATE = B.CHECK_DATE(+) \n");
    sbSql8.append("   AND A.CHARGE_SABUN = '" + strCsabun + "' \n");
    sbSql8.append("   AND A.CHECK_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strCheckDate + "', 'YYYYMMDD'), -12), 'YYYY') || '0101' AND TO_CHAR(TO_DATE('" + strCheckDate + "', 'YYYYMMDD') -1, 'YYYYMMDD') \n");
    sbSql8.append("   AND A.NOT_FIT_YN = 1 \n");
    sbSql8.append("   AND A.CHECK_TYPE IN('001', '004') \n");
    sbSql8.append(" --ORDER BY A.CHECK_DATE, B.LRG_CLASS_CD, B.MIDDLE_CLASS_CD, B.CLASS_CD \n");
    sbSql8.append("UNION ALL                                                                                        \n");
    sbSql8.append(" SELECT  TO_CHAR(TO_DATE(A.EDU_DATE, 'YYYYMMDD'), 'YYYY-MM-DD') AS DT                            \n");
    sbSql8.append("        ,TO_NUMBER(A.UPJANG)                                                                     \n");
    sbSql8.append("        ,(SELECT Z.UPJANGNM FROM ST_UPJANG Z WHERE Z.UPJANG = A.UPJANG AND Z.USE_YN = 'Y') AS UPJANGNM \n");
    sbSql8.append("        ,A.EDU_SABUN                                                                             \n");
    sbSql8.append("        ,(SELECT ZZ.NM_KOR FROM HLDC_HR_PERSONAL ZZ WHERE ZZ.SABUN =  A.EDU_SABUN) AS CHARGE_NM  \n");
    sbSql8.append("        ,'-1점' AS CHECK_NUM                                                                     \n");
    sbSql8.append("        ,NULL AS CLASS_CD                                                                        \n");
    sbSql8.append("        ,NULL AS LRG_CLASS_CD                                                                    \n");
    sbSql8.append("        ,NULL AS LRG_CLASS_NAME                                                                  \n");
    sbSql8.append("        ,NULL AS MIDDLE_CLASS_CD                                                                 \n");
    sbSql8.append("        ,NULL AS MIDDLE_CLASS_NAME                                                               \n");
    sbSql8.append("        ,'특별교육이수' AS CLASS_NAME                                                                      \n");
    sbSql8.append("        ,NULL AS EVAL_CONTENTS                                                                   \n");
    sbSql8.append("  FROM FSC_EDULIST A                                                                             \n");
    sbSql8.append(" WHERE A.EDU_SABUN = '" + strCsabun + "'                                                                 \n");
    sbSql8.append("   AND A.USE_YN = 'Y'                                                                            \n");
    sbSql8.append("   AND A.EDU_APPLY_YN = 'Y'                                                                            \n");
    sbSql8.append("   AND A.EDU_DATE BETWEEN TO_CHAR(ADD_MONTHS(SYSDATE,-24),'YYYYMMDD') AND TO_CHAR(SYSDATE,'YYYYMMDD') \n");
    sbSql8.append("   ORDER BY CHECK_DATE                                                                          \n");    

    // 일반관리항목 관리이력
    StringBuffer sbSql9 = new StringBuffer();
    sbSql9.append("WITH AF_NUM AS \n");
    sbSql9.append("( \n");
    sbSql9.append("SELECT '전 차수'  AS GBN \n");
    sbSql9.append("     , MAX(CHECK_DATE) AS CHECK_DATE \n");
    sbSql9.append("     , MAX(MARK_1) AS MARK_1 \n");
    sbSql9.append("     , MAX(SCORE_1) AS SCORE_1 \n");
    sbSql9.append("     , MAX(MARK_2) AS MARK_2 \n");
    sbSql9.append("     , MAX(SCORE_2) AS SCORE_2 \n");
    sbSql9.append("     , MAX(MARK_3) AS MARK_3 \n");
    sbSql9.append("     , MAX(SCORE_3) AS SCORE_3 \n");
    sbSql9.append("     , MAX(MARK_4) AS MARK_4 \n");
    sbSql9.append("     , MAX(SCORE_4) AS SCORE_4 \n");
    sbSql9.append("     , MAX(MARK_5) AS MARK_5 \n");
    sbSql9.append("     , MAX(SCORE_5) AS SCORE_5 \n");
    sbSql9.append("     , MAX(MARK_6) AS MARK_6 \n");
    sbSql9.append("     , MAX(SCORE_6) AS SCORE_6 \n");
    sbSql9.append("     , MAX(MARK_7) AS MARK_7 \n");
    sbSql9.append("     , MAX(SCORE_7) AS SCORE_7 \n");
    sbSql9.append("     , MAX(TOTAL_SCORE) AS TOTAL_SCORE \n");
    sbSql9.append("  FROM ( \n");
    sbSql9.append("        SELECT '' AS CHECK_DATE, 0 AS MARK_1 , 0 AS SCORE_1, 0 AS MARK_2, 0 AS SCORE_2 \n");
    sbSql9.append("             , 0 AS MARK_3, 0 AS SCORE_3, 0 AS MARK_4, 0 AS SCORE_4, 0 AS MARK_5 \n");
    sbSql9.append("             , 0 AS SCORE_5, 0 AS MARK_6, 0 AS SCORE_6, 0 AS MARK_7, 0 AS SCORE_7 \n");
    sbSql9.append("             , 0 AS TOTAL_SCORE \n");
    sbSql9.append("          FROM DUAL \n");
    sbSql9.append("         UNION ALL \n");
    sbSql9.append("        SELECT DECODE(MAX(D.CHECK_DATE), '', '', '(' || SUBSTR(MAX(D.CHECK_DATE), 3, 2) || '.' || SUBSTR(MAX(D.CHECK_DATE), 5, 2) || '.' || SUBSTR(MAX(D.CHECK_DATE), 7, 2) || ')') AS CHECK_DATE \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01004' THEN B.MARK_1 ELSE 0 END) AS MARK_1 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01004' THEN A.SCORE ELSE 0 END) AS SCORE_1 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01005' THEN B.MARK_1 ELSE 0 END) AS MARK_2 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01005' THEN A.SCORE ELSE 0 END) AS SCORE_2 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01006' THEN B.MARK_1 ELSE 0 END) AS MARK_3 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01006' THEN A.SCORE ELSE 0 END) AS SCORE_3 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01007' THEN B.MARK_1 ELSE 0 END) AS MARK_4 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01007' THEN A.SCORE ELSE 0 END) AS SCORE_4 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01008' THEN B.MARK_1 ELSE 0 END) AS MARK_5 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01008' THEN A.SCORE ELSE 0 END) AS SCORE_5 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01009' THEN B.MARK_1 ELSE 0 END) AS MARK_6 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01009' THEN A.SCORE ELSE 0 END) AS SCORE_6 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01010' THEN B.MARK_1 ELSE 0 END) AS MARK_7 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01010' THEN A.SCORE ELSE 0 END) AS SCORE_7 \n");
    sbSql9.append("             , SUM(A.SCORE) AS TOTAL_SCORE \n");
    sbSql9.append("          FROM FSC_RESULT_DTL A \n");
    sbSql9.append("             , FSC_FORM_DTL B \n");
    sbSql9.append("             , FSC_CLASS_MST C \n");
    sbSql9.append("             , FSC_RESULT_MST D \n");
    sbSql9.append("         WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
    sbSql9.append("           AND A.FORM_CD = B.FORM_CD \n");
    sbSql9.append("           AND A.CLASS_CD = B.CLASS_CD \n");
    sbSql9.append("           AND A.TABLE_TYPE = C.TABLE_TYPE \n");
    sbSql9.append("           AND A.FORM_CD = C.FORM_CD \n");
    sbSql9.append("           AND SUBSTR(A.CLASS_CD, 1, 5)||'000' = C.CLASS_CD \n");
    sbSql9.append("           AND A.TABLE_TYPE = D.TABLE_TYPE \n");
    sbSql9.append("           AND A.FORM_CD = D.FORM_CD \n");
    sbSql9.append("           AND A.UPJANG = D.UPJANG \n");
    sbSql9.append("           AND A.CHECK_DATE = D.CHECK_DATE \n");
    sbSql9.append("           AND A.TABLE_TYPE = '" + strTableType + "' \n");
    sbSql9.append("           AND A.UPJANG = " + strUpjang + " \n");
    sbSql9.append("           AND D.CHECK_TYPE = '001' \n");
    sbSql9.append("           AND A.CHECK_DATE = (SELECT MAX(CHECK_DATE) \n");
    sbSql9.append("                                         FROM FSC_RESULT_MST \n");
    sbSql9.append("                                        WHERE TABLE_TYPE = '" + strTableType + "' \n");
    sbSql9.append("                                          AND CHECK_TYPE = '001' \n");
    sbSql9.append("                                          AND UPJANG = " + strUpjang + " \n");
    sbSql9.append("                                          AND CHECK_DATE < '" + strCheckDate + "') \n");
    sbSql9.append("       ) \n");
    sbSql9.append(") \n");
    sbSql9.append(", BF_NUM AS \n");
    sbSql9.append("( \n");
    sbSql9.append("SELECT '당 차수'  AS GBN \n");
    sbSql9.append("     , MAX(CHECK_DATE) AS CHECK_DATE \n");
    sbSql9.append("     , MAX(MARK_1) AS MARK_1 \n");
    sbSql9.append("     , MAX(SCORE_1) AS SCORE_1 \n");
    sbSql9.append("     , MAX(MARK_2) AS MARK_2 \n");
    sbSql9.append("     , MAX(SCORE_2) AS SCORE_2 \n");
    sbSql9.append("     , MAX(MARK_3) AS MARK_3 \n");
    sbSql9.append("     , MAX(SCORE_3) AS SCORE_3 \n");
    sbSql9.append("     , MAX(MARK_4) AS MARK_4 \n");
    sbSql9.append("     , MAX(SCORE_4) AS SCORE_4 \n");
    sbSql9.append("     , MAX(MARK_5) AS MARK_5 \n");
    sbSql9.append("     , MAX(SCORE_5) AS SCORE_5 \n");
    sbSql9.append("     , MAX(MARK_6) AS MARK_6 \n");
    sbSql9.append("     , MAX(SCORE_6) AS SCORE_6 \n");
    sbSql9.append("     , MAX(MARK_7) AS MARK_7 \n");
    sbSql9.append("     , MAX(SCORE_7) AS SCORE_7 \n");
    sbSql9.append("     , MAX(TOTAL_SCORE) AS TOTAL_SCORE \n");
    sbSql9.append("  FROM ( \n");
    sbSql9.append("        SELECT '' AS CHECK_DATE, 0 AS MARK_1 , 0 AS SCORE_1, 0 AS MARK_2, 0 AS SCORE_2 \n");
    sbSql9.append("             , 0 AS MARK_3, 0 AS SCORE_3, 0 AS MARK_4, 0 AS SCORE_4, 0 AS MARK_5 \n");
    sbSql9.append("             , 0 AS SCORE_5, 0 AS MARK_6, 0 AS SCORE_6, 0 AS MARK_7, 0 AS SCORE_7 \n");
    sbSql9.append("             , 0 AS TOTAL_SCORE \n");
    sbSql9.append("          FROM DUAL \n");
    sbSql9.append("         UNION ALL \n");
    sbSql9.append("        SELECT DECODE(MAX(D.CHECK_DATE), '', '', '(' || SUBSTR(MAX(D.CHECK_DATE), 3, 2) || '.' || SUBSTR(MAX(D.CHECK_DATE), 5, 2) || '.' || SUBSTR(MAX(D.CHECK_DATE), 7, 2) || ')') AS CHECK_DATE \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01004' THEN B.MARK_1 ELSE 0 END) AS MARK_1 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01004' THEN A.SCORE ELSE 0 END) AS SCORE_1 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01005' THEN B.MARK_1 ELSE 0 END) AS MARK_2 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01005' THEN A.SCORE ELSE 0 END) AS SCORE_2 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01006' THEN B.MARK_1 ELSE 0 END) AS MARK_3 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01006' THEN A.SCORE ELSE 0 END) AS SCORE_3 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01007' THEN B.MARK_1 ELSE 0 END) AS MARK_4 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01007' THEN A.SCORE ELSE 0 END) AS SCORE_4 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01008' THEN B.MARK_1 ELSE 0 END) AS MARK_5 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01008' THEN A.SCORE ELSE 0 END) AS SCORE_5 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01009' THEN B.MARK_1 ELSE 0 END) AS MARK_6 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01009' THEN A.SCORE ELSE 0 END) AS SCORE_6 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01010' THEN B.MARK_1 ELSE 0 END) AS MARK_7 \n");
    sbSql9.append("             , SUM(CASE WHEN SUBSTR(A.CLASS_CD, 0, 5) = '01010' THEN A.SCORE ELSE 0 END) AS SCORE_7 \n");
    sbSql9.append("             , SUM(A.SCORE) AS TOTAL_SCORE \n");
    sbSql9.append("          FROM FSC_RESULT_DTL A \n");
    sbSql9.append("             , FSC_FORM_DTL B \n");
    sbSql9.append("             , FSC_CLASS_MST C \n");
    sbSql9.append("             , FSC_RESULT_MST D \n");
    sbSql9.append("         WHERE A.TABLE_TYPE = B.TABLE_TYPE \n");
    sbSql9.append("           AND A.FORM_CD = B.FORM_CD \n");
    sbSql9.append("           AND A.CLASS_CD = B.CLASS_CD \n");
    sbSql9.append("           AND A.TABLE_TYPE = C.TABLE_TYPE \n");
    sbSql9.append("           AND A.FORM_CD = C.FORM_CD \n");
    sbSql9.append("           AND SUBSTR(A.CLASS_CD, 1, 5)||'000' = C.CLASS_CD \n");
    sbSql9.append("           AND A.TABLE_TYPE = D.TABLE_TYPE \n");
    sbSql9.append("           AND A.FORM_CD = D.FORM_CD \n");
    sbSql9.append("           AND A.UPJANG = D.UPJANG \n");
    sbSql9.append("           AND A.CHECK_DATE = D.CHECK_DATE \n");
    sbSql9.append("           AND A.TABLE_TYPE = '" + strTableType + "' \n");
    sbSql9.append("           AND A.UPJANG = " + strUpjang + " \n");
    sbSql9.append("           AND D.CHECK_TYPE = '001' \n");
    sbSql9.append("           AND A.CHECK_DATE = '" + strCheckDate + "' \n");
    sbSql9.append("       ) \n");
    sbSql9.append(") \n");
    sbSql9.append("SELECT GBN \n");
    sbSql9.append("     , CHECK_DATE \n");
    sbSql9.append("     , TO_CHAR(MARK_1) AS MARK_1 \n");
    sbSql9.append("     , TO_CHAR(SCORE_1) AS SCORE_1 \n");
    sbSql9.append("     , DECODE(MARK_1, 0, 0, ROUND((SCORE_1 / MARK_1) * 100, 1)) || '%' AS SCORE_RATE_1 \n");
    sbSql9.append("     , TO_CHAR(MARK_2) AS MARK_2 \n");
    sbSql9.append("     , TO_CHAR(SCORE_2) AS SCORE_2 \n");
    sbSql9.append("     , DECODE(MARK_2, 0, 0, ROUND((SCORE_2 / MARK_2) * 100, 1)) || '%' AS SCORE_RATE_2 \n");
    sbSql9.append("     , TO_CHAR(MARK_3) AS MARK_3 \n");
    sbSql9.append("     , TO_CHAR(SCORE_3) AS SCORE_3 \n");
    sbSql9.append("     , DECODE(MARK_3, 0, 0, ROUND((SCORE_3 / MARK_3) * 100, 1)) || '%' AS SCORE_RATE_3 \n");
    sbSql9.append("     , TO_CHAR(MARK_4) AS MARK_4 \n");
    sbSql9.append("     , TO_CHAR(SCORE_4) AS SCORE_4 \n");
    sbSql9.append("     , DECODE(MARK_4, 0, 0, ROUND((SCORE_4 / MARK_4) * 100, 1)) || '%' AS SCORE_RATE_4 \n");
    sbSql9.append("     , TO_CHAR(MARK_5) AS MARK_5 \n");
    sbSql9.append("     , TO_CHAR(SCORE_5) AS SCORE_5 \n");
    sbSql9.append("     , DECODE(MARK_5, 0, 0, ROUND((SCORE_5 / MARK_5) * 100, 1)) || '%' AS SCORE_RATE_5 \n");
    sbSql9.append("     , TO_CHAR(MARK_6) AS MARK_6 \n");
    sbSql9.append("     , TO_CHAR(SCORE_6) AS SCORE_6 \n");
    sbSql9.append("     , DECODE(MARK_6, 0, 0, ROUND((SCORE_6 / MARK_6) * 100, 1)) || '%' AS SCORE_RATE_6 \n");
    sbSql9.append("     , TO_CHAR(MARK_7) AS MARK_7 \n");
    sbSql9.append("     , TO_CHAR(SCORE_7) AS SCORE_7 \n");
    sbSql9.append("     , DECODE(MARK_7, 0, 0, ROUND((SCORE_7 / MARK_7) * 100, 1)) || '%' AS SCORE_RATE_7 \n");
    sbSql9.append("     , TOTAL_SCORE \n");
    sbSql9.append("  FROM AF_NUM \n");
    sbSql9.append("UNION ALL \n");
    sbSql9.append("SELECT GBN \n");
    sbSql9.append("     , CHECK_DATE \n");
    sbSql9.append("     , TO_CHAR(MARK_1) AS MARK_1 \n");
    sbSql9.append("     , TO_CHAR(SCORE_1) AS SCORE_1 \n");
    sbSql9.append("     , DECODE(MARK_1, 0, 0, ROUND((SCORE_1 / MARK_1) * 100, 1)) || '%' AS SCORE_RATE_1 \n");
    sbSql9.append("     , TO_CHAR(MARK_2) AS MARK_2 \n");
    sbSql9.append("     , TO_CHAR(SCORE_2) AS SCORE_2 \n");
    sbSql9.append("     , DECODE(MARK_2, 0, 0, ROUND((SCORE_2 / MARK_2) * 100, 1)) || '%' AS SCORE_RATE_2 \n");
    sbSql9.append("     , TO_CHAR(MARK_3) AS MARK_3 \n");
    sbSql9.append("     , TO_CHAR(SCORE_3) AS SCORE_3 \n");
    sbSql9.append("     , DECODE(MARK_3, 0, 0, ROUND((SCORE_3 / MARK_3) * 100, 1)) || '%' AS SCORE_RATE_3 \n");
    sbSql9.append("     , TO_CHAR(MARK_4) AS MARK_4 \n");
    sbSql9.append("     , TO_CHAR(SCORE_4) AS SCORE_4 \n");
    sbSql9.append("     , DECODE(MARK_4, 0, 0, ROUND((SCORE_4 / MARK_4) * 100, 1)) || '%' AS SCORE_RATE_4 \n");
    sbSql9.append("     , TO_CHAR(MARK_5) AS MARK_5 \n");
    sbSql9.append("     , TO_CHAR(SCORE_5) AS SCORE_5 \n");
    sbSql9.append("     , DECODE(MARK_5, 0, 0, ROUND((SCORE_5 / MARK_5) * 100, 1)) || '%' AS SCORE_RATE_5 \n");
    sbSql9.append("     , TO_CHAR(MARK_6) AS MARK_6 \n");
    sbSql9.append("     , TO_CHAR(SCORE_6) AS SCORE_6 \n");
    sbSql9.append("     , DECODE(MARK_6, 0, 0, ROUND((SCORE_6 / MARK_6) * 100, 1)) || '%' AS SCORE_RATE_6 \n");
    sbSql9.append("     , TO_CHAR(MARK_7) AS MARK_7 \n");
    sbSql9.append("     , TO_CHAR(SCORE_7) AS SCORE_7 \n");
    sbSql9.append("     , DECODE(MARK_7, 0, 0, ROUND((SCORE_7 / MARK_7) * 100, 1)) || '%' AS SCORE_RATE_7 \n");
    sbSql9.append("     , TOTAL_SCORE \n");
    sbSql9.append("  FROM BF_NUM \n");
    sbSql9.append("UNION ALL \n");
    sbSql9.append("SELECT '전차수 대비' AS GBN \n");
    sbSql9.append("     , '' AS CHECK_DATE \n");
    sbSql9.append("     , '' AS MARK_1 \n");
    sbSql9.append("     , '' AS SCORE_1 \n");
    sbSql9.append("     , DECODE(A.MARK_1, 0, 0, ROUND((A.SCORE_1 / A.MARK_1) * 100, 1)) - DECODE(B.MARK_1, 0, 0, ROUND((B.SCORE_1 / B.MARK_1) * 100, 1)) || '%' AS SCORE_RATE_1 \n");
    sbSql9.append("     , '' AS MARK_2 \n");
    sbSql9.append("     , '' AS SCORE_2 \n");
    sbSql9.append("     , DECODE(A.MARK_2, 0, 0, ROUND((A.SCORE_2 / A.MARK_2) * 100, 1)) - DECODE(B.MARK_2, 0, 0, ROUND((B.SCORE_2 / B.MARK_2) * 100, 1)) || '%' AS SCORE_RATE_2 \n");
    sbSql9.append("     , '' AS MARK_3 \n");
    sbSql9.append("     , '' AS SCORE_3 \n");
    sbSql9.append("     , DECODE(A.MARK_3, 0, 0, ROUND((A.SCORE_3 / A.MARK_3) * 100, 1)) - DECODE(B.MARK_3, 0, 0, ROUND((B.SCORE_3 / B.MARK_3) * 100, 1)) || '%' AS SCORE_RATE_3 \n");
    sbSql9.append("     , '' AS MARK_4 \n");
    sbSql9.append("     , '' AS SCORE_4 \n");
    sbSql9.append("     , DECODE(A.MARK_4, 0, 0, ROUND((A.SCORE_4 / A.MARK_4) * 100, 1)) - DECODE(B.MARK_4, 0, 0, ROUND((B.SCORE_4 / B.MARK_4) * 100, 1)) || '%' AS SCORE_RATE_4 \n");
    sbSql9.append("     , '' AS MARK_5 \n");
    sbSql9.append("     , '' AS SCORE_5 \n");
    sbSql9.append("     , DECODE(A.MARK_5, 0, 0, ROUND((A.SCORE_5 / A.MARK_5) * 100, 1)) - DECODE(B.MARK_5, 0, 0, ROUND((B.SCORE_5 / B.MARK_5) * 100, 1)) || '%' AS SCORE_RATE_5 \n");
    sbSql9.append("     , '' AS MARK_6 \n");
    sbSql9.append("     , '' AS SCORE_6 \n");
    sbSql9.append("     , DECODE(A.MARK_6, 0, 0, ROUND((A.SCORE_6 / A.MARK_6) * 100, 1)) - DECODE(B.MARK_6, 0, 0, ROUND((B.SCORE_6 / B.MARK_6) * 100, 1)) || '%' AS SCORE_RATE_6 \n");
    sbSql9.append("     , '' AS MARK_7 \n");
    sbSql9.append("     , '' AS SCORE_7 \n");
    sbSql9.append("     , DECODE(A.MARK_7, 0, 0, ROUND((A.SCORE_7 / A.MARK_7) * 100, 1)) - DECODE(B.MARK_7, 0, 0, ROUND((B.SCORE_7 / B.MARK_7) * 100, 1)) || '%' AS SCORE_RATE_7 \n");
    sbSql9.append("     , A.TOTAL_SCORE - B.TOTAL_SCORE \n");
    sbSql9.append("  FROM BF_NUM A \n");
    sbSql9.append("     , AF_NUM B \n");

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

      pstmt7 = conn.prepareStatement(sbSql7.toString());
      rs7 = pstmt7.executeQuery();

      pstmt8 = conn.prepareStatement(sbSql8.toString());
      rs8 = pstmt8.executeQuery();

      pstmt9 = conn.prepareStatement(sbSql9.toString());
      rs9 = pstmt9.executeQuery();
%>
<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <DIV style="TEXT-ALIGN: center; margin-top:20px;">
            <SPAN STYLE="font-size:20px;"><b>[<%=nullToBlank(rs.getString("CHECK_TYPE_NM"))%>] <%=nullToBlank(rs.getString("UPJANGNM"))%> - 위생 점검 보고서 - 마트용</b></SPAN>
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
                        <TH style="TEXT-ALIGN: center">소속</TH>
                       <TH style="TEXT-ALIGN: center">점검자</TH>
                        <TH style="TEXT-ALIGN: center">점검구분</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">지도점검구분</TH>
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("UPJANGNM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_SABUN_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_TYPE_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("LEAD_CHECK_TYPE_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점장명</TH>
                        <TH style="TEXT-ALIGN: center">사업장구분</TH>
                        <TH style="TEXT-ALIGN: center">점검일자</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">점검시간</TH>
                        
                    </TR>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("ATTR05"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TABLE_TYPE_NM"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_DATE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_TIME"))%></TD>
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
                    <COL style="WIDTH: 12%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">점수합계</TH>
                        <TH style="TEXT-ALIGN: center">점검등급</TH>
                        <TH style="TEXT-ALIGN: center">중대법규</TH>
                        <TH style="TEXT-ALIGN: center">일반법규</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">불합격판정</TH>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">점수</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("TOTAL_MARK"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=getGrade(nullToBlank(rs1.getString("TOTAL_MARK")))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("NOT_FIT_CNT1"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("NOT_FIT_CNT2"))%></TD>
                        <%
                                if (Integer.parseInt(nullToZero(rs1.getString("NOT_YN"))) != 0){
                        %>
                                <TD style="TEXT-ALIGN: center"><font color = "red"><%=nullToBlank(rs1.getString("NOT_FIT_YN"))%></font></TD>
                        <%
                                } else {
                        %>
                                <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs1.getString("NOT_FIT_YN"))%></TD>
                        <%
                                }
                        %>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
      
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>3. 총평 및 특이사항</SPAN></DIV></H3>
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
        <H3><DIV class=title><SPAN>4. 주요 지적사항(사진포함)</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 7%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 31%">
                    <COL style="WIDTH: 31%">
                    <COL style="WIDTH: 18%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">대분류</TH>
                        <TH style="TEXT-ALIGN: center">중분류</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>
                    </TR>
                    <%
                    	int nCnt = 0;
                    	while(rs3.next()) {
                    		nCnt++;
                    %>
                    <TR>
                        <TH style="TEXT-ALIGN: left; HEIGHT:120px"><%=nullToBlank(rs3.getString("LRG_CLASS_NAME"))%></TH>
                    	<TD style="TEXT-ALIGN: left; HEIGHT:120px"><%=nullToBlank(rs3.getString("MIDDLE_CLASS_NAME"))%></TD>
                    	<TD style="TEXT-ALIGN: left; HEIGHT:120px"><%=nullToBlank(rs3.getString("CLASS_NAME"))%></TD>
                    	<TD style="TEXT-ALIGN: left; HEIGHT:120px"><%=nullToBlank(rs3.getString("EVAL_CONTENTS"))%></TD>
                    	<TD style="TEXT-ALIGN: center; HEIGHT:120px">
                        <%
                        	if(rs3.getString("SPHOTO") == null || rs3.getString("SPHOTO").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs3.getString("SPHOTO").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs3.getString("SPHOTO"))%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
                    		}
                        %>
                    	</TD>
                    </TR>
                    <%
                    	}
                		if(nCnt == 0)
                		{
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center" colspan="5">등록된 내용이 없습니다.</TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>
        </DIV>
		<DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>5. 우수사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 5%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                     	<TH style="TEXT-ALIGN: center">No</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>
                    </TR>
                    <%
                    	int imgCnt = 0;
                        int noCnt = 0;
                    	while(rs5.next()) {
                    		noCnt++;
                    %>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=noCnt%></TD>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs5.getString("CLASS_NAME"))%></TD>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs5.getString("EVAL_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                       		<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs5.getString("SPHOTO"))%>" style="width: 70%; height: 120px; vertical-align: middle"/>
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
                        <TD style="TEXT-ALIGN: center" colspan="4">등록된 내용이 없습니다.</TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>
        </DIV>
		<DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>6. 확인사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 5%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 30%">
                    <COL style="WIDTH: 40%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                    	<TH style="TEXT-ALIGN: center">No</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>
                    </TR>
                    <%
                		imgCnt = 0;
                        noCnt  = 0;
                    	while(rs6.next()) {
                    		noCnt++;
                    %>
                    <TR>
                    	<TD style="TEXT-ALIGN: center"><%=noCnt%></TD>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs6.getString("CLASS_NAME"))%></TD>
                        <TD style="TEXT-ALIGN: left"><%=nullToBlank(rs6.getString("EVAL_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs6.getString("SPHOTO") == null || rs6.getString("SPHOTO").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs6.getString("SPHOTO").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=nullToBlank(rs6.getString("SPHOTO"))%>" style="width: 70%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
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
                        <TD style="TEXT-ALIGN: center" colspan="4">등록된 내용이 없습니다.</TD>
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

		pstmt7.close();
		rs7.close();

		pstmt8.close();
		rs8.close();

		pstmt9.close();
		rs9.close();
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
        if (rs7 != null) {
            try {
                rs7.close();
            } catch(Exception e) {}
        }
        if (pstmt7 != null) {
            try {
                pstmt7.close();
            } catch(Exception e) {}
        }
        if (rs8 != null) {
            try {
                rs8.close();
            } catch(Exception e) {}
        }
        if (pstmt8 != null) {
            try {
                pstmt8.close();
            } catch(Exception e) {}
        }
        if (rs9 != null) {
            try {
                rs9.close();
            } catch(Exception e) {}
        }
        if (pstmt9 != null) {
            try {
                pstmt9.close();
            } catch(Exception e) {}
        }
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>