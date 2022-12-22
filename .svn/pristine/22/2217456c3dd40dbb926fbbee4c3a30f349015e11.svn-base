<%

/*-----------------------------------------------------------------------------

■ 시스템명     : 영업관리/영업잔액조회

■ 프로그램ID   : MAG00010V_T001.jsp

■ 프로그램명   : 영업잔액조회

■ 작성일자     : 2013-02-05 

■ 작성자       : 박은규

■ 이력관리     : 

	1) 2013-02-05 박은규 - 최초개발 (CH201203_00081)

-----------------------------------------------------------------------------*/

%>



<%@ page contentType="text/html; charset=EUC-KR" %>

<%@ include file = "../../sc/main/common.jsp" %>

<%

	try	{

		PlatformRequest platformRequest = this.proc_input(request);

		in_vl = platformRequest.getData().getVariableList();

		in_dl = platformRequest.getData().getDataSetList();

		

		//jsp log 서비스 시작 

		logger.startIndividualLog(in_vl.getString("titLogId"));

	

		//입력 데이타

		DataSet ds_Cond     = in_dl.get("ds_Cond");

		//FileLog.println("d:\\aaa.txt", ds_cond

		

		String strTmCd      = nullToBlank(ds_Cond.getString(0, "TM_CD"));

		String strUpjang    = nullToBlank(ds_Cond.getString(0, "UPJANG"));

		String strSdate     = nullToBlank(ds_Cond.getString(0, "SDATE"));

		String strEdate     = nullToBlank(ds_Cond.getString(0, "EDATE"));

		String strIndex     = nullToBlank(in_vl.getString("strIndex"));



		//out 데이타

		DataSet ds_List;

		//sql문 버퍼생성

		StringBuffer sbSql = new StringBuffer();



		//내역조회

		//1.전도금 잔액

		if (strIndex.equals("1"))

		{

			sbSql.delete(0, sbSql.length());
			sbSql.append("    SELECT (SELECT TM_NAME FROM MAC_UPJANG_V WHERE UPJANG = V.UPJANG) TM_NAME,                                                                                                             \n");
			sbSql.append("           V.UPJANGNM,                                                                                                             \n");
	        sbSql.append("           V.계정명           AS ACCTNM,                                                                                           \n");
	        sbSql.append("           V.거래처명         AS CUSTNM,                                                                                           \n");
	        sbSql.append("           V.거래처사업자번호 AS SAUPNO,                                                                                           \n");
	        sbSql.append("           V.회계잔액         AS IRIS_AMT,                                                                                         \n");
	        sbSql.append("           V.SALE_A           AS IFIS_AMT,                                                                                         \n");
	        sbSql.append("           V.차이금액         AS AMT                                                                                               \n");
	        sbSql.append("      FROM (                                                                                                                       \n");
	        sbSql.append("            SELECT V.UPJANG,                                                                                                       \n");
	        sbSql.append("                   V.UPJANGNM,                                                                                                     \n");
	        sbSql.append("                   V.ACCTCD  계정코드,                                                                                             \n");
	        sbSql.append("                   V.ACCTNM6 계정명,                                                                                               \n");
	        sbSql.append("                   V.거래처코드,                                                                                                   \n");
	        sbSql.append("                   V.거래처명,                                                                                                     \n");
	        sbSql.append("                   V.거래처사업자번호,                                                                                             \n");
	        sbSql.append("                   SUM(회계잔액) 회계잔액,                                                                                         \n");
	        sbSql.append("                   SUM(SALE_A)   SALE_A,                                                                                           \n");
	        sbSql.append("                   (NVL(SUM(회계잔액), 0) - NVL(SUM(SALE_A), 0)) 차이금액                                                          \n");
	        sbSql.append("              FROM (                                                                                                               \n");
	        sbSql.append("                    SELECT D.UPJANG,                                                                                               \n");
	        sbSql.append("                           D.UPJANGNM,                                                                                             \n");
	        sbSql.append("                           A.ACCTCD,                                                                                               \n");
	        sbSql.append("                           C.ACCTNM6,                                                                                              \n");
	        sbSql.append("                           TO_NUMBER(A.ADITEM1)   거래처코드,                                                                      \n");
	        sbSql.append("                           (SELECT CUSTNM FROM HLDC_ST_CUST WHERE CUSTCD = A.ADITEM1) 거래처명,                                    \n");
	        sbSql.append("                           (SELECT SAUPNO FROM HLDC_ST_CUST WHERE CUSTCD = A.ADITEM1) 거래처사업자번호,                            \n");
	        sbSql.append("                           SUM(DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT)) 회계잔액,                               \n");
	        sbSql.append("                           0 SALE_A                                                                                                \n");
	        sbSql.append("                      FROM HLDC_GA_ACCTCD_ADITEM_MONTH A,                                                                          \n");
	        sbSql.append("                           HLDC_SC_DEPT_V B,                                                                                       \n");
	        sbSql.append("                           HLDC_ST_ACCOUNT C,                                                                                      \n");
	        sbSql.append("                           HLDC_ST_UPJANG D                                                                                        \n");
	        sbSql.append("                      WHERE A.DEPT_ID = B.DEPT_ID                                                                                  \n");
	        sbSql.append("                      AND   A.ACCTCD  = C.ACCTCD                                                                                   \n");
	        sbSql.append("                      AND   A.CC_CD = D.CC_CD                                                                                      \n");
	        sbSql.append("                      AND   B.MU_CD   = 'YA'                                                                                       \n");
	        sbSql.append("                      AND   A.ACCTCD  = '1110411'                                                                                  \n");
	        sbSql.append("                      AND   A.ACCYEAR_MONTH BETWEEN SUBSTR('" + strSdate + "', 1, 4)||'00' AND '" + strSdate + "' /* PARAM3 */     \n");
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   D.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"')                                                   \n");
	        	}else{
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM SCO_UPJANG_MST_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
	        
	        sbSql.append("                    GROUP BY D.UPJANG, D.UPJANGNM, A.ACCTCD, C.ACCTNM6, A.ADITEM1                                                  \n");
	        sbSql.append("                    HAVING SUM(DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT)) <> 0                                    \n");
	        sbSql.append("                    UNION ALL                                                                                                      \n");
	        sbSql.append("                    --외상매출금 FS IFIS 단체급식 잔액                                                                             \n");
	        sbSql.append("                    SELECT V.UPJANG,                                                                                               \n");
	        sbSql.append("                           V.UPJANGNM,                                                                                             \n");
	        sbSql.append("                           '1110411' ACCTCD,                                                                                       \n");
	        sbSql.append("                           '외상매출금' ACCTNM6,                                                                                   \n");
	        sbSql.append("                           V.CUSTCD 거래처코드,                                                                                    \n");
	        sbSql.append("                           V.CUSTNM 거래처명,                                                                                      \n");
	        sbSql.append("                           V.SAUPNO 거래처사업자번호,                                                                              \n");
	        sbSql.append("                           0 회계잔액,                                                                                             \n");
	        sbSql.append("                           V.JANAMT SALE_A                                                                                         \n");
	        sbSql.append("                      FROM (                                                                                                       \n");
	        sbSql.append("                            SELECT B.UPJANG,                                                                                       \n");
	        sbSql.append("                                   B.UPJANGNM,                                                                                     \n");
	        sbSql.append("                                   C.CUSTCD,                                                                                       \n");
	        sbSql.append("                                   C.CUSTNM,                                                                                       \n");
	        sbSql.append("                                   C.SAUPNO,                                                                                       \n");
	        sbSql.append("                                   NVL(SUM(V.AMT), 0) -  NVL(SUM(V.LINE_AMT1), 0) - NVL(SUM(V.LINE_AMT2), 0) JANAMT                \n");
	        sbSql.append("                            FROM     (SELECT V.UPJANG, V.CUSTCD,                                                                   \n");
	        sbSql.append("                                           NVL(SUM(V.AMT), 0) AMT,                                                                 \n");
	        sbSql.append("                                           NVL(SUM((SELECT SUM(AMT) FROM MAS_TRX_LINE         WHERE TRX_ID      = V.TRX_ID AND LINE_DATE <= '" + strSdate + "'||'31')), 0) LINE_AMT1, \n");
	        sbSql.append("                                           NVL(SUM((SELECT SUM(AMT) FROM MAS_TRX_SUBST_LINE   WHERE ORG_TRX_ID  = V.TRX_ID AND LINE_DATE <= '" + strSdate + "'||'31')), 0) LINE_AMT2 \n");
	        sbSql.append("                                      FROM MAS_TRX V                                                                               \n");
	        sbSql.append("                                      WHERE V.TRX_DATE BETWEEN '00000000' AND '" + strSdate + "'||'31' /* PARAM3 */                          \n");
	        sbSql.append("                                      AND   V.DR_ACCTCD = '1110411' --1110411 외상매출금                                           \n");
	        sbSql.append("                                      GROUP BY V.UPJANG, V.CUSTCD) V,                                                              \n");
	        sbSql.append("                                   HLDC_ST_UPJANG B,                                                                               \n");
	        sbSql.append("                                   HLDC_ST_CUST C                                                                                  \n");
	        sbSql.append("                             WHERE V.UPJANG = B.UPJANG                                                                             \n");
	        sbSql.append("                             AND   V.CUSTCD = C.CUSTCD(+)                                                                          \n");
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   B.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   B.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"' )                                                  \n");
	        	}else{
		        	sbSql.append("                      AND   B.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
        	
	        sbSql.append("                             GROUP BY B.UPJANG,                                                                                    \n");
	        sbSql.append("                                      B.UPJANGNM,                                                                                  \n");
	        sbSql.append("                                      C.CUSTCD,                                                                                    \n");
	        sbSql.append("                                      C.CUSTNM,                                                                                    \n");
	        sbSql.append("                                      C.SAUPNO                                                                                     \n");
	        sbSql.append("                           ) V                                                                                                     \n");
	        sbSql.append("                    WHERE JANAMT <> 0                                                                                              \n");
	        sbSql.append("                    ) V                                                                                                            \n");
	        sbSql.append("            GROUP BY V.UPJANG,                                                                                                     \n");
	        sbSql.append("                     V.UPJANGNM,                                                                                                   \n");
	        sbSql.append("                     V.ACCTCD,                                                                                                     \n");
	        sbSql.append("                     V.ACCTNM6,                                                                                                    \n");
	        sbSql.append("                     V.거래처코드,                                                                                                 \n");
	        sbSql.append("                     V.거래처명,                                                                                                   \n");
	        sbSql.append("                     V.거래처사업자번호                                                                                            \n");
	        sbSql.append("        ) V                                                                                                                        \n");
	        sbSql.append("        ORDER BY V.UPJANG, ABS(V.차이금액)                                                                                         \n");

		}

		//2.선수금잔액

		else if (strIndex.equals("2"))

		{

			sbSql.delete(0, sbSql.length());
			sbSql.append("    SELECT (SELECT TM_NAME FROM MAC_UPJANG_V WHERE UPJANG = V.UPJANG) TM_NAME,                                                                                                             \n");
			sbSql.append("           V.UPJANGNM,                                                                                                                               \n");
	        sbSql.append("           V.계정명 AS ACCTNM,                                                                                                                       \n");
	        sbSql.append("           V.거래처명 AS CUSTNM,                                                                                                                     \n");
	        sbSql.append("           V.거래처사업자번호 AS SAUPNO,                                                                                                             \n");
	        sbSql.append("           V.회계잔액 AS IRIS_AMT,                                                                                                                   \n");
	        sbSql.append("           V.SALE_A AS IFIS_AMT,                                                                                                                     \n");
	        sbSql.append("           V.차이금액 AS AMT                                                                                                                                \n");
	        sbSql.append("      FROM (                                                                                                                                         \n");
	        sbSql.append("        SELECT V.UPJANG,                                                                                                                             \n");
	        sbSql.append("               V.UPJANGNM,                                                                                                                           \n");
	        sbSql.append("               V.ACCTCD  계정코드,                                                                                                                   \n");
	        sbSql.append("               V.ACCTNM6 계정명,                                                                                                                     \n");
	        sbSql.append("               V.거래처코드,                                                                                                                         \n");
	        sbSql.append("               V.거래처명,                                                                                                                           \n");
	        sbSql.append("               V.거래처사업자번호,                                                                                                                   \n");
	        sbSql.append("               SUM(회계잔액) 회계잔액,                                                                                                               \n");
	        sbSql.append("               SUM(SALE_A)   SALE_A,                                                                                                                 \n");
	        sbSql.append("               (NVL(SUM(회계잔액), 0) - NVL(SUM(SALE_A), 0)) 차이금액                                                                                \n");
	        sbSql.append("          FROM (                                                                                                                                     \n");
	        sbSql.append("                SELECT D.UPJANG,                                                                                                                     \n");
	        sbSql.append("                       D.UPJANGNM,                                                                                                                   \n");
	        sbSql.append("                       A.ACCTCD,                                                                                                                     \n");
	        sbSql.append("                       C.ACCTNM6,                                                                                                                    \n");
	        sbSql.append("                       A.ADITEM1   거래처코드,                                                                                                       \n");
	        sbSql.append("                       (SELECT CUSTNM FROM HLDC_ST_CUST WHERE CUSTCD = A.ADITEM1) 거래처명,                                                          \n");
	        sbSql.append("                       (SELECT SAUPNO FROM HLDC_ST_CUST WHERE CUSTCD = A.ADITEM1) 거래처사업자번호,                                                  \n");
	        sbSql.append("                       SUM(DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT)) 회계잔액,                                                     \n");
	        sbSql.append("                       0 SALE_A                                                                                                                      \n");
	        sbSql.append("                  FROM HLDC_GA_ACCTCD_ADITEM_MONTH A,                                                                                                \n");
	        sbSql.append("                       HLDC_SC_DEPT_V B,                                                                                                             \n");
	        sbSql.append("                       HLDC_ST_ACCOUNT C,                                                                                                            \n");
	        sbSql.append("                       HLDC_ST_UPJANG D                                                                                                              \n");
	        sbSql.append("                  WHERE A.DEPT_ID = B.DEPT_ID                                                                                                        \n");
	        sbSql.append("                  AND   A.ACCTCD  = C.ACCTCD                                                                                                         \n");
	        sbSql.append("                  AND   A.CC_CD   = D.CC_CD                                                                                                          \n");
	        sbSql.append("                  AND   B.MU_CD   = 'YA'                                                                                                             \n");
	        sbSql.append("                  AND   A.ACCTCD  IN ('2110411', '2110441', '2110421','2110412')                                                                     \n");
	        sbSql.append("                  AND   A.ACCYEAR_MONTH BETWEEN SUBSTR('" + strSdate + "', 1, 4)||'00' AND '" + strSdate + "' /* PARAM3 */                                               \n");
	        
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   D.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"' )                                                  \n");
	        	}else{
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }

        	
	        sbSql.append("                GROUP BY D.UPJANG, D.UPJANGNM, A.ACCTCD, C.ACCTNM6, A.ADITEM1                                                                        \n");
	        sbSql.append("                HAVING SUM(DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT)) <> 0                                                          \n");
	        sbSql.append("                UNION ALL                                                                                                                            \n");
	        sbSql.append("                SELECT B.UPJANG,                                                                                                                     \n");
	        sbSql.append("                       B.UPJANGNM,                                                                                                                   \n");
	        sbSql.append("                       '2110411' ACCTCD,                                                                                                             \n");
	        sbSql.append("                       '선수금(사업장)' ACCTNM6,                                                                                                     \n");
	        sbSql.append("                       '999999' 거래처코드,                                                                                                          \n");
	        sbSql.append("                       '기타(거래처)' 거래처명,                                                                                                      \n");
	        sbSql.append("                       '9999999999' 거래처사업자번호,                                                                                                \n");
	        sbSql.append("                       0 회계잔액,                                                                                                                   \n");
	        sbSql.append("                       NVL(SUM(AMT_SUM), 0) - NVL(SUM(TRX_AMT_SUM), 0)               SALE_A                                                          \n");
	        sbSql.append("                  FROM (                                                                                                                             \n");
	        sbSql.append("                        SELECT V.UPJANG,                                                                                                             \n");
	        sbSql.append("                                NVL(SUM(AMT), 0) + NVL(SUM(FEE), 0) AMT_SUM,                                                                         \n");
	        sbSql.append("                                NVL(SUM((SELECT SUM(AMT) FROM MAS_TRX_LINE       WHERE RCP_ID     = V.RCP_ID AND LINE_DATE BETWEEN '19000101' AND '" + strSdate + "'||'31')), 0) + \n");
	        sbSql.append("                                NVL(SUM((SELECT SUM(AMT) FROM MAS_TRX_SUBST_LINE WHERE ORG_RCP_ID = V.RCP_ID AND LINE_DATE BETWEEN '19000101' AND '" + strSdate + "'||'31')), 0) TRX_AMT_SUM \n");
	        sbSql.append("                        FROM   MAS_RCP V                                                                                                             \n");
	        sbSql.append("                        WHERE V.CR_ACCTCD  = '2110411'                                                                                               \n");
	        sbSql.append("                        AND   (V.RCP_DATE    BETWEEN '19000101' AND '" + strSdate + "'||'31')                                                                  \n");
	        sbSql.append("                        GROUP BY V.UPJANG                                                                                                            \n");
	        sbSql.append("                      ) V,                                                                                                                           \n");
	        sbSql.append("                      HLDC_ST_UPJANG B                                                                                                               \n");
	        sbSql.append("                WHERE V.UPJANG = B.UPJANG                                                                                                            \n");
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   B.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   B.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"' )                                                  \n");
	        	}else{
		        	sbSql.append("                      AND   B.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
	        
	        sbSql.append("                GROUP BY B.UPJANG,  B.UPJANGNM                                                                                                       \n");
	        sbSql.append("                HAVING NVL(SUM(AMT_SUM), 0) - NVL(SUM(TRX_AMT_SUM), 0) <> 0                                                                          \n");
	        sbSql.append("                ) V                                                                                                                                  \n");
	        sbSql.append("        GROUP BY V.UPJANG,                                                                                                                           \n");
	        sbSql.append("                 V.UPJANGNM,                                                                                                                         \n");
	        sbSql.append("                 V.ACCTCD,                                                                                                                           \n");
	        sbSql.append("                 V.ACCTNM6,                                                                                                                          \n");
	        sbSql.append("                 V.거래처코드,                                                                                                                       \n");
	        sbSql.append("                 V.거래처명,                                                                                                                         \n");
	        sbSql.append("                 V.거래처사업자번호                                                                                                                  \n");
	        sbSql.append("        ) V                                                                                                                                          \n");
	        sbSql.append("        ORDER BY V.UPJANG, ABS(V.차이금액)                                                                                                           \n");

		}

		//3.전도금잔액

		else if (strIndex.equals("3") || strIndex.equals("6"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("    SELECT (SELECT TM_NAME FROM MAC_UPJANG_V WHERE UPJANG = V.UPJANG) TM_NAME,                                                                                                             \n");
			sbSql.append("           V.UPJANGNM,                                                                                          \n");
	        sbSql.append("           V.회계전도금 AS IRIS_AMT,                                                                            \n");
	        sbSql.append("           V.회계미지급금 AS IRIS_MIJI_AMT,                                                                     \n");
	        sbSql.append("           V.영업전도금 AS IFIS_AMT,                                                                            \n");
	        sbSql.append("           V.영업미지급금 AS IFIS_MIJI_AMT,                                                                     \n");
	        sbSql.append("           V.차이금액전도금 AS AMT,                                                                             \n");
	        sbSql.append("           V.차이금액미지급금 AS MIJI_AMT                                                                       \n");
	        sbSql.append("      FROM (                                                                                                    \n");
	        sbSql.append("            SELECT V.UPJANG,                                                                                    \n");
	        sbSql.append("                   V.UPJANGNM,                                                                                  \n");
	        sbSql.append("                   NVL(SUM(회계전도금), 0)     회계전도금,                                                      \n");
	        sbSql.append("                   NVL(SUM(회계미지급금), 0)   회계미지급금,                                                    \n");
	        sbSql.append("                   NVL(SUM(영업전도금), 0)     영업전도금,                                                      \n");
	        sbSql.append("                   NVL(SUM(영업미지급금), 0)   영업미지급금,                                                    \n");
	        sbSql.append("                   (NVL(SUM(회계전도금), 0)   - NVL(SUM(영업전도금), 0))   차이금액전도금,                      \n");
	        sbSql.append("                   (NVL(SUM(회계미지급금), 0) - NVL(SUM(영업미지급금), 0)) 차이금액미지급금                     \n");
	        sbSql.append("              FROM (                                                                                            \n");
	        sbSql.append("                    SELECT D.UPJANG,                                                                            \n");
	        sbSql.append("                           D.UPJANGNM,                                                                          \n");
	        sbSql.append("                           SUM(DECODE(A.ACCTCD, '1110112', DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT), 0)) 회계전도금, \n");
	        sbSql.append("                           SUM(DECODE(A.ACCTCD, '2110314', DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT), 0)) 회계미지급금, \n");
	        sbSql.append("                           0 영업전도금,                                                                        \n");
	        sbSql.append("                           0 영업미지급금                                                                       \n");
	        
        	if (! strEdate.equals("")){
        		sbSql.append("                      FROM GA_ACCTCD_ADITEM_DATE A,                                                       \n");	        	
	        }else{
	        	sbSql.append("                      FROM HLDC_GA_ACCTCD_ADITEM_MONTH A,                                                                     \n");
	        }
        	
	        sbSql.append("                           HLDC_SC_DEPT_V B,                                                                    \n");
	        sbSql.append("                           HLDC_ST_ACCOUNT C,                                                                   \n");
	        sbSql.append("                           HLDC_ST_UPJANG D                                                                     \n");
	        sbSql.append("                      WHERE A.DEPT_ID = B.DEPT_ID                                                               \n");
	        sbSql.append("                      AND   A.ACCTCD  = C.ACCTCD                                                                \n");
	        sbSql.append("                      AND   A.CC_CD = D.CC_CD                                                                   \n");
	        sbSql.append("                      AND   B.MU_CD   = 'YA'                                                                    \n");
	        sbSql.append("                      AND   A.ACCTCD  IN  ('1110112', '2110314')                                                \n");
	        
	        if (! strEdate.equals("")){
        		sbSql.append("                      AND   A.ACCDATE BETWEEN SUBSTR('" + strEdate + "', 1, 4) || '0000' AND '" + strEdate + "' \n");	        	
	        }else{
	        	sbSql.append("                      AND   A.ACCYEAR_MONTH BETWEEN SUBSTR('" + strSdate + "', 1, 4)||'00' AND '" + strSdate + "'  \n");
	        }
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   D.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"')                                                   \n");
	        	}else{
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
        	
	        sbSql.append("                    GROUP BY D.UPJANG, D.UPJANGNM                                                               \n");
	        sbSql.append("                    HAVING SUM(DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT)) <> 0                 \n");
	        sbSql.append("                    UNION ALL                                                                                   \n");
	        sbSql.append("                    --전도금 FS IFIS 단체급식 잔액                                                              \n");
	        sbSql.append("                    SELECT B.UPJANG,                                                                            \n");
	        sbSql.append("                           B.UPJANGNM,                                                                          \n");
	        sbSql.append("                           0 회계전도금,                                                                        \n");
	        sbSql.append("                           0 회계미지급금,                                                                      \n");
	        sbSql.append("                           NVL(SUM(DECODE(A.ADV_KIND, 'I', A.AMT, 0)),  0) -                                    \n");
	        sbSql.append("                           NVL(SUM(DECODE(A.ADV_KIND, 'O', NVL(A.ADJ_AMT, 0) + NVL(A.VAT, 0) - NVL(A.NOPAY_AMT, 0), 0)),  0) 영업전도금, \n");
	        sbSql.append("                           NVL(SUM(DECODE(A.NOPAY_AMT, 0, 0, A.NOPAY_AMT -  NVL((                               \n");
	        sbSql.append("                                                                                 SELECT SUM(AMT)                \n");
	        sbSql.append("                                                                                   FROM MAS_ADV_PREPAY AA       \n");
	        sbSql.append("                                                                                  WHERE AA.NOPAY_ID = A.ADV_ID  \n");
	        sbSql.append("                                                                                    AND EXISTS (SELECT 'X'      \n");
	        sbSql.append("                                                                                                  FROM MAS_ADVANCE \n");
	        sbSql.append("                                                                                                 WHERE ADV_ID = AA.ADV_ID \n");
	        sbSql.append("                                                                                                   AND   ADJ_DATE BETWEEN '19000101' AND '" + strSdate + "'||'31') \n");
	        sbSql.append("                                                                                 ), 0))), 0) 영업미지급금       \n");
	        sbSql.append("                      FROM MAS_ADVANCE A,                                                                       \n");
	        sbSql.append("                           HLDC_ST_UPJANG B                                                                     \n");
	        sbSql.append("                      WHERE (A.UPJANG = B.UPJANG)                                                               \n");
	        sbSql.append("                      AND   (NVL(B.CUSTCD,0) = 0)                                                               \n");
	        sbSql.append("                      AND   (B.CC_CD IN (SELECT CC_CD FROM HLDC_SC_DEPT WHERE EXP_CD = 'Y'))                    \n");
	        
	        if (! strEdate.equals("")){
	        	sbSql.append("                      AND   (A.ADJ_DATE BETWEEN '19000101' AND '" + strEdate + "')                                  \n");	        	
	        }else{
	        	sbSql.append("                      AND   (A.ADJ_DATE BETWEEN '19000101' AND '" + strSdate + "'||'31')                                  \n");
	        }
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   B.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   B.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"' )                                                  \n");
	        	}else{
		        	sbSql.append("                      AND   B.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
        	
	        sbSql.append("                      GROUP BY B.UPJANG, B.UPJANGNM                                                             \n");
	        sbSql.append("                    ) V                                                                                         \n");
	        sbSql.append("              GROUP BY V.UPJANG, V.UPJANGNM                                                                     \n");
	        sbSql.append("            ) V                                                                                                 \n");
	        sbSql.append("        ORDER BY V.UPJANG, ABS(V.차이금액전도금), ABS(V.차이금액미지급금)                                       \n");
		}
		//4.미수금식권
		//5.미수금(신용카드)
		else if (strIndex.equals("4") || strIndex.equals("5"))
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("    SELECT (SELECT TM_NAME FROM MAC_UPJANG_V WHERE UPJANG = V.UPJANG) TM_NAME,                                                                                                             \n");
			sbSql.append("           V.UPJANGNM,                                                                                                                        \n");
	        sbSql.append("           V.회계미수금식권 AS IRIS_SK_AMT /* 회계(IRIS)식권 */,                                                                              \n");
	        sbSql.append("           V.회계미수금신용카드 AS IRIS_CARD_AMT /* 회계(IRIS)신용카드 */ ,                                                                   \n");
	        sbSql.append("           V.영업미수금식권 AS IFIS_SK_AMT /* 영업(IRIS)식권 */,                                                                              \n");
	        sbSql.append("           V.영업미수금신용카드 AS IFIS_CARD_AMT /* 영업(IRIS)식권 */,                                                                        \n");
	        sbSql.append("           V.차이금액미수금식권 AS SK_AMT,                                                                                                    \n");
	        sbSql.append("           V.차이금액미수금신용카드 AS CARD_AMT                                                                                               \n");
	        sbSql.append("      FROM (                                                                                                                                  \n");
	        sbSql.append("            SELECT V.UPJANG,                                                                                                                  \n");
	        sbSql.append("                   V.UPJANGNM,                                                                                                                \n");
	        sbSql.append("                   NVL(SUM(회계미수금식권), 0)     회계미수금식권,                                                                            \n");
	        sbSql.append("                   NVL(SUM(회계미수금신용카드), 0) 회계미수금신용카드,                                                                        \n");
	        sbSql.append("                   NVL(SUM(영업미수금식권), 0)     영업미수금식권,                                                                            \n");
	        sbSql.append("                   NVL(SUM(영업미수금신용카드), 0) 영업미수금신용카드,                                                                        \n");
	        sbSql.append("                   (NVL(SUM(회계미수금식권), 0)   - NVL(SUM(영업미수금식권), 0))       차이금액미수금식권,                                    \n");
	        sbSql.append("                   (NVL(SUM(회계미수금신용카드), 0) - NVL(SUM(영업미수금신용카드), 0)) 차이금액미수금신용카드                                 \n");
	        sbSql.append("              FROM (                                                                                                                          \n");
	        sbSql.append("                    SELECT D.UPJANG,                                                                                                          \n");
	        sbSql.append("                           D.UPJANGNM,                                                                                                        \n");
	        sbSql.append("                           SUM(DECODE(A.ACCTCD, '1110822', DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT), 0)) 회계미수금식권,    \n");
	        sbSql.append("                           SUM(DECODE(A.ACCTCD, '1110815', DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT), 0)) 회계미수금신용카드, \n");
	        sbSql.append("                           0 영업미수금식권,                                                                                                  \n");
	        sbSql.append("                           0 영업미수금신용카드                                                                                               \n");
	        sbSql.append("                      FROM HLDC_GA_ACCTCD_ADITEM_MONTH A,                                                                                     \n");
	        sbSql.append("                           HLDC_SC_DEPT_V B,                                                                                                  \n");
	        sbSql.append("                           HLDC_ST_ACCOUNT C,                                                                                                 \n");
	        sbSql.append("                           HLDC_ST_UPJANG D                                                                                                   \n");
	        sbSql.append("                      WHERE A.DEPT_ID = B.DEPT_ID                                                                                             \n");
	        sbSql.append("                      AND   A.ACCTCD  = C.ACCTCD                                                                                              \n");
	        sbSql.append("                      AND   A.CC_CD   = D.CC_CD                                                                                               \n");
	        sbSql.append("                      AND   B.MU_CD   = 'YA'                                                                                                  \n");
	        sbSql.append("                      AND   A.ACCTCD  IN  ('1110822', '1110815')                                                                              \n");
	        sbSql.append("                      AND   A.ACCYEAR_MONTH BETWEEN SUBSTR('" + strSdate + "', 1, 4)||'00' AND '" + strSdate + "'                                                 \n");
	        
        	if (! strUpjang.equals(""))
        	{
        		sbSql.append("                      AND   D.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }
        	else
	        {	
        		if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"' )                                                  \n");
        		}else{
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
	        
	        sbSql.append("                    GROUP BY D.UPJANG, D.UPJANGNM                                                                                             \n");
	        sbSql.append("                    HAVING SUM(DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT)) <> 0                                               \n");
	        sbSql.append("                    UNION ALL                                                                                                                 \n");
	        sbSql.append("                    --FS IFIS 단체급식 잔액                                                                                                   \n");
	        sbSql.append("                    SELECT V.UPJANG,                                                                                                          \n");
	        sbSql.append("                           V.UPJANGNM,                                                                                                        \n");
	        sbSql.append("                           0 회계미수금식권,                                                                                                  \n");
	        sbSql.append("                           0 회계미수금신용카드,                                                                                              \n");
	        sbSql.append("                           SUM(DECODE(V.DUE_GUBUN, '미수금',     V.AMT - (V.RCP_AMT1 + V.RCP_AMT2), 0))             영업미수금식권,           \n");
	        sbSql.append("                           SUM(DECODE(V.DUE_GUBUN, '미수금(신용카드)',     V.AMT - (V.RCP_AMT1 + V.RCP_AMT2), 0))   영업미수금신용카드        \n");
	        sbSql.append("                     FROM (                                                                                                                   \n");
	        sbSql.append("                           SELECT C.UPJANG,                                                                                                   \n");
	        sbSql.append("                                  C.UPJANGNM,                                                                                                 \n");
	        sbSql.append("                                  NVL(V.AMT, 0) AMT,                                                                                          \n");
	        sbSql.append("                                  V.RCP_DATE    BOND_DATE,                                                                                    \n");
	        sbSql.append("                                  DECODE(V.DR_ACCTCD, '1110822', '미수금', '1110815', '미수금(신용카드)') DUE_GUBUN,                          \n");
	        sbSql.append("                                  NVL((SELECT SUM(AMT) FROM MAS_RMT_LINE       WHERE RCP_ID     = V.RCP_ID AND LINE_DATE BETWEEN '19000101' AND '" + strSdate + "'||'31'), 0) RCP_AMT1, \n");
	        sbSql.append("                                  0 RCP_AMT2                                                                                                  \n");
	        sbSql.append("                             FROM MAS_RCP V,                                                                                                  \n");
	        sbSql.append("                                  MAS_BOND_CODE A,                                                                                            \n");
	        sbSql.append("                                  SCO_UPJANG_CUST  B,                                                                                         \n");
	        sbSql.append("                                  SCO_UPJANG_MST_V C                                                                                          \n");
	        sbSql.append("                           WHERE (A.BOND_GUBUN = 'MISU')                                                                                      \n");
	        sbSql.append("                           AND   (V.DR_ACCTCD  = A.ACCTCD)                                                                                    \n");
	        sbSql.append("                           AND   (V.UPJANG     = B.UPJANG)                                                                                    \n");
	        sbSql.append("                           AND   (V.CUSTCD     = B.CUSTCD)                                                                                    \n");
	        sbSql.append("                           AND   (V.UPJANG     = C.UPJANG)                                                                                    \n");
	        sbSql.append("                           AND   (V.RCP_DATE   BETWEEN '19000101' AND '" + strSdate + "'||'31')                                                         \n");
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   V.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){	
		        	sbSql.append("                      AND   V.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"')                                                   \n");
	        	}else{
		        	sbSql.append("                      AND   V.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
	        
	        
	        sbSql.append("                          ) V                                                                                                                 \n");
	        sbSql.append("                    GROUP BY V.UPJANG, V.UPJANGNM                                                                                             \n");
	        sbSql.append("                 ) V                                                                                                                          \n");
	        sbSql.append("             GROUP BY V.UPJANG, V.UPJANGNM                                                                                                             \n");
	        sbSql.append("        ) V                                                                                                                                   \n");
	        sbSql.append("   ORDER BY V.UPJANG, ABS(V.차이금액미수금식권), ABS(V.차이금액미수금신용카드)                                                           \n");
		}
		else if (strIndex.equals("7")) //7.소액현금잔액
		{
			sbSql.delete(0, sbSql.length());
	        sbSql.append("SELECT (SELECT TM_NAME FROM MAC_UPJANG_V WHERE UPJANG = V.UPJANG) TM_NAME,                                                                                                             \n");
			sbSql.append("       V.UPJANGNM,                                                                                                                  \n");
	        sbSql.append("       V.회계 AS IRIS_AMT,                                                                                                          \n");
	        sbSql.append("       V.영업 AS IFIS_AMT,                                                                                                          \n");
	        sbSql.append("       V.차액 AS AMT                                                                                                                \n");
	        sbSql.append("  FROM (SELECT V.UPJANG,                                                                                                            \n");
	        sbSql.append("               V.UPJANGNM,                                                                                                          \n");
	        sbSql.append("               NVL(SUM(회계미수금소액현금), 0) 회계,                                                                                \n");
	        sbSql.append("               NVL(SUM(영업미수금소액현금), 0) 영업,                                                                                \n");
	        sbSql.append("               (NVL(SUM(회계미수금소액현금), 0) - NVL(SUM(영업미수금소액현금), 0)) 차액                                             \n");
	        sbSql.append("          FROM (                                                                                                                    \n");
	        sbSql.append("            SELECT D.UPJANG,                                                                                                        \n");
	        sbSql.append("                   D.UPJANGNM,                                                                                                      \n");
	        sbSql.append("                   SUM(DECODE(A.ACCTCD, '1110114', DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT), 0)) 회계미수금소액현금, \n");
	        sbSql.append("                   0 영업미수금소액현금                                                                                             \n");
	        sbSql.append("              FROM HLDC_GA_ACCTCD_ADITEM_MONTH A,                                                                                   \n");
	        sbSql.append("                   HLDC_SC_DEPT_V B,                                                                                                \n");
	        sbSql.append("                   HLDC_ST_ACCOUNT C,                                                                                               \n");
	        sbSql.append("                   HLDC_ST_UPJANG  D                                                                                                \n");
	        sbSql.append("              WHERE A.DEPT_ID = B.DEPT_ID                                                                                           \n");
	        sbSql.append("                AND A.ACCTCD  = C.ACCTCD                                                                                            \n");
	        sbSql.append("                AND A.CC_CD   = D.CC_CD                                                                                             \n");
	        sbSql.append("                AND B.MU_CD   = 'YA'                                                                                                \n");
	        sbSql.append("                AND A.ACCTCD  IN  ('1110114')                                                                                       \n");
	        sbSql.append("                AND A.ACCYEAR_MONTH BETWEEN SUBSTR('" + strSdate + "', 1, 4)||'00' AND '" + strSdate + "'                                               \n");
	        
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   D.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){	
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"')                                                   \n");
	        	}else{
		        	sbSql.append("                      AND   D.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
        	
        	
	        sbSql.append("              GROUP BY D.UPJANG, D.UPJANGNM                                                                                         \n");
	        sbSql.append("             HAVING SUM(DECODE(C.BALDIV, '1',A.DRAMT - A.CRAMT, A.CRAMT - A.DRAMT)) <> 0                                            \n");
	        sbSql.append("              UNION ALL                                                                                                             \n");
	        sbSql.append("            --FS IFIS 단체급식 잔액                                                                                                 \n");
	        sbSql.append("            SELECT V.UPJANG,                                                                                                        \n");
	        sbSql.append("                   V.UPJANGNM,                                                                                                      \n");
	        sbSql.append("                   0 회계미수금소액현금,                                                                                            \n");
	        sbSql.append("                   SUM(DECODE(V.DUE_GUBUN, '소액현금f/s(업장)', V.AMT - (V.RCP_AMT1 + V.RCP_AMT2), 0)) 영업미수금소액현금           \n");
	        sbSql.append("              FROM (                                                                                                                \n");
	        sbSql.append("                   SELECT C.UPJANG,                                                                                                 \n");
	        sbSql.append("                          C.UPJANGNM,                                                                                               \n");
	        sbSql.append("                          NVL(V.AMT, 0) AMT,                                                                                        \n");
	        sbSql.append("                          V.RCP_DATE BOND_DATE,                                                                                     \n");
	        sbSql.append("                          DECODE(V.DR_ACCTCD, '1110114', '소액현금f/s(업장)') DUE_GUBUN,                                            \n");
	        sbSql.append("                          NVL((SELECT SUM(AMT) FROM MAS_RMT_LINE WHERE RCP_ID = V.RCP_ID AND LINE_DATE BETWEEN '19000101' AND '" + strSdate + "'||'31'), 0) RCP_AMT1, \n");
	        sbSql.append("                          0 RCP_AMT2                                                                                                \n");
	        sbSql.append("                    FROM MAS_RCP V,                                                                                                 \n");
	        sbSql.append("                         MAS_BOND_CODE A,                                                                                           \n");
	        sbSql.append("                         SCO_UPJANG_CUST B,                                                                                         \n");
	        sbSql.append("                         SCO_UPJANG_MST_V C                                                                                         \n");
	        sbSql.append("                  WHERE (A.BOND_GUBUN = 'CASH')                                                                                     \n");
	        sbSql.append("                    AND (V.DR_ACCTCD = A.ACCTCD)                                                                                    \n");
	        sbSql.append("                    AND (V.UPJANG = B.UPJANG)                                                                                       \n");
	        sbSql.append("                    AND (V.CUSTCD = B.CUSTCD)                                                                                       \n");
	        sbSql.append("                    AND (V.UPJANG = C.UPJANG)                                                                                       \n");
	        sbSql.append("                    AND   (V.RCP_DATE   BETWEEN '19000101' AND '" + strSdate + "'||'31')                                                      \n");
	        
        	if (! strUpjang.equals("")){
        		sbSql.append("                      AND   V.UPJANG   = " + strUpjang + " /* PARAM2 */                                                       \n");	        	
	        }else{
	        	if(! strTmCd.equals("")){
		        	sbSql.append("                      AND   V.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD = '" + strTmCd +"' )                                                  \n");
	        	}else{
		        	sbSql.append("                      AND   V.UPJANG   IN (SELECT UPJANG                                                                      \n");
		        	sbSql.append("                                             FROM MAC_UPJANG_V                                                                \n");
		        	sbSql.append("                                            WHERE TM_CD IN ('Y25', 'Y34', 'Y45', 'Y46', 'Y64', 'Y71', 'Z15', 'Z18', 'Z19'))                                                   \n");
        		}
	        }
        	
	        sbSql.append("                    ) V                                                                                                             \n");
	        sbSql.append("              GROUP BY V.UPJANG, V.UPJANGNM                                                                                         \n");
	        sbSql.append("              ) V                                                                                                                   \n");
	        sbSql.append("        GROUP BY V.UPJANG, V.UPJANGNM                                                                                               \n");
	        sbSql.append("        ) V                                                                                                                         \n");
	        sbSql.append("  ORDER BY V.UPJANGNM, ABS(V.차액)                                                                                                  \n");
		}
		

out_vl.add("fa_Sql", sbSql.toString());

		//System.out.println(sbSql.toString());

		pstmt = conn.prepareStatement(sbSql.toString());		

		rs = pstmt.executeQuery(); 

		ds_List = this.makeDataSet(rs, "ds_List");

		

		rs.close();

		pstmt.close();



		/**종료**/

		out_dl.add(ds_List);

		this.setResultMessage(0, "OK", out_vl);



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