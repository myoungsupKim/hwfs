<%@page import="org.apache.axis.components.logger.LogFactory"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ include file = "/hwfs_svc/sc/main/common.jsp" %>
<%
  /**
   * 월 마감장 팩스발송 URL
   * @ClassName closingBooks.jsp
   * @Description closingBooks JSP
   * @Modification-Information
   *    수정일       수정자              수정내용
   *  ----------   ----------   -------------------------------
   *  2021.08.04   김명섭        최초 생성
   *  
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

    String strEncUpjang  = LimsUtil.checkNull(request.getParameter("UPJANG"));
    String strEncMonth   = LimsUtil.checkNull(request.getParameter("CLOSEMM"));
    
    if (strEncUpjang == "" || strEncMonth == "") return;
    
    String strUpjang = "";
    String strSdate = "";
    String strEdate = "";

    StringBuffer sbDecSql = new StringBuffer();
    
    sbDecSql.append("SELECT SC_CRYPTO_FUN('DEC','" + strEncUpjang + "') AS UPJANG, \n");
    sbDecSql.append("       SC_CRYPTO_FUN('DEC','" + strEncMonth + "')||'01' AS SDATE, \n");
    sbDecSql.append("       SC_CRYPTO_FUN('DEC','" + strEncMonth + "')||'31' AS EDATE \n");
    sbDecSql.append("  FROM DUAL \n");
    
    StringBuffer sbSql = new StringBuffer();

    sbSql.append("SELECT MU_CD,                                                                                                                                                                                         \n");
    sbSql.append("       MU_NM,                                                                                                                                                                                         \n");
    sbSql.append("       (SELECT ORG_LEVEL_NM3 FROM SCC_CC WHERE ORG_LEVEL_CD3 = SUBSTR(TM_CD,1,3) AND ROWNUM = 1) BU_NM,                                                                                               \n");
    sbSql.append("       TM_CD,                                                                                                                                                                                         \n");
    sbSql.append("       TM_NM,                                                                                                                                                                                         \n");
    sbSql.append("       UPJANG,                                                                                                                                                                                        \n");
    sbSql.append("       UPJANGNM,                                                                                                                                                                                      \n");
    sbSql.append("       (SELECT DECODE( COUNT(UPJANG_CD), 0 ,'Y', 'N') FROM SLA_UPJANG_SALS_DAY WHERE UPJANG_CD = A.UPJANG  AND FROM_DT <= '" + strEdate + "' AND TO_DT >= '" + strSdate + "') AS SALE_YN,     \n");
    sbSql.append("       NEW_GUBUN,                                                                                                                                                                                     \n");
    sbSql.append("       DAY_AMT4           AS DAY_AMT4,                                                                                                                                                                \n");
    sbSql.append("       DAY_TOT_AMT4       AS DAY_TOT_AMT4,                                                                                                                                                            \n");
    sbSql.append("       PLAN_MON_AMT     AS PLAN_MON_AMT                                                                                                                                                               \n");
    sbSql.append("  FROM (                                                                                                                                                                                              \n");
    sbSql.append("SELECT MU_CD,                                                                                                                                                                                         \n");
    sbSql.append("       MU_NM,                                                                                                                                                                                         \n");
    sbSql.append("       TM_CD,                                                                                                                                                                                         \n");
    sbSql.append("       TM_NM,                                                                                                                                                                                         \n");
    sbSql.append("       UPJANG,                                                                                                                                                                                        \n");
    sbSql.append("       UPJANGNM,                                                                                                                                                                                      \n");
    sbSql.append("       (SELECT CASE WHEN OPEN_DATE IS NULL THEN '미지정'                                                                                                                                              \n");
    sbSql.append("                    WHEN SUBSTR(OPEN_DATE,1,4) = SUBSTR('" + strEdate + "',1,4) THEN '신규'                                                                                                                   \n");
    sbSql.append("               ELSE '기존' END                                                                                                                                                                        \n");
    sbSql.append("          FROM SCO_UPJANG_MST_V                                                                                                                                                                       \n");
    sbSql.append("         WHERE UPJANG = T1.UPJANG) NEW_GUBUN,                                                                                                                                                         \n");
    sbSql.append("       ROUND(SUM(DAY_AMT4)/1000)         AS DAY_AMT4,                                                                                                                                                 \n");
    sbSql.append("       ROUND(SUM(DAY_TOT_AMT4)/1000)     AS DAY_TOT_AMT4,                                                                                                                                             \n");
    sbSql.append("       ROUND(SUM(PLAN_MON_AMT)/1000)     AS PLAN_MON_AMT                                                                                                                                              \n");
    sbSql.append("  FROM (                                                                                                                                                                                              \n");
    sbSql.append("SELECT MU_CD,                                                                                                                                                                                         \n");
    sbSql.append("       MU_NM,                                                                                                                                                                                         \n");
    sbSql.append("       TM_CD,                                                                                                                                                                                         \n");
    sbSql.append("       TM_NM,                                                                                                                                                                                         \n");
    sbSql.append("       UPJANG,                                                                                                                                                                                        \n");
    sbSql.append("       UPJANGNM,                                                                                                                                                                                      \n");
    sbSql.append("       0 DAY_AMT4,      --당일_당일실적                                                                                                                                                               \n");
    sbSql.append("       0 DAY_TOT_AMT4,  --당일누계_당일실적                                                                                                                                                           \n");
    sbSql.append("       CASE WHEN PRIORITY1_YN = 'Y' THEN PLAN_MON_AMT1                                                                                                                                                \n");
    sbSql.append("       ELSE PLAN_MON_AMT11 END AS  PLAN_MON_AMT  --당월_계획                                                                                                                                          \n");
    sbSql.append("  FROM (                                                                                                                                                                                              \n");
    sbSql.append("SELECT MU_CD,                                                                                                                                                                                         \n");
    sbSql.append("       MAX(MU_NM) AS MU_NM,                                                                                                                                                                           \n");
    sbSql.append("       TM_CD,                                                                                                                                                                                         \n");
    sbSql.append("       MAX(TM_NM) AS TM_NM,                                                                                                                                                                           \n");
    sbSql.append("       '' AS UPJANG,                                                                                                                                                                                  \n");
    sbSql.append("       UPJANGNM AS UPJANGNM,                                                                                                                                                                          \n");
    sbSql.append("       MAX(PRIORITY1_YN) PRIORITY1_YN,                                                                                                                                                                \n");
    sbSql.append("       MAX(PRIORITY2_YN) PRIORITY2_YN,                                                                                                                                                                \n");
    sbSql.append("       SUM(PLAN_MON_AMT1) PLAN_MON_AMT1,     --당월(1순위)                                                                                                                                            \n");
    sbSql.append("       SUM(PLAN_MON_AMT11) PLAN_MON_AMT11    --당월(2순위)                                                                                                                                            \n");
    sbSql.append("  FROM (                                                                                                                                                                                              \n");
    sbSql.append("/* 매출계획 등록 관리(식재사업부) */                                                                                                                                                                  \n");
    sbSql.append("SELECT T1.MU_CD,                                                                                                                                                                                      \n");
    sbSql.append("       MAX(T1.MU_NM) AS MU_NM,                                                                                                                                                                        \n");
    sbSql.append("       T1.TM_CD,                                                                                                                                                                                      \n");
    sbSql.append("       MAX(T1.TM_NM) AS TM_NM,                                                                                                                                                                        \n");
    sbSql.append("       '' AS UPJANG,                                                                                                                                                                                  \n");
    sbSql.append("       H.NM_KOR||'('||H.SABUN||')' AS UPJANGNM,                                                                                                                                                       \n");
    sbSql.append("       'Y' PRIORITY1_YN,                                                                                                                                                                              \n");
    sbSql.append("       ''  PRIORITY2_YN,                                                                                                                                                                              \n");
    sbSql.append("       SUM(A.SALE_AMOUNT)      PLAN_MON_AMT1,                                                                                                                                                         \n");
    sbSql.append("       SUM(0)      PLAN_MON_AMT11                                                                                                                                                                     \n");
    sbSql.append("  FROM FMB_SALE_PLAN A                                                                                                                                                                                \n");
    sbSql.append("INNER JOIN ST_UPJANG B2 ON A.MAIN_UPJANG = B2.UPJANG                                                                                                                                                  \n");
    sbSql.append("INNER JOIN SCO_UPJANG_MST_V T1 ON A.MAIN_UPJANG = T1.UPJANG                                                                                                                                           \n");
    sbSql.append("AND T1.MU_CD = '2004'                                                                                                                                                                                \n");
    sbSql.append("AND T1.UPJANG LIKE '" + strUpjang + "'||'%'                                                                                                                                                                      \n");
    sbSql.append("AND T1.CC_CD NOT IN ('317770','317780','317840','315920','318760')                                                                                                                                    \n");
    sbSql.append("INNER JOIN FMS_UPJANG Z ON 1 = 1 AND A.MAIN_UPJANG = Z.UPJANG                                                                                                                                         \n");
    sbSql.append("LEFT JOIN HR_PERSONAL H ON 1 = 1 AND A.SABUN = H.SABUN                                                                                                                                                \n");
    sbSql.append("INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1 AND B2.DEPT_ID = D.DEPT_ID                                                                                                                                       \n");
    sbSql.append(" LEFT JOIN SCC_COMMON_CODE C ON C.GROUP_CODE = 'FM0022' AND A.PART_CODE = C.CODE                                                                                                                      \n");
    sbSql.append(" WHERE A.YYYYMMDD BETWEEN '" + strSdate + "' AND '" + strEdate + "'                                                                                                                               \n");
    sbSql.append("   AND NOT EXISTS (SELECT 'x' FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'ATTACH_DEPT' AND SET1 = D.CC_CD) /* 유통영업팀제외 */                                                                          \n");
    sbSql.append(" GROUP BY T1.MU_CD, T1.TM_CD, H.NM_KOR||'('||H.SABUN||')'                                                                                                                                             \n");
    sbSql.append("UNION ALL                                                                                                                                                                                             \n");
    sbSql.append("/* 유통영업팀 */                                                                                                                                                                                      \n");
    sbSql.append("SELECT T1.MU_CD,                                                                                                                                                                                      \n");
    sbSql.append("       MAX(T1.MU_NM) AS MU_NM,                                                                                                                                                                        \n");
    sbSql.append("       T1.TM_CD,                                                                                                                                                                                      \n");
    sbSql.append("       MAX(T1.TM_NM) AS TM_NM,                                                                                                                                                                        \n");
    sbSql.append("       '' AS UPJANG,                                                                                                                                                                                  \n");
    sbSql.append("       C.CODE_NAME AS UPJANGNM,                                                                                                                                                                       \n");
    sbSql.append("       'Y' PRIORITY1_YN,                                                                                                                                                                              \n");
    sbSql.append("       ''  PRIORITY2_YN,                                                                                                                                                                              \n");
    sbSql.append("       SUM(A.SALE_AMOUNT)      PLAN_MON_AMT1,                                                                                                                                                         \n");
    sbSql.append("       SUM(0)      PLAN_MON_AMT11                                                                                                                                                                     \n");
    sbSql.append("  FROM FMB_SALE_PLAN A                                                                                                                                                                                \n");
    sbSql.append("INNER JOIN ST_UPJANG B2 ON A.MAIN_UPJANG = B2.UPJANG                                                                                                                                                  \n");
    sbSql.append("INNER JOIN SCO_UPJANG_MST_V T1 ON A.MAIN_UPJANG = T1.UPJANG                                                                                                                                           \n");
    sbSql.append("AND T1.MU_CD = '2004'                                                                                                                                                                                \n");
    sbSql.append("AND T1.UPJANG LIKE '" + strUpjang + "'||'%'                                                                                                                                                                      \n");
    sbSql.append("AND T1.CC_CD NOT IN ('317770','317780','317840','315920','318760')                                                                                                                                    \n");
    sbSql.append("INNER JOIN FMS_UPJANG Z ON 1 = 1 AND A.MAIN_UPJANG = Z.UPJANG                                                                                                                                         \n");
    sbSql.append("LEFT JOIN HR_PERSONAL H ON 1 = 1 AND A.SABUN = H.SABUN                                                                                                                                                \n");
    sbSql.append("INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1 AND B2.DEPT_ID = D.DEPT_ID                                                                                                                                       \n");
    sbSql.append(" LEFT JOIN SCC_COMMON_CODE C ON C.GROUP_CODE = 'ATTACH_DEPT' AND D.CC_CD = C.SET1                                                                                                                     \n");
    sbSql.append(" WHERE A.YYYYMMDD BETWEEN '" + strSdate + "' AND '" + strEdate + "'                                                                                                                               \n");
    sbSql.append("   AND EXISTS (SELECT 'x' FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'ATTACH_DEPT' AND SET1 = D.CC_CD) /* 유통영업팀 */                                                                                  \n");
    sbSql.append(" GROUP BY T1.MU_CD, T1.TM_CD, C.CODE_NAME                                                                                                                                                             \n");
    sbSql.append("/* 유통영업팀 */                                                                                                                                                                                      \n");
    sbSql.append("UNION ALL                                                                                                                                                                                             \n");
    sbSql.append("/* 마케터별 일계획 관리(식재사업부) */                                                                                                                                                                \n");
    sbSql.append("SELECT T1.MU_CD,                                                                                                                                                                                      \n");
    sbSql.append("       MAX(T1.MU_NM) AS MU_NM,                                                                                                                                                                        \n");
    sbSql.append("       T1.TM_CD,                                                                                                                                                                                      \n");
    sbSql.append("       MAX(T1.TM_NM) AS TM_NM,                                                                                                                                                                        \n");
    sbSql.append("       '' AS UPJANG,                                                                                                                                                                                  \n");
    sbSql.append("       H.NM_KOR||'('||H.SABUN||')' AS UPJANGNM,                                                                                                                                                       \n");
    sbSql.append("       ''  PRIORITY1_YN,                                                                                                                                                                              \n");
    sbSql.append("       'Y' PRIORITY2_YN,                                                                                                                                                                              \n");
    sbSql.append("       SUM(0),                                                                                                                                                                                        \n");
    sbSql.append("       SUM(A.DD_AMT)                                                                                                                                                                                  \n");
    sbSql.append("  FROM MAP_DAY_PLAN2 A                                                                                                                                                                                \n");
    sbSql.append("INNER JOIN ST_UPJANG B2 ON A.UPJANG = B2.UPJANG                                                                                                                                                       \n");
    sbSql.append("INNER JOIN SCO_UPJANG_MST_V T1 ON A.UPJANG = T1.UPJANG                                                                                                                                                \n");
    sbSql.append("AND T1.MU_CD = '2004'                                                                                                                                                                                \n");
    sbSql.append("AND T1.UPJANG LIKE '" + strUpjang + "'||'%'                                                                                                                                                                      \n");
    sbSql.append("AND T1.CC_CD NOT IN ('317770','317780','317840','315920','318760')                                                                                                                                    \n");
    sbSql.append("INNER JOIN FMS_UPJANG Z ON 1 = 1 AND A.UPJANG = Z.UPJANG                                                                                                                                              \n");
    sbSql.append("LEFT JOIN HR_PERSONAL H ON 1 = 1 AND A.SABUN = H.SABUN                                                                                                                                                \n");
    sbSql.append("INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1 AND B2.DEPT_ID = D.DEPT_ID                                                                                                                                       \n");
    sbSql.append(" LEFT JOIN SCC_COMMON_CODE C ON C.GROUP_CODE = 'FM0022' AND Z.PART_CODE = C.CODE                                                                                                                      \n");
    sbSql.append(" WHERE A.YMD BETWEEN '" + strSdate + "' AND '" + strEdate + "'                                                                                                                                    \n");
    sbSql.append(" GROUP BY T1.MU_CD, T1.TM_CD, H.NM_KOR||'('||H.SABUN||')'                                                                                                                                             \n");
    sbSql.append(") GROUP BY MU_CD, TM_CD, UPJANGNM                                                                                                                                                                     \n");
    sbSql.append(")                                                                                                                                                                                                     \n");
    sbSql.append("UNION ALL                                                                                                                                                                                             \n");
    sbSql.append("SELECT T1.MU_CD,                                                                                                                                                                                      \n");
    sbSql.append("       T1.MU_NM,                                                                                                                                                                                      \n");
    sbSql.append("       T1.TM_CD,                                                                                                                                                                                      \n");
    sbSql.append("       T1.TM_NM,                                                                                                                                                                                      \n");
    sbSql.append("       --TO_CHAR(T1.UPJANG),                                                                                                                                                                          \n");
    sbSql.append("       --T1.UPJANGNM,                                                                                                                                                                                 \n");
    sbSql.append("       '' AS UPJANG,                                                                                                                                                                                  \n");
    sbSql.append("       H.NM_KOR||'('||H.SABUN||')' AS UPJANGNM,                                                                                                                                                       \n");
    sbSql.append("       SUM(CASE WHEN A.TRANS_DATE = '" + strEdate + "' THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(NVL(A.SALE_PRICE, 0) * A.TRANS_QTY) ELSE 0 END), --당일_실적                                    \n");
    sbSql.append("       SUM(CASE WHEN A.TRANS_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "' THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(NVL(A.SALE_PRICE, 0) * A.TRANS_QTY) ELSE 0 END), --당일누계_실적         \n");
    sbSql.append("       0 AS PLAN_MON_AMT  --당월_계획                                                                                                                                                                 \n");
    sbSql.append("  FROM FMS_TRANSACTION_V A                                                                                                                                                                            \n");
    sbSql.append("INNER JOIN ST_UPJANG B2 ON A.TRANS_UPJANG = B2.UPJANG                                                                                                                                                 \n");
    sbSql.append("INNER JOIN SCO_UPJANG_MST_V T1 ON A.TRANS_UPJANG = T1.UPJANG                                                                                                                                          \n");
    sbSql.append("AND T1.MU_CD = '2004'                                                                                                                                                                                \n");
    sbSql.append("AND T1.UPJANG LIKE '" + strUpjang + "'||'%'                                                                                                                                                                      \n");
    sbSql.append("AND T1.CC_CD NOT IN ('317770','317780','317840','315920','318760')                                                                                                                                    \n");
    sbSql.append("INNER JOIN FMS_UPJANG Z ON 1 = 1 AND A.TRANS_UPJANG = Z.UPJANG                                                                                                                                        \n");
    sbSql.append("LEFT JOIN HR_PERSONAL H ON 1 = 1 AND Z.PART_SALES_SABUN = H.SABUN                                                                                                                                     \n");
    sbSql.append("INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1 AND B2.DEPT_ID = D.DEPT_ID                                                                                                                                       \n");
    sbSql.append(" LEFT JOIN SCC_COMMON_CODE C ON C.GROUP_CODE = 'FM0022' AND Z.PART_CODE = C.CODE --추가                                                                                                               \n");
    sbSql.append(" WHERE SUBSTR(A.SUBINV_CODE, 1, 2) = 'S1'                                                                                                                                                             \n");
    sbSql.append("   AND (A.TRANS_TYPE IN '_002' OR A.TRANS_TYPE = 'I001' )                                                                                                                                             \n");
    sbSql.append("   AND A.TRANS_DATE2 BETWEEN '" + strSdate + "' AND '" + strEdate + "'                                                                                                                                              \n");
    sbSql.append("--GROUP BY T1.MU_CD,T1.MU_NM,T1.TM_CD,T1.TM_NM,T1.UPJANG,T1.UPJANGNM                                                                                                                                  \n");
    sbSql.append("GROUP BY T1.MU_CD,T1.MU_NM,T1.TM_CD,T1.TM_NM,H.NM_KOR||'('||H.SABUN||')'                                                                                                                              \n");
    sbSql.append("UNION ALL                                                                                                                                                                                             \n");
    sbSql.append("SELECT T3.MU_CD,                                                                                                                                                                                      \n");
    sbSql.append("       T3.MU_NM,                                                                                                                                                                                      \n");
    sbSql.append("       T3.TM_CD,                                                                                                                                                                                      \n");
    sbSql.append("       T3.TM_NM,                                                                                                                                                                                      \n");
    sbSql.append("       '' AS UPJANG,                                                                                                                                                                                  \n");
    sbSql.append("       T2.CODE_NAME AS UPJANGNM,                                                                                                                                                                      \n");
    sbSql.append("       SUM(CASE WHEN T1.RELEASE_DATE = '" + strEdate + "' THEN CASE WHEN T2.CODE_NAME LIKE '%순액%' THEN T1.REAL_SALE_AMT - T1.BUY_CST ELSE T1.REAL_SALE_AMT END ELSE 0 END) AS DAY_AMT4, --당일_전년실적     \n");
    sbSql.append("       SUM(CASE WHEN T1.RELEASE_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "' THEN CASE WHEN T2.CODE_NAME LIKE '%순액%' THEN T1.REAL_SALE_AMT - T1.BUY_CST ELSE T1.REAL_SALE_AMT END ELSE 0 END) AS DAY_TOT_AMT4,\n");
    sbSql.append("       0 AS PLAN_MON_AMT  --당월_계획                                                                                                                                                                 \n");
    sbSql.append("  FROM (                                                                                                                                                                                              \n");
    sbSql.append("SELECT A.ATTACH_DEPT                                                                                                                                                                                  \n");
    sbSql.append("      ,A.BUY_CST                                                                                                                                                                                      \n");
    sbSql.append("      ,A.REAL_SALE_AMT                                                                                                                                                                                \n");
    sbSql.append("      ,A.RELEASE_DATE                                                                                                                                                                                 \n");
    sbSql.append("  FROM RELEASE_ITEM_MGMT A                                                                                                                                                                            \n");
    sbSql.append(" WHERE A.RELEASE_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "'                                                                                                                                             \n");
    sbSql.append("UNION ALL                                                                                                                                                                                             \n");
    sbSql.append("SELECT A.ATTACH_DEPT                                                                                                                                                                                  \n");
    sbSql.append("      ,-1 * B.PURCHASE_RETURN_CST AS BUY_CST                                                                                                                                                          \n");
    sbSql.append("      ,-1 * B.PURCHASE_RETURN_AMT AS REAL_SALE_AMT                                                                                                                                                    \n");
    sbSql.append("      ,TO_CHAR(B.PURCHASE_RETURN_DATE)                                                                                                                                                                \n");
    sbSql.append("  FROM RELEASE_ITEM_MGMT A, PURCHASE_RETURN_MGMT B                                                                                                                                                    \n");
    sbSql.append(" WHERE A.RELEASE_NUM = B.RELEASE_NUM                                                                                                                                                                  \n");
    sbSql.append("   AND B.PURCHASE_RETURN_DATE BETWEEN '" + strSdate + "' AND '" + strEdate + "'                                                                                                                                     \n");
    sbSql.append(") T1, SCC_COMMON_CODE T2, HLDC_SC_DEPT_V T3                                                                                                                                                           \n");
    sbSql.append(" WHERE T1.ATTACH_DEPT = T2.CODE                                                                                                                                                                       \n");
    sbSql.append("   AND T2.GROUP_CODE = 'ATTACH_DEPT'                                                                                                                                                                  \n");
    sbSql.append("   AND T2.SET1 = T3.CC_CD                                                                                                                                                                             \n");
    sbSql.append("   AND T3.MU_CD = '2004'                                                                                                                                                                             \n");
    sbSql.append("   AND T3.CC_CD NOT IN ('317770','317780','317840','315920','318760')                                                                                                                                 \n");
    sbSql.append("GROUP BY T3.MU_CD, T3.MU_NM, T3.TM_CD, T3.TM_NM, T2.CODE_NAME                                                                                                                                         \n");
    sbSql.append("/* 출고관리 */                                                                                                                                                                                        \n");
    sbSql.append(") T1                                                                                                                                                                                                  \n");
    sbSql.append("GROUP BY MU_CD,                                                                                                                                                                                       \n");
    sbSql.append("       MU_NM,                                                                                                                                                                                         \n");
    sbSql.append("       TM_CD,                                                                                                                                                                                         \n");
    sbSql.append("       TM_NM,                                                                                                                                                                                         \n");
    sbSql.append("       UPJANG,                                                                                                                                                                                        \n");
    sbSql.append("       UPJANGNM) A                                                                                                                                                                                    \n");
    
    try {

        pstmt = conn.prepareStatement(sbDecSql.toString());
        rs = pstmt.executeQuery();
        rs.next();
        
        strUpjang = rs.getString("UPJANG");
        strSdate = rs.getString("SDATE");
        strEdate = rs.getString("EDATE");

    	System.out.println("strUpjang:" + strUpjang);
    	System.out.println("strSdate:" + strSdate);
    	System.out.println("strEdate:" + strEdate);

        pstmt1 = conn.prepareStatement(sbSql.toString());
        rs1 = pstmt1.executeQuery();
    	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>마감장조회</title>
<body>
	<div id="divProcessing" style="visibility:show;" align="center">
		<div>
			<div>
				<h4>처리 중 입니다. 잠시만 기다려 주십시오.</h4>
			</div>
		</div>
	  
		<div>
			<img src="/images/cmn/processing.gif" />
		</div>
	</div> 
</body>
</html>
<%
		pstmt.close();
		rs.close();

		pstmt1.close();
		rs1.close();

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