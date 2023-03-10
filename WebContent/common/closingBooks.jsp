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
    , com.hwfs.ls.cmn.util.LimsUtil
    , java.text.*"%>
<%

	PreparedStatement pstmt1= null;
	ResultSet rs1 = null;
	PreparedStatement pstmt2= null;
	ResultSet rs2 = null;

    ServletContext sc = pageContext.getServletContext();
    WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);

    //propertiesService Bean을 얻는다.
    PropertiesService propertiesService = (PropertiesService)wac.getBean("propertiesService");

    String strEncUpjang  = LimsUtil.checkNull(request.getParameter("UPJANG"));
    String strEncSdate   = LimsUtil.checkNull(request.getParameter("STARTYMD"));
    String strEncEdate   = LimsUtil.checkNull(request.getParameter("ENDYMD"));
    
    if (strEncUpjang == "" || strEncSdate == "" || strEncEdate == "") return;
    
    StringBuffer sbSql = new StringBuffer();

    sbSql.append("     SELECT V3.MAINUPJANG                                                                                                                                                                                                                   \n");
    sbSql.append("      	 , V3.MAINUPJANGNM                                                                                                                                                                                                                  \n"); 
    sbSql.append("      	 , MAX(V3.BIZ_NUM) AS BIZ_NUM                                                                                                                                                                                                       \n"); 
    sbSql.append("      	 , MAX(V3.TEL_NO) AS TEL_NO                                                                                                                                                                                                         \n"); 
    sbSql.append("      	 , MAX(V3.FAX_NO) AS FAX_NO                                                                                                                                                                                                         \n"); 
    sbSql.append("      	 , MAX(V3.CUST_ADDR) AS CUST_ADDR                                                                                                                                                                                                   \n"); 
    sbSql.append("      	 , MAX(V3.EMAIL) AS EMAIL                                                                                                                                                                                                 \n"); 
    sbSql.append("       	 , MAX(V3.DRNAME2) AS DRNAME2                                                                                                                                                                                                       \n");
    sbSql.append("      	 , TO_CHAR(SUM(V3.CREDIT_LIMIT),'FM999,999,999,999') AS CREDIT_LIMIT                                                                                                                                                                \n");                              
    sbSql.append("      	 , MAX(V3.PART_SALES_SABUN_NM) AS PART_SALES_SABUN_NM                                                                                                                                                                               \n"); 
    sbSql.append("      	 , TO_CHAR(TO_DATE(SC_CRYPTO_FUN('DEC','" + strEncSdate + "'),'YYYYMMDD'),'YYYY-MM-DD') AS SDATE                                                                                                                                                                               \n"); 
    sbSql.append("      	 , TO_CHAR(TO_DATE(SC_CRYPTO_FUN('DEC','" + strEncEdate + "'),'YYYYMMDD'),'YYYY-MM-DD') AS EDATE                                                                                                                                                                               \n"); 
    sbSql.append("        FROM (                                                                                                                                                                                                                              \n");
    sbSql.append("      		SELECT                                                                                                                                                                                                                            \n"); 
    sbSql.append("      			   TO_CHAR(A.MAIN_UPJANG) AS MAINUPJANG,                                                                                                                                                                                        \n"); 
    sbSql.append("      			   (SELECT UPJANGNM_DISP FROM FMS_UPJANG WHERE UPJANG = A.MAIN_UPJANG) AS MAINUPJANGNM,                                                                                                                                         \n"); 
    sbSql.append("      			   CUST_V.SAUPNO AS BIZ_NUM,                                                                                                                                                                                                    \n"); 
    sbSql.append("      		       MAX(CASE WHEN A.MAIN_UPJANG = A.UPJANG THEN REGEXP_REPLACE(SCC_CRYPTO.DEC_FUN(A.PART_SALES_TEL_NO_ENC), '[^0-9]+') ELSE ' ' END) AS TEL_NO,                                                                                  \n"); 
    sbSql.append("      		       MAX(CASE WHEN A.MAIN_UPJANG = A.UPJANG THEN REGEXP_REPLACE(SCC_CRYPTO.DEC_FUN(A.FAX_NO_ENC), '[^0-9]+') ELSE ' ' END) AS FAX_NO,                                                                                             \n"); 
    sbSql.append("      			   CUST_V.ADDR || ' ' || SCC_CRYPTO.MASKAUTH_FUN(CUST_V.DETAIL_ADDR_ENC, 10,'YYYYNNYYYYYNNNN', '0') AS CUST_ADDR,                                                                                                               \n"); 
    sbSql.append("   		   MAX(CASE WHEN A.UPJANG = A.MAIN_UPJANG THEN SCC_CRYPTO.MASKAUTH_FUN (A.EMAIL_ENC,7,'YYYYNNYYYYYNNNN', '0') ELSE ' ' END) AS EMAIL,                                                                                      \n");
    sbSql.append("   		   MAX(CASE WHEN A.UPJANG = A.MAIN_UPJANG THEN A.DRNAME2 ELSE ' ' END) AS DRNAME2,                                                                                                                                                   \n");
    sbSql.append("      			   CASE WHEN CREDIT_OVER_END < TO_CHAR(SYSDATE, 'YYYYMMDD') THEN CREDIT_AMOUNT ELSE CREDIT_AMOUNT + CREDIT_OVER_AMOUNT END AS CREDIT_LIMIT,                                                                                     \n"); 
    sbSql.append("   		   MAX(CASE WHEN A.UPJANG = A.MAIN_UPJANG THEN (SELECT SCC_CRYPTO.MASKAUTH_FUN (NM_KOR, 12, 'YYYYNNYYYYYNNNN', '0') FROM HLDC_HR_PERSONAL WHERE SABUN=A.PART_SALES_SABUN) ELSE ' ' END) AS PART_SALES_SABUN_NM                       \n");
    sbSql.append("                FROM                                                                                                                                                                                                                        \n");       
    sbSql.append("      		        FMS_UPJANG A,                                                                                                                                                                                                             \n"); 
    sbSql.append("      				ST_UPJANG S,                                                                                                                                                                                                                  \n"); 
    sbSql.append("      				HLDC_ST_UPJANG HSU,                                                                                                                                                                                                           \n"); 
    sbSql.append("      				HLDC_ST_CUST CUST_V,                                                                                                                                                                                                          \n"); 
    sbSql.append("      		        ( SELECT TO_CHAR(V.UPJANG) UPJANG, SUM(V.CREDIT_EXT_DAYS) CREDIT_EXT_DAYS                                                                                                                                                 \n"); 
    sbSql.append("      		            FROM FMS_CREDIT_EXT V                                                                                                                                                                                                 \n"); 
    sbSql.append("      		           WHERE '20210831' BETWEEN V.SUPPLY_START AND V.SUPPLY_END                                                                                                                                                               \n");
    sbSql.append("      		             AND V.APPR_YN = 'Y'                                                                                                                                                                                                  \n"); 
    sbSql.append("      		           GROUP BY V.UPJANG                                                                                                                                                                                                      \n"); 
    sbSql.append("      		        ) V2,                                                                                                                                                                                                                     \n"); 
    sbSql.append("      		        (                                                                                                                                                                                                                         \n"); 
    sbSql.append("      		        	 SELECT UPJANG                                                                                                                                                                                                          \n"); 
    sbSql.append("      		                  , MAX(PAY_GUBUN_CD) AS PAY_GUBUN_CD                                                                                                                                                                             \n"); 
    sbSql.append("      		                  , MAX(PAY_DATE) AS PAY_DATE                                                                                                                                                                                     \n"); 
    sbSql.append("      		               FROM SCO_UPJANG_CUST                                                                                                                                                                                               \n"); 
    sbSql.append("      		              GROUP BY UPJANG                                                                                                                                                                                                     \n"); 
    sbSql.append("      		        ) V3                                                                                                                                                                                                                      \n"); 
    sbSql.append("      		WHERE (A.MAIN_UPJANG IN (SC_CRYPTO_FUN('DEC','" + strEncUpjang + "')))                                                                                                                                                                                    \n");
    sbSql.append("               AND A.UPJANG = S.UPJANG                                                                                                                                                                                                      \n");    
    sbSql.append("      		  AND V2.UPJANG(+) = A.UPJANG                                                                                                                                                                                                     \n"); 
    sbSql.append("      		  AND V3.UPJANG(+) = A.UPJANG                                                                                                                                                                                                     \n"); 
    sbSql.append("      		  AND A.MAIN_UPJANG = HSU.UPJANG                                                                                                                                                                                                  \n"); 
    sbSql.append("      		  AND HSU.CUSTCD = CUST_V.CUSTCD(+)                                                                                                                                                                                               \n"); 
    sbSql.append("      		  AND INSTR(NVL(A.AR_DESC_CD, 0), 'AA') < 1                                                                                                                                                                                       \n"); 
    sbSql.append("      		  AND A.DEPT_ID IN (SELECT CC_CD                                                                                                                                                                                                  \n"); 
    sbSql.append("      		  					  FROM HLDC_SC_DEPT_V                                                                                                                                                                                                 \n"); 
    sbSql.append("      		    				 WHERE BU_CD = '2000'                                                                                                                                                                                                 \n"); 
    sbSql.append("      		        			   AND MU_CD ='2004'                                                                                                                                                                                                \n"); 
    sbSql.append("      		        			   AND TM_CD LIKE 'CI%')                                                                                                                                                                                            \n"); 
    sbSql.append("      		GROUP BY A.MAIN_UPJANG                                                                                                                                                                                                            \n"); 
    sbSql.append("      			   , CUST_V.SAUPNO                                                                                                                                                                                                              \n"); 
    sbSql.append("      			   , CUST_V.DETAIL_ADDR_ENC                                                                                                                                                                                                     \n"); 
    sbSql.append("      			   , CUST_V.ADDR                                                                                                                                                                                                                \n"); 
    sbSql.append("      			   , A.CREDIT_OVER_END                                                                                                                                                                                                          \n"); 
    sbSql.append("      			   , A.CREDIT_AMOUNT                                                                                                                                                                                                            \n"); 
    sbSql.append("      			   , A.CREDIT_OVER_AMOUNT                                                                                                                                                                                                       \n"); 
    sbSql.append("      										) V3                                                                                                                                                                                                              \n"); 
    sbSql.append("      	GROUP BY V3.MAINUPJANG                                                                                                                                                                                                              \n"); 
    sbSql.append("      	 	   , V3.MAINUPJANGNM                                                                                                                                                                                                              \n");     

    StringBuffer sbSql2 = new StringBuffer();
    sbSql2.append(" SELECT  BOND_DATE                                                                                                                                                                                                                        \n");
    sbSql2.append("       , SUBSTR(BOND_DATE, 0, 7) AS BOND_DATE2                                                                                                                                                                                            \n");
    sbSql2.append("           , DECODE(ITEM_NAME, NULL, RECEIVE_TYPE, ITEM_NAME) AS ITEM_NAME                                                                                                                                                              \n");       
    sbSql2.append("           , DECODE(ITEM_NAME, NULL, 2, 1) AS ITEM_NAME_ORDERBY                                                                                                                                                                           \n"); 
    sbSql2.append("           , UPJANGNM                                                                                                                                                                                                                     \n");
    sbSql2.append("           , TO_CHAR(SALE_AMT,'FM999,999,999,999') AS SALE_AMT                                                                                                                                                                                                                    \n"); 
    sbSql2.append("           , TO_CHAR(COLLECT_AMT,'FM999,999,999,999') AS COLLECT_AMT                                                                                                                                                                                                                 \n"); 
    sbSql2.append("           , TO_CHAR(GIMAL_AMT,'FM999,999,999,999') AS GIMAL_AMT                                                                                                                                                                                                                   \n"); 
    sbSql2.append("           , TO_CHAR(SUM(GIMAL_AMT) OVER(ORDER BY GUBN, BOND_DATE, DECODE(ITEM_NAME, NULL, 2, 1), DECODE(ITEM_NAME, NULL, RECEIVE_TYPE, ITEM_NAME) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)                                                                                                                                     \n"); 
    sbSql2.append("           + SUM(SALE_AMT) OVER(ORDER BY GUBN, BOND_DATE, DECODE(ITEM_NAME, NULL, 2, 1), DECODE(ITEM_NAME, NULL, RECEIVE_TYPE, ITEM_NAME) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)                                                                                                                                      \n"); 
    sbSql2.append("           - SUM(COLLECT_AMT) OVER(ORDER BY GUBN, BOND_DATE, DECODE(ITEM_NAME, NULL, 2, 1), DECODE(ITEM_NAME, NULL, RECEIVE_TYPE, ITEM_NAME) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),'FM999,999,999,999')  AS STOCK_BALANCE                                                                                                                 \n"); 	
    sbSql2.append("       FROM (                                                                                                                                                                                                                             \n");
    sbSql2.append("              SELECT PR_NUM                                                                                                                                                                                                               \n"); 
    sbSql2.append("            , SUBSTR(BOND_DATE,0,4)||'-'||SUBSTR(BOND_DATE,5,2)||'-'||SUBSTR(BOND_DATE,7,2) AS BOND_DATE                                                                                                                                  \n");
    sbSql2.append("            , SUM(SALE_AMT) AS SALE_AMT                                                                                                                                                                                                   \n"); 
    sbSql2.append("            , SUM(COLLECT_AMT) AS COLLECT_AMT                                                                                                                                                                                             \n"); 
    sbSql2.append("            , SUM(GIMAL_AMT) AS GIMAL_AMT                                                                                                                                                                                                 \n"); 
    sbSql2.append("            , '2' AS GUBN                                                                                                                                                                                                                 \n"); 
    sbSql2.append("            , ITEM_NAME AS ITEM_NAME                                                                                                                                                                                                      \n"); 
    sbSql2.append("            , UPJANGNM                                                                                                                                                                                                                    \n");
	sbSql2.append("            , CASE                                                                                                                                                                                                                                   \n");
	sbSql2.append("              WHEN RECEIVE_TYPE_CD = 'B02' THEN '본계좌입금'                                                                                                                                                                          \n");
	sbSql2.append("              WHEN RECEIVE_TYPE_CD = 'B10' THEN '가상계좌입금'                                                                                                                                                                       \n");
	sbSql2.append("              WHEN RECEIVE_TYPE_CD = 'B20' THEN '매출장려금'                                                                                                                                                                         \n");
	sbSql2.append("              WHEN RECEIVE_TYPE_CD = 'B21' THEN '채권채무상계'                                                                                                                                                                       \n");
	sbSql2.append("              ELSE '기타' END AS RECEIVE_TYPE                                                                                                                                                                                               \n");
    sbSql2.append("                FROM (                                                                                                                                                                                                                    \n"); 
    sbSql2.append("                         WITH TB_STOCK AS                                                                                                                                                                                                 \n"); 
    sbSql2.append("                         (                                                                                                                                                                                                                \n"); 
    sbSql2.append("                             /* 채권 */                                                                                                                                                                                                   \n");     
    sbSql2.append("                             SELECT  '' AS AR_NUM                                                                                                                                                                                         \n"); 
    sbSql2.append("                                    , Z.UPJANG                                                                                                                                                                                            \n"); 
    sbSql2.append("                                    , Z.DEPT_ID                                                                                                                                                                                           \n"); 
    sbSql2.append("                                    , SUM(Z.SALE_SUM) AS AMT                                                                                                                                                                              \n"); 
    sbSql2.append("                                    , Z.TRANS_DATE2 AS BOND_DATE                                                                                                                                                                          \n"); 
    sbSql2.append("                                    ,0 AS RCP_AMT1                                                                                                                                                                                        \n"); 
    sbSql2.append("                                    ,0 AS CURR_MACHUL                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    ,0 AS MI_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    ,0 AS DO_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    ,0 AS AK_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    , Z.PR_NUM AS PR_NUM                                                                                                                                                                                  \n"); 
    sbSql2.append("                                    , MAX(ITEM_NAME)||DECODE(SIGN(COUNT(DISTINCT ITEM_NAME) - 1), 1, ' 외 ' || TO_CHAR(COUNT(DISTINCT ITEM_NAME) - 1) || '건') AS ITEM_NAME                                                               \n");
    sbSql2.append("                                    , '' RECEIVE_TYPE_CD                                                               \n");
    sbSql2.append("                                FROM (                                                                                                                                                                                                    \n"); 
    sbSql2.append("                                         SELECT RS.TRANS_DATE                                                                                                                                                                             \n"); 
    sbSql2.append("                                               , RS.ITEM_NAME                                                                                                                                                                             \n"); 
    sbSql2.append("                                               , RS.SALE_SUM - (RS.CK_SUM + RS.JI_SUM) AS SALE_SUM		/* 매출합계 = 매출합계 - (각종 수수료금액 제외) */                                                                                   \n");
    sbSql2.append("                                               , RS.PR_NUM                                                                                                                                                                                \n"); 
    sbSql2.append("                                               , RS.UPJANG                                                                                                                                                                                \n"); 
    sbSql2.append("                                               , RS.DEPT_ID                                                                                                                                                                               \n"); 
    sbSql2.append("                                               , RS.TRANS_DATE2                                                                                                                                                                           \n"); 
    sbSql2.append("                                           FROM (                                                                                                                                                                                         \n"); 
    sbSql2.append("                                             SELECT                                                                                                                                                                                       \n"); 
    sbSql2.append("                                                   TO_CHAR(TO_DATE(X.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') TRANS_DATE                                                                                                                      \n"); 
    sbSql2.append("                                                 , X.ITEM_CODE                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , X.ITEM_NAME                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , X.ITEM_SIZE                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , X.TRANS_UOM                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , SUM(                                                                                                                                                                                   \n"); 
    sbSql2.append("                                                     CASE WHEN X.FLAG = '1' THEN                                                                                                                                                          \n"); 
    sbSql2.append("                                                         DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(X.TAX_CODE,'100',1.1,1) * ROUND(X.SALE_PRICE * X.TRANS_QTY))                                                            \n"); 
    sbSql2.append("                                                     ELSE                                                                                                                                                                                 \n"); 
    sbSql2.append("                                                         DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(X.SALE_PRICE * X.TRANS_QTY) + X.SALE_VAT                                                                                       \n"); 
    sbSql2.append("                                                     END                                                                                                                                                                                  \n"); 
    sbSql2.append("                                                     ) AS SALE_SUM                                                                                                                                                                        \n"); 
    sbSql2.append("                                                 , SUM(ROUND(X.CK_AMOUNT) + DECODE(X.TAX_CODE,100,ROUND(X.CK_AMOUNT / 10),0) * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1)) AS CK_SUM                                                    \n"); 
    sbSql2.append("                                                 , SUM(ROUND(X.JI_AMOUNT) + DECODE(X.TAX_CODE,100,ROUND(X.JI_AMOUNT / 10),0) * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1)) AS JI_SUM                                                    \n"); 
    sbSql2.append("                                                 , x.pr_num                                                                                                                                                                               \n"); 
    sbSql2.append("                                                 , X.UPJANG                                                                                                                                                                               \n"); 
    sbSql2.append("                                                 , X.DEPT_ID                                                                                                                                                                              \n"); 
    sbSql2.append("                                                 , X.TRANS_DATE2                                                                                                                                                                          \n"); 
    sbSql2.append("                                                 , X.PO_TYPE                                                                                                                                                                              \n"); 
    sbSql2.append("                                               FROM (                                                                                                                                                                                     \n"); 
    sbSql2.append("                                                         SELECT T.TRANS_DATE                                                                                                                                                              \n"); 
    sbSql2.append("                                                              , T.ITEM_CODE                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.ITEM_NAME                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.ITEM_SIZE                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.TRANS_UOM                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.TRANS_TYPE                                                                                                                                                              \n"); 
    sbSql2.append("                                                              , T.TRANS_QTY                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.SALE_PRICE                                                                                                                                                              \n"); 
    sbSql2.append("                                                              , T.TAX_CODE                                                                                                                                                                \n"); 
    sbSql2.append("                                                              , T.SALE_VAT                                                                                                                                                                \n"); 
    sbSql2.append("                                                              , T.FLAG                                                                                                                                                                    \n"); 
    sbSql2.append("                                                              , CASE WHEN NVL(T.SALE_AMOUNT, 0) = 0 THEN 0                                                                                                                                \n"); 
    sbSql2.append("                                                                   ELSE                                                                                                                                                                   \n"); 
    sbSql2.append("                                                                         CASE WHEN NVL(T.C_SALE_RATE, 0) = 0 THEN                                                                                                                         \n"); 
    sbSql2.append("                                                                             CASE WHEN NVL(T.C1_SALE_RATE, 0) = 0 THEN 0                                                                                                                  \n"); 
    sbSql2.append("                                                                             ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.C1_SALE_RATE,0) / 100)))) END			    					                                                     \n");
    sbSql2.append("                                                                         ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.C_SALE_RATE,0) / 100))))                                                                                 \n"); 
    sbSql2.append("                                                                         END                                                                                                                                                              \n"); 
    sbSql2.append("                                                                   END AS CK_AMOUNT                                                                                                                                                       \n"); 
    sbSql2.append("                                                              , CASE WHEN NVL(T.SALE_AMOUNT, 0) = 0 THEN 0                                                                                                                                \n"); 
    sbSql2.append("                                                                   ELSE                                                                                                                                                                   \n"); 
    sbSql2.append("                                                                         CASE WHEN NVL(T.J_SALE_RATE, 0) = 0 THEN                                                                                                                         \n"); 
    sbSql2.append("                                                                             CASE WHEN NVL(T.J1_SALE_RATE, 0) = 0 THEN 0                                                                                                                  \n"); 
    sbSql2.append("                                                                             ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.J1_SALE_RATE,0) / 100)))) END			    					                                                     \n");
    sbSql2.append("                                                                         ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.J_SALE_RATE,0) / 100))))                                                                                 \n"); 
    sbSql2.append("                                                                         END                                                                                                                                                              \n"); 
    sbSql2.append("                                                                 END AS JI_AMOUNT                                                                                                                                                         \n"); 
    sbSql2.append("                                                              , T.pr_num                                                                                                                                                                  \n"); 
    sbSql2.append("                                                              , T.UPJANG                                                                                                                                                                  \n"); 
    sbSql2.append("                                                              , T.DEPT_ID                                                                                                                                                                 \n"); 
    sbSql2.append("                                                              , T.TRANS_DATE2 		                                                                                                                                                         \n");
    sbSql2.append("                                                              , T.PO_TYPE		                                                                                                                                                             \n");
    sbSql2.append("                                                           FROM (                                                                                                                                                                         \n"); 
    sbSql2.append("                                                                 SELECT /*+ PUSH_PRED(A) */                                                                                                                                               \n"); 
    sbSql2.append("                                                                        A.TRANS_DATE                                                                                                                                                      \n"); 
    sbSql2.append("                                                                      , A.ITEM_CODE                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.ITEM_NAME                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.ITEM_SIZE                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.TRANS_UOM                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.TRANS_TYPE                                                                                                                                                      \n"); 
    sbSql2.append("                                                                      , A.TRANS_QTY                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , NVL(A.TRANS_MPRICE, 0) AS TRANS_MPRICE                                                                                                                            \n"); 
    sbSql2.append("                                                                      , NVL(A.TRANS_MAMOUNT, 0) AS TRANS_MAMOUNT                                                                                                                          \n"); 
    sbSql2.append("                                                                      /* , NVL(A.TRANS_MVAT, 0) AS TRANS_MVAT */                                                                                                                          \n"); 
    sbSql2.append("                                                                      , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * NVL(A.TRANS_MAMOUNT, 0)) AS TRANS_MVAT                                                                                     \n"); 
    sbSql2.append("                                                                      , CASE WHEN A.PO_TYPE IN ('71', '72') THEN 0 ELSE NVL(A.SALE_PRICE, 0) END AS SALE_PRICE                                                                                                                                \n"); 
    sbSql2.append("                                                                      , CASE WHEN A.PO_TYPE IN ('71', '72') THEN 0 ELSE NVL(A.SALE_AMOUNT, 0) END AS SALE_AMOUNT                                                                                                                              \n"); 
    sbSql2.append("                                                                      , CASE WHEN A.PO_TYPE IN ('71', '72') THEN 0 ELSE NVL(A.SALE_VAT, 0) END AS SALE_VAT                                                                                                                                    \n"); 
    sbSql2.append("                                                                      , A.TAX_CODE                                                                                                                                                        \n"); 
    sbSql2.append("                                                                      , A.FLAG                                                                                                                                                            \n"); 
    sbSql2.append("                                                                      /*검색 조건 : CK물류비제외*/                                                                                                                                        \n");          
    sbSql2.append("                                                                      , 0 AS C1_SALE_RATE								/* 분류 기준 CK 물류비율 */                                                                                                      \n");
    sbSql2.append("                                                                      , 0 AS C_SALE_RATE									/* 자재 기준 CK 물류비율 */                                                                                                      \n");
    sbSql2.append("                                                                      /*검색 조건 : 지급수수료제외*/                                                                                                                                      \n");            
    sbSql2.append("                                                                      , 0 AS J1_SALE_RATE									/* 분류 기준 지급수수료 비율 */                                                                                                \n");
    sbSql2.append("                                                                      , 0 AS J_SALE_RATE		/* 자재별 지급수수료 비율 */                                                                                                                   \n");         
    sbSql2.append("                                                                      /*검색 조건 : 장려금제외*/                                                                                                                                          \n");          
    sbSql2.append("                                                                      ,	0 AS S1_SALE_RATE									/* 분류 기준 장려금 비율 */	                                                                                                   \n");
    sbSql2.append("                                                                      , 0 AS S_SALE_RATE									/* 자재별 장려금 비율 */                                                                                                         \n");
    sbSql2.append("                                                                      , a.pr_id                                                                                                                                                           \n"); 
    sbSql2.append("                                                                      , a.pr_num                                                                                                                                                          \n"); 
    sbSql2.append("                                                                      , B2.UPJANG                                                                                                                                                         \n"); 
    sbSql2.append("                                                                      , B2.DEPT_ID                                                                                                                                                        \n"); 
    sbSql2.append("                                                                      , A.TRANS_DATE2                                                                                                                                                     \n"); 
    sbSql2.append("                                                                      , A.PO_TYPE                                                                                                                                                         \n"); 
    sbSql2.append("                                                                   FROM FMS_TRANSACTION_RTN_V A                                                                                                                                           \n"); 
    sbSql2.append("                                                                        INNER JOIN ST_UPJANG B2 ON 1 = 1                                                                                                                                  \n"); 
    sbSql2.append("                                                                        /*검색 조건 : 본사*/                                                                                                                                              \n");       
    sbSql2.append("                                                                        AND B2.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE  MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                 \n");              
    sbSql2.append("                                                                        /*검색 조건 : 사업장*/                                                                                                                                            \n");        
    sbSql2.append("                                                                        AND A.TRANS_UPJANG = B2.UPJANG																			                                                                                               \n");
    sbSql2.append("                                                                        INNER JOIN FMS_UPJANG Z ON 1 = 1                                                                                                                                  \n"); 
    sbSql2.append("                                                                        /*검색 조건 : 영업담당*/                                                                                                                                          \n");     
    sbSql2.append("                                                                        /*검색 조건 : 세부직군*/                                                                                                                                          \n");     
    sbSql2.append("                                                                        AND A.TRANS_UPJANG = Z.UPJANG                                                                                                                                     \n"); 
    sbSql2.append("                                                                        INNER JOIN HLDC_SC_DEPT_V D ON  1 = 1                                                                                                                             \n"); 
    sbSql2.append("                                                                        /*검색 조건 : 관리부서(팀)*/                                                                                                                                      \n");          
    sbSql2.append("                                                                        AND D.TM_CD LIKE 'CI%'                                                                                                                                            \n"); 
    sbSql2.append("                                                                        /*검색 조건 : CC */                                                                                                                                               \n");     
    sbSql2.append("                                                                        AND  B2.DEPT_ID = D.DEPT_ID                                                                                                                                       \n"); 
    sbSql2.append("                                                                   WHERE (SUBSTR(A.SUBINV_CODE, 1, 2) = 'S1' )                                                                                                                            \n");
    sbSql2.append("                                                                     AND (A.TRANS_TYPE IN '_002' OR A.TRANS_TYPE = 'I001' )                                                                                                               \n"); 
    sbSql2.append("                                                                     /*검색 조건 : 기간*/                                                                                                                                                 \n");       
    sbSql2.append("                                                                     AND A.TRANS_DATE2 BETWEEN SC_CRYPTO_FUN('DEC','" + strEncSdate + "') AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                  \n");                                   
    sbSql2.append("                                                                     /*검색 조건 : 센터*/                                                                                                                                                 \n");       
    sbSql2.append("                                                                     /*검색 조건 : 납품업체*/                                                                                                                                             \n");                  
    sbSql2.append("                                                     ) T	                                                                                                                                                                                 \n"); 
    sbSql2.append("                                             ) X		                                                                                                                                                                                       \n");
    sbSql2.append("                                          GROUP BY X.TRANS_DATE, X.ITEM_CODE, X.ITEM_NAME, X.ITEM_SIZE, X.TRANS_UOM,  X.SALE_PRICE , x.pr_num, X.UPJANG, X.DEPT_ID, X.TRANS_DATE2, X.PO_TYPE                                              \n"); 
    sbSql2.append("                                         ) RS                                                                                                                                                                                             \n"); 
    sbSql2.append("                                     ) Z                                                                                                                                                                                                  \n"); 
    sbSql2.append("                             GROUP BY Z.TRANS_DATE, Z.PR_NUM, Z.UPJANG, Z.DEPT_ID, Z.TRANS_DATE2                                                                                                                                          \n"); 
    sbSql2.append("                              UNION ALL                                                                                                                                                                                                   \n"); 
    sbSql2.append("                             /* 입금     */                                                                                                                                                                                               \n");     
    sbSql2.append("                             SELECT V.AR_NUM                                                                                                                                                                                              \n"); 
    sbSql2.append("                                  , V.UPJANG_CD UPJANG                                                                                                                                                                                    \n"); 
    sbSql2.append("                                  , V.CC_CD AS DEPT_ID                                                                                                                                                                                    \n"); 
    sbSql2.append("                                  , 0 AS  AMT                                                                                                                                                                                             \n"); 
    sbSql2.append("                                  , V1.RECEIVE_DATE BOND_DATE                                                                                                                                                                             \n"); 
    sbSql2.append("                                  , NVL(V1.RECEIVE_AMT,0) AS RCP_AMT1                                                                                                                                                                     \n"); 
    sbSql2.append("                                  , 0 AS CURR_MACHUL                                                                                                                                                                                      \n"); 
    sbSql2.append("                                  , 0 MI_BOND_AMT                                                                                                                                                                                         \n"); 
    sbSql2.append("                                  , 0 DO_BOND_AMT                                                                                                                                                                                         \n"); 
    sbSql2.append("                                  , 0 AK_BOND_AMT                                                                                                                                                                                         \n"); 
    sbSql2.append("                                  , '' AS PR_NUM                                                                                                                                                                                          \n"); 
    sbSql2.append("                                  , '' AS ITEM_NAME                                                                                                                                                                                       \n");
    sbSql2.append("                                  , V2.RECEIVE_TYPE_CD                                                                                                                                                                                       \n");
    sbSql2.append("                               FROM SLA_AR_MST V INNER JOIN SLA_AR_RECEIVE_DETAIL V1 ON V1.RECEIVE_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                 \n");                  
    sbSql2.append("                                AND V1.RECD_STATUS = 'L'	                                                                                                                                                                                 \n"); 
    sbSql2.append("                                AND V.AR_NUM = V1.AR_NUM                                                                                                                                                                                  \n"); 
    sbSql2.append("                                INNER JOIN SLA_AR_RECEIVE_MST V2 ON V1.RECEIVE_NUM = V2.RECEIVE_NUM                                                                                                                                                                          \n"); 
    sbSql2.append("                                AND V2.RECD_STATUS = 'L'                                                                                                                                                         \n");
    sbSql2.append("                                INNER JOIN FMS_UPJANG B ON 1 = 1                                                                                                                                                                          \n"); 
    sbSql2.append("                                AND (B.MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                                                                                                         \n");              
    sbSql2.append("                                AND V.UPJANG_CD = B.UPJANG                                                                                                                                                                                \n"); 
    sbSql2.append("                                INNER JOIN ST_UPJANG S ON  1 = 1                                                                                                                                                                          \n"); 
    sbSql2.append("                                AND B.UPJANG = S.UPJANG						                                                                                                                                                                       \n");
    sbSql2.append("                                INNER JOIN HLDC_SC_DEPT_V D ON  1 = 1                                                                                                                                                                     \n"); 
    sbSql2.append("                                AND (D.MU_CD      = '2004')                                                                                                                                                                               \n"); 
    sbSql2.append("                                AND (D.TM_CD LIKE 'CI%')                                                                                                                                                                                  \n"); 
    sbSql2.append("                                AND S.DEPT_ID = D.DEPT_ID                                                                                                                                                                                 \n"); 
    sbSql2.append("                                AND V.MU_CD = D.MU_CD                                                                                                                                                                                     \n"); 
    sbSql2.append("                              WHERE V.SYS_CLASS IN ('13','14')                                                                                                                                                                            \n"); 
    sbSql2.append("                                AND V.RECD_STATUS='L'                                                                                                                                                                                     \n"); 
    sbSql2.append("                                AND V1.ACCT_CD NOT IN ('11202010')  /*대체된 금액은 입금반영이 되지 않도록함*/                                                                                                                            \n");                    
    sbSql2.append("                                UNION ALL                                                                                                                                                                                                 \n"); 
    sbSql2.append("                             /* 입금(선수금) : +, -  : 일자별 잔액 개념으로 변경, 2015-12-03    */                                                                                                                                        \n");                   
    sbSql2.append("                             SELECT                                                                                                                                                                                                       \n"); 
    sbSql2.append("                                 X.ADVANCE_NUM AS AR_NUM                                                                                                                                                                                  \n"); 
    sbSql2.append("                                 , X.UPJANG                                                                                                                                                                                               \n"); 
    sbSql2.append("                                 , X.DEPT_ID                                                                                                                                                                                              \n"); 
    sbSql2.append("                                 , 0 AS AMT                                                                                                                                                                                               \n"); 
    sbSql2.append("                                 , X.BOND_DATE                                                                                                                                                                                            \n"); 
    sbSql2.append("                                 , SUM(X.RCP_AMT1) - SUM(RCP_AMT2) AS RCP_AMT1                                                                                                                                                            \n"); 
    sbSql2.append("                                 , 0 AS CURR_MACHUL                                                                                                                                                                                       \n"); 
    sbSql2.append("                                 , 0 AS MI_BOND_AMT                                                                                                                                                                                       \n"); 
    sbSql2.append("                                 , 0 AS DO_BOND_AMT                                                                                                                                                                                       \n"); 
    sbSql2.append("                                 , 0 AS AK_BOND_AMT                                                                                                                                                                                       \n"); 
    sbSql2.append("                                 , '' AS PR_NUM                                                                                                                                                                                           \n"); 
    sbSql2.append("                                 , '' AS ITEM_NAME                                                                                                                                                                                        \n");
    sbSql2.append("                                 , 'B10' AS RECEIVE_TYPE_CD                                                                                                                                                                                        \n");
    sbSql2.append("                             FROM                                                                                                                                                                                                         \n"); 
    sbSql2.append("                                 (                                                                                                                                                                                                        \n"); 
    sbSql2.append("                                     /* 선수금 발생금액   */                                                                                                                                                                              \n");          
    sbSql2.append("                                 SELECT V.ADVANCE_NUM                                                                                                                                                                                     \n"); 
    sbSql2.append("                                      , V.UPJANG_CD UPJANG                                                                                                                                                                                \n"); 
    sbSql2.append("                                      , V.CC_CD AS DEPT_ID                                                                                                                                                                                \n"); 
    sbSql2.append("                                      , 0 AS  AMT                                                                                                                                                                                         \n"); 
    sbSql2.append("                                      , V.OCCUR_DATE AS  BOND_DATE                                                                                                                                                                        \n"); 
    sbSql2.append("                                      , NVL(V.OCCUR_AMT,0) AS RCP_AMT1                                                                                                                                                                    \n"); 
    sbSql2.append("                                      , 0 AS RCP_AMT2                                                                                                                                                                                     \n"); 
    sbSql2.append("                                      , 0 AS CURR_MACHUL                                                                                                                                                                                  \n"); 
    sbSql2.append("                                      , 0 MI_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                      , 0 DO_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                      , 0 AK_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                   FROM SLA_ADVANCE_MST V INNER JOIN FMS_UPJANG B ON 1 = 1																	                                                                                                               \n");
    sbSql2.append("                                        AND (B.MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                                                                                                 \n");              
    sbSql2.append("                                        AND V.UPJANG_CD = B.UPJANG                                                                                                                                                                        \n"); 
    sbSql2.append("                                        INNER JOIN ST_UPJANG S ON 1 = 1							 																					                                                                                                           \n");
    sbSql2.append("                                        AND B.UPJANG = S.UPJANG                                                                                                                                                                           \n"); 
    sbSql2.append("                                        AND V.UPJANG_CD = S.UPJANG                                                                                                                                                                        \n"); 
    sbSql2.append("                                        INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1						                                                                                                                                                   \n");
    sbSql2.append("                                        AND (D.MU_CD = '2004')                                                                                                                                                                            \n"); 
    sbSql2.append("                                        AND (D.TM_CD LIKE 'CI%')                                                                                                                                                                          \n"); 
    sbSql2.append("                                        AND S.DEPT_ID = D.DEPT_ID                                                                                                                                                                         \n"); 
    sbSql2.append("                                 WHERE  V.OCCUR_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                                                    \n");                  
    sbSql2.append("                                    AND V.SYS_CLASS IN ('13','14')                                                                                                                                                                        \n"); 
    sbSql2.append("                                    AND V.RECD_STATUS='L'                                                                                                                                                                                 \n"); 
    sbSql2.append("                                 UNION ALL                                                                                                                                                                                                \n"); 
    sbSql2.append("                                 /* 선수금 대체금액 */                                                                                                                                                                                    \n");          
    sbSql2.append("                                 SELECT                                                                                                                                                                                                   \n"); 
    sbSql2.append("                                      V.ADVANCE_NUM                                                                                                                                                                                       \n"); 
    sbSql2.append("                                      , V.UPJANG_CD UPJANG                                                                                                                                                                                \n"); 
    sbSql2.append("                                      , V.CC_CD AS DEPT_ID                                                                                                                                                                                \n"); 
    sbSql2.append("                                      , 0 AS  AMT                                                                                                                                                                                         \n"); 
    sbSql2.append("                                      , V1.ALT_DATE AS  BOND_DATE                                                                                                                                                                         \n"); 
    sbSql2.append("                                      , 0 AS RCP_AMT1                                                                                                                                                                                     \n"); 
    sbSql2.append("                                      , NVL(V1.APPLY_AMT, 0) AS RCP_AMT2                                                                                                                                                                  \n"); 
    sbSql2.append("                                      , 0 AS CURR_MACHUL                                                                                                                                                                                  \n"); 
    sbSql2.append("                                      , 0 MI_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                      , 0 DO_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                      , 0 AK_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                   FROM SLA_ADVANCE_MST V                                                                                                                                                                                 \n"); 
    sbSql2.append("                                        INNER JOIN SLA_ADVANCE_ALT_DETAIL V1 ON 1 = 1                                                                                                                                                     \n"); 
    sbSql2.append("                                        AND V1.RECD_STATUS = 'L'                                                                                                                                                                          \n"); 
    sbSql2.append("                                        AND V1.ALT_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                                                 \n");                  
    sbSql2.append("                                        AND V.ADVANCE_NUM = V1.ADVANCE_NUM                                                                                                                                                                \n"); 
    sbSql2.append("                                        INNER JOIN FMS_UPJANG B ON 1 = 1                                                                                                                                                                  \n"); 
    sbSql2.append("                                        AND (B.MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                                                                                                 \n");              
    sbSql2.append("                                        AND V.UPJANG_CD = B.UPJANG                                                                                                                                                                        \n"); 
    sbSql2.append("                                        INNER JOIN ST_UPJANG S ON 1 = 1									 																					AND B.UPJANG = S.UPJANG                                                                                \n");
    sbSql2.append("                                        AND V.UPJANG_CD = S.UPJANG                                                                                                                                                                        \n"); 
    sbSql2.append("                                        INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1                                                                                                                                                              \n"); 
    sbSql2.append("                                        AND (D.MU_CD = '2004')                                                                                                                                                                            \n"); 
    sbSql2.append("                                        AND (D.TM_CD LIKE 'CI%')                                                                                                                                                                          \n"); 
    sbSql2.append("                                        AND S.DEPT_ID = D.DEPT_ID                                                                                                                                                                         \n"); 
    sbSql2.append("                                        INNER JOIN SLA_ADVANCE_ALT_MST V2 ON 1=1                                                                                                                                                          \n"); 
    sbSql2.append("                                        AND V2.ALT_NUM = V1.ALT_NUM                                                                                                                                                                       \n"); 
    sbSql2.append("                                  WHERE V.OCCUR_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                                                    \n");                  
    sbSql2.append("                                    AND V.SYS_CLASS IN ('13','14')                                                                                                                                                                        \n"); 
    sbSql2.append("                                    AND V.RECD_STATUS='L'                                                                                                                                                                                 \n"); 
    sbSql2.append("                                  ) X                                                                                                                                                                                                     \n"); 
    sbSql2.append("                             GROUP BY X.UPJANG, X.DEPT_ID, X.BOND_DATE, X.ADVANCE_NUM                                                                                                                                                     \n"); 
    sbSql2.append("                         )                                                                                                                                                                                                                \n"); 
    sbSql2.append("             SELECT V.PR_NUM                                                                                                                                                                                                              \n"); 
    sbSql2.append("                   ,SUM((CASE WHEN V.BOND_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "') THEN V.AMT ELSE 0 END)) SALE_AMT                                                                                                         \n");                  
    sbSql2.append("                   ,SUM((CASE WHEN V.BOND_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "') THEN V.RCP_AMT1 ELSE 0 END)) COLLECT_AMT                                                                                                 \n");                  
    sbSql2.append("                   ,0 GIMAL_AMT                                                                                                                                                                                                           \n"); 
    sbSql2.append("                   ,ITEM_NAME                                                                                                                                                                                                             \n"); 
    sbSql2.append("                   ,BOND_DATE                                                                                                                                                                                                             \n"); 
    sbSql2.append("                   ,V.UPJANG                                                                                                                                                                                                              \n");
    sbSql2.append("                   ,(SELECT UPJANGNM FROM SCO_UPJANG_MST_V WHERE UPJANG = V.UPJANG) UPJANGNM                                                                                                                                              \n");
    sbSql2.append("                   ,RECEIVE_TYPE_CD                                                                                                                                                                                                              \n");
    sbSql2.append("               FROM TB_STOCK V                                                                                                                                                                                                            \n"); 
    sbSql2.append("              WHERE V.BOND_DATE BETWEEN SC_CRYPTO_FUN('DEC','" + strEncSdate + "') AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                                                         \n");                                   
    sbSql2.append("              GROUP BY V.PR_NUM, V.BOND_DATE,V.AMT,V.RCP_AMT1, V.ITEM_NAME                                                                                                                                                                \n"); 
    sbSql2.append("              ,V.UPJANG, V.RECEIVE_TYPE_CD                                                                                                                                                                                                                   \n");
    sbSql2.append("     )                                                                                                                                                                                                                                    \n"); 
    sbSql2.append("     GROUP BY PR_NUM, BOND_DATE, ITEM_NAME                                                                                                                                                                                                \n"); 
    sbSql2.append("     ,UPJANG, UPJANGNM, RECEIVE_TYPE_CD                                                                                                                                                                                                                    \n");
    sbSql2.append("     UNION ALL                                                                                                                                                                                                                            \n"); 
    sbSql2.append("     SELECT '' AS PR_NUM                                                                                                                                                                                                                  \n"); 
    sbSql2.append("          , ' ' AS BOND_DATE                                                                                                                                                                                                              \n"); 
    sbSql2.append("          , 0 AS SALE_AMT                                                                                                                                                                                                                 \n"); 
    sbSql2.append("          , 0 AS COLLECT_AMT                                                                                                                                                                                                              \n");
    sbSql2.append("          , GIMAL_AMT                                                                                                                                                                                                                     \n");
    sbSql2.append("          ,'1' AS GUBN                                                                                                                                                                                                                    \n");
    sbSql2.append("          , '이월잔액' AS ITEM_NAME                                                                                                                                                                                                       \n");    
    sbSql2.append("           , '' AS UPJANGNM                                                                                                                                                                                                               \n");
    sbSql2.append("           , '' AS RECEIVE_TYPE                                                                                                                                                                                                           \n");
    sbSql2.append("       FROM (                                                                                                                                                                                                                             \n"); 
    sbSql2.append("             WITH TB_STOCK1 AS                                                                                                                                                                                                            \n"); 
    sbSql2.append("             (                                                                                                                                                                                                                            \n"); 
    sbSql2.append("                             /* 채권*/                                                                                                                                                                                                    \n");     
    sbSql2.append("                             SELECT  '' AS AR_NUM                                                                                                                                                                                         \n"); 
    sbSql2.append("                                    , Z.UPJANG                                                                                                                                                                                            \n"); 
    sbSql2.append("                                    , Z.DEPT_ID                                                                                                                                                                                           \n"); 
    sbSql2.append("                                    , SUM(Z.SALE_SUM) AS AMT                                                                                                                                                                              \n"); 
    sbSql2.append("                                    , Z.TRANS_DATE2 AS BOND_DATE                                                                                                                                                                          \n"); 
    sbSql2.append("                                    ,0 AS RCP_AMT1                                                                                                                                                                                        \n"); 
    sbSql2.append("                                    ,0 AS CURR_MACHUL                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    ,0 AS MI_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    ,0 AS DO_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    ,0 AS AK_BOND_AMT                                                                                                                                                                                     \n"); 
    sbSql2.append("                                    , Z.PR_NUM AS PR_NUM                                                                                                                                                                                  \n"); 
    sbSql2.append("                                    , MAX(ITEM_NAME)||DECODE(SIGN(COUNT(DISTINCT ITEM_NAME) - 1), 1, ' 외 ' || TO_CHAR(COUNT(DISTINCT ITEM_NAME) - 1) || '건') AS ITEM_NAME                                                               \n");   
    sbSql2.append("                                FROM (                                                                                                                                                                                                    \n"); 
    sbSql2.append("                                         SELECT RS.TRANS_DATE                                                                                                                                                                             \n"); 
    sbSql2.append("                                               , RS.ITEM_NAME                                                                                                                                                                             \n"); 
    sbSql2.append("                                               , RS.SALE_SUM - (RS.CK_SUM + RS.JI_SUM) AS SALE_SUM		/* 매출합계 = 매출합계 - (각종 수수료금액 제외) */                                                                                   \n");
    sbSql2.append("                                               , RS.PR_NUM                                                                                                                                                                                \n"); 
    sbSql2.append("                                               , RS.UPJANG                                                                                                                                                                                \n"); 
    sbSql2.append("                                               , RS.DEPT_ID                                                                                                                                                                               \n"); 
    sbSql2.append("                                               , RS.TRANS_DATE2                                                                                                                                                                           \n"); 
    sbSql2.append("                                           FROM (                                                                                                                                                                                         \n"); 
    sbSql2.append("                                             SELECT                                                                                                                                                                                       \n"); 
    sbSql2.append("                                                   TO_CHAR(TO_DATE(X.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') TRANS_DATE                                                                                                                      \n"); 
    sbSql2.append("                                                 , X.ITEM_CODE                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , X.ITEM_NAME                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , X.ITEM_SIZE                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , X.TRANS_UOM                                                                                                                                                                            \n"); 
    sbSql2.append("                                                 , SUM(                                                                                                                                                                                   \n"); 
    sbSql2.append("                                                     CASE WHEN X.FLAG = '1' THEN                                                                                                                                                          \n"); 
    sbSql2.append("                                                         DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(X.TAX_CODE,'100',1.1,1) * ROUND(X.SALE_PRICE * X.TRANS_QTY))                                                            \n"); 
    sbSql2.append("                                                     ELSE                                                                                                                                                                                 \n"); 
    sbSql2.append("                                                         DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(X.SALE_PRICE * X.TRANS_QTY) + X.SALE_VAT                                                                                       \n"); 
    sbSql2.append("                                                     END                                                                                                                                                                                  \n"); 
    sbSql2.append("                                                     ) AS SALE_SUM                                                                                                                                                                        \n"); 
    sbSql2.append("                                                 , SUM(ROUND(X.CK_AMOUNT) + DECODE(X.TAX_CODE,100,ROUND(X.CK_AMOUNT / 10),0) * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1)) AS CK_SUM                                                    \n"); 
    sbSql2.append("                                                 , SUM(ROUND(X.JI_AMOUNT) + DECODE(X.TAX_CODE,100,ROUND(X.JI_AMOUNT / 10),0) * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1)) AS JI_SUM                                                    \n"); 
    sbSql2.append("                                                 , x.pr_num                                                                                                                                                                               \n"); 
    sbSql2.append("                                                 , X.UPJANG                                                                                                                                                                               \n"); 
    sbSql2.append("                                                 , X.DEPT_ID                                                                                                                                                                              \n"); 
    sbSql2.append("                                                 , X.TRANS_DATE2                                                                                                                                                                          \n"); 
    sbSql2.append("                                                 , X.PO_TYPE                                                                                                                                                                              \n"); 
    sbSql2.append("                                               FROM (                                                                                                                                                                                     \n"); 
    sbSql2.append("                                                         SELECT T.TRANS_DATE                                                                                                                                                              \n"); 
    sbSql2.append("                                                              , T.ITEM_CODE                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.ITEM_NAME                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.ITEM_SIZE                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.TRANS_UOM                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.TRANS_TYPE                                                                                                                                                              \n"); 
    sbSql2.append("                                                              , T.TRANS_QTY                                                                                                                                                               \n"); 
    sbSql2.append("                                                              , T.SALE_PRICE                                                                                                                                                              \n"); 
    sbSql2.append("                                                              , T.TAX_CODE                                                                                                                                                                \n"); 
    sbSql2.append("                                                              , T.SALE_VAT                                                                                                                                                                \n"); 
    sbSql2.append("                                                              , T.FLAG                                                                                                                                                                    \n"); 
    sbSql2.append("                                                              , CASE WHEN NVL(T.SALE_AMOUNT, 0) = 0 THEN 0                                                                                                                                \n"); 
    sbSql2.append("                                                                   ELSE                                                                                                                                                                   \n"); 
    sbSql2.append("                                                                         CASE WHEN NVL(T.C_SALE_RATE, 0) = 0 THEN                                                                                                                         \n"); 
    sbSql2.append("                                                                             CASE WHEN NVL(T.C1_SALE_RATE, 0) = 0 THEN 0                                                                                                                  \n"); 
    sbSql2.append("                                                                             ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.C1_SALE_RATE,0) / 100)))) END			    					                                                     \n");
    sbSql2.append("                                                                         ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.C_SALE_RATE,0) / 100))))                                                                                 \n"); 
    sbSql2.append("                                                                         END                                                                                                                                                              \n"); 
    sbSql2.append("                                                                   END AS CK_AMOUNT                                                                                                                                                       \n"); 
    sbSql2.append("                                                              , CASE WHEN NVL(T.SALE_AMOUNT, 0) = 0 THEN 0                                                                                                                                \n"); 
    sbSql2.append("                                                                   ELSE                                                                                                                                                                   \n"); 
    sbSql2.append("                                                                         CASE WHEN NVL(T.J_SALE_RATE, 0) = 0 THEN                                                                                                                         \n"); 
    sbSql2.append("                                                                             CASE WHEN NVL(T.J1_SALE_RATE, 0) = 0 THEN 0                                                                                                                  \n"); 
    sbSql2.append("                                                                             ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.J1_SALE_RATE,0) / 100)))) END			    					                                                     \n");
    sbSql2.append("                                                                         ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.J_SALE_RATE,0) / 100))))                                                                                 \n"); 
    sbSql2.append("                                                                         END                                                                                                                                                              \n"); 
    sbSql2.append("                                                                 END AS JI_AMOUNT                                                                                                                                                         \n"); 
    sbSql2.append("                                                              , T.pr_num                                                                                                                                                                  \n"); 
    sbSql2.append("                                                              , T.UPJANG                                                                                                                                                                  \n"); 
    sbSql2.append("                                                              , T.DEPT_ID                                                                                                                                                                 \n"); 
    sbSql2.append("                                                              , T.TRANS_DATE2 		                                                                                                                                                         \n");
    sbSql2.append("                                                              , T.PO_TYPE		                                                                                                                                                             \n");
    sbSql2.append("                                                           FROM (                                                                                                                                                                         \n"); 
    sbSql2.append("                                                                 SELECT /*+ PUSH_PRED(A) */                                                                                                                                               \n"); 
    sbSql2.append("                                                                        A.TRANS_DATE                                                                                                                                                      \n"); 
    sbSql2.append("                                                                      , A.ITEM_CODE                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.ITEM_NAME                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.ITEM_SIZE                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.TRANS_UOM                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , A.TRANS_TYPE                                                                                                                                                      \n"); 
    sbSql2.append("                                                                      , A.TRANS_QTY                                                                                                                                                       \n"); 
    sbSql2.append("                                                                      , NVL(A.TRANS_MPRICE, 0) AS TRANS_MPRICE                                                                                                                            \n"); 
    sbSql2.append("                                                                      , NVL(A.TRANS_MAMOUNT, 0) AS TRANS_MAMOUNT                                                                                                                          \n"); 
    sbSql2.append("                                                                      /* , NVL(A.TRANS_MVAT, 0) AS TRANS_MVAT */                                                                                                                          \n"); 
    sbSql2.append("                                                                      , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * NVL(A.TRANS_MAMOUNT, 0)) AS TRANS_MVAT                                                                                     \n"); 
    sbSql2.append("                                                                      , CASE WHEN A.PO_TYPE IN ('71', '72') THEN 0 ELSE NVL(A.SALE_PRICE, 0) END AS SALE_PRICE                                                                            \n"); 
    sbSql2.append("                                                                      , CASE WHEN A.PO_TYPE IN ('71', '72') THEN 0 ELSE NVL(A.SALE_AMOUNT, 0) END AS SALE_AMOUNT                                                                          \n"); 
    sbSql2.append("                                                                      , CASE WHEN A.PO_TYPE IN ('71', '72') THEN 0 ELSE NVL(A.SALE_VAT, 0) END AS SALE_VAT                                                                                \n"); 
    sbSql2.append("                                                                      , A.TAX_CODE                                                                                                                                                        \n"); 
    sbSql2.append("                                                                      , A.FLAG                                                                                                                                                            \n"); 
    sbSql2.append("                                                                      /*검색 조건 : CK물류비제외*/                                                                                                                                        \n");          
    sbSql2.append("                                                                      , 0 AS C1_SALE_RATE								/* 분류 기준 CK 물류비율 */                                                                                                      \n");
    sbSql2.append("                                                                      , 0 AS C_SALE_RATE									/* 자재 기준 CK 물류비율 */                                                                                                      \n");
    sbSql2.append("                                                                      /*검색 조건 : 지급수수료제외*/                                                                                                                                      \n");            
    sbSql2.append("                                                                      , 0 AS J1_SALE_RATE									/* 분류 기준 지급수수료 비율 */                                                                                                \n");
    sbSql2.append("                                                                      , 0 AS J_SALE_RATE		/* 자재별 지급수수료 비율 */                                                                                                                   \n");         
    sbSql2.append("                                                                      /*검색 조건 : 장려금제외*/                                                                                                                                          \n");          
    sbSql2.append("                                                                      ,	0 AS S1_SALE_RATE									/* 분류 기준 장려금 비율 */	                                                                                                   \n");
    sbSql2.append("                                                                      , 0 AS S_SALE_RATE									/* 자재별 장려금 비율 */                                                                                                         \n");
    sbSql2.append("                                                                      , a.pr_id                                                                                                                                                           \n"); 
    sbSql2.append("                                                                      , a.pr_num                                                                                                                                                          \n"); 
    sbSql2.append("                                                                      , B2.UPJANG                                                                                                                                                         \n"); 
    sbSql2.append("                                                                      , B2.DEPT_ID                                                                                                                                                        \n"); 
    sbSql2.append("                                                                      , A.TRANS_DATE2                                                                                                                                                     \n"); 
    sbSql2.append("                                                                      , A.PO_TYPE                                                                                                                                                         \n"); 
    sbSql2.append("                                                                   FROM FMS_TRANSACTION_RTN_V A                                                                                                                                           \n"); 
    sbSql2.append("                                                                        INNER JOIN ST_UPJANG B2 ON 1 = 1                                                                                                                                  \n"); 
    sbSql2.append("                                                                        /*검색 조건 : 본사*/                                                                                                                                              \n");       
    sbSql2.append("                                                                        AND B2.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE  MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                 \n");              
    sbSql2.append("                                                                        /*검색 조건 : 사업장*/                                                                                                                                            \n");        
    sbSql2.append("                                                                        AND A.TRANS_UPJANG = B2.UPJANG																			                                                                                               \n");
    sbSql2.append("                                                                        INNER JOIN FMS_UPJANG Z ON 1 = 1                                                                                                                                  \n"); 
    sbSql2.append("                                                                        /*검색 조건 : 영업담당*/                                                                                                                                          \n");     
    sbSql2.append("                                                                        /*검색 조건 : 세부직군*/                                                                                                                                          \n");     
    sbSql2.append("                                                                        AND A.TRANS_UPJANG = Z.UPJANG                                                                                                                                     \n"); 
    sbSql2.append("                                                                        INNER JOIN HLDC_SC_DEPT_V D ON  1 = 1                                                                                                                             \n"); 
    sbSql2.append("                                                                        /*검색 조건 : 관리부서(팀)*/                                                                                                                                      \n");          
    sbSql2.append("                                                                        AND D.TM_CD LIKE 'CI%'                                                                                                                                            \n"); 
    sbSql2.append("                                                                        /*검색 조건 : CC */                                                                                                                                               \n");     
    sbSql2.append("                                                                        AND  B2.DEPT_ID = D.DEPT_ID                                                                                                                                       \n"); 
    sbSql2.append("                                                                   WHERE (SUBSTR(A.SUBINV_CODE, 1, 2) = 'S1' )                                                                                                                            \n");
    sbSql2.append("                                                                     AND (A.TRANS_TYPE IN '_002' OR A.TRANS_TYPE = 'I001' )                                                                                                               \n"); 
    sbSql2.append("                                                                     /*검색 조건 : 기간*/                                                                                                                                                 \n");       
    sbSql2.append("                                                                     AND A.TRANS_DATE2 BETWEEN '20210101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                  \n");                  
    sbSql2.append("                                                                     /*검색 조건 : 센터*/                                                                                                                                                 \n");       
    sbSql2.append("                                                                     /*검색 조건 : 납품업체*/                                                                                                                                             \n");         
    sbSql2.append("                                                     ) T	                                                                                                                                                                                 \n"); 
    sbSql2.append("                                             ) X		                                                                                                                                                                                       \n");
    sbSql2.append("                                          GROUP BY X.TRANS_DATE, X.ITEM_CODE, X.ITEM_NAME, X.ITEM_SIZE, X.TRANS_UOM,  X.SALE_PRICE , x.pr_num, X.UPJANG, X.DEPT_ID, X.TRANS_DATE2, X.PO_TYPE                                              \n"); 
    sbSql2.append("                                         ) RS                                                                                                                                                                                             \n"); 
    sbSql2.append("                                     ) Z                                                                                                                                                                                                  \n"); 
    sbSql2.append("                             GROUP BY Z.TRANS_DATE, Z.PR_NUM, Z.UPJANG, Z.DEPT_ID, Z.TRANS_DATE2                                                                                                                                          \n"); 
    sbSql2.append("					    	UNION ALL                                                                                                                                                                                                      \n"); 
    sbSql2.append("							/* 채권(판매) */                                                                                                                                                                                                 \n"); 
    sbSql2.append("					        SELECT '' AS AR_NUM                                                                                                                                                                                         \n"); 
    sbSql2.append("								 , V.UPJANG_CD AS UPJANG                                                                                                                                                                             \n"); 
    sbSql2.append("					             , B2.DEPT_ID                                                                                                                                                                                                \n"); 
    sbSql2.append("					             , NVL(V.AR_AMT,0) - NVL(V.MNGMV_AMT,0) AS AMT	/* 이관된 금액이 중복으로 잡혀 이관된 금액 뺌 */                                                                                \n"); 
    sbSql2.append("					             , V.OCCUR_DATE AS BOND_DATE                                                                                                                                                                      \n"); 
    sbSql2.append("								 , 0 AS RCP_AMT1                                                                                                                                                                                         \n"); 
    sbSql2.append("					             , 0 AS CURR_MACHUL                                                                                                                                                                                   \n"); 
    sbSql2.append("					             , 0 MI_BOND_AMT                                                                                                                                                                                        \n"); 
    sbSql2.append("					             , 0 DO_BOND_AMT                                                                                                                                                                                       \n"); 
    sbSql2.append("					             , 0 AK_BOND_AMT                                                                                                                                                                                        \n"); 
    sbSql2.append("							     , '' AS PR_NUM                                                                                                                                                                                            \n"); 
    sbSql2.append("							     , '' as ITEM_NAME                                                                                                                                                                                         \n"); 
    sbSql2.append("					          FROM SLA_AR_MST V                                                                                                                                                                                       \n"); 
    sbSql2.append("								  INNER JOIN ST_UPJANG B2 ON 1 = 1                                                                                                                                                                \n"); 
    sbSql2.append("								  /*검색 조건 : 본사*/                                                                                                                                                                                      \n"); 
    sbSql2.append("								  AND B2.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE  MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                          \n"); 
    sbSql2.append("								  /*검색 조건 : 사업장*/                                                                                                                                                                                   \n"); 
    sbSql2.append("								  AND V.UPJANG_CD = B2.UPJANG																			                                                                                            \n"); 
    sbSql2.append("								  INNER JOIN FMS_UPJANG Z ON 1 = 1                                                                                                                                                               \n"); 
    sbSql2.append("														  /*검색 조건 : 영업담당*/                                                                                                                                                         \n"); 
    sbSql2.append("														  /*검색 조건 : 세부직군*/                                                                                                                                                         \n"); 
    sbSql2.append("								  AND V.UPJANG_CD = Z.UPJANG                                                                                                                                                                      \n"); 
    sbSql2.append("								  INNER JOIN HLDC_SC_DEPT_V D ON  1 = 1                                                                                                                                                         \n"); 
    sbSql2.append("								  /*검색 조건 : 관리부서(팀)*/                                                                                                                                                                            \n"); 
    sbSql2.append("								  AND D.TM_CD LIKE 'CI%'                                                                                                                                                                               \n"); 
    sbSql2.append("								  /*검색 조건 : CC */                                                                                                                                                                                       \n"); 
    sbSql2.append("								  AND  B2.DEPT_ID = D.DEPT_ID                                                                                                                                                                         \n"); 
    sbSql2.append("					         WHERE V.OCCUR_DATE BETWEEN '19000101' AND '20201231'                                                                                                                                      \n"); 
    sbSql2.append("					               AND V.SYS_CLASS IN ('13','14')                                                                                                                                                                       \n"); 
    sbSql2.append("					               AND V.RECD_STATUS='L'                                                                                                                                                                              \n"); 
    sbSql2.append("                   UNION ALL                                                                                                                                                                                                              \n"); 
    sbSql2.append("                 /* 입금*/                                                                                                                                                                                                                \n");     
    sbSql2.append("                 SELECT V.AR_NUM                                                                                                                                                                                                          \n"); 
    sbSql2.append("                      , V.UPJANG_CD UPJANG                                                                                                                                                                                                \n"); 
    sbSql2.append("                      , V.CC_CD AS DEPT_ID                                                                                                                                                                                                \n"); 
    sbSql2.append("                      , 0 AS  AMT                                                                                                                                                                                                         \n"); 
    sbSql2.append("                      , V1.RECEIVE_DATE BOND_DATE                                                                                                                                                                                         \n"); 
    sbSql2.append("                      , NVL(V1.RECEIVE_AMT,0) AS RCP_AMT1                                                                                                                                                                                 \n"); 
    sbSql2.append("                      , 0 AS CURR_MACHUL                                                                                                                                                                                                  \n"); 
    sbSql2.append("                      , 0 MI_BOND_AMT                                                                                                                                                                                                     \n"); 
    sbSql2.append("                      , 0 DO_BOND_AMT                                                                                                                                                                                                     \n"); 
    sbSql2.append("                      , 0 AK_BOND_AMT                                                                                                                                                                                                     \n"); 
    sbSql2.append("                      , '' AS PR_NUM                                                                                                                                                                                                      \n"); 
    sbSql2.append("                      , '' AS ITEM_NAME                                                                                                                                                                                                   \n"); 
    sbSql2.append("                   FROM SLA_AR_MST V INNER JOIN SLA_AR_RECEIVE_DETAIL V1 ON V1.RECEIVE_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                             \n");                  
    sbSql2.append("                    AND V1.RECD_STATUS = 'L'	                                                                                                                                                                                             \n"); 
    sbSql2.append("                    AND V.AR_NUM = V1.AR_NUM                                                                                                                                                                                              \n"); 
    sbSql2.append("                    INNER JOIN FMS_UPJANG B ON 1 = 1                                                                                                                                                                                      \n"); 
    sbSql2.append("                    AND (B.MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                                                                                                                     \n");              
    sbSql2.append("                    AND V.UPJANG_CD = B.UPJANG                                                                                                                                                                                            \n"); 
    sbSql2.append("                    INNER JOIN ST_UPJANG S ON  1 = 1                                                                                                                                                                                      \n"); 
    sbSql2.append("                    AND B.UPJANG = S.UPJANG						                                                                                                                                                                                   \n");
    sbSql2.append("                    INNER JOIN HLDC_SC_DEPT_V D ON  1 = 1                                                                                                                                                                                 \n"); 
    sbSql2.append("                    AND (D.MU_CD      = '2004')                                                                                                                                                                                           \n"); 
    sbSql2.append("                    AND (D.TM_CD LIKE 'CI%')                                                                                                                                                                                              \n"); 
    sbSql2.append("                    AND S.DEPT_ID = D.DEPT_ID                                                                                                                                                                                             \n"); 
    sbSql2.append("                    AND V.MU_CD = D.MU_CD                                                                                                                                                                                                 \n"); 
    sbSql2.append("                  WHERE V.SYS_CLASS IN ('13','14')                                                                                                                                                                                        \n"); 
    sbSql2.append("                    AND V.RECD_STATUS='L'                                                                                                                                                                                                 \n"); 
    sbSql2.append("                    AND V1.ACCT_CD NOT IN ('11202010')  /*대체된 금액은 입금반영이 되지 않도록함  */                                                                                                                                      \n");                    
    sbSql2.append("                    UNION ALL                                                                                                                                                                                                             \n"); 
    sbSql2.append("                 /* 입금(선수금) : +, -  : 일자별 잔액 개념으로 변경, 2015-12-03    */                                                                                                                                                    \n");                   
    sbSql2.append("                 SELECT                                                                                                                                                                                                                   \n"); 
    sbSql2.append("                       X.ADVANCE_NUM AS AR_NUM                                                                                                                                                                                            \n"); 
    sbSql2.append("                     , X.UPJANG                                                                                                                                                                                                           \n"); 
    sbSql2.append("                     , X.DEPT_ID                                                                                                                                                                                                          \n"); 
    sbSql2.append("                     , 0 AS AMT                                                                                                                                                                                                           \n"); 
    sbSql2.append("                     , X.BOND_DATE                                                                                                                                                                                                        \n"); 
    sbSql2.append("                     , SUM(X.RCP_AMT1) - SUM(RCP_AMT2) AS RCP_AMT1                                                                                                                                                                        \n"); 
    sbSql2.append("                     , 0 AS CURR_MACHUL                                                                                                                                                                                                   \n"); 
    sbSql2.append("                     , 0 AS MI_BOND_AMT                                                                                                                                                                                                   \n"); 
    sbSql2.append("                     , 0 AS DO_BOND_AMT                                                                                                                                                                                                   \n"); 
    sbSql2.append("                     , 0 AS AK_BOND_AMT                                                                                                                                                                                                   \n"); 
    sbSql2.append("                     , '' AS PR_NUM                                                                                                                                                                                                       \n"); 
    sbSql2.append("                     , '' AS ITEM_NAME                                                                                                                                                                                                    \n"); 
    sbSql2.append("                  FROM (                                                                                                                                                                                                                  \n"); 
    sbSql2.append("                         /* 선수금 발생금액  */                                                                                                                                                                                           \n");          
    sbSql2.append("                         SELECT V.ADVANCE_NUM                                                                                                                                                                                             \n"); 
    sbSql2.append("                              , V.UPJANG_CD UPJANG                                                                                                                                                                                        \n"); 
    sbSql2.append("                              , V.CC_CD AS DEPT_ID                                                                                                                                                                                        \n"); 
    sbSql2.append("                              , 0 AS  AMT                                                                                                                                                                                                 \n"); 
    sbSql2.append("                              , V.OCCUR_DATE AS  BOND_DATE                                                                                                                                                                                \n"); 
    sbSql2.append("                              , NVL(V.OCCUR_AMT,0) AS RCP_AMT1                                                                                                                                                                            \n"); 
    sbSql2.append("                              , 0 AS RCP_AMT2                                                                                                                                                                                             \n"); 
    sbSql2.append("                              , 0 AS CURR_MACHUL                                                                                                                                                                                          \n"); 
    sbSql2.append("                              , 0 MI_BOND_AMT                                                                                                                                                                                             \n"); 
    sbSql2.append("                              , 0 DO_BOND_AMT                                                                                                                                                                                             \n"); 
    sbSql2.append("                              , 0 AK_BOND_AMT                                                                                                                                                                                             \n"); 
    sbSql2.append("                           FROM SLA_ADVANCE_MST V INNER JOIN FMS_UPJANG B ON 1 = 1																	                                                                                                                       \n");
    sbSql2.append("                                AND (B.MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                                                                                                         \n");              
    sbSql2.append("                                AND V.UPJANG_CD = B.UPJANG                                                                                                                                                                                \n"); 
    sbSql2.append("                                INNER JOIN ST_UPJANG S ON 1 = 1							 																					                                                                                                                   \n");
    sbSql2.append("                                AND B.UPJANG = S.UPJANG                                                                                                                                                                                   \n"); 
    sbSql2.append("                                AND V.UPJANG_CD = S.UPJANG                                                                                                                                                                                \n"); 
    sbSql2.append("                                INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1						                                                                                                                                                           \n");
    sbSql2.append("                                AND (D.MU_CD = '2004')                                                                                                                                                                                    \n"); 
    sbSql2.append("                                AND (D.TM_CD LIKE 'CI%')                                                                                                                                                                                  \n"); 
    sbSql2.append("                                AND S.DEPT_ID = D.DEPT_ID                                                                                                                                                                                 \n"); 
    sbSql2.append("                         WHERE  V.OCCUR_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                                                            \n");                  
    sbSql2.append("                            AND V.SYS_CLASS IN ('13','14')                                                                                                                                                                                \n"); 
    sbSql2.append("                            AND V.RECD_STATUS='L'                                                                                                                                                                                         \n"); 
    sbSql2.append("                 UNION ALL                                                                                                                                                                                                                \n"); 
    sbSql2.append("                 /* 선수금 대체금액  */                                                                                                                                                                                                   \n");          
    sbSql2.append("                 SELECT                                                                                                                                                                                                                   \n"); 
    sbSql2.append("                      V.ADVANCE_NUM                                                                                                                                                                                                       \n"); 
    sbSql2.append("                      , V.UPJANG_CD UPJANG                                                                                                                                                                                                \n"); 
    sbSql2.append("                      , V.CC_CD AS DEPT_ID                                                                                                                                                                                                \n"); 
    sbSql2.append("                      , 0 AS  AMT                                                                                                                                                                                                         \n"); 
    sbSql2.append("                      , V1.ALT_DATE AS  BOND_DATE                                                                                                                                                                                         \n"); 
    sbSql2.append("                      , 0 AS RCP_AMT1                                                                                                                                                                                                     \n"); 
    sbSql2.append("                      , NVL(V1.APPLY_AMT, 0) AS RCP_AMT2                                                                                                                                                                                  \n"); 
    sbSql2.append("                      , 0 AS CURR_MACHUL                                                                                                                                                                                                  \n"); 
    sbSql2.append("                      , 0 MI_BOND_AMT                                                                                                                                                                                                     \n"); 
    sbSql2.append("                      , 0 DO_BOND_AMT                                                                                                                                                                                                     \n"); 
    sbSql2.append("                      , 0 AK_BOND_AMT                                                                                                                                                                                                     \n"); 
    sbSql2.append("                   FROM SLA_ADVANCE_MST V                                                                                                                                                                                                 \n"); 
    sbSql2.append("                        INNER JOIN SLA_ADVANCE_ALT_DETAIL V1 ON 1 = 1                                                                                                                                                                     \n"); 
    sbSql2.append("                        AND V1.RECD_STATUS = 'L'                                                                                                                                                                                          \n"); 
    sbSql2.append("                        AND V1.ALT_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                                                                 \n");                  
    sbSql2.append("                        AND V.ADVANCE_NUM = V1.ADVANCE_NUM                                                                                                                                                                                \n"); 
    sbSql2.append("                        INNER JOIN FMS_UPJANG B ON 1 = 1                                                                                                                                                                                  \n"); 
    sbSql2.append("                        AND (B.MAIN_UPJANG = SC_CRYPTO_FUN('DEC','" + strEncUpjang + "'))                                                                                                                                                                 \n");              
    sbSql2.append("                        AND V.UPJANG_CD = B.UPJANG                                                                                                                                                                                        \n"); 
    sbSql2.append("                        INNER JOIN ST_UPJANG S ON 1 = 1                                                                                                                                                                                   \n"); 
    sbSql2.append("                        AND B.UPJANG = S.UPJANG                                                                                                                                                                                           \n"); 
    sbSql2.append("                        AND V.UPJANG_CD = S.UPJANG                                                                                                                                                                                        \n"); 
    sbSql2.append("                        INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1                                                                                                                                                                              \n"); 
    sbSql2.append("                        AND (D.MU_CD = '2004')                                                                                                                                                                                            \n"); 
    sbSql2.append("                        AND (D.TM_CD LIKE 'CI%')                                                                                                                                                                                          \n"); 
    sbSql2.append("                        AND S.DEPT_ID = D.DEPT_ID                                                                                                                                                                                         \n"); 
    sbSql2.append("                        INNER JOIN SLA_ADVANCE_ALT_MST V2 ON 1=1                                                                                                                                                                          \n"); 
    sbSql2.append("                        AND V2.ALT_NUM = V1.ALT_NUM                                                                                                                                                                                       \n"); 
    sbSql2.append("                  WHERE V.OCCUR_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "')                                                                                                                                                    \n");                  
    sbSql2.append("                    AND V.SYS_CLASS IN ('13','14')                                                                                                                                                                                        \n"); 
    sbSql2.append("                    AND V.RECD_STATUS='L'                                                                                                                                                                                                 \n"); 
    sbSql2.append("                  ) X                                                                                                                                                                                                                     \n"); 
    sbSql2.append("             GROUP BY X.UPJANG, X.DEPT_ID, X.BOND_DATE, X.ADVANCE_NUM                                                                                                                                                                     \n"); 
    sbSql2.append("         )                                                                                                                                                                                                                                \n"); 
    sbSql2.append("     SELECT                                                                                                                                                                                                                               \n"); 
    sbSql2.append("            SUM(GIMAL_AMT) AS GIMAL_AMT                                                                                                                                                                                                   \n");
    sbSql2.append("       FROM (                                                                                                                                                                                                                             \n"); 
    sbSql2.append("               SELECT                                                                                                                                                                                                                     \n"); 
    sbSql2.append("                     ( SUM((CASE WHEN V1.BOND_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "') THEN V1.AMT ELSE 0 END)) -                                                                                                           \n");                  
    sbSql2.append("                      SUM((CASE WHEN V1.BOND_DATE BETWEEN SC_CRYPTO_FUN('DEC','" + strEncSdate + "') AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "') THEN V1.AMT ELSE 0 END)) )                                                                                            \n");                                   
    sbSql2.append("                      - (SUM((CASE WHEN V1.BOND_DATE BETWEEN '19000101' AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "') THEN V1.RCP_AMT1 ELSE 0 END)) -                                                                                                    \n");                  
    sbSql2.append("                      SUM((CASE WHEN V1.BOND_DATE BETWEEN SC_CRYPTO_FUN('DEC','" + strEncSdate + "') AND SC_CRYPTO_FUN('DEC','" + strEncEdate + "') THEN V1.RCP_AMT1 ELSE 0 END))) AS GIMAL_AMT                                                                           \n");                                   
    sbSql2.append("                 FROM TB_STOCK1 V1                                                                                                                                                                                                        \n"); 
    sbSql2.append("             )                                                                                                                                                                                                                            \n"); 
    sbSql2.append("         )                                                                                                                                                                                                                                \n"); 
    sbSql2.append("     )                                                                                                                                                                                                                                    \n"); 
    sbSql2.append("     WHERE (SALE_AMT != 0 OR COLLECT_AMT != 0 OR GIMAL_AMT != 0 OR GUBN = '1')                                                                                                                                                            \n"); 
    sbSql2.append(" ORDER BY GUBN, BOND_DATE, ITEM_NAME_ORDERBY, ITEM_NAME                                                                                                                                                                                   \n");    

    try {

    	//header
        pstmt1 = conn.prepareStatement(sbSql.toString());
        rs1 = pstmt1.executeQuery();
        rs1.next();

        //detail
        pstmt2 = conn.prepareStatement(sbSql2.toString());
        rs2 = pstmt2.executeQuery();
        
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html><head><title>마감장조회</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="/lshtml/inspectRpt.css" />
</head>
<body>
<div style="text-align:center;padding-bottom:10px;">
<p><span style="font-family:'gulim';font-size: 28pt;"><%=nullToBlank(rs1.getString("MAINUPJANGNM"))%></span></p>
</div>
<div style="position:relative;">
<div style="text-align:left;padding-left:10px;padding-bottom:10px;">
<p style="font-family:'gulim';font-size:10pt;margin-left:2%;margin-right:2%;">
  <table width="95%" border=0 cellpadding=0 cellspacing=0 style="border-width:0px; border-collapse: collapse;">
    <tr>
    <td style="height:20px;font-family:'gulim';font-size:10pt;border-style: none;text-align:left;">회사명 : (주)푸디스트 / 담당 : <%=nullToBlank(rs1.getString("PART_SALES_SABUN_NM"))%> </td>
    <td style="height:20px;font-family:'gulim';font-size:10pt;border-style: none;text-align:right;"><%=nullToBlank(rs1.getString("SDATE"))%> ~ <%=nullToBlank(rs1.getString("EDATE"))%></td>
    </tr>
  </table>
</p>
<div style="text-align:center">
<div>
<table width=95% border=1 cellpadding=4 cellspacing=-1 style="border-width:0px; _border-collapse: collapse;">
<tr>
<td width=91 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>사업자등록번호</span></p>
</td>
<td width=239 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs1.getString("BIZ_NUM"))%></span></p>
</td>
<td width=90 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>대표자</span></p>
</td>
<td width=223 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs1.getString("DRNAME2"))%></span></p>
</td>
</tr>
<tr>
<td width=91 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>여신한도</span></p>
</td>
<td width=239 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs1.getString("CREDIT_LIMIT"))%></span></p>
</td>
<td width=90 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>전화</span></p>
</td>
<td width=223 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=LimsUtil.phoneFormat(rs1.getString("TEL_NO"))%></span></p>
</td>
</tr>
<tr>
<td width=91 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>Email</span></p>
</td>
<td width=239 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs1.getString("EMAIL"))%></span></p>
</td>
<td width=90 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>Fax</span></p>
</td>
<td width=223 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=LimsUtil.phoneFormat(rs1.getString("FAX_NO"))%></span></p>
</td>
</tr>
<tr>
<td width=91 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>주소</span></p>
</td>
<td colspan="3" width=552 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs1.getString("CUST_ADDR"))%></span></p>
</td>
</tr>
</table>
</div>
</div>

<div style="text-align:center">
<div>
<table width=95% border=1 cellpadding=4 cellspacing=-1 style="border-width:0px; _border-collapse: collapse;">
<tr>
<td colspan="6" style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>판매/수금내역</span></p>
</td>
<tr>
<td width=91 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>일자</span></p>
</td>
<td width=200 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>고객사명</span></p>
</td>
<td width=300 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>적요</span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>판매</span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>수금</span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span>잔액</span></p>
</td>
</tr>
<%
 int noCnt  = 0;
 String saleAmtS;
 String collectAmtS;
 String bondDate2S = null;
 String lastStockBalanceS = null;
 int saleSum = 0;
 int saleTSum = 0;
 int collectSum = 0;
 int collectTSum = 0;
 
 DecimalFormat df = new DecimalFormat("###,###");
	while(rs2.next()) {
		if(noCnt > 1 && bondDate2S != null && !bondDate2S.equals(rs2.getString("BOND_DATE2"))){
%>
<tr>
<td colspan="3" style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><b><%=nullToBlank(bondDate2S)%> 월계</b></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><b><%=df.format(saleSum)%></b></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><b><%=df.format(collectSum)%></b></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span></span></p>
</td>
</tr>
<%
			saleSum = 0;
			collectSum = 0;
		}
		noCnt++;
		bondDate2S = rs2.getString("BOND_DATE2");
		saleAmtS = rs2.getString("SALE_AMT").replaceAll(",","");
		saleSum = saleSum + Integer.parseInt(saleAmtS);
		saleTSum = saleTSum + Integer.parseInt(saleAmtS);
		collectAmtS = rs2.getString("COLLECT_AMT").replaceAll(",","");
		collectSum = collectSum + Integer.parseInt(collectAmtS);
		collectTSum = collectTSum + Integer.parseInt(collectAmtS);
		lastStockBalanceS = rs2.getString("STOCK_BALANCE");
%>
<tr>
<%
	if(noCnt == 1) {
%>
<td colspan="5" style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("ITEM_NAME"))%></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("STOCK_BALANCE"))%></span></p>
</td>
<%
	} else  {
%>
<td width=91 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("BOND_DATE"))%></span></p>
</td>
<td width=200 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("UPJANGNM"))%></span></p>
</td>
<td width=300 style="height:20px;font-family:'gulim';font-size:10pt;text-align:left;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("ITEM_NAME"))%></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("SALE_AMT"))%></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("COLLECT_AMT"))%></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px;"><p><span><%=nullToBlank(rs2.getString("STOCK_BALANCE"))%></span></p>
</td>
<%
	}
%>
</tr>
<%
	}
%>
<tr>
<td colspan="3" style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><b><%=nullToBlank(bondDate2S)%> 월계</b></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><b><%=df.format(saleSum)%></b></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><b><%=df.format(collectSum)%></b></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span></span></p>
</td>
</tr>
<tr>
<td colspan="3" style="height:20px;font-family:'gulim';font-size:10pt;text-align:center;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><b>누계</b></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><%=df.format(saleTSum)%></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><%=df.format(collectTSum)%></span></p>
</td>
<td width=60 style="height:20px;font-family:'gulim';font-size:10pt;text-align:right;border-width:1px; border-color: #000000; border-style: solid; padding:0px 7px; background-color: #CEECF5;"><p><span><%=lastStockBalanceS%></span></p>
</td>
</tr>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
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