<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
<%
  /**
   * 협력업체위생관리 진단결과 상신
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
    // 1. 진단정보
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
    sbSql.append("     , A.GSCORE                                                                                                                                     \n");
    sbSql.append("     , A.TSCORE                                                                                                                                     \n");
    sbSql.append("     , A.REMARK                                                                                                                                     \n");
    sbSql.append("     , SUBSTR(A.CHK_START_TIME,1,2) || ':' || SUBSTR(A.CHK_START_TIME,3,2)AS CHK_START_TIME                                                         \n");
    sbSql.append("     , SUBSTR(A.CHK_END_TIME,1,2) || ':' || SUBSTR(A.CHK_END_TIME,3,2)AS CHK_END_TIME                                                               \n");
    sbSql.append("     , CASE WHEN SUBSTR('" + strChkDd + "', 5, 4) < '0701' THEN                                                                                     \n");
    sbSql.append("                 TO_CHAR(TO_DATE(TO_CHAR(ADD_MONTHS('" + strChkDd + "', -12), 'YYYY') || '0701'), 'YYYY.MM.DD')                                     \n");
    sbSql.append("            ELSE                                                                                                                                    \n");
    sbSql.append("                 TO_CHAR(TO_DATE(SUBSTR('" + strChkDd + "', 1, 4) || '0101'), 'YYYY.MM.DD')                                                         \n");
    sbSql.append("       END || '~' || TO_CHAR(TO_DATE('" + strChkDd + "'), 'YYYY.MM.DD') AS CHK_PERIOD                                                               \n");
    sbSql.append("  FROM FSC_PATL_RESULT A                                                                                                                            \n");
    sbSql.append("     , SCO_UPJANG_MST_V B                                                                                                                           \n");
    sbSql.append(" WHERE A.UPJANG = B.UPJANG                                                                                                                          \n");
    sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                                                                                        \n");
    sbSql.append("   AND A.UPJANG = '" + strUpjang + "'                                                                                                               \n");
    sbSql.append("   AND A.FORM_CD = '" + strFormCd + "'                                                                                                              \n");
    sbSql.append("   AND A.CHK_DD = '" + strChkDd + "'                                                                                                                \n");

    // 2. 진단결과
	StringBuffer sbSql1 = new StringBuffer();
    sbSql1.append("SELECT SUM(DECODE(SUBSTR(A.CLASS_CD,1,2), '01', A.CHK_SCORE,0)) AS LRG_CLASS_MARK1  \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2), '02', A.CHK_SCORE,0)) AS LRG_CLASS_MARK2  \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2), '03', A.CHK_SCORE,0)) AS LRG_CLASS_MARK3  \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2), '04', A.CHK_SCORE,0)) AS LRG_CLASS_MARK4  \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2), '05', A.CHK_SCORE,0)) AS LRG_CLASS_MARK5  \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2), '06', A.CHK_SCORE,0)) AS LRG_CLASS_MARK6  \n");
    sbSql1.append("     , SUM(DECODE(SUBSTR(A.CLASS_CD,1,2), '07', A.CHK_SCORE,0)) AS LRG_CLASS_MARK7  \n");
    sbSql1.append("     , CASE WHEN MAX(D.SCORE) >= 70 THEN '적합' ELSE '부적합' END AS NOT_FIT_YN          \n");
    sbSql1.append("     , CASE WHEN MAX(D.SCORE) >= 70 THEN 0 ELSE 1 END AS NOT_YN          \n");
    sbSql1.append("  FROM FSC_PATL_RESULT_DTL A                                                        \n");
    sbSql1.append("     , FSC_PATL_FORM_DTL B                                                          \n");
    sbSql1.append("     , FSC_PATL_CLASS C                                                             \n");
    sbSql1.append("     , FSC_PATL_RESULT D                                                            \n");
    sbSql1.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                  \n");
    sbSql1.append("   AND A.FORM_CD = B.FORM_CD                                                        \n");
    sbSql1.append("   AND A.CLASS_CD = B.CLASS_CD                                                      \n");
    sbSql1.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                  \n");
    sbSql1.append("   AND A.FORM_CD = C.FORM_CD                                                        \n");
    sbSql1.append("   AND SUBSTR(A.CLASS_CD,1,5)||'000' = C.CLASS_CD                                   \n");
    sbSql1.append("   AND A.TABLE_TYPE = D.TABLE_TYPE                                                  \n");
    sbSql1.append("   AND A.FORM_CD = D.FORM_CD                                                        \n");
    sbSql1.append("   AND A.UPJANG = D.UPJANG                                                          \n");
    sbSql1.append("   AND A.CHK_DD = D.CHK_DD                                                          \n");
    sbSql1.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                        \n");
    sbSql1.append("   AND A.FORM_CD = '" + strFormCd + "'                                              \n");
    sbSql1.append("   AND A.UPJANG = '" + strUpjang + "'                                               \n");
    sbSql1.append("   AND A.CHK_DD = '" + strChkDd + "'                                                \n");

    // 3. 진단결과 누계
    StringBuffer sbSql2 = new StringBuffer();
    sbSql2.append("SELECT A.UPJANG_CHECK_CNT                                                                                                                                               \n");
    sbSql2.append("     , A.UPJANG_AVG_SCORE                                                                                                                                               \n");
    sbSql2.append("     , A.UPJANG_NOT_FIT_CNT                                                                                                                                             \n");
	sbSql2.append("    , TO_CHAR(TO_DATE(SUBSTR('" + strChkDd + "', 1, 4) || '0101'), 'YYYY.MM.DD') || '~' || TO_CHAR(TO_DATE('" + strChkDd + "'), 'YYYY.MM.DD') AS UPJANG_DATE    \n");
    sbSql2.append("     , B.CHARGE_SABUN                                                                                                                                                   \n");
    sbSql2.append("     , B.CHARGE_NM_KOR                                                                                                                                                  \n");
    sbSql2.append("     , B.CHARGE_CHECK_CNT                                                                                                                                               \n");
    sbSql2.append("     , B.CHARGE_AVG_SCORE                                                                                                                                               \n");
    sbSql2.append("     , B.CHARGE_NOT_FIT_CNT                                                                                                                                             \n");
    sbSql2.append("     , B.RESP1_SABUN                                                                                                                                                    \n");
    sbSql2.append("     , B.RESP1_NM_KOR                                                                                                                                                   \n");
    sbSql2.append("     , B.RESP1_NOT_FIT_CNT                                                                                                                                              \n");
    sbSql2.append("     , B.RESP2_SABUN                                                                                                                                                    \n");
    sbSql2.append("     , B.RESP2_NM_KOR                                                                                                                                                   \n");
    sbSql2.append("     , B.RESP2_NOT_FIT_CNT                                                                                                                                              \n");
    sbSql2.append("     , B.RESP3_SABUN                                                                                                                                                    \n");
    sbSql2.append("     , B.RESP3_NM_KOR                                                                                                                                                   \n");
    sbSql2.append("     , B.RESP3_NOT_FIT_CNT                                                                                                                                              \n");
    sbSql2.append("    , CASE WHEN SUBSTR('" + strChkDd + "', 5, 4) < '0701' THEN                                                                                                      \n");
    sbSql2.append("                TO_CHAR(TO_DATE(TO_CHAR(ADD_MONTHS('" + strChkDd + "', -12), 'YYYY') || '0701'), 'YYYY.MM.DD')                                                      \n");
    sbSql2.append("           ELSE                                                                                                                                                         \n");
    sbSql2.append("                TO_CHAR(TO_DATE(SUBSTR('" + strChkDd + "', 1, 4) || '0101'), 'YYYY.MM.DD')                                                                          \n");
    sbSql2.append("      END || '~' || TO_CHAR(TO_DATE('" + strChkDd + "'), 'YYYY.MM.DD') AS RESP_DATE                                                                                 \n");
	sbSql2.append("  FROM (                                                                                                                                                                \n");
    sbSql2.append("        SELECT COUNT(1) AS UPJANG_CHECK_CNT                                                                                                                             \n");
    sbSql2.append("             , DECODE(SUM(A.AVG_CNT), 0, 0, ROUND(SUM(A.SCORE) / SUM(A.AVG_CNT), 1)) AS UPJANG_AVG_SCORE                                                                \n");
    sbSql2.append("             , SUM(NOT_FIT_YN) AS UPJANG_NOT_FIT_CNT                                                                                                                    \n");
    sbSql2.append("          FROM (                                                                                                                                                        \n");
    sbSql2.append("                SELECT UPJANG                                                                                                                                           \n");
    sbSql2.append("                     , 1 AS AVG_CNT                                                                                                                                     \n");
    sbSql2.append("                     , A.SCORE                                                                                                                                          \n");
    sbSql2.append("                     , CASE WHEN SCORE < 70 THEN 1 ELSE 0 END AS NOT_FIT_YN                                                                                             \n");
    sbSql2.append("                  FROM FSC_PATL_RESULT A                                                                                                                                \n");
    sbSql2.append("                WHERE A.UPJANG = '" + strUpjang + "'                                                                                                                    \n");
    sbSql2.append("                  AND A.TABLE_TYPE = '" + strTableType + "'                                                                                                             \n");
    sbSql2.append("                  AND A.CHK_DD BETWEEN SUBSTR('" + strChkDd + "', 1, 4) || '0101' AND '" + strChkDd + "'                                                        \n");
    sbSql2.append("               ) A                                                                                                                                                      \n");
    sbSql2.append("         GROUP BY UPJANG                                                                                                                                                \n");
    sbSql2.append("       ) A                                                                                                                                                              \n");
    sbSql2.append("     , (                                                                                                                                                                \n");
    sbSql2.append("        SELECT MAX(A.CHARGE_SABUN) AS CHARGE_SABUN                                                                                                                      \n");
    sbSql2.append("             , MAX(B.NM_KOR) AS CHARGE_NM_KOR                                                                                                                           \n");
    sbSql2.append("             , SUM(A.CHARGE_CHECK_CNT) AS CHARGE_CHECK_CNT                                                                                                              \n");
    sbSql2.append("             , DECODE(SUM(A.CHARGE_AVG_CNT), 0, 0, ROUND(SUM(A.CHARGE_SCORE) / SUM(A.CHARGE_AVG_CNT), 1)) AS CHARGE_AVG_SCORE                                           \n");
    sbSql2.append("             , SUM(A.CHARGE_NOT_FIT_YN) AS CHARGE_NOT_FIT_CNT                                                                                                           \n");
    sbSql2.append("             , MAX(A.RESP1_SABUN) AS RESP1_SABUN                                                                                                                        \n");
    sbSql2.append("             , MAX(C.NM_KOR) AS RESP1_NM_KOR                                                                                                                            \n");
    sbSql2.append("             , SUM(A.RESP1_NOT_FIT_YN) AS RESP1_NOT_FIT_CNT                                                                                                             \n");
    sbSql2.append("             , MAX(A.RESP2_SABUN) AS RESP2_SABUN                                                                                                                        \n");
    sbSql2.append("             , MAX(D.NM_KOR) AS RESP2_NM_KOR                                                                                                                            \n");
    sbSql2.append("             , SUM(A.RESP2_NOT_FIT_YN) AS RESP2_NOT_FIT_CNT                                                                                                             \n");
    sbSql2.append("             , MAX(A.RESP3_SABUN) AS RESP3_SABUN                                                                                                                        \n");
    sbSql2.append("             , MAX(E.NM_KOR) AS RESP3_NM_KOR                                                                                                                            \n");
    sbSql2.append("             , SUM(A.RESP3_NOT_FIT_YN) AS RESP3_NOT_FIT_CNT                                                                                                             \n");
    sbSql2.append("          FROM (                                                                                                                                                        \n");
    sbSql2.append("                SELECT CASE WHEN A.CHARGE_SABUN = C.SABUN THEN C.SABUN ELSE '' END AS CHARGE_SABUN                                                                      \n");
    sbSql2.append("                     , CASE WHEN A.CHARGE_SABUN = C.SABUN THEN 1 ELSE 0 END AS CHARGE_CHECK_CNT                                                                         \n");
    sbSql2.append("                     , CASE WHEN A.CHARGE_SABUN = C.SABUN THEN 1 ELSE 0 END AS CHARGE_AVG_CNT                                                                           \n");
    sbSql2.append("                     , CASE WHEN A.CHARGE_SABUN = C.SABUN THEN A.SCORE ELSE 0 END AS CHARGE_SCORE                                                                       \n");
    sbSql2.append("                     , CASE WHEN A.CHARGE_SABUN = C.SABUN AND A.SCORE < 70 THEN 1 ELSE 0 END AS CHARGE_NOT_FIT_YN                                                       \n");
    sbSql2.append("                     , CASE WHEN A.RESP_USER1 = C.SABUN THEN C.SABUN ELSE '' END AS RESP1_SABUN                                                                         \n");
    sbSql2.append("                     , CASE WHEN A.RESP_USER1 = C.SABUN AND A.SCORE < 70 THEN 1 ELSE 0 END AS RESP1_NOT_FIT_YN                                                          \n");
    sbSql2.append("                     , CASE WHEN A.RESP_USER2 = C.SABUN THEN C.SABUN ELSE '' END AS RESP2_SABUN                                                                         \n");
    sbSql2.append("                     , CASE WHEN A.RESP_USER2 = C.SABUN AND A.SCORE < 70 THEN 1 ELSE 0 END AS RESP2_NOT_FIT_YN                                                          \n");
    sbSql2.append("                     , CASE WHEN A.RESP_USER3 = C.SABUN THEN C.SABUN ELSE '' END AS RESP3_SABUN                                                                         \n");
    sbSql2.append("                     , CASE WHEN A.RESP_USER3 = C.SABUN AND A.SCORE < 70 THEN 1 ELSE 0 END AS RESP3_NOT_FIT_YN                                                          \n");
    sbSql2.append("                  FROM FSC_PATL_RESULT A                                                                                                                                \n");
    sbSql2.append("                     ,(SELECT SABUN_TYPE                                                                                                                                \n");
    sbSql2.append("                            , SABUN                                                                                                                                     \n");
    sbSql2.append("                         FROM (                                                                                                                                         \n");
    sbSql2.append("                               SELECT DECODE(lv, 1, '01', 2, '02', 3, '03', 4, '04') AS SABUN_TYPE                                                                      \n");
    sbSql2.append("                                    , DECODE(lv, 1, CHARGE_SABUN, 2, RESP_USER1, 3, RESP_USER2, 4, RESP_USER3) AS SABUN                                                 \n");
    sbSql2.append("                                 FROM (SELECT CHARGE_SABUN                                                                                                              \n");
    sbSql2.append("                                            , RESP_USER1                                                                                                                \n");
    sbSql2.append("                                            , RESP_USER2                                                                                                                \n");
    sbSql2.append("                                            , RESP_USER3                                                                                                                \n");
    sbSql2.append("                                         FROM FSC_PATL_RESULT                                                                                                           \n");
    sbSql2.append("                                       WHERE TABLE_TYPE = '" + strTableType + "'                                                                                        \n");
    sbSql2.append("                                         AND FORM_CD = '" + strFormCd + "'                                                                                              \n");
    sbSql2.append("                                         AND CHK_DD = '" + strChkDd + "'                                                                                            \n");
    sbSql2.append("                                         AND UPJANG = '" + strUpjang + "')                                                                                              \n");
    sbSql2.append("                                    , (SELECT LEVEL lv                                                                                                                  \n");
    sbSql2.append("                                         FROM DUAL                                                                                                                      \n");
    sbSql2.append("                                       CONNECT BY LEVEL <= 4)                                                                                                           \n");
    sbSql2.append("                              )                                                                                                                                         \n");
    sbSql2.append("                        WHERE SABUN IS NOT NULL                                                                                                                         \n");
    sbSql2.append("                       ) C                                                                                                                                              \n");
    sbSql2.append("                WHERE A.TABLE_TYPE = '" + strTableType + "'                                                                                                             \n");
    sbSql2.append("                  AND A.CHK_DD BETWEEN CASE WHEN SUBSTR('" + strChkDd + "', 5, 4) < '0701' THEN                                                                     \n");
    sbSql2.append("                                                     TO_CHAR(ADD_MONTHS('" + strChkDd + "', -12), 'YYYY') || '0701'                                                 \n");
    sbSql2.append("                                                ELSE                                                                                                                    \n");
    sbSql2.append("                                                     SUBSTR('" + strChkDd + "', 1, 4) || '0101'                                                                     \n");
    sbSql2.append("                                           END                                                                                                                          \n");
    sbSql2.append("                                           AND '" + strChkDd + "'                                                                                                   \n");
    sbSql2.append("                 AND A.CONFIRM_YN = 'Y'                                                                                                   \n");
    sbSql2.append("               ) A                                                                                                                                                      \n");
    sbSql2.append("             , HLDC_HR_PERSONAL B                                                                                                                                       \n");
    sbSql2.append("             , HLDC_HR_PERSONAL C                                                                                                                                       \n");
    sbSql2.append("             , HLDC_HR_PERSONAL D                                                                                                                                       \n");
    sbSql2.append("             , HLDC_HR_PERSONAL E                                                                                                                                       \n");
    sbSql2.append("         WHERE A.CHARGE_SABUN = B.SABUN(+)                                                                                                                              \n");
    sbSql2.append("           AND A.RESP1_SABUN = C.SABUN(+)                                                                                                                               \n");
    sbSql2.append("           AND A.RESP2_SABUN = D.SABUN(+)                                                                                                                               \n");
    sbSql2.append("           AND A.RESP3_SABUN = E.SABUN(+)                                                                                                                               \n");
    sbSql2.append("       ) B                                                                                                                                                              \n");

    StringBuffer sbSql3 = new StringBuffer();
    sbSql3.append("SELECT C.CLASS_CD                                                                      \n");
    sbSql3.append("     , C.CLASS_NM                                                                      \n");
    sbSql3.append("     , A.CHK_CONTENTS                                                                  \n");
    sbSql3.append("     , A.CHK_SCORE                                                                     \n");
    sbSql3.append("     , B.SVR_IMGE                                                                      \n");
    sbSql3.append("     , B.IMPROV_SVR_IMGE                                                               \n");
    sbSql3.append("     , A.IMPROV_MRMT_CONTENTS                                                          \n");
    sbSql3.append("  FROM FSC_PATL_RESULT_DTL A                                                           \n");
    sbSql3.append("     , FSC_PATL_CHK_IMGE B                                                             \n");
    sbSql3.append("     , FSC_PATL_FORM_DTL C                                                             \n");
    sbSql3.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE(+)                                                  \n");
    sbSql3.append("   AND A.FORM_CD = B.FORM_CD(+)                                                        \n");
    sbSql3.append("   AND A.UPJANG = B.UPJANG(+)                                                          \n");
    sbSql3.append("   AND A.CLASS_CD = B.CLASS_CD(+)                                                      \n");
    sbSql3.append("   AND A.CHK_DD = B.CHK_DD(+)                                                          \n");
    sbSql3.append("   AND A.TABLE_TYPE = C.TABLE_TYPE                                                     \n");
    sbSql3.append("   AND A.FORM_CD = C.FORM_CD                                                           \n");
    sbSql3.append("   AND A.CLASS_CD = C.CLASS_CD                                                         \n");
    sbSql3.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                           \n");
    sbSql3.append("   AND A.FORM_CD = '" + strFormCd + "'                                                 \n");
    sbSql3.append("   AND A.UPJANG = '" + strUpjang + "'                                                  \n");
    sbSql3.append("   AND A.CHK_DD = '" + strChkDd + "'                                                   \n");
    sbSql3.append("   AND A.IMPROV_CHECK = 'Y'                                                            \n");
    sbSql3.append(" ORDER BY C.CLASS_CD                                                                   \n");

    // 4. 주요지적사항
    StringBuffer sbSql4 = new StringBuffer();
    sbSql4.append("SELECT B.HL_CLASS_NM                                                                   \n");
    sbSql4.append("     , B.HM_CLASS_NM                                                                   \n");
    sbSql4.append("     , B.CLASS_NM                                                                      \n");
    sbSql4.append("     , A.CHK_CONTENTS                                                                  \n");
    sbSql4.append("  FROM FSC_PATL_RESULT_DTL A                                                           \n");
    sbSql4.append("     , FSC_PATL_FORM_DTL B                                                             \n");
    sbSql4.append(" WHERE A.TABLE_TYPE = B.TABLE_TYPE                                                     \n");
    sbSql4.append("   AND A.FORM_CD = B.FORM_CD                                                           \n");
    sbSql4.append("   AND A.CLASS_CD = B.CLASS_CD                                                         \n");
    sbSql4.append("   AND A.TABLE_TYPE = '" + strTableType + "'                                           \n");
    sbSql4.append("   AND A.FORM_CD = '" + strFormCd + "'                                                 \n");
    sbSql4.append("   AND A.UPJANG = '" + strUpjang + "'                                                  \n");
    sbSql4.append("   AND A.CHK_DD = '" + strChkDd + "'                                                   \n");
    sbSql4.append("   AND A.IMPROV_CHECK = 'Y'                                                            \n");

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

%>
<LINK rel=stylesheet type=text/css href="<%=propertiesService.getString("gw.server.css","")%>">
<DIV id=subContents>
    <DIV class=contents>
        <DIV style="TEXT-ALIGN: center; margin-top:20px;">
            <SPAN STYLE="font-size:20px;"><b>(<%=nullToBlank(rs.getString("UPJANGNM"))%>) CS 진단 보고서</b></SPAN>
        </DIV>
        <H3><DIV class=title><SPAN>1. 진단 정보</SPAN></DIV></H3>
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
                    <!--
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
                        <TH style="TEXT-ALIGN: center">진단구분</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHK_CLASS_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">진단자</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_SABUN_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">진단일자</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("CHK_DD"))%></TD>
                    </TR>
                     -->
                    <TR>
                        <TH style="TEXT-ALIGN: center">사업장명</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("UPJANGNM"))%></TD>
                        <TH style="TEXT-ALIGN: center">점장명</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHARGE_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">팀장/본부장</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("TEAM_MST_NM"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">소속팀</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TM_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">본부팀장</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SUBTEAM_MST_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">진단일자</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("CHK_DD"))%></TD>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">진단구분</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHK_CLASS_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">진단자</TH>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("CHECK_SABUN_NM"))%></TD>
                        <TH style="TEXT-ALIGN: center">진단시간</TH>
                        <TD style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8"><%=nullToBlank(rs.getString("CHK_START_TIME"))%>~<%=nullToBlank(rs.getString("CHK_END_TIME"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>2. 진단 결과</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 10%">
                	<COL style="WIDTH: 30%">
                	<COL style="WIDTH: 30%">
                	<COL style="WIDTH: 30%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">구분</TH>
                        <TH style="TEXT-ALIGN: center">일반관리</TH>
                        <TH style="TEXT-ALIGN: center">테마관리</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">총점(100)</TH>
                    </TR>
                    <TR>
                    	<TH style="TEXT-ALIGN: center">점수</TH>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("GSCORE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("TSCORE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs.getString("SCORE"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>3. 진단결과 누계</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 13%">
                    <COL style="WIDTH: 15%">
                    <COL style="WIDTH: 16%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center" colspan="2">사업장기준</TH>
                        <TH style="TEXT-ALIGN: center" colspan="3">실무담당자</TH>
                        <TH style="TEXT-ALIGN: center" colspan="2" style="border-right:1px solid #9ea2a8">점장</TH>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center" colspan="2">평가기간 : <%=nullToBlank(rs2.getString("UPJANG_DATE"))%></TH>
                        <TH style="TEXT-ALIGN: center" colspan="5" style="border-right:1px solid #9ea2a8">평가기간 : <%=nullToBlank(rs2.getString("RESP_DATE"))%></TH>
                    </TR>
                    <TR>
                        <TH style="TEXT-ALIGN: center">진단<br/>횟수</TH>
                        <TH style="TEXT-ALIGN: center">평균<br/>점수</TH>
                        <TH style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP1_NM_KOR"))%></TH>
                        <TH style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP2_NM_KOR"))%></TH>
                        <TH style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP3_NM_KOR"))%></TH>
                        <TH style="TEXT-ALIGN: center">진단<br/>횟수</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">평균<br/>점수</TH>
                    </TR>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("UPJANG_CHECK_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("UPJANG_AVG_SCORE"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP1_NOT_FIT_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP2_NOT_FIT_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("RESP3_NOT_FIT_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("CHARGE_CHECK_CNT"))%></TD>
                    	<TD style="TEXT-ALIGN: center"><%=nullToBlank(rs2.getString("CHARGE_AVG_SCORE"))%></TD>
                    </TR>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>4. 주요 지적사항</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1">
            <TABLE style="TABLE-LAYOUT: fixed" border=0 cellSpacing=0>
                <COLGROUP>
                	<COL style="WIDTH: 5%">
                    <COL style="WIDTH: 35%">
                    <COL style="WIDTH: 35%">
                    <COL style="WIDTH: 25%">
                </COLGROUP>
                <TBODY id=tbdArea>
                    <TR>
                        <TH style="TEXT-ALIGN: center">No</TH>
                        <TH style="TEXT-ALIGN: center">소분류</TH>
                        <TH style="TEXT-ALIGN: center">평가내용</TH>
                        <TH style="TEXT-ALIGN: center" style="border-right:1px solid #9ea2a8">사진</TH>
                    </TR>
                    <%
    	                int noCnt  = 0;
                    	while(rs3.next()) {
                    		noCnt++;
                    %>
                    <TR>
                        <TD style="TEXT-ALIGN: center"><%=noCnt%></TD>
                        <TD><%=nullToBlank(rs3.getString("CLASS_NM"))%></TD>
                        <TD><%=nullToBlank(rs3.getString("CHK_CONTENTS"))%></TD>
                        <TD style="TEXT-ALIGN: center">
                        <%
                        	if(rs3.getString("SVR_IMGE") == null || rs3.getString("SVR_IMGE").equals("")) {
                        %>
                        	미등록
                        <%
                    		} else {
                    			if(rs3.getString("SVR_IMGE").indexOf("img_NoImageBig.png") > 0) {
                        %>
                                    미등록
                        <%
                    			} else {
                        %>
                        	<div style="width: 100%; height: 120px; line-height: 120px; text-align: center">
                        	<img src="<%=strImgRoot%><%=rs3.getString("SVR_IMGE")%>" style="width: 100%; height: 120px; vertical-align: middle"/>
                        	</div>
                        <%
                    			}
                    		}
                        %>
                        </TD>
                    </TR>
                    <%
                    	}
                    %>
                </TBODY>
            </TABLE>
        </DIV>
        <DIV class=hgtSplit10></DIV>
        <H3><DIV class=title><SPAN>5. 총평</SPAN></DIV></H3>
        <DIV class="acc_table_basic style1 list">
			<TABLE border=0 cellSpacing=0>
	            <TBODY>
	                <TR>
	                    <TD height="100px" style="TEXT-ALIGN: left; vertical-align: top;"><%=nullToBlank(rs.getString("REMARK")).replace("\r\n", "<br/>")%>&nbsp;</TD>
	                </TR>
	            </TBODY>
	        </TABLE>
        </DIV>

        <DIV class=hgtSplit10></DIV>
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
        if (conn != null) {
            try {
                conn.close();
            } catch(Exception e) {}
        }
    }
%>