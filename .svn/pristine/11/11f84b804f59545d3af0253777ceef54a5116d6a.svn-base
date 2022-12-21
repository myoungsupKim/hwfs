<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));			
	
		String  STD_CHK					= in_vl.getString("STD_CHK");			
		String  UPJANG_CHK				= in_vl.getString("UPJANG_CHK");		
		String  SUBUPJANG_CHK			= in_vl.getString("SUBUPJANG_CHK");	
		String  RECIPE_NAME				= in_vl.getString("RECIPE_NAME");		
		String  RECIPE_CLASS			= in_vl.getString("RECIPE_CLASS");	
		String  RECIPE_TYPE				= in_vl.getString("RECIPE_TYPE");		
		String  CUISINE_TYPE			= in_vl.getString("CUISINE_TYPE");	
		String  MAIN_ITEM_CODE1			= in_vl.getString("MAIN_ITEM_CODE1");	
		String  RESP_NUT1				= in_vl.getString("RESP_NUT1");		
		String  MENU_DATE				= in_vl.getString("MENU_DATE");		
		String  UPJANG					= in_vl.getString("UPJANG");			
		String  SUBINV_CLASS			= in_vl.getString("SUBINV_CLASS");		
		String  UNITPRICE_FROM			= in_vl.getString("UNITPRICE_FROM");	
		String  UNITPRICE_TO			= in_vl.getString("UNITPRICE_TO");	
		String  SALEPRICE_FROM			= in_vl.getString("SALEPRICE_FROM");	
		String  SALEPRICE_TO			= in_vl.getString("SALEPRICE_TO");
			
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());

        //튜닝 시작	20170705 처리자:맹수영	 
		sbSql.append("WITH WT_ITEM AS                                                                                                                                                                     \n");
		sbSql.append("(                                                                                                                                                                                   \n");
		sbSql.append("        SELECT /*+ LEADING(A) USE_NL(B) USE_NL(C) */                                                                                                                                \n");
		sbSql.append("                       '0' GUBUN, --한화                                                                                                                                            \n");
		sbSql.append("                       A.RECIPE_CD, --레시피코드                                                                                                                                         \n");
		sbSql.append("                       A.RECIPE_NAME, --레시피명                                                                                                                                        \n");
		sbSql.append("                       B.ITEM_CODE,                                                                                                                                                 \n");
		sbSql.append("                       0 AS COST_RATE, -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100)                                                                                           \n");
		sbSql.append("                       A.SALE_PRICE, -- 판매가                                                                                                                                         \n");
		sbSql.append("                       '' AS PREFER,                                                                                                                                              \n");
		sbSql.append("                       '' AS PREFER_LABEL,                                                                                                                                        \n");
		sbSql.append("                       A.RECIPE_CLASS,                                                                                                                                              \n");
		sbSql.append("                       A.RECIPE_TYPE,                                                                                                                                               \n");
		sbSql.append("                       A.CUISINE_TYPE,                                                                                                                                              \n");
		sbSql.append("                       A.PHF,                                                                                                                                                       \n");
		sbSql.append("                       B.NEED_QTY,                                                                                                                                                  \n");
		sbSql.append("                       CASE WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0                                                                           \n");
		sbSql.append("                            THEN 1                                                                                                                                                  \n");
		sbSql.append("                            ELSE 0                                                                                                                                                  \n");
		sbSql.append("                       END AS DI_MON                                                                                                                                                \n");
		sbSql.append("                  FROM FMR_STD_RECIPE_MST A,                                                                                                                                        \n");
		sbSql.append("                       FMR_STD_RECIPE_ITEM B,                                                                                                                                       \n");
		sbSql.append("                       FMM_CHG_ITEM_LIST C                                                                                                                                          \n");
		sbSql.append("                 WHERE A.RECIPE_CD = B.RECIPE_CD                                                                                                                                    \n");
		sbSql.append("                   AND A.RECIPE_CLASS IN (                                                                                                                                          \n");
		sbSql.append("                                            SELECT A.CODE                                                                                                                           \n");
		sbSql.append("                                                FROM SCC_COMMON_CODE A,                                                                                                             \n");
		sbSql.append("                                                      SCC_COMMON_CODE B                                                                                                             \n");
		sbSql.append("                                              WHERE A.GROUP_CODE = 'FS0001'                                                                                                     \n");
		sbSql.append("                                                  AND B.GROUP_CODE = 'FM0007'                                                                                                   \n");
		sbSql.append("                                                  AND B.SET2 = A.CODE                                                                                                               \n");
		sbSql.append("                                                  AND B.SET1 = '"+SUBINV_CLASS+"'                                                                                                              \n");
		sbSql.append("                                                  AND A.USE_YN='Y'                                                                                                                \n");
		sbSql.append("                                                 AND B.USE_YN='Y'                                                                                                                 \n");
		sbSql.append("                                         )                                                                                                                                          \n");
		sbSql.append("                   AND A.RECIPE_CLASS <> 'H'                                                                                                                                      \n");
		sbSql.append("                   AND C.UPJANG(+) = "+UPJANG+"                                                                                                                                          \n");
		sbSql.append("                   AND B.ITEM_CODE = C.ITEM_CODE(+)                                                                                                                                 \n");
				if(!RECIPE_NAME.equals(""))
				{
				sbSql.append("                   AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
				}
				if(!RECIPE_CLASS.equals(""))
				{
				sbSql.append("                   AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
				}
				if(!RECIPE_TYPE.equals(""))
				{
				sbSql.append("                   AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
				}
				if(!CUISINE_TYPE.equals(""))
				{
				sbSql.append("                   AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
				}
				if(!MAIN_ITEM_CODE1.equals(""))
				{
				sbSql.append("                   AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
				}
				if(!RESP_NUT1.equals(""))
				{
				sbSql.append("                   AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
				}
				if(STD_CHK.equals("0"))
				{
				sbSql.append("                   AND TO_CHAR(A.CDATE,'YYYYMMDD')='99991231'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
				}
		sbSql.append("        UNION ALL                                                                                                                                                                   \n");
		sbSql.append("        SELECT /*+ LEADING(A) USE_NL(B) */                                                                                                                                          \n");
		sbSql.append("               '1' GUBUN, --본사                                                                                                                                                    \n");
		sbSql.append("               A.RECIPE_CD, --레시피코드                                                                                                                                                 \n");
		sbSql.append("               A.RECIPE_NAME, --레시피명                                                                                                                                                \n");
		sbSql.append("               B.ITEM_CODE,                                                                                                                                                         \n");
		sbSql.append("               0 AS COST_RATE, -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100)                                                                                                   \n");
		sbSql.append("               A.SALE_PRICE, -- 판매가                                                                                                                                                 \n");
		sbSql.append("               '' AS PREFER,                                                                                                                                                      \n");
		sbSql.append("               '' AS PREFER_LABEL,                                                                                                                                                \n");
		sbSql.append("               A.RECIPE_CLASS,                                                                                                                                                      \n");
		sbSql.append("               A.RECIPE_TYPE,                                                                                                                                                       \n");
		sbSql.append("               A.CUISINE_TYPE,                                                                                                                                                      \n");
		sbSql.append("               A.PHF,                                                                                                                                                               \n");
		sbSql.append("               B.NEED_QTY,                                                                                                                                                          \n");
		sbSql.append("               CASE                                                                                                                                                                 \n");
		sbSql.append("                   WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0                                                                                    \n");
		sbSql.append("                   THEN 1                                                                                                                                                           \n");
		sbSql.append("                   ELSE 0                                                                                                                                                           \n");
		sbSql.append("               END AS DI_MON                                                                                                                                                        \n");
		sbSql.append("          FROM FMM_STD_RECIPE_MST A,                                                                                                                                                \n");
		sbSql.append("               FMM_STD_RECIPE_ITEM B                                                                                                                                                \n");
		sbSql.append("         WHERE A.UPJANG    = B.UPJANG  --->튜닝중추가확인필요                                                                                                                                \n");
		sbSql.append("           AND A.RECIPE_CD = B.RECIPE_CD                                                                                                                                            \n");
		sbSql.append("           AND A.UPJANG=(SELECT MAIN_UPJANG FROM FMS_UPJANGv WHERE UPJANG="+UPJANG+" )                                                                                                   \n");
		sbSql.append("           AND A.RECIPE_CLASS IN (                                                                                                                                                  \n");
		sbSql.append("                                    SELECT A.CODE                                                                                                                                   \n");
		sbSql.append("                                        FROM SCC_COMMON_CODE A,                                                                                                                     \n");
		sbSql.append("                                              SCC_COMMON_CODE B                                                                                                                     \n");
		sbSql.append("                                      WHERE A.GROUP_CODE = 'FS0001'                                                                                                               \n");
		sbSql.append("                                          AND B.GROUP_CODE = 'FM0007'                                                                                                             \n");
		sbSql.append("                                          AND B.SET2 = A.CODE                                                                                                                       \n");
		sbSql.append("                                          AND B.SET1 = '"+SUBINV_CLASS+"'                                                                                                                     \n");
		sbSql.append("                                          AND A.USE_YN='Y'                                                                                                                        \n");
		sbSql.append("                                         AND B.USE_YN='Y'                                                                                                                         \n");
		sbSql.append("                                   )                                                                                                                                                \n");
				if(!RECIPE_NAME.equals(""))
				{
				sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
				}
				if(!RECIPE_CLASS.equals(""))
				{
				sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
				}
				if(!RECIPE_TYPE.equals(""))
				{
				sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
				}
				if(!CUISINE_TYPE.equals(""))
				{
				sbSql.append("          AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
				}
				if(!MAIN_ITEM_CODE1.equals(""))
				{
				sbSql.append("          AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
				}
				if(!RESP_NUT1.equals(""))
				{
				sbSql.append("          AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
				}
				if(UPJANG_CHK.equals("0"))
				{
				sbSql.append("          AND TO_CHAR(A.CDATE,'YYYYMMDD')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
				}
		sbSql.append("        UNION ALL                                                                                                                                                                   \n");
		sbSql.append("        SELECT /*+ LEADING(A) USE_NL(B) */                                                                                                                                          \n");
		sbSql.append("               '2' GUBUN, --사업장                                                                                                                                                   \n");
		sbSql.append("               A.RECIPE_CD, --레시피코드                                                                                                                                                 \n");
		sbSql.append("               A.RECIPE_NAME, --레시피명                                                                                                                                                \n");
		sbSql.append("               B.ITEM_CODE, -- SUM(NVL(C.OP_PRICE,0))  RECIPE_COST, --레시피원가                                                                                                         \n");
		sbSql.append("               0 AS COST_RATE, -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100)                                                                                                   \n");
		sbSql.append("               A.SALE_PRICE, -- 판매가                                                                                                                                                 \n");
		sbSql.append("               A.PREFER,                                                                                                                                                            \n");
		sbSql.append("               (                                                                                                                                                                    \n");
		sbSql.append("                SELECT CONTENTS                                                                                                                                                     \n");
		sbSql.append("                  FROM SCC_COMMON_CODE                                                                                                                                              \n");
		sbSql.append("                 WHERE GROUP_CODE ='FS0020'                                                                                                                                       \n");
		sbSql.append("                   AND CODE=A.PREFER                                                                                                                                                \n");
		sbSql.append("               ) AS PREFER_LABEL,                                                                                                                                                   \n");
		sbSql.append("               A.RECIPE_CLASS,                                                                                                                                                      \n");
		sbSql.append("               A.RECIPE_TYPE,                                                                                                                                                       \n");
		sbSql.append("               A.CUISINE_TYPE,                                                                                                                                                      \n");
		sbSql.append("               A.PHF,                                                                                                                                                               \n");
		sbSql.append("               B.NEED_QTY,                                                                                                                                                          \n");
		sbSql.append("               CASE                                                                                                                                                                 \n");
		sbSql.append("                   WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0                                                                                    \n");
		sbSql.append("                   THEN 1                                                                                                                                                           \n");
		sbSql.append("                   ELSE 0                                                                                                                                                           \n");
		sbSql.append("               END AS DI_MON                                                                                                                                                        \n");
		sbSql.append("          FROM FMM_UPJANG_RECIPE_MST A,                                                                                                                                             \n");
		sbSql.append("               FMM_UPJANG_RECIPE_ITEM B                                                                                                                                             \n");
		sbSql.append("         WHERE A.RECIPE_CD = B.RECIPE_CD  AND A.UPJANG=B.UPJANG  AND A.SUBINV_CLASS=B.SUBINV_CLASS                                                                                  \n");
		sbSql.append("           AND A.UPJANG="+UPJANG+"                                                                                                                                                       \n");
		sbSql.append("           AND A.SUBINV_CLASS='"+SUBINV_CLASS+"'                                                                                                                                                 \n");
		sbSql.append("           AND A.RECIPE_CLASS IN (                                                                                                                                                  \n");
		sbSql.append("                                    SELECT A.CODE                                                                                                                                   \n");
		sbSql.append("                                        FROM SCC_COMMON_CODE A,                                                                                                                     \n");
		sbSql.append("                                              SCC_COMMON_CODE B                                                                                                                     \n");
		sbSql.append("                                      WHERE A.GROUP_CODE = 'FS0001'                                                                                                               \n");
		sbSql.append("                                          AND B.GROUP_CODE = 'FM0007'                                                                                                             \n");
		sbSql.append("                                          AND B.SET2 = A.CODE                                                                                                                       \n");
		sbSql.append("                                          AND B.SET1 ='"+SUBINV_CLASS+"'                                                                                                                    \n");
		sbSql.append("                                          AND A.USE_YN='Y'                                                                                                                       \n");
		sbSql.append("                                         AND B.USE_YN='Y'                                                                                                                         \n");
		sbSql.append("                                   )                                                                                                                                                \n");
				if(!RECIPE_NAME.equals(""))
				{
				sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
				}
				if(!RECIPE_CLASS.equals(""))
				{
				sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
				}
				if(!RECIPE_TYPE.equals(""))
				{
				sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
				}
				if(!CUISINE_TYPE.equals(""))
				{
				sbSql.append("          AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
				}
				if(!MAIN_ITEM_CODE1.equals(""))
				{
				sbSql.append("          AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
				}
				if(!RESP_NUT1.equals(""))
				{
				sbSql.append("          AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
				}
				if(SUBUPJANG_CHK.equals("0"))
				{
				sbSql.append("          AND TO_CHAR(A.CDATE,'YYYYMMDD')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
				}
		sbSql.append(") ,                                                                                                                                                                                 \n");
		sbSql.append("WT_ARG AS (                                                                                                                                                                         \n");
		sbSql.append("    SELECT                                                                                                                                                                          \n");
		sbSql.append("         "+UPJANG+"      AS SEEK_UPJANG                                                                                                                                                  \n");
		sbSql.append("       , ITEM_CODE  AS SEEK_ITEM_CODE                                                                                                                                               \n");
		sbSql.append("    FROM WT_ITEM                                                                                                                                                                    \n");
		sbSql.append("    GROUP BY ITEM_CODE                                                                                                                                                              \n");
		sbSql.append(")                                                                                                                                                                                   \n");
		sbSql.append("---------------------------------------------------------------------------------------------------------------------------------------------------------------------               \n");
		sbSql.append("SELECT                                                                                                                                                                              \n");
		sbSql.append("    AA.*                                                                                                                                                                            \n");
		sbSql.append("  FROM (                                                                                                                                                                            \n");
		sbSql.append("        SELECT A.GUBUN, A.RECIPE_CD, A.RECIPE_NAME, ROUND(SUM(NVL(B.OP_PRICE,0)*A.NEED_QTY)) RECIPE_COST, --레시피원가                                                                   \n");
		sbSql.append("               A.COST_RATE, A.SALE_PRICE, A.PREFER, A.PREFER_LABEL, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.DI_MON                                                  \n");
		sbSql.append("        FROM  WT_ITEM A,                                                                                                                                                            \n");
		sbSql.append("        (                                                                                                                                                                           \n");
		sbSql.append("          SELECT                                                                                                                                                                    \n");
		sbSql.append("                 A.ITEM_CODE,                                                                                                                                                       \n");
		sbSql.append("                 CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL                                                                                                          \n");
		sbSql.append("                      THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / B.KG_CONVERT_RATE / 1000  \n");
		sbSql.append("                      WHEN B.OP_PRICE IS NOT NULL OR B.OP_RATE IS NOT NULL                                                                                                          \n");
		sbSql.append("                      THEN DECODE(SIGN(NVL(B.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL), B.OP_PRICE) / B.KG_CONVERT_RATE / 1000  \n");
		sbSql.append("                      ELSE A.SALE_PRICE/ B.KG_CONVERT_RATE / 1000 END AS OP_PRICE  --운영단가                                                                                           \n");
		sbSql.append("            FROM (                                                                                                                                                                  \n");
		sbSql.append("                                                                                                                                                                                    \n");
		sbSql.append("                      SELECT                                                                                                                                                        \n");
		sbSql.append("                         "+UPJANG+"  AS UPJANG                                                                                                                                           \n");
		sbSql.append("                        , NVL('"+MENU_DATE+"', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) AS NEED_DATE                                                                                           \n");
		sbSql.append("                        , A.ITEM_CODE                                                                                                                                               \n");
		sbSql.append("                        , A.CONTRACT_PRICE AS UNIT_PRICE                                                                                                                            \n");
		sbSql.append("                        , A.SALE_PRICE                                                                                                                                              \n");
		sbSql.append("                        , A.CENTER_CODE                                                                                                                                             \n");
		sbSql.append("                        , A.CUSTCD                                                                                                                                                  \n");
		sbSql.append("                      FROM                                                                                                                                                          \n");
		sbSql.append("                      (                                                                                                                                                             \n");
		sbSql.append("                          SELECT                                                                                                                                                    \n");
		sbSql.append("                             B.AP_UNITPRICE_UPJANG                                                                                                                                  \n");
		sbSql.append("                            ,WA.SEEK_ITEM_CODE                                                                                                                                      \n");
		sbSql.append("                            ,NVL('"+MENU_DATE+"',TO_CHAR(SYSDATE,'YYYYMMDD' )) AS YYYYMMDD                                                                                           \n");
		sbSql.append("                          FROM WT_ARG WA CROSS JOIN HLDC_ST_UPJANG B                                                                                                                \n");
		sbSql.append("                          WHERE B.UPJANG = "+UPJANG+"                                                                                                                                    \n");
		sbSql.append("                          GROUP BY B.AP_UNITPRICE_UPJANG ,WA.SEEK_ITEM_CODE                                                                                                         \n");
		sbSql.append("                      ) B                                                                                                                                                           \n");
		sbSql.append("                      , HLDC_PO_CONTRACT_FSALE A                                                                                                                                    \n");
		sbSql.append("                      WHERE A.ITEM_CODE = B.SEEK_ITEM_CODE                                                                                                                          \n");
		sbSql.append("                        AND A.UPJANG    = TO_NUMBER(B.AP_UNITPRICE_UPJANG)                                                                                                          \n");
		sbSql.append("                        --AND B.YYYYMMDD BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') -- NULL이없음                                                                   \n");
		sbSql.append("                        AND B.YYYYMMDD BETWEEN A.CONTRACT_START AND A.CONTRACT_END                                                                                                  \n");
		sbSql.append("                        AND A.SALE_PRICE > 0                                                                                                                                        \n");
		sbSql.append("                        AND A.USE_YN = 'Y'                                                                                                                                        \n");
		sbSql.append("                 -----------                                                                                                                                                        \n");
		sbSql.append("                   UNION ALL                                                                                                                                                        \n");
		sbSql.append("                 -----------                                                                                                                                                        \n");
		sbSql.append("                    SELECT                                                                                                                                                          \n");
		sbSql.append("                     "+UPJANG+"  AS UPJANG,                                                                                                                                              \n");
		sbSql.append("                     NVL(TO_CHAR(TO_DATE('"+MENU_DATE+"','YYYYMMDD'),'YYYYMMDD'), TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE ,                                                    \n");
		sbSql.append("                     A.ITEM_CODE,                                                                                                                                                   \n");
		sbSql.append("                     A.UNIT_PRICE,                                                                                                                                                  \n");
		sbSql.append("                     A.SALE_PRICE,                                                                                                                                                  \n");
		sbSql.append("                     '0' CENTER_CODE,                                                                                                                                             \n");
		sbSql.append("                     0  CUSTCD                                                                                                                                                      \n");
		sbSql.append("                    FROM                                                                                                                                                            \n");
		sbSql.append("                    (                                                                                                                                                               \n");
		sbSql.append("                        SELECT                                                                                                                                                      \n");
		sbSql.append("                            A.OTCUST_PRICE_UPJANG                                                                                                                                   \n");
		sbSql.append("                          , WA.SEEK_ITEM_CODE                                                                                                                                       \n");
		sbSql.append("                          , NVL('"+MENU_DATE+"',TO_CHAR(SYSDATE,'YYYYMMDD' )) AS YYYYMMDD                                                                                            \n");
		sbSql.append("                        FROM FMS_UPJANGv A CROSS JOIN WT_ARG WA                                                                                                                     \n");
		sbSql.append("                        WHERE UPJANG = "+UPJANG+"                                                                                                                                        \n");
		sbSql.append("                        GROUP BY A.OTCUST_PRICE_UPJANG, WA.SEEK_ITEM_CODE                                                                                                           \n");
		sbSql.append("                    ) WA                                                                                                                                                            \n");
		sbSql.append("                    , FMP_OTCUST_PRICE_AVA_V A                                                                                                                                      \n");
		sbSql.append("                    WHERE WA.OTCUST_PRICE_UPJANG=A.UPJANG                                                                                                                           \n");
		sbSql.append("                      AND WA.SEEK_ITEM_CODE     =A.ITEM_CODE                                                                                                                        \n");
		sbSql.append("                      AND A.SDATE = (SELECT/*+ NO_UNNEST */  MAX(S.SDATE) FROM FMP_OTCUST_PRICE_AVA_V S                                                                             \n");
		sbSql.append("                                      WHERE S.UPJANG   = A.UPJANG                                                                                                                   \n");
		sbSql.append("                                       AND  S.ITEM_CODE= A.ITEM_CODE                                                                                                                \n");
		sbSql.append("                                       AND  S.SDATE <=  WA.YYYYMMDD)                                                                                                                \n");
		sbSql.append("                 ) A,                                                                                                                                                               \n");
		sbSql.append("                 (                                                                                                                                                                  \n");
		sbSql.append("                    SELECT /*+ LEADING(WA) */                                                                                                                                       \n");
		sbSql.append("                         B.ITEM_CODE                                                                                                                                                \n");
		sbSql.append("                        ,B.KG_CONVERT_RATE                                                                                                                                          \n");
		sbSql.append("                        ,D.OP_PRICE                                                                                                                                                 \n");
		sbSql.append("                        ,D.OP_RATE                                                                                                                                                  \n");
		sbSql.append("                        ,D.CEIL_VAL                                                                                                                                                 \n");
		sbSql.append("                    FROM WT_ARG      WA                                                                                                                                             \n");
		sbSql.append("                       , FMS_ITEM_V  B                                                                                                                                              \n");
		sbSql.append("                       , FMU_OP_RATE D                                                                                                                                              \n");
		sbSql.append("                    WHERE B.ITEM_CODE   = WA.SEEK_ITEM_CODE                                                                                                                         \n");
		sbSql.append("                      AND "+UPJANG+"         = D.UPJANG(+)                                                                                                                               \n");
		sbSql.append("                      AND B.ITEM_CLASS4 = D.ITEM_CODE(+)                                                                                                                            \n");
		sbSql.append("                      AND '"+MENU_DATE+"' BETWEEN D.SDATE(+) AND D.EDATE(+)                                                                                                            \n");
		sbSql.append("                      AND 'Y' =D.USE_YN    (+)                                                                                                                                    \n");
		sbSql.append("                      AND 'C' =D.ITEM_TYPE (+)                                                                                                                                    \n");
		sbSql.append("                 ) B,                                                                                                                                                               \n");
		sbSql.append("                 (                                                                                                                                                                  \n");
		sbSql.append("                 SELECT /*+ LEADING(WA) */                                                                                                                                          \n");
		sbSql.append("                      ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL                                                                                                                        \n");
		sbSql.append("                   FROM FMU_OP_RATE , WT_ARG WA                                                                                                                                     \n");
		sbSql.append("                  WHERE UPJANG = SEEK_UPJANG                                                                                                                                        \n");
		sbSql.append("                    AND ITEM_CODE=SEEK_ITEM_CODE                                                                                                                                    \n");
		sbSql.append("                    AND '"+MENU_DATE+"' BETWEEN SDATE AND EDATE                                                                                                                        \n");
		sbSql.append("                    AND USE_YN = 'Y'                                                                                                                                              \n");
		sbSql.append("                    AND ITEM_TYPE = 'M'                                                                                                                                          \n");
		sbSql.append("                 ) C                                                                                                                                                                \n");
		sbSql.append("      WHERE A.ITEM_CODE = B.ITEM_CODE                                                                                                                                               \n");
		sbSql.append("        AND B.ITEM_CODE = C.ITEM_CODE(+)                                                                                                                                            \n");
		sbSql.append("       ) B                                                                                                                                                                          \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+)                                                                                                                                                 \n");
		sbSql.append(" GROUP BY A.GUBUN, A.RECIPE_CD, A.RECIPE_NAME, A.COST_RATE, A.SALE_PRICE, A.PREFER, A.PREFER_LABEL, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.DI_MON                  \n");
		sbSql.append(" ORDER BY GUBUN DESC, RECIPE_CD                                                                                                                                                     \n");
		sbSql.append(") AA                                                                                                                                                                                \n");
		sbSql.append("WHERE 1=1                                                                                                                                                                          \n");
				if(!UNITPRICE_FROM.equals(""))
				{
					sbSql.append("   AND AA.RECIPE_COST > "+UNITPRICE_FROM+" \n");
				}
				if(!UNITPRICE_TO.equals(""))
				{
					sbSql.append("   AND AA.RECIPE_COST < "+UNITPRICE_TO+" \n");
				}
				if(!SALEPRICE_FROM.equals(""))
				{
					sbSql.append("   AND AA.SALE_PRICE > "+SALEPRICE_FROM+" \n");
				}
				if(!SALEPRICE_TO.equals(""))
				{
					sbSql.append("   AND AA.SALE_PRICE < "+SALEPRICE_TO+" \n");
				}		
        //튜닝 끝 20170705 처리자:맹수영
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);
		rs.close();
		pstmt.close();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception e) {}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e) {}
			}
			//jsp log 서비스 닫기 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}				
		}
		
	  proc_output(response,out,out_vl,out_dl);

%>
<%-- 기존쿼리 : 20170705 튜닝 전
		sbSql.append("SELECT AA.* \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT A.GUBUN, A.RECIPE_CD, A.RECIPE_NAME, ROUND(SUM(NVL(B.OP_PRICE,0)*A.NEED_QTY)) RECIPE_COST, --레시피원가 \n");
		sbSql.append("               A.COST_RATE, A.SALE_PRICE, A.PREFER, A.PREFER_LABEL, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.DI_MON \n");
		sbSql.append("          FROM ( \n");
		sbSql.append("                SELECT '0' GUBUN, --한화 \n");
		sbSql.append("                       A.RECIPE_CD, --레시피코드 \n");
		sbSql.append("                       A.RECIPE_NAME, --레시피명 \n");
		sbSql.append("                       B.ITEM_CODE, \n");
		sbSql.append("                       0 AS COST_RATE, -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("                       A.SALE_PRICE, -- 판매가 \n");
		sbSql.append("                       '' AS PREFER, \n");
		sbSql.append("                       '' AS PREFER_LABEL, \n");
		sbSql.append("                       A.RECIPE_CLASS, \n");
		sbSql.append("                       A.RECIPE_TYPE, \n");
		sbSql.append("                       A.CUISINE_TYPE, \n");
		sbSql.append("                       A.PHF, \n");
		sbSql.append("                       B.NEED_QTY, \n");
		sbSql.append("                       CASE WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 \n");
		sbSql.append("                            THEN 1 \n");
		sbSql.append("                            ELSE 0 \n");
		sbSql.append("                       END AS DI_MON \n");
		sbSql.append("                  FROM FMR_STD_RECIPE_MST A, \n");
		sbSql.append("                       FMR_STD_RECIPE_ITEM B, \n");
		sbSql.append("                       FMM_CHG_ITEM_LIST C \n");
		sbSql.append("                 WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("                   AND A.RECIPE_CLASS IN ( \n");
		sbSql.append("								            SELECT A.CODE \n");
		sbSql.append("				  				              FROM SCC_COMMON_CODE A, \n");
		sbSql.append("				       				               SCC_COMMON_CODE B \n");
		sbSql.append("				 				             WHERE A.GROUP_CODE = 'FS0001' \n");
		sbSql.append("				   				               AND B.GROUP_CODE = 'FM0007' \n");
		sbSql.append("				   				               AND B.SET2 = A.CODE \n");
		sbSql.append("				   				               AND B.SET1 = '"+SUBINV_CLASS+"' \n");
		sbSql.append("				   				               AND A.USE_YN='Y' \n");
		sbSql.append("				  				               AND B.USE_YN='Y'	\n");
		sbSql.append("								           ) \n");
		sbSql.append("                   AND A.RECIPE_CLASS <> 'H' \n");
		sbSql.append("                   AND C.UPJANG(+) = "+UPJANG+" \n");
		sbSql.append("                   AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("                   AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("                   AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("                   AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("                   AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("                   AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("                   AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
		}
		if(STD_CHK.equals("0"))
		{
		sbSql.append("                   AND TO_CHAR(A.CDATE,'YYYYMMDD')='99991231'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("        UNION ALL \n");
		sbSql.append("        SELECT '1' GUBUN, --본사 \n");
		sbSql.append("               A.RECIPE_CD, --레시피코드 \n");
		sbSql.append("               A.RECIPE_NAME, --레시피명 \n");
		sbSql.append("               B.ITEM_CODE, \n");
		sbSql.append("               0 AS COST_RATE, -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("               A.SALE_PRICE, -- 판매가 \n");
		sbSql.append("               '' AS PREFER, \n");
		sbSql.append("               '' AS PREFER_LABEL, \n");
		sbSql.append("               A.RECIPE_CLASS, \n");
		sbSql.append("               A.RECIPE_TYPE, \n");
		sbSql.append("               A.CUISINE_TYPE, \n");
		sbSql.append("               A.PHF, \n");
		sbSql.append("               B.NEED_QTY, \n");
		sbSql.append("               CASE \n");
		sbSql.append("                   WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 \n");
		sbSql.append("                   THEN 1 \n");
		sbSql.append("                   ELSE 0 \n");
		sbSql.append("               END AS DI_MON \n");
		sbSql.append("          FROM FMM_STD_RECIPE_MST A, \n");
		sbSql.append("               FMM_STD_RECIPE_ITEM B \n");
		sbSql.append("         WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("           AND A.UPJANG=(SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG="+UPJANG+") \n");
		sbSql.append("           AND A.RECIPE_CLASS IN ( \n");
		sbSql.append("								    SELECT A.CODE \n");
		sbSql.append("				  				      FROM SCC_COMMON_CODE A,	\n");
		sbSql.append("				       				       SCC_COMMON_CODE B \n");
		sbSql.append("				 				     WHERE A.GROUP_CODE = 'FS0001' \n");
		sbSql.append("				   				       AND B.GROUP_CODE = 'FM0007' \n");
		sbSql.append("				   				       AND B.SET2 = A.CODE \n");
		sbSql.append("				   				       AND B.SET1 = '"+SUBINV_CLASS+"' \n");
		sbSql.append("				   				       AND A.USE_YN='Y' \n");
		sbSql.append("				  				       AND B.USE_YN='Y' \n");
		sbSql.append("								   )						 \n");		
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
		}
		if(UPJANG_CHK.equals("0"))
		{
		sbSql.append("          AND TO_CHAR(A.CDATE,'YYYYMMDD')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("        UNION ALL \n");
		sbSql.append("        SELECT '2' GUBUN, --사업장 \n");
		sbSql.append("               A.RECIPE_CD, --레시피코드 \n");
		sbSql.append("               A.RECIPE_NAME, --레시피명 \n");
		sbSql.append("               B.ITEM_CODE, -- SUM(NVL(C.OP_PRICE,0))  RECIPE_COST, --레시피원가 \n");
		sbSql.append("               0 AS COST_RATE, -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("               A.SALE_PRICE, -- 판매가 \n");
		sbSql.append("               A.PREFER, \n");
		sbSql.append("               ( \n");
		sbSql.append("                SELECT CONTENTS \n");
		sbSql.append("                  FROM SCC_COMMON_CODE \n");
		sbSql.append("                 WHERE GROUP_CODE ='FS0020' \n");
		sbSql.append("                   AND CODE=A.PREFER \n");
		sbSql.append("               ) AS PREFER_LABEL, \n");
		sbSql.append("               A.RECIPE_CLASS, \n");
		sbSql.append("               A.RECIPE_TYPE, \n");
		sbSql.append("               A.CUISINE_TYPE, \n");
		sbSql.append("               A.PHF, \n");
		sbSql.append("               B.NEED_QTY, \n");
		sbSql.append("               CASE \n");
		sbSql.append("                   WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 \n");
		sbSql.append("                   THEN 1 \n");
		sbSql.append("                   ELSE 0 \n");
		sbSql.append("               END AS DI_MON \n");
		sbSql.append("          FROM FMM_UPJANG_RECIPE_MST A, \n");
		sbSql.append("               FMM_UPJANG_RECIPE_ITEM B \n");
		sbSql.append("         WHERE A.RECIPE_CD = B.RECIPE_CD  AND A.UPJANG=B.UPJANG  AND A.SUBINV_CLASS=B.SUBINV_CLASS \n");
		sbSql.append("           AND A.UPJANG="+UPJANG+" \n");
		sbSql.append("           AND A.SUBINV_CLASS='"+SUBINV_CLASS+"' \n");
		sbSql.append("           AND A.RECIPE_CLASS IN ( \n");
		sbSql.append("								    SELECT A.CODE \n");
		sbSql.append("				  				      FROM SCC_COMMON_CODE A, \n");
		sbSql.append("				       				       SCC_COMMON_CODE B \n");
		sbSql.append("				 				     WHERE A.GROUP_CODE = 'FS0001' \n");
		sbSql.append("				   				       AND B.GROUP_CODE = 'FM0007' \n");
		sbSql.append("				   				       AND B.SET2 = A.CODE \n");
		sbSql.append("				   				       AND B.SET1 = '"+SUBINV_CLASS+"' \n");
		sbSql.append("				   				       AND A.USE_YN='Y' \n");
		sbSql.append("				  				       AND B.USE_YN='Y' \n");
		sbSql.append("								   ) \n");		
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
		}
		if(SUBUPJANG_CHK.equals("0"))
		{
		sbSql.append("          AND TO_CHAR(A.CDATE,'YYYYMMDD')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("       ) A, \n");
		sbSql.append("       ( \n");
		sbSql.append("          SELECT \n");
		sbSql.append("                 A.ITEM_CODE, \n");
		sbSql.append("                 CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                      THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / B.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                      WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                      THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) / B.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                      ELSE A.SALE_PRICE/ B.KG_CONVERT_RATE / 1000 END AS OP_PRICE  --운영단가 \n");
		sbSql.append("            FROM ( \n");
		sbSql.append("                  SELECT "+UPJANG+" AS UPJANG , \n");
		sbSql.append("                         NVL('"+MENU_DATE+"', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) AS NEED_DATE , \n");
		sbSql.append("                         A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE, A.CENTER_CODE, A.CUSTCD \n");
		sbSql.append("                    FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
		sbSql.append("                   WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                     AND B.UPJANG = "+UPJANG+" \n");
		sbSql.append("                     AND NVL( '"+MENU_DATE+"', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("                     AND A.SALE_PRICE > 0 \n");
		sbSql.append("                     AND A.USE_YN = 'Y' \n");
		sbSql.append("                 ----------- \n");
		sbSql.append("                   UNION ALL \n");
		sbSql.append("                 ----------- \n");
		sbSql.append("                  SELECT "+UPJANG+" AS UPJANG, \n");
		sbSql.append("                         NVL(TO_CHAR(TO_DATE('"+MENU_DATE+"','YYYYMMDD'),'YYYYMMDD'), TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE , \n");
		sbSql.append("                         A.ITEM_CODE, \n");
		sbSql.append("                         A.UNIT_PRICE, \n");
		sbSql.append("                         A.SALE_PRICE, \n");
		sbSql.append("                         0 CENTER_CODE, \n");
		sbSql.append("                         0 CUSTCD \n");
		sbSql.append("                    FROM FMP_OTCUST_PRICE_AVA_V A, \n");
		sbSql.append("                         ( \n");
		sbSql.append("                          SELECT UPJANG, \n");
		sbSql.append("                                 ITEM_CODE, \n");
		sbSql.append("                                 MAX(SDATE) AS SDATE \n");
		sbSql.append("                            FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                           WHERE UPJANG = \n");
		sbSql.append("                                         ( \n");
		sbSql.append("                                          SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                                            FROM FMS_UPJANG \n");
		sbSql.append("                                           WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                                         ) \n");
		sbSql.append("                             AND SDATE <= NVL(TO_CHAR(TO_DATE('"+MENU_DATE+"','YYYYMMDD'),'YYYYMMDD'), TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                           GROUP BY UPJANG, \n");
		sbSql.append("                                 ITEM_CODE \n");
		sbSql.append("                         ) B \n");
		sbSql.append("                  WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                    AND A.SDATE = B.SDATE \n");
		sbSql.append("                    AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                    AND A.SALE_PRICE > 0 \n");
		sbSql.append("                    AND A.USE_YN = 'Y' \n");
		sbSql.append("                 ) A, \n");
		sbSql.append("                 FMS_ITEM_V B, \n");
		sbSql.append("                 ( \n");        
		sbSql.append("                 SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("                   FROM FMU_OP_RATE \n");
		sbSql.append("                  WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                    AND '"+MENU_DATE+"' BETWEEN SDATE AND EDATE \n");
		sbSql.append("                    AND USE_YN = 'Y' \n");
		sbSql.append("                    AND ITEM_TYPE = 'M' \n");
		sbSql.append("                 ) C, \n");
		sbSql.append("                 ( \n");        
		sbSql.append("                 SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("                   FROM FMU_OP_RATE \n");
		sbSql.append("                  WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                    AND '"+MENU_DATE+"' BETWEEN SDATE AND EDATE \n");
		sbSql.append("                    AND USE_YN = 'Y' \n");
		sbSql.append("                    AND ITEM_TYPE = 'C' \n");
		sbSql.append("                 ) D \n");
		sbSql.append("      WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("        AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("        AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		sbSql.append("       ) B \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY A.GUBUN, A.RECIPE_CD, A.RECIPE_NAME, A.COST_RATE, A.SALE_PRICE, A.PREFER, A.PREFER_LABEL, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.DI_MON \n");
		sbSql.append(" ORDER BY GUBUN DESC, RECIPE_CD \n");
		sbSql.append(") AA \n");
		sbSql.append("WHERE 1=1 \n");
		if(!UNITPRICE_FROM.equals(""))
		{
			sbSql.append("   AND AA.RECIPE_COST > "+UNITPRICE_FROM+" \n");
		}
		if(!UNITPRICE_TO.equals(""))
		{
			sbSql.append("   AND AA.RECIPE_COST < "+UNITPRICE_TO+" \n");
		}
		if(!SALEPRICE_FROM.equals(""))
		{
			sbSql.append("   AND AA.SALE_PRICE > "+SALEPRICE_FROM+" \n");
		}
		if(!SALEPRICE_TO.equals(""))
		{
			sbSql.append("   AND AA.SALE_PRICE < "+SALEPRICE_TO+" \n");
		}		


 --%>
<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));			
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
	
		String  STD_CHK					= in_vl.getString("STD_CHK");			
		String  UPJANG_CHK				= in_vl.getString("UPJANG_CHK");		
		String  SUBUPJANG_CHK			= in_vl.getString("SUBUPJANG_CHK");	
		String  RECIPE_NAME				= in_vl.getString("RECIPE_NAME");		
		String  RECIPE_CLASS			= in_vl.getString("RECIPE_CLASS");	
		String  RECIPE_TYPE				= in_vl.getString("RECIPE_TYPE");		
		String  CUISINE_TYPE			= in_vl.getString("CUISINE_TYPE");	
		String  MAIN_ITEM_CODE1			= in_vl.getString("MAIN_ITEM_CODE1");	
		String  RESP_NUT1				= in_vl.getString("RESP_NUT1");		
		String  MENU_DATE				= in_vl.getString("MENU_DATE");		
		String  UPJANG					= in_vl.getString("UPJANG");			
		String  SUBINV_CLASS			= in_vl.getString("SUBINV_CLASS");		
		String  UNITPRICE_FROM			= in_vl.getString("UNITPRICE_FROM");	
		String  UNITPRICE_TO			= in_vl.getString("UNITPRICE_TO");	
		String  SALEPRICE_FROM			= in_vl.getString("SALEPRICE_FROM");	
		String  SALEPRICE_TO			= in_vl.getString("SALEPRICE_TO");
		
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
	//	System.out.println("::::==============FMM00210V_S009");

	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		//운영율 설정조회
// 		sbSql.delete(0, sbSql.length());
// 		sbSql.append("SELECT FMS_OPRATEINFO_FUN(" + UPJANG + ", NVL( '"+MENU_DATE+"', TO_CHAR(SYSDATE,'YYYYMMDD' ) )) AS OP_LEN FROM DUAL \n");
// 		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
// 		rs = pstmt.executeQuery();
// 		rs.next();
// 		String strOpLen = rs.getString("OP_LEN");
// 		rs.close();
// 		pstmt.close();

		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT AA.* \n");
		sbSql.append("FROM (      \n");
		sbSql.append("SELECT \n");
		sbSql.append("       A.GUBUN, A.RECIPE_CD, A.RECIPE_NAME, ROUND(SUM(NVL(B.OP_PRICE,0)*A.NEED_QTY)) RECIPE_COST, --레시피원가 \n");
		sbSql.append("       A.COST_RATE, A.SALE_PRICE, A.PREFER, A.PREFER_LABEL, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.DI_MON \n");
		sbSql.append("  FROM \n");
		sbSql.append("       ( \n");
		sbSql.append("       SELECT '0' GUBUN,              --한화 \n");
		sbSql.append("              A.RECIPE_CD,            --레시피코드 \n");
		sbSql.append("              A.RECIPE_NAME,          --레시피명 \n");
		sbSql.append("              B.ITEM_CODE, \n");
		sbSql.append("              0 AS COST_RATE,         -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("              A.SALE_PRICE,           -- 판매가 \n");
		sbSql.append("              '' AS PREFER, \n");
		sbSql.append("              '' AS PREFER_LABEL, \n");
		sbSql.append("              A.RECIPE_CLASS, \n");
		sbSql.append("              A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE, \n");
		sbSql.append("              A.PHF, \n");
		sbSql.append("              B.NEED_QTY, \n");
		sbSql.append("              CASE WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 \n");
		sbSql.append("                   THEN 1 \n");
		sbSql.append("                   ELSE 0 \n");
		sbSql.append("              END   DI_MON \n");
		sbSql.append("         FROM FMR_STD_RECIPE_MST A , \n");
		sbSql.append("              ( \n");

		sbSql.append("              SELECT B.RECIPE_CD,FMM_CHGITEM_FUN("+UPJANG+", B.ITEM_CODE) ITEM_CODE,SUM(B.NEED_QTY) NEED_QTY    	\n");
		sbSql.append("              FROM   FMR_STD_RECIPE_MST A,                                                                  	\n");
		sbSql.append("                     FMR_STD_RECIPE_ITEM B                                                                  	\n");
		sbSql.append("              WHERE  A.RECIPE_CD = B.RECIPE_CD                                                              	\n");
		sbSql.append("              AND  A.RECIPE_CLASS<>'H'                                                                      	\n");
		sbSql.append("              AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%'                                                 	\n");
		sbSql.append("              GROUP BY B.RECIPE_CD,FMM_CHGITEM_FUN("+UPJANG+", B.ITEM_CODE)                                     	\n");
		sbSql.append("              ) B \n");
		
		sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("        AND A.RECIPE_CLASS IN (				 \n");
		sbSql.append("								SELECT /*+ UNNEST NL_SJ */ A.CODE 				 \n");
		sbSql.append("				  				FROM SCC_COMMON_CODE A				 \n");
		sbSql.append("				       				,SCC_COMMON_CODE B				 \n");
		sbSql.append("				 				WHERE A.GROUP_CODE = 'FS0001'				 \n");
		sbSql.append("				   				AND B.GROUP_CODE = 'FM0007'				 \n");
		sbSql.append("				   				AND B.SET2 = A.CODE				 \n");
		sbSql.append("				   				AND B.SET1 = '"+SUBINV_CLASS+"'				 \n");
		sbSql.append("				   				AND A.USE_YN='Y'				 \n");
		sbSql.append("				  				AND B.USE_YN='Y'				 \n");
		sbSql.append("								)						 \n");
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
		}
		if(STD_CHK.equals("0"))
		{
		sbSql.append("          AND to_char(A.CDATE,'yyyymmdd')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT /*+ NO_MERGE INDEX(A FMM_STD_RECIPE_MST_PK)  */ '1' GUBUN,       --본사 \n");
		sbSql.append("              A.RECIPE_CD,     --레시피코드 \n");
		sbSql.append("              A.RECIPE_NAME,   --레시피명 \n");
		sbSql.append("              B.ITEM_CODE, \n");
		sbSql.append("              0 AS COST_RATE,  -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("              A.SALE_PRICE,    -- 판매가 \n");
		sbSql.append("              '' AS PREFER, \n");
		sbSql.append("              '' AS PREFER_LABEL, \n");
		sbSql.append("              A.RECIPE_CLASS, \n");
		sbSql.append("              A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE, \n");
		sbSql.append("              A.PHF, \n");
		sbSql.append("              B.NEED_QTY, \n");
		sbSql.append("              CASE \n");
		sbSql.append("                     WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 \n");
		sbSql.append("                     THEN 1 \n");
		sbSql.append("                     ELSE 0 \n");
		sbSql.append("              END    DI_MON \n");
		sbSql.append("         FROM FMM_STD_RECIPE_MST A , \n");
		sbSql.append("              FMM_STD_RECIPE_ITEM B \n");
		sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("          AND A.UPJANG=(SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG="+UPJANG+") \n");
		sbSql.append("        AND A.RECIPE_CLASS IN (				 \n");
		sbSql.append("								SELECT /*+ UNNEST NL_SJ */ A.CODE 				 \n");
		sbSql.append("				  				FROM SCC_COMMON_CODE A				 \n");
		sbSql.append("				       				,SCC_COMMON_CODE B				 \n");
		sbSql.append("				 				WHERE A.GROUP_CODE = 'FS0001'				 \n");
		sbSql.append("				   				AND B.GROUP_CODE = 'FM0007'				 \n");
		sbSql.append("				   				AND B.SET2 = A.CODE				 \n");
		sbSql.append("				   				AND B.SET1 = '"+SUBINV_CLASS+"'				 \n");
		sbSql.append("				   				AND A.USE_YN='Y'				 \n");
		sbSql.append("				  				AND B.USE_YN='Y'				 \n");
		sbSql.append("								)						 \n");		
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
		}
		if(UPJANG_CHK.equals("0"))
		{
		sbSql.append("          AND to_char(A.CDATE,'yyyymmdd')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT /*+ NO_MERGE LEADING(A B) USE_NL(A B) */ '2' GUBUN,       --사업장 \n");
		sbSql.append("              A.RECIPE_CD,     --레시피코드 \n");
		sbSql.append("              A.RECIPE_NAME,   --레시피명 \n");
		sbSql.append("              B.ITEM_CODE,     --       SUM(NVL(C.OP_PRICE,0))  RECIPE_COST, --레시피원가 \n");
		sbSql.append("              0 AS COST_RATE,  -- 수식으로 해결 => 판매가가 0이 아닐 경우 ROUND((레시피원가/판매가)*100) \n");
		sbSql.append("              A.SALE_PRICE,    -- 판매가 \n");
		sbSql.append("              A.PREFER, \n");
		sbSql.append("              ( \n");
		sbSql.append("              SELECT CONTENTS \n");
		sbSql.append("                FROM SCC_COMMON_CODE \n");
		sbSql.append("               WHERE GROUP_CODE ='FS0020' \n");
		sbSql.append("                 AND CODE=A.PREFER \n");
		sbSql.append("              ) PREFER_LABEL, \n");
		sbSql.append("              A.RECIPE_CLASS, \n");
		sbSql.append("              A.RECIPE_TYPE, \n");
		sbSql.append("              A.CUISINE_TYPE, \n");
		sbSql.append("              A.PHF, \n");
		sbSql.append("              B.NEED_QTY, \n");
		sbSql.append("              CASE \n");
		sbSql.append("                     WHEN MONTHS_BETWEEN( SYSDATE, DECODE(A.CDATE, NULL, SYSDATE, A.CDATE) )<= 1.0 \n");
		sbSql.append("                     THEN 1 \n");
		sbSql.append("                     ELSE 0 \n");
		sbSql.append("              END \n");
		sbSql.append("              DI_MON \n");
		sbSql.append("         FROM FMM_UPJANG_RECIPE_MST A , \n");
		sbSql.append("              FMM_UPJANG_RECIPE_ITEM B \n");
		sbSql.append("        WHERE A.RECIPE_CD = B.RECIPE_CD  AND A.UPJANG=B.UPJANG  AND A.SUBINV_CLASS=B.SUBINV_CLASS       \n");
		sbSql.append("          AND A.UPJANG="+UPJANG+" \n");
		sbSql.append("          AND A.SUBINV_CLASS='"+SUBINV_CLASS+"' \n");
		sbSql.append("        AND A.RECIPE_CLASS IN (				 \n");
		sbSql.append("								SELECT /*+ UNNEST NL_SJ */ A.CODE 				 \n");
		sbSql.append("				  				FROM SCC_COMMON_CODE A				 \n");
		sbSql.append("				       				,SCC_COMMON_CODE B				 \n");
		sbSql.append("				 				WHERE A.GROUP_CODE = 'FS0001'				 \n");
		sbSql.append("				   				AND B.GROUP_CODE = 'FM0007'				 \n");
		sbSql.append("				   				AND B.SET2 = A.CODE				 \n");
		sbSql.append("				   				AND B.SET1 = '"+SUBINV_CLASS+"'				 \n");
		sbSql.append("				   				AND A.USE_YN='Y'				 \n");
		sbSql.append("				  				AND B.USE_YN='Y'				 \n");
		sbSql.append("								)						 \n");		
		if(!RECIPE_NAME.equals(""))
		{
		sbSql.append("          AND A.RECIPE_NAME LIKE '%'||'"+RECIPE_NAME+"'||'%' \n");
		}
		if(!RECIPE_CLASS.equals(""))
		{
		sbSql.append("          AND A.RECIPE_CLASS = '"+RECIPE_CLASS+"' \n");
		}
		if(!RECIPE_TYPE.equals(""))
		{
		sbSql.append("          AND A.RECIPE_TYPE = '"+RECIPE_TYPE+"' \n");
		}
		if(!CUISINE_TYPE.equals(""))
		{
		sbSql.append("          AND A.CUISINE_TYPE = '"+CUISINE_TYPE+"' \n");
		}
		if(!MAIN_ITEM_CODE1.equals(""))
		{
		sbSql.append("          AND A.MAIN_ITEM_CODE1 = '"+MAIN_ITEM_CODE1+"' \n");
		}
		if(!RESP_NUT1.equals(""))
		{
		sbSql.append("          AND A.RESP_NUT1 = '"+RESP_NUT1+"' \n");
		}
		if(SUBUPJANG_CHK.equals("0"))
		{
		sbSql.append("          AND to_char(A.CDATE,'yyyymmdd')='99999999'	-- 본사 레시피 미체크이면 데이타 없도록 \n");
		}
		sbSql.append("       ) A, \n");
		sbSql.append("       ( \n");
		sbSql.append("          SELECT /*+-- ORDERED USE_HASH(A B) */ \n");
		sbSql.append("                 A.ITEM_CODE, \n");
		
		sbSql.append("                 CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL              \n");
		sbSql.append("                      THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) / B.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                      WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL              \n");
		sbSql.append("                      THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) / B.KG_CONVERT_RATE / 1000 \n");
		sbSql.append("                      ELSE 0 END AS OP_PRICE  --운영단가(1인원가)                       \n");
		
		sbSql.append("            FROM  \n");
		sbSql.append("                 ( \n");
		sbSql.append("                     SELECT "+UPJANG+" AS UPJANG , \n");
		sbSql.append("                            NVL('"+MENU_DATE+"', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) AS NEED_DATE , \n");
		sbSql.append("                            A.ITEM_CODE, A.CONTRACT_PRICE AS UNIT_PRICE, A.SALE_PRICE, A.CENTER_CODE, A.CUSTCD \n");
		sbSql.append("                       FROM HLDC_PO_CONTRACT_FSALE A, HLDC_ST_UPJANG B \n");
		sbSql.append("                       WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG \n");
		sbSql.append("                         AND B.UPJANG = "+UPJANG+" \n");
		sbSql.append("                         AND NVL( '"+MENU_DATE+"', TO_CHAR(SYSDATE,'YYYYMMDD' ) ) BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'20201231') \n");
		sbSql.append("                         AND A.SALE_PRICE > 0 \n");
		sbSql.append("                         AND A.USE_YN = 'Y' \n");
		sbSql.append("                 ----------- \n");
		sbSql.append("                  UNION ALL \n");
		sbSql.append("                 ----------- \n");
		sbSql.append("                 SELECT "+UPJANG+" AS UPJANG, \n");
		sbSql.append("                        NVL(TO_CHAR(TO_DATE('"+MENU_DATE+"','YYYYMMDD'),'YYYYMMDD'), TO_CHAR(SYSDATE,'YYYYMMDD')) AS NEED_DATE , \n");
		sbSql.append("                        A.ITEM_CODE, \n");
		sbSql.append("                        A.UNIT_PRICE, \n");
		sbSql.append("                        A.SALE_PRICE, \n");
		sbSql.append("                        0 CENTER_CODE, \n");
		sbSql.append("                        0 CUSTCD \n");
		sbSql.append("                   FROM FMP_OTCUST_PRICE_AVA_V A , \n");
		sbSql.append("                        ( \n");
		sbSql.append("                        SELECT UPJANG, \n");
		sbSql.append("                               ITEM_CODE, \n");
		sbSql.append("                               MAX(SDATE) AS SDATE \n");
		sbSql.append("                          FROM FMP_OTCUST_PRICE_AVA_V \n");
		sbSql.append("                         WHERE UPJANG = \n");
		sbSql.append("                               ( \n");
		sbSql.append("                               SELECT OTCUST_PRICE_UPJANG \n");
		sbSql.append("                                 FROM FMS_UPJANG \n");
		sbSql.append("                                WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                               ) \n");
		sbSql.append("                           AND SDATE <= NVL(TO_CHAR(TO_DATE('"+MENU_DATE+"','YYYYMMDD'),'YYYYMMDD'), TO_CHAR(SYSDATE,'YYYYMMDD')) \n");
		sbSql.append("                         GROUP BY UPJANG, \n");
		sbSql.append("                               ITEM_CODE \n");
		sbSql.append("                        ) B \n");
		sbSql.append("                  WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                    AND A.SDATE = B.SDATE \n");
		sbSql.append("                    AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                    AND A.SALE_PRICE > 0 \n");
		sbSql.append("                    AND A.USE_YN = 'Y' \n");
		sbSql.append("                 ) A, \n");
		sbSql.append("                 FMS_ITEM_V B, \n");
		
		sbSql.append("                 ( \n");        
		sbSql.append("                 SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("                   FROM FMU_OP_RATE \n");
		sbSql.append("                  WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                    AND '"+MENU_DATE+"' BETWEEN SDATE AND EDATE \n");
		sbSql.append("                    AND USE_YN = 'Y' \n");
		sbSql.append("                    AND ITEM_TYPE = 'M' \n");
		sbSql.append("                 ) C, \n");
		sbSql.append("                 ( \n");        
		sbSql.append("                 SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL \n");
		sbSql.append("                   FROM FMU_OP_RATE \n");
		sbSql.append("                  WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                    AND '"+MENU_DATE+"' BETWEEN SDATE AND EDATE \n");
		sbSql.append("                    AND USE_YN = 'Y' \n");
		sbSql.append("                    AND ITEM_TYPE = 'C' \n");
		sbSql.append("                 ) D \n");
		
		sbSql.append("      WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("        AND B.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("        AND B.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		
		sbSql.append("       ) B \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY A.GUBUN, A.RECIPE_CD, A.RECIPE_NAME, A.COST_RATE, A.SALE_PRICE, A.PREFER, A.PREFER_LABEL, A.RECIPE_CLASS, A.RECIPE_TYPE, A.CUISINE_TYPE, A.PHF, A.DI_MON \n");
		sbSql.append(" ORDER BY GUBUN DESC, RECIPE_CD \n");
		sbSql.append(") AA \n");
		sbSql.append("WHERE 1=1 \n");
		if(!UNITPRICE_FROM.equals(""))
		{
			sbSql.append("   AND AA.RECIPE_COST > "+UNITPRICE_FROM+" \n");
			//sbSql.append("   AND A.RECIPE_COST &gt; "+UNITPRICE_FROM+" \n");//SUM(NVL(B.OP_PRICE,0))
		}
		if(!UNITPRICE_TO.equals(""))
		{
			sbSql.append("   AND AA.RECIPE_COST < "+UNITPRICE_TO+" \n");
			//sbSql.append("   AND A.RECIPE_COST < "+UNITPRICE_TO+" \n");
		}
		if(!SALEPRICE_FROM.equals(""))
		{
			sbSql.append("   AND AA.SALE_PRICE > "+SALEPRICE_FROM+" \n");
		}
		if(!SALEPRICE_TO.equals(""))
		{
			sbSql.append("   AND AA.SALE_PRICE < "+SALEPRICE_TO+" \n");
		}		
		
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_List = this.makeDataSet(rs,"ds_List");
		out_dl.add(ds_List);
		rs.close();
		pstmt.close();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
			if(rs != null) {
				try {
					rs.close();
				}catch(Exception e) {}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(Exception e) {}
			}
			if(conn != null) {
				try {
					conn.close();
				}catch(Exception e) {}
			}
			//jsp log 서비스 닫기 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}				
		}
		
	  proc_output(response,out,out_vl,out_dl);

--%>