<%  
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00080E_T001.jsp
■ 프로그램명   : 주문상품 조회
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2008.01.21
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회

        sbSql.append("SELECT A.ITEM_CODE, A.ITEM_NAME, A.ITEM_SIZE, A.PO_UOM, A.UNIT_PRICE, A.UNIT_PRICE AS MARGIN_PRICE                                                                                                                            \n");
        sbSql.append("     , A.SALE_PRICE, B.DEF_QTY AS PR_QTY, ROUND(A.SALE_PRICE * B.DEF_QTY) AS SALE_AMOUNT                                                                                                                                      \n");
        sbSql.append("     , '004' AS LINE_STATUS, '마감전' AS CLS_STATUS, NULL AS PR_REMARK                                                                                                                                                        \n");
        sbSql.append("     , 'S1010967' AS SUBINV_CODE, A.NEED_DATE                                                                                                                                                                                 \n");
        sbSql.append("     , A.TAX_CODE, A.CUSTCD, A.CENTER_FLAG                                                                                                                                                                                    \n");
        sbSql.append("     , A.CENTER_CODE, A.POINT_FLAG, 131029 AS PR_UPJANG                                                                                                                                                                       \n");
        sbSql.append("     , A.UPJANG AS RC_UPJANG, 'N' AS INVAT_FLAG, 'N' AS OUTVAT_FLAG                                                                                                                                                           \n");
        sbSql.append("     , A.MIN_ORD_QTY, A.MAX_ORD_QTY, A.MULTIPLIER_QTY                                                                                                                                                                         \n");
        sbSql.append("     , A.OTCUSTCD                                                                                                                                                                                                             \n");
        sbSql.append("     , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) AS OP_PRICE                             \n");
        sbSql.append("     , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE) * B.DEF_QTY) AS OP_AMOUNT         \n");
        sbSql.append("     , ROUND(DECODE(SIGN(NVL(C.OP_PRICE,0)),0, CEIL((A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100)) / POWER(10,NVL(C.CEIL_VAL,0))) * POWER(10,NVL(C.CEIL_VAL,0)), C.OP_PRICE)/A.KG_CONVERT_RATE/1000,1) AS G_PRICE \n");
        sbSql.append("     , FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS) AS D_DAYS                                                                                                                                                                     \n");
        sbSql.append("     , A.D_TIMES                                                                                                                                                                                                              \n");
        sbSql.append("     , 'D-'||TO_CHAR(FMP_GETEXCDAYS_FUN(A.NEED_DATE,A.D_DAYS))||' '||TRIM(TO_CHAR(A.D_TIMES,'0000')) AS D_DAY_DISP                                                                                                            \n");
        sbSql.append("     , D.OTCUSTNM, A.KG_CONVERT_RATE                                                                                                                                                                                          \n");
        sbSql.append("     , A.FEATURE_NAME                                                                                                                                                                                                         \n");
        sbSql.append("     , A.IMAGE_PATH, DECODE(A.IMAGE_PATH,NULL,'N','Y') AS IMAGE_YN                                                                                                                                                            \n");
        sbSql.append("     , A.WEEK_ITEM_CODE                                                                                                                                                                                                       \n");
        sbSql.append("     , A.CONSUM_YN, B.PR_ID                                                                                                                                                                                                   \n");
        sbSql.append("  FROM                                                                                                                                                                                                                        \n");
        sbSql.append("      (SELECT * FROM FMU_OP_RATE                                                                                                                                                                                              \n");
        sbSql.append("        WHERE UPJANG = 131029                                                                                                                                                                                                 \n");
        sbSql.append("          AND '20130809' BETWEEN SDATE AND EDATE                                                                                                                                                                              \n");
        sbSql.append("          AND ITEM_CODE > ' '                                                                                                                                                                                                 \n");
        sbSql.append("          AND USE_YN = 'Y') C                                                                                                                                                                                                 \n");
        sbSql.append("     , FMP_OTHER_CUST D , FMP_OTCUST_LINK F                                                                                                                                                                                   \n");
        sbSql.append("     ,(SELECT 0 AS DEF_QTY, '' AS PR_ID FROM DUAL) B                                                                                                                                                                          \n");
        sbSql.append("     ,(SELECT 131029 AS UPJANG                                                                                                                                                                                                \n");
        sbSql.append("            , '20130809' AS NEED_DATE                                                                                                                                                                                         \n");
        sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4                                                                                                                                                        \n");
        sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM                                                                                                                                                                 \n");
        sbSql.append("            , C.TAX_CODE, A.CUSTCD, A.CENTER_FLAG                                                                                                                                                                             \n");
        sbSql.append("            , A.CENTER_CODE, C.POINT_FLAG                                                                                                                                                                                     \n");
        sbSql.append("            , A.CONTRACT_PRICE AS UNIT_PRICE                                                                                                                                                                                  \n");
        sbSql.append("            , A.SALE_PRICE                                                                                                                                                                                                    \n");
        sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY                                                                                                                                                                  \n");
        sbSql.append("            , '0000' AS OTCUSTCD                                                                                                                                                                                              \n");
        sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가                                                                                                                                      \n");
        sbSql.append("            , DECODE( SIGN(TO_DATE('20130809','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(K.D_DAYS,0) - 1)                                                                                            \n");
        sbSql.append("                    , 0, DECODE(SIGN(DECODE(K.D_TIMES,'',24,0,24,K.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1)                                                                                                      \n");
        sbSql.append("                    , 0 ) + NVL(K.D_DAYS,0) + 1 AS D_DAYS                                                                                                                                                                     \n");
        sbSql.append("            , DECODE(K.D_TIMES,'',2400,0,2400,K.D_TIMES*100) AS D_TIMES                                                                                                                                                       \n");
        sbSql.append("            , C.KG_CONVERT_RATE                                                                                                                                                                                               \n");
        sbSql.append("            ,(SELECT A.CODE_NAME FROM SCC_COMMON_CODE A WHERE A.GROUP_CODE = 'FS0033' AND A.CODE = O.ITEM_FEATURE) AS FEATURE_NAME                                                                                            \n");
        sbSql.append("            , C.IMG_PATH AS IMAGE_PATH                                                                                                                                                                                        \n");
        sbSql.append("            , A.WEEK_ITEM_CODE                                                                                                                                                                                                \n");
        sbSql.append("         FROM                                                                                                                                                                                                                 \n");
        sbSql.append("             (  SELECT     A.*, NULL AS WEEK_ITEM_CODE                                                                                                                                                                        \n");
        sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A                                                                                                                                                                                 \n");
        sbSql.append("               WHERE (CENTER_CODE, CUSTCD, ITEM_CODE) NOT IN                                                                                                                                                                  \n");
        sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                                                                                                                                                   \n");
        sbSql.append("                        FROM HLDC_PO_ORDER_SCHEDULE                                                                                                                                                                           \n");
        sbSql.append("                       WHERE CENTER_CODE = 300001                                                                                                                                                                             \n");
        sbSql.append("                         AND UPJANG = 131029                                                                                                                                                                                  \n");
        sbSql.append("                         AND USE_YN = 'Y'                                                                                                                                                                                     \n");
        sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('20130809','YYYYMMDD'),'D'),                                                                                                                                              \n");
        sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'                                                                                                                                        \n");
        sbSql.append("                       UNION ALL                                                                                                                                                                                              \n");
        sbSql.append("                     (SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                                                                                                                                                   \n");
        sbSql.append("                        FROM HLDC_PO_ORDER_SCHEDULE                                                                                                                                                                           \n");
        sbSql.append("                       WHERE CENTER_CODE = 300001                                                                                                                                                                             \n");
        sbSql.append("                         AND UPJANG = -2                                                                                                                                                                                      \n");
        sbSql.append("                         AND USE_YN = 'Y'                                                                                                                                                                                     \n");
        sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('20130809','YYYYMMDD'),'D'),                                                                                                                                              \n");
        sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'                                                                                                                                        \n");
        sbSql.append("                       MINUS                                                                                                                                                                                                  \n");
        sbSql.append("                      SELECT CENTER_CODE, CUSTCD, ITEM_CODE                                                                                                                                                                   \n");
        sbSql.append("                        FROM HLDC_PO_ORDER_SCHEDULE                                                                                                                                                                           \n");
        sbSql.append("                       WHERE CENTER_CODE = 300001                                                                                                                                                                             \n");
        sbSql.append("                         AND UPJANG = 131029                                                                                                                                                                                  \n");
        sbSql.append("                         AND USE_YN = 'Y'                                                                                                                                                                                     \n");
        sbSql.append("                         AND DECODE(TO_CHAR(TO_DATE('20130809','YYYYMMDD'),'D'),                                                                                                                                              \n");
        sbSql.append("                                      1,SUN,2,MON,3,TUE,4,WED,5,THU,6,FRI,7,SAT) = 'Y'))                                                                                                                                      \n");
        sbSql.append("             ) A                                                                                                                                                                                                              \n");
        sbSql.append("            ,(SELECT /*+ INDEX(A PO_CONTRACT_FSALE_PK) */                                                                                                                                                                     \n");
        sbSql.append("                     CENTER_CODE, UPJANG, ITEM_CODE, MAX(CONTRACT_START) AS CONTRACT_START                                                                                                                                    \n");
        sbSql.append("                FROM HLDC_PO_CONTRACT_FSALE A                                                                                                                                                                                 \n");
        sbSql.append("               WHERE CENTER_CODE = 300001                                                                                                                                                                                     \n");
        sbSql.append("                 AND UPJANG = 131029                                                                                                                                                                                          \n");
        sbSql.append("                 AND ITEM_CODE > ' '                                                                                                                                                                                          \n");
        sbSql.append("                 AND CONTRACT_START <= '20130809'                                                                                                                                                                             \n");
        sbSql.append("               GROUP BY CENTER_CODE, UPJANG, ITEM_CODE) B                                                                                                                                                                     \n");
        sbSql.append("            ,(SELECT A.CENTER_CODE, A.CUSTCD, A.ITEM_CODE, A.ITEM_FEATURE                                                                                                                                                     \n");
        sbSql.append("                FROM FSI_ITEM_FEATURE A                                                                                                                                                                                       \n");
        sbSql.append("                   ,(SELECT CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE                                                                                                                                     \n");
        sbSql.append("                       FROM FSI_ITEM_FEATURE                                                                                                                                                                                  \n");
        sbSql.append("                      WHERE CENTER_CODE = 300001                                                                                                                                                                              \n");
        sbSql.append("                        AND '20130809' BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD')                                                                                              \n");
        sbSql.append("                      GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE) B                                                                                                                                                              \n");
        sbSql.append("               WHERE A.CENTER_CODE = B.CENTER_CODE                                                                                                                                                                            \n");
        sbSql.append("                 AND A.CUSTCD = B.CUSTCD                                                                                                                                                                                      \n");
        sbSql.append("                 AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                \n");
        sbSql.append("                 AND A.APPLY_DATE= B.APPLY_DATE) O                                                                                                                                                                            \n");
        sbSql.append("            , HLDC_PO_ITEM_MST C                                                                                                                                                                                              \n");
        sbSql.append("            , HLDC_PO_PREORDER_LIST K                                                                                                                                                                                         \n");
        sbSql.append("        WHERE A.CENTER_CODE = B.CENTER_CODE                                                                                                                                                                                   \n");
        sbSql.append("          AND A.UPJANG = B.UPJANG                                                                                                                                                                                             \n");
        sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                       \n");
        sbSql.append("          AND A.CONTRACT_START = B.CONTRACT_START                                                                                                                                                                             \n");
        sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                       \n");
        sbSql.append("          AND EXISTS (SELECT 1 FROM HLDC_PO_TREAT_UPJANG X WHERE X.ITEM_CODE = A.ITEM_CODE AND UPJANG = 131029)                                                                                                               \n");
        sbSql.append("          AND A.SALE_PRICE > 0                                                                                                                                                                                                \n");
        sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'                                                                                                                                                                               \n");
        sbSql.append("          AND C.ITEM_CODE BETWEEN '010000000000' AND '019999999999'                                                                                                                                                           \n");
        sbSql.append("          AND C.CONSUM_YN = NVL('N',C.CONSUM_YN)                                                                                                                                                                              \n");
        sbSql.append("          AND A.CENTER_CODE = K.CENTER_CODE(+)                                                                                                                                                                                \n");
        sbSql.append("          AND A.ITEM_CODE = K.ITEM_CODE(+)                                                                                                                                                                                    \n");
        sbSql.append("          AND A.CENTER_CODE = O.CENTER_CODE(+)                                                                                                                                                                                \n");
        sbSql.append("          AND A.CUSTCD = O.CUSTCD(+)                                                                                                                                                                                          \n");
        sbSql.append("          AND A.ITEM_CODE = O.ITEM_CODE(+)                                                                                                                                                                                    \n");
        sbSql.append("       -----------                                                                                                                                                                                                            \n");
        sbSql.append("        UNION ALL                                                                                                                                                                                                             \n");
        sbSql.append("       -----------                                                                                                                                                                                                            \n");
        sbSql.append("       SELECT 131029 AS UPJANG, '20130809' AS NEED_DATE                                                                                                                                                                       \n");
        sbSql.append("            , C.CONSUM_YN, C.ITEM_CLASS2, C.ITEM_CLASS3, C.ITEM_CLASS4                                                                                                                                                        \n");
        sbSql.append("            , A.ITEM_CODE, C.ITEM_NAME, C.ITEM_SIZE, C.PO_UOM                                                                                                                                                                 \n");
        sbSql.append("            , C.TAX_CODE, 0 AS CUSTCD, 'N' AS CENTER_FLAG                                                                                                                                                                     \n");
        sbSql.append("            , 0 AS CENTER_CODE, C.POINT_FLAG                                                                                                                                                                                  \n");
        sbSql.append("            , A.UNIT_PRICE                                                                                                                                                                                                    \n");
        sbSql.append("            , A.SALE_PRICE                                                                                                                                                                                                    \n");
        sbSql.append("            , C.MIN_ORD_QTY, C.MAX_ORD_QTY, C.MULTIPLIER_QTY                                                                                                                                                                  \n");
        sbSql.append("            , C.OTCUSTCD                                                                                                                                                                                                      \n");
        sbSql.append("              --디데이날짜와 입고일이 같으면 디타임을 체크하여 넘었으면 디데이 하루 추가                                                                                                                                      \n");
        sbSql.append("            , DECODE( SIGN(TO_DATE('20130809','YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD') - NVL(C.D_DAYS,0) - 1)                                                                                            \n");
        sbSql.append("                    , 0, DECODE(SIGN(DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24MI'))),1,0,1)                                                                                     \n");
        sbSql.append("                    , 0 ) + NVL(C.D_DAYS,0) + 1 AS D_DAYS                                                                                                                                                                     \n");
        sbSql.append("            , DECODE(C.D_TIMES,'',2400,0,2400,TO_NUMBER(C.D_TIMES)) AS D_TIMES                                                                                                                                                \n");
        sbSql.append("            , C.KG_CONVERT_RATE                                                                                                                                                                                               \n");
        sbSql.append("            , NULL AS FEATURE_NAME                                                                                                                                                                                            \n");
        sbSql.append("            , C.SIMAGE_PATH AS IMAGE_PATH                                                                                                                                                                                     \n");
        sbSql.append("            , NULL AS WEEK_ITEM_CODE                                                                                                                                                                                          \n");
        sbSql.append("         FROM FMP_OTCUST_PRICE_AVA_V A                                                                                                                                                                                        \n");
        sbSql.append("            ,(SELECT UPJANG, ITEM_CODE, MAX(SDATE) AS SDATE                                                                                                                                                                   \n");
        sbSql.append("                FROM FMP_OTCUST_PRICE_AVA_V                                                                                                                                                                                   \n");
        sbSql.append("               WHERE UPJANG = 131029                                                                                                                                                                                          \n");
        sbSql.append("                 AND SDATE <= '20130809'                                                                                                                                                                                      \n");
        sbSql.append("               GROUP BY UPJANG, ITEM_CODE) B                                                                                                                                                                                  \n");
        sbSql.append("            , FMP_OTCUST_ITEM C                                                                                                                                                                                               \n");
        sbSql.append("        WHERE A.UPJANG = B.UPJANG                                                                                                                                                                                             \n");
        sbSql.append("          AND A.SDATE = B.SDATE                                                                                                                                                                                               \n");
        sbSql.append("          AND A.ITEM_CODE = B.ITEM_CODE                                                                                                                                                                                       \n");
        sbSql.append("          AND A.ITEM_CODE = C.ITEM_CODE                                                                                                                                                                                       \n");
        sbSql.append("          AND A.SALE_PRICE > 0                                                                                                                                                                                                \n");
        sbSql.append("          AND A.USE_YN = 'Y' AND C.USE_YN = 'Y'                                                                                                                                                                               \n");
        sbSql.append("          AND C.CONSUM_YN = NVL('N',C.CONSUM_YN)                                                                                                                                                                              \n");
        sbSql.append("      ) A                                                                                                                                                                                                                     \n");
        sbSql.append(" WHERE SUBSTR(A.ITEM_CODE, 1, 8) = C.ITEM_CODE(+)                                                                                                                                                                             \n");
        sbSql.append("   AND A.OTCUSTCD = D.OTCUSTCD                                                                                                                                                                                                \n");
        sbSql.append("   AND A.ITEM_CLASS2 = NVL('',A.ITEM_CLASS2)                                                                                                                                                                                  \n");
        sbSql.append("   AND A.ITEM_CLASS3 = NVL('',A.ITEM_CLASS3)                                                                                                                                                                                  \n");
        sbSql.append("   AND A.ITEM_CLASS4 = NVL('',A.ITEM_CLASS4)                                                                                                                                                                                  \n");
        sbSql.append("   AND D.OTCUSTCD = F.OTCUSTCD                                                                                                                                                                                                \n");
        sbSql.append("   AND F.UPJANG = ((SELECT Z.MAIN_UPJANG FROM FMS_UPJANG Z WHERE UPJANG = 131029))                                                                                                                                            \n");
        sbSql.append("   AND F.USE_YN = 'Y'                                                                                                                                                                                                         \n");
        sbSql.append("   AND A.ITEM_NAME LIKE '%'||'감자'||'%'                                                                                                                                                                                      \n");
        sbSql.append("   AND (SELECT TO_NUMBER(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(Z.NONHOLI_DATE,'YYYYMMDD'))                                                                                                                                \n");
        sbSql.append("          FROM (SELECT ROW_NUMBER() OVER(ORDER BY CD_SY||CD_SM||CD_SD DESC) AS SEQ                                                                                                                                            \n");
        sbSql.append("                     , CD_SY||CD_SM||CD_SD AS NONHOLI_DATE                                                                                                                                                                    \n");
        sbSql.append("                  FROM SCC_CALENDA_DATA                                                                                                                                                                                       \n");
        sbSql.append("                 WHERE CD_SY||CD_SM||CD_SD < '20130809'                                                                                                                                                                       \n");
        sbSql.append("                   AND CD_SY BETWEEN TO_NUMBER(SUBSTR('20130809',1,4))-1 AND TO_NUMBER(SUBSTR('20130809',1,4))                                                                                                                \n");
        sbSql.append("                   AND CD_WEEK NOT IN ('일')) Z                                                                                                                                                                               \n");
        sbSql.append("         WHERE Z.SEQ = TO_NUMBER(A.D_DAYS)) <= TO_NUMBER(TRIM(TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD') - TO_DATE(TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD'),'0000')))                                                             \n");
        sbSql.append("   AND NOT EXISTS                                                                                                                                                                                                             \n");
        sbSql.append("      (SELECT 1 FROM FMP_ORD_LIMIT Z                                                                                                                                                                                          \n");
        sbSql.append("        WHERE Z.UPJANG = A.UPJANG                                                                                                                                                                                             \n");
        sbSql.append("          AND Z.ITEM_CODE = A.ITEM_CODE                                                                                                                                                                                       \n");
        sbSql.append("          AND A.NEED_DATE BETWEEN Z.SDATE AND Z.EDATE                                                                                                                                                                         \n");
        sbSql.append("          AND Z.USE_YN = 'Y')                                                                                                                                                                                                 \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		//ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		/**종료**/
		//out_dl.add("ds_List", ds_list);
		//this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);		
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
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
