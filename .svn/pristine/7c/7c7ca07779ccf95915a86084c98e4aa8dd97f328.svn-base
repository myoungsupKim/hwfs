<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식채권관리
■ 프로그램ID   : MAK10170S_T003.jsp
■ 프로그램명   : 입금 및 여신현황조회(본사)
■ 작성일자     : 
■ 작성자       : 
■ 이력관리     : 
* HISTORY    : 
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
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List, ds_ListTmp;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0,sbSql.length());
		sbSql.append(" \n");
		sbSql.append("  WITH SALE_WITH AS (SELECT B.UPJANG, B.MAIN_UPJANG     , B.HEAD_CREDIT_YN   \n");
		sbSql.append("                        , MAX(NVL(TO_CHAR(TO_DATE(A.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'), GREATEST(TO_CHAR(ADD_MONTHS(B.CDATE, -1), 'YYYYMM')||'01', TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM')||'01'))) AS SALE_DATE     \n");
		sbSql.append("                     FROM FMS_SALES A, FMS_UPJANG B     \n");
		sbSql.append(" 					   WHERE 1=1	\n");
		
		if (! nullToBlank(ds_Cond.getString(0, "JDATE")).equals("")) {
			sbSql.append("                    AND A.SALE_DATE(+) < '"+ds_Cond.getString(0, "JDATE")+"'     \n");	
		}
		
		sbSql.append("                      AND A.TRANS_YN(+) = 'Y'     \n");
		sbSql.append("                      AND A.UPJANG(+) = B.UPJANG     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals("")) {
			sbSql.append("                      AND B.MAIN_UPJANG = '"+ds_Cond.getString(0, "MAIN_UPJANG")+"'     \n");
		}
		
		sbSql.append("                      --AND B.HEAD_CREDIT_YN = 'Y'     \n");
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals("")) {
			sbSql.append("                      AND B.USE_YN = '"+ds_Cond.getString(0, "USE_YN")+"'     \n");
		}
		
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) {
			sbSql.append("                      AND B.PART_SALES_SABUN = '"+ds_Cond.getString(0, "SALE_SABUN")+"'     \n");
		}
		
		sbSql.append("                    GROUP BY B.UPJANG, B.MAIN_UPJANG , B.HEAD_CREDIT_YN)     \n");
		sbSql.append("  ,     \n");
		sbSql.append("   FMS_UPJANG_BB_WITH AS (SELECT UPJANG, MAIN_UPJANG     ,  HEAD_CREDIT_YN   \n");
		sbSql.append("                      FROM    FMS_UPJANG     \n");
		sbSql.append("                      WHERE   1=1     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals("")) {
			sbSql.append("                      AND MAIN_UPJANG    = "+ds_Cond.getString(0, "MAIN_UPJANG")+"     \n");
		}
		
		sbSql.append("                      --AND     HEAD_CREDIT_YN = 'Y'     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) {
			sbSql.append("                      AND PART_SALES_SABUN = '"+ds_Cond.getString(0, "SALE_SABUN")+"'     \n");
		}
		
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals("")) {
			sbSql.append("                      AND     USE_YN         = '"+ds_Cond.getString(0, "USE_YN")+"'                 \n");
		}
				
		sbSql.append("  ),");
		
		sbSql.append("  SALE_WITH_ALL AS (SELECT B.UPJANG, B.MAIN_UPJANG     , B.HEAD_CREDIT_YN   \n");
		sbSql.append("                        , MAX(NVL(TO_CHAR(TO_DATE(A.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'), GREATEST(TO_CHAR(ADD_MONTHS(B.CDATE, -1), 'YYYYMM')||'01', TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM')||'01'))) AS SALE_DATE     \n");
		sbSql.append("                     FROM FMS_SALES A, FMS_UPJANG B     \n");
		sbSql.append(" 					   WHERE 1=1	\n");
		
		if (! nullToBlank(ds_Cond.getString(0, "JDATE")).equals("")) {
			sbSql.append("                    AND A.SALE_DATE(+) < '"+ds_Cond.getString(0, "JDATE")+"'     \n");	
		}
		
		sbSql.append("                      AND A.TRANS_YN(+) = 'Y'     \n");
		sbSql.append("                      AND A.UPJANG(+) = B.UPJANG     \n");
		 
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals("")) {
			sbSql.append("                      AND B.MAIN_UPJANG   = "+ds_Cond.getString(0, "MAIN_UPJANG")+"    \n");
		} else {
			sbSql.append("                      AND B.MAIN_UPJANG   IN (SELECT MAIN_UPJANG FROM FMS_UPJANGV WHERE    PART_SALES_SABUN = '"+ds_Cond.getString(0, "SALE_SABUN")+"' )     \n");
		}
		
		sbSql.append("                      --AND B.HEAD_CREDIT_YN = 'Y'     \n");
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals("")) {
			sbSql.append("                      AND B.USE_YN = '"+ds_Cond.getString(0, "USE_YN")+"'     \n");
		}
		
		sbSql.append("                    GROUP BY B.UPJANG, B.MAIN_UPJANG , B.HEAD_CREDIT_YN)     \n");
		sbSql.append("  ,     \n");
		sbSql.append("   FMS_UPJANG_BB_WITH_ALL AS (SELECT UPJANG, MAIN_UPJANG     ,  HEAD_CREDIT_YN   \n");
		sbSql.append("                      FROM    FMS_UPJANG     \n");
		sbSql.append("                      WHERE   1=1     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals("")) {
			sbSql.append("                      AND MAIN_UPJANG   = "+ds_Cond.getString(0, "MAIN_UPJANG")+"    \n");
		} else {
			sbSql.append("                      AND MAIN_UPJANG   IN (SELECT MAIN_UPJANG FROM FMS_UPJANGV WHERE    PART_SALES_SABUN = '"+ds_Cond.getString(0, "SALE_SABUN")+"' )     \n");
		}
		
		sbSql.append("                      --AND     HEAD_CREDIT_YN = 'Y'     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals("")) {
			sbSql.append("                      AND     USE_YN         = '"+ds_Cond.getString(0, "USE_YN")+"'                 \n");
		}
				
		sbSql.append("  ),");		
		
		
		
		sbSql.append("  MAX_NEED_DATE_WITH AS ( SELECT MAX(NEED_DATE) AS NEED_DATE, RC_UPJANG FROM SO_PR 	\n");
		sbSql.append("  WHERE 1=1 	\n");
		sbSql.append("  AND NEED_DATE BETWEEN "+ds_Cond.getString(0, "JDATE")+"  AND GREATEST(TO_CHAR(SYSDATE+15,'YYYYMMDD'), "+ds_Cond.getString(0, "JDATE")+") 	\n");
		sbSql.append("  AND SUBINV_CODE LIKE 'S1%' AND LINE_STATUS NOT IN ('003', '005','999') 	\n");
		sbSql.append("  AND RC_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG_BB_WITH) 	\n");
		sbSql.append("  GROUP BY RC_UPJANG");
		sbSql.append("  )");
		
		sbSql.append("  , MAX_NEED_DATE_WITH_ALL AS ( SELECT MAX(NEED_DATE) AS NEED_DATE, RC_UPJANG FROM SO_PR 	\n");
		sbSql.append("  WHERE 1=1 	\n");
		sbSql.append("  AND NEED_DATE BETWEEN "+ds_Cond.getString(0, "JDATE")+"  AND GREATEST(TO_CHAR(SYSDATE+15,'YYYYMMDD'), "+ds_Cond.getString(0, "JDATE")+") 	\n");
		sbSql.append("  AND SUBINV_CODE LIKE 'S1%' AND LINE_STATUS NOT IN ('003', '005','999') 	\n");
		sbSql.append("  AND RC_UPJANG IN (SELECT UPJANG FROM FMS_UPJANG_BB_WITH_ALL) 	\n");
		sbSql.append("  GROUP BY RC_UPJANG");
		sbSql.append("  )");		
		
		
		sbSql.append("  SELECT      \n");
		sbSql.append("  	   DECODE(A.MAIN_UPJANG, A.UPJANG, 0, 1) AS BON_GB,		\n");
		sbSql.append("         A.MAIN_UPJANG ,     \n");
		sbSql.append("         A.UPJANG ,     \n");
		sbSql.append("         DECODE(A.MAIN_UPJANG, A.UPJANG, A.UPJANGNM_DISP, '	- '||A.UPJANGNM_DISP) AS UPJANGNM_DISP ,     \n");
		sbSql.append("         CASE      \n");
		sbSql.append("  			WHEN "+ds_Cond.getString(0, "JDATE")+" BETWEEN NVL(A.CREDIT_START,'00000000') AND    NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0)     \n");
		sbSql.append("                ELSE 0     \n");
		sbSql.append("         END AS CREDIT_AMOUNT,		-- 여신금액      \n");
		sbSql.append("              \n");
		sbSql.append("         CASE     \n");
		sbSql.append("                WHEN "+ds_Cond.getString(0, "JDATE")+" BETWEEN NVL(A.CREDIT_START,'00000000') AND    NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0)     \n");
		sbSql.append("                ELSE 0     \n");
		sbSql.append("         END AS CREDIT_EXT_AMOUNT,		-- 여신연장금액-여신연장금액 삭제      \n");
		sbSql.append("              \n");
		sbSql.append("         CASE      \n");
		sbSql.append("  			WHEN "+ds_Cond.getString(0, "JDATE")+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0)     \n");
		sbSql.append("  			ELSE 0     \n");
		sbSql.append("         END AS CREDIT_AMOUNT_TOT,		-- 총 여신책정금액-여신연장금액 삭제      \n");
		sbSql.append("              \n");
		sbSql.append("         NVL( CASE      \n");
		sbSql.append("  				WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT     \n");
		sbSql.append("  				ELSE 0     \n");
		sbSql.append("  			END,0) AS CREDIT_OVER_AMOUNT,		-- 여신한도초과액      \n");
		sbSql.append("              \n");
		sbSql.append("         CASE      \n");
		sbSql.append("  			WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_END     \n");
		sbSql.append("              ELSE ''     \n");
		sbSql.append("         END AS CREDIT_OVER_END,		-- 한도초과종료     \n");
		sbSql.append("              \n");
		sbSql.append("         NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS,		-- 여신회전일     \n");
		sbSql.append("              \n");
		sbSql.append("         NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_EXT_DAYS,		-- 총 여신회전일 : 여신연장일 삭제     \n");
		sbSql.append("              \n");
	//	sbSql.append("         NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS_TOT , DECODE(C.L_BILL_DATE,NULL,-1,TO_DATE(20161126,'YYYYMMDD') - TO_DATE(C.L_BILL_DATE,'YYYYMMDD')) AS LAST_TURN_CNT,     \n");
		sbSql.append("  	        \n");
		sbSql.append("         NVL(F.PR_AMT,0) AS PR_AMT,		-- 매입예정(신청)      \n");
		sbSql.append("              \n");
		//sbSql.append("         NVL(E.PO_AMT,0) AS PO_AMT,		-- 매입예정(발주)     \n");
		sbSql.append("         DECODE(A.MAIN_UPJANG, A.UPJANG, E.PO_AMT, E_1.PO_AMT) AS PO_AMT ,		-- 매입예정(발주)     \n");
		sbSql.append("              \n");
		//sbSql.append("         NVL(D.TR_AMT,0) AS TR_AMT,		-- 매입확정     \n");
		sbSql.append("           DECODE(A.MAIN_UPJANG, A.UPJANG, D.TR_AMT, D_1.TR_AMT)    AS TR_AMT,		-- 매입확정     \n");
		sbSql.append("              \n");
		//sbSql.append("         NVL(C0.RMN_AMT,0) AS RMN_AMT,		-- 외상매출잔액     \n");
		sbSql.append("          DECODE(A.MAIN_UPJANG, A.UPJANG,C0.RMN_AMT, C0_1.RMN_AMT)  AS RMN_AMT,		-- 외상매출잔액     \n");
		sbSql.append("              \n");
		//sbSql.append("         NVL(C1.PRE_AMT,0) AS PRE_AMT,		-- 선수잔액     \n");
		sbSql.append("          DECODE(A.MAIN_UPJANG, A.UPJANG,C1.PRE_AMT, C1_1.PRE_AMT)   AS PRE_AMT,	-- 선수잔액     \n");
		sbSql.append("              \n");
		sbSql.append("         NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) + NVL(D.TR_AMT,0) + NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS BOND_AMT,		-- 채권잔액     \n");
		sbSql.append("              \n");
		//sbSql.append("         CASE     \n");
		//sbSql.append("                WHEN "+ds_Cond.getString(0, "JDATE")+" BETWEEN NVL(A.CREDIT_START,'00000000') AND    NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0)     \n");
		//sbSql.append("                ELSE 0     \n");
		//sbSql.append("         END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT,		-- 가용여신     \n");
		//sbSql.append("          END - DECODE( A.MAIN_UPJANG, A.UPJANG,  NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)  ,  NVL(C0_1.RMN_AMT,0) + NVL(C1_1.PRE_AMT,0) - NVL(D_1.TR_AMT,0) - NVL(E_1.PO_AMT,0) - NVL(F.PR_AMT,0))AS CREDIT_RMN_AMT,		-- 가용여신   \n");
       sbSql.append("   DECODE( A.MAIN_UPJANG, A.UPJANG,  \n");
       sbSql.append("         CASE      \n");
       sbSql.append("            WHEN 20170424 BETWEEN NVL(A.CREDIT_START,'00000000') AND    NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0)      \n");
      sbSql.append("             ELSE 0      \n");
      sbSql.append("              END -   NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)	,	-- 가용여신  , \n");
              
      sbSql.append("     DECODE(A.HEAD_CREDIT_YN, 'N',  CASE      \n");
      sbSql.append("             WHEN 20170424 BETWEEN NVL(A.CREDIT_START,'00000000') AND    NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0)      \n");
     sbSql.append("              ELSE 0      \n");
   sbSql.append("     -- END - DECODE( A.MAIN_UPJANG, A.UPJANG,  0 ,  NVL(C0_1.RMN_AMT,0) + NVL(C1_1.PRE_AMT,0) - NVL(D_1.TR_AMT,0) - NVL(E_1.PO_AMT,0) - NVL(F.PR_AMT,0))AS CREDIT_RMN_AMT,		-- 가용여신      \n");
    sbSql.append("     END -  NVL(C0_1.RMN_AMT,0) + NVL(C1_1.PRE_AMT,0) - NVL(D_1.TR_AMT,0) - NVL(E_1.PO_AMT,0) - NVL(F.PR_AMT,0) , 0) )AS CREDIT_RMN_AMT,		-- 가용여신      \n");
        
        	
		sbSql.append("              \n");
		sbSql.append("         CASE     \n");
		sbSql.append("                WHEN "+ds_Cond.getString(0, "JDATE")+" BETWEEN NVL(A.CREDIT_START,'00000000') AND    NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0)     \n");
		sbSql.append("                ELSE 0     \n");
		sbSql.append("         END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) + NVL(     \n");
		sbSql.append("  		   CASE     \n");
		sbSql.append("  				  WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD')     \n");
		sbSql.append("  				  THEN A.CREDIT_OVER_AMOUNT     \n");
		sbSql.append("  				  ELSE 0     \n");
		sbSql.append("  		   END,0) AS CREDIT_AVAIL_AMT,		 -- 실주문가능금액     \n");
		sbSql.append("             \n");
		//sbSql.append("         NVL(C.L_BILL_DATE,'00000000') AS L_BILL_DATE,		-- 최장 미입금된 외상매출발생일     \n");
		sbSql.append("              \n");
		//sbSql.append("         DECODE(C.L_BILL_DATE,NULL, '채권없음', TO_CHAR(TO_DATE(C.L_BILL_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"')) AS L_BILL_DATE_DISP,		-- 최장 미입금된 외상매출발생일     \n");
		sbSql.append("              \n");
		sbSql.append("         A.HEAD_CREDIT_YN,		-- 통합관리여부     \n");
		sbSql.append("              \n");
		sbSql.append("         A.CREDIT_CONTROL_YN,		-- 여신통제여부     \n");
		sbSql.append("              \n");
		sbSql.append("         A.CREDIT_TURN_CONTROL_YN,		-- 'Y'이면 여신회전일통제, 'N'이면 '통제안함'     \n");
		sbSql.append("              \n");
		sbSql.append("         A.CREDIT_AMOUNT_CONTROL_YN,		-- 'Y'이면 여신금액통제, 'N'이면 '통제안함'     \n");
		sbSql.append("              \n");
		sbSql.append("      -- SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD,		-- 계좌정보     \n");
		sbSql.append("              \n");
		sbSql.append("         DECODE(A.CREDIT_CONTROL_YN     \n");
		sbSql.append("                       ||A.CREDIT_TURN_CONTROL_YN     \n");
		sbSql.append("                       ||A.CREDIT_AMOUNT_CONTROL_YN ,'YYY', '금액+회전일' ,     \n");
		sbSql.append("  						'YYN', '회전일통제' ,     \n");
		sbSql.append("  						'YNY', '금액통제',     \n");
		sbSql.append("  						'무통제') AS CREDIT_CONTROL_DESC,		 -- 통제구분     \n");
		sbSql.append("             \n");
		sbSql.append("         A.CREDIT_START,		-- 여신부여일     \n");
		sbSql.append("              \n");
		sbSql.append("         A.CREDIT_END			-- 여신종료일     \n");
		sbSql.append("              \n");
		sbSql.append("  FROM   FMS_UPJANG A,     \n");
		sbSql.append("         --FMS_UPJANG A1     \n");
 
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         C0.외상잔액정보, 본사     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("               \n");
		sbSql.append("         (SELECT  T.MAIN_UPJANG ,     \n");
		sbSql.append("                  SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT     \n");
		sbSql.append("         FROM     (SELECT B.MAIN_UPJANG ,     \n");
		sbSql.append("                          NVL(M.AR_AMT, 0) AS AR_AMT ,     \n");
		sbSql.append("                          (SELECT NVL(SUM(D.RECEIVE_AMT),0)     \n");
		sbSql.append("                          FROM    SLA_AR_RECEIVE_DETAIL D     \n");
		sbSql.append("                          WHERE   D.RECD_STATUS   = 'L'     \n");
		sbSql.append("                          AND     D.RECEIVE_DATE <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                          AND     D.AR_NUM        = M.AR_NUM     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                          AS RECEIVE_AMT     \n");
		sbSql.append("                          ,B.HEAD_CREDIT_YN    \n");
		sbSql.append("                  FROM    SLA_AR_MST M,     \n");
		sbSql.append("                          FMS_UPJANG B     \n");
		sbSql.append("                  WHERE   M.SYS_CLASS      = '13'     \n");
		sbSql.append("                  AND     M.RECD_STATUS    = 'L'     \n");
		sbSql.append("                  AND     M.OCCUR_DATE    <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                  --AND     B.HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("                  AND     M.UPJANG_CD      = B.UPJANG     \n");
		sbSql.append("                  AND     M.UPJANG_CD IN     \n");
		sbSql.append("                          (SELECT UPJANG     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                          FROM    FMS_UPJANG_BB_WITH_ALL    \n");
		else
		    sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		
		sbSql.append("  ----                        WHERE   MAIN_UPJANG    = 111747     \n");
		sbSql.append("  ----                        AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                        AND     USE_YN         = 'Y'     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                  )     \n");
		sbSql.append("                  T     \n");
		sbSql.append("         WHERE HEAD_CREDIT_YN = 'Y'    \n");
		sbSql.append("         GROUP BY T.MAIN_UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         C0     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         C0.외상잔액정보, 사업장     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("          ,     \n");
		sbSql.append("         (SELECT  T.UPJANG ,     \n");
		sbSql.append("                  SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT     \n");
		sbSql.append("         FROM     (SELECT B.UPJANG ,     \n");
		sbSql.append("                          NVL(M.AR_AMT, 0) AS AR_AMT ,     \n");
		sbSql.append("                          (SELECT NVL(SUM(D.RECEIVE_AMT),0)     \n");
		sbSql.append("                          FROM    SLA_AR_RECEIVE_DETAIL D     \n");
		sbSql.append("                          WHERE   D.RECD_STATUS   = 'L'     \n");
		sbSql.append("                          AND     D.RECEIVE_DATE <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                          AND     D.AR_NUM        = M.AR_NUM     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                          AS RECEIVE_AMT     \n");
		sbSql.append("                          ,B.HEAD_CREDIT_YN    \n");
		sbSql.append("                  FROM    SLA_AR_MST M,     \n");
		sbSql.append("                          FMS_UPJANG B     \n");
		sbSql.append("                  WHERE   M.SYS_CLASS      = '13'     \n");
		sbSql.append("                  AND     M.RECD_STATUS    = 'L'     \n");
		sbSql.append("                  AND     M.OCCUR_DATE    <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                  --AND     B.HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("                  AND     M.UPJANG_CD      = B.UPJANG     \n");
		sbSql.append("                  AND     M.UPJANG_CD IN     \n");
		sbSql.append("                          (SELECT UPJANG     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                          FROM    FMS_UPJANG_BB_WITH_ALL    \n");
		else
		    sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                        WHERE   MAIN_UPJANG    = 111747     \n");
		sbSql.append("  ----                        AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                        AND     USE_YN         = 'Y'     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                  )     \n");
		sbSql.append("                  T     \n");
		sbSql.append("         WHERE HEAD_CREDIT_YN = 'N'    \n");
		sbSql.append("         GROUP BY T.UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         C0_1     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         C1.선수잔액정보     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("         ,     \n");
		sbSql.append("         (SELECT  T.MAIN_UPJANG ,     \n");
		sbSql.append("                  SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT     \n");
		sbSql.append("         FROM     (SELECT B.MAIN_UPJANG ,     \n");
		sbSql.append("                          NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT ,     \n");
		sbSql.append("                          (SELECT NVL(SUM(D.APPLY_AMT),0)     \n");
		sbSql.append("                          FROM    SLA_ADVANCE_ALT_DETAIL D     \n");
		sbSql.append("                          WHERE   D.RECD_STATUS = 'L'     \n");
		sbSql.append("                          AND     D.ALT_DATE   <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                          AND     D.ADVANCE_NUM = M.ADVANCE_NUM     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                          AS APPLY_AMT     \n");
		sbSql.append("                          ,B.HEAD_CREDIT_YN    \n");
		sbSql.append("                  FROM    SLA_ADVANCE_MST M,     \n");
		sbSql.append("                          FMS_UPJANG B     \n");
		sbSql.append("                  WHERE   M.SYS_CLASS      = '13'     \n");
		sbSql.append("                  AND     M.RECD_STATUS    = 'L'     \n");
		sbSql.append("                  AND     M.OCCUR_DATE    <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                  --AND     B.HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("                  AND     M.UPJANG_CD      = B.UPJANG     \n");
		sbSql.append("                  AND     M.UPJANG_CD IN     \n");
		sbSql.append("                          (SELECT UPJANG     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                          FROM    FMS_UPJANG_BB_WITH_ALL    \n");
		else
		    sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                        WHERE   MAIN_UPJANG    = 111747     \n");
		sbSql.append("  ----                        AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                        AND     USE_YN         = 'Y'     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                  )     \n");
		sbSql.append("                  T     \n");
		sbSql.append("        WHERE HEAD_CREDIT_YN = 'Y'    \n");
		sbSql.append("         GROUP BY T.MAIN_UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         C1     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         C1.선수잔액정보     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("         ,     \n");
		sbSql.append("         (SELECT  T.UPJANG ,     \n");
		sbSql.append("                  SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT     \n");
		sbSql.append("         FROM     (SELECT B.UPJANG ,     \n");
		sbSql.append("                          NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT ,     \n");
		sbSql.append("                          (SELECT NVL(SUM(D.APPLY_AMT),0)     \n");
		sbSql.append("                          FROM    SLA_ADVANCE_ALT_DETAIL D     \n");
		sbSql.append("                          WHERE   D.RECD_STATUS = 'L'     \n");
		sbSql.append("                          AND     D.ALT_DATE   <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                          AND     D.ADVANCE_NUM = M.ADVANCE_NUM     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                          AS APPLY_AMT     \n");
		sbSql.append("                          ,B.HEAD_CREDIT_YN    \n");
		sbSql.append("                  FROM    SLA_ADVANCE_MST M,     \n");
		sbSql.append("                          FMS_UPJANG B     \n");
		sbSql.append("                  WHERE   M.SYS_CLASS      = '13'     \n");
		sbSql.append("                  AND     M.RECD_STATUS    = 'L'     \n");
		sbSql.append("                  AND     M.OCCUR_DATE    <= "+ds_Cond.getString(0, "JDATE")+"     \n");
		sbSql.append("                  --AND     B.HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("                  AND     M.UPJANG_CD      = B.UPJANG     \n");
		sbSql.append("                  AND     M.UPJANG_CD IN     \n");
		sbSql.append("                          (SELECT UPJANG     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                          FROM    FMS_UPJANG_BB_WITH_ALL    \n");
		else
		    sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                        WHERE   MAIN_UPJANG    = 111747     \n");
		sbSql.append("  ----                        AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                        AND     USE_YN         = 'Y'     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                  )     \n");
		sbSql.append("                  T     \n");
		sbSql.append("         WHERE HEAD_CREDIT_YN = 'N'    \n");
		sbSql.append("         GROUP BY T.UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         C1_1     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         D.당월 미매출마감된 검수금액     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("         ,     \n");
		sbSql.append("         (     \n");
		sbSql.append("  ----       SELECT  X.MAIN_UPJANG ,     \n");
		sbSql.append("  ----                SUM(X.TR_AMT) AS TR_AMT     \n");
		sbSql.append("  ----       FROM     (     \n");
		sbSql.append("         SELECT     \n");
		sbSql.append("                           /*+ PUSH_PRED(A) */     \n");
		sbSql.append("                           A.MAIN_UPJANG ,     \n");
		sbSql.append("                           --A.UPJANG ,     \n");
		sbSql.append("                           SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I', 1, -1) * ROUND(DECODE(A.TAX_CODE,'100', 1.1, 1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT     \n");
		sbSql.append("                  FROM     (SELECT DT.MG_NO AS TRANS_ID,		-- 자재수불번호     \n");
		sbSql.append("                                   CASE WHEN SUBSTR(DT.MOVEMENT_TYP,0,2)='25' THEN 'FO'     \n");
		sbSql.append("                                        WHEN DT.PROC_TYP_CD IS NULL AND DT.IVT_INSP_NO IS NOT NULL THEN '재고조정'     \n");
		sbSql.append("                                        WHEN DT.PROC_TYP_CD    IS NULL AND DT.IVT_INSP_NO IS NULL THEN 'INV'     \n");
		sbSql.append("                                        ELSE 'PO'     \n");
		sbSql.append("                                   END AS SOURCE_TYPE,		-- FO, PO, INV, 재고조정     \n");
		sbSql.append("                                        \n");
		sbSql.append("                                   SL.CUST_GR_DATE AS TRANS_DATE,		-- 판매일자     \n");
		sbSql.append("                                        \n");
		sbSql.append("                                   DT.MG_DATE AS MG_DATE,		-- 수불일자     \n");
		sbSql.append("                                        \n");
		sbSql.append("                                   CASE WHEN SUBSTR(DT.MOVEMENT_TYP,0,1) = '3' AND DT.GR_QTY IS NULL     \n");
		sbSql.append("                                          THEN 'O002'     \n");
		sbSql.append("                                        WHEN SUBSTR(DT.MOVEMENT_TYP,0,1) = '3' AND DT.GR_QTY IS NOT NULL     \n");
		sbSql.append("                                          THEN 'I002'     \n");
		sbSql.append("                                        WHEN DT.MOVEMENT_TYP    = '251' OR DT.MOVEMENT_TYP = '252'     \n");
		sbSql.append("                                           THEN 'O001'     \n");
		sbSql.append("                                        WHEN DT.MOVEMENT_TYP    = '701' OR DT.MOVEMENT_TYP = '702'     \n");
		sbSql.append("                                          THEN 'O004'     \n");
		sbSql.append("                                        ELSE 'I001'     \n");
		sbSql.append("                                   END AS TRANS_TYPE,     \n");
		sbSql.append("                                   CASE WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=0 AND DT.PROC_TYP_CD IS NOT NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_PURC_QTY*-1,DT.GR_PURC_QTY*-1)     \n");
		sbSql.append("                                        WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=1 AND DT.PROC_TYP_CD IS NOT NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_PURC_QTY,DT.GR_PURC_QTY)     \n");
		sbSql.append("                                        WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=0 AND DT.PROC_TYP_CD IS NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_QTY*-1,DT.GR_QTY*-1)     \n");
		sbSql.append("                                        WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=1 AND DT.PROC_TYP_CD IS NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_QTY,DT.GR_QTY)     \n");
		sbSql.append("                                   END AS TRANS_QTY,     \n");
		sbSql.append("                                   SL.SHOP_CD AS TRANS_UPJANG,     \n");
		sbSql.append("                                   SL.CUST_WH_CD AS SUBINV_CODE,     \n");
		sbSql.append("                                  CASE WHEN PO.DUTY_FREE_YN ='1' THEN '100'     \n");
		sbSql.append("                                       WHEN PO.DUTY_FREE_YN ='3' THEN '210'     \n");
		sbSql.append("                                       WHEN PO.DUTY_FREE_YN ='2' THEN '220'     \n");
		sbSql.append("                                  END AS TAX_CODE, -- 과세구분코드     \n");
		sbSql.append("                                  SL.SAL_PRICE AS SALE_PRICE,     \n");
		sbSql.append("                                   SALE_WITH.MAIN_UPJANG,		-- 외부판매단가     \n");
		sbSql.append("                           		 SALE_WITH.HEAD_CREDIT_YN    \n");
		sbSql.append("                             FROM EPROCUSR.ESIMGDT DT  -- 수불상세     \n");
		sbSql.append("                                , EPROCUSR.ESPPODT PO	 -- 발주 상세     \n");
		sbSql.append("                                , EPROCUSR.ESISALP SL -- 판매단가     \n");
		
		
		//sbSql.append("									,(		\n");
		//sbSql.append("										SELECT  /*+ NO_MERGE LEADING(SL) USE_NL(SLD) */		\n");                                                                                                                                                                               
		//sbSql.append("										        SL.SL_ID AS SL_ID,		\n");                                                                                                                                                                                                         
		//sbSql.append("										        SLD.SHOP_CD,		\n");                                                                                                                                                                                                                
		//sbSql.append("										        SLD.SAL_PRICE,		\n");                                                                                                                                                                                                              
		//sbSql.append("										        SL.MAIN_UPJANG   -- GROUP 합계용 MAIN_UPJANG 데이터		\n");                                                                                                                                                                         
		//sbSql.append("										        FROM EPROCUSR.ESISALP SLD,		\n");                                                                                                                                                                                                         
		//sbSql.append("										        	(		\n");                                                                                                                                                                                                                             
		//sbSql.append("										             	SELECT /*+ NO_MERGE */ SL.ROWID AS SL_ID,		\n");                                                                                                                                                                                  
		//sbSql.append("										                		BB.MAIN_UPJANG		\n");                                                                                                                                                                                                      
		//sbSql.append("										                        FROM EPROCUSR.ESISALP SL	-- 판매단가		\n");                                                                                                                                       
		//sbSql.append("										                        	INNER JOIN FMS_UPJANG_BB_WITH BB		\n");                                                                                                                                                                                          
		//sbSql.append("										                                    ON SL.SHOP_CD = BB.UPJANG		\n");                                                                                                                                                                                              
		//sbSql.append("										                                ORDER BY SL.ROWID		\n");                                                                                                                                                                                                          
		//sbSql.append("										             ) SL		\n");                                                                                                                                                                                                                           
		//sbSql.append("										             WHERE SLD.ROWID = SL.SL_ID		\n");                                                                                                                                                                                                     
		//sbSql.append("										             ORDER BY SL.SL_ID		\n");
		//sbSql.append("									) SL		\n");		
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                               , SALE_WITH_ALL SALE_WITH      \n");
		else
		    sbSql.append("                               , SALE_WITH SALE_WITH      \n");	 
		
		//sbSql.append("								  , (SELECT /*+  NO_MERGE USE_NL(BB SL) USE_HASH(SL DT) INDEX_FFS(DT ESIMGDT_PK)  */		\n");
		//sbSql.append("												SL.ROWID AS SL_ID,		\n");                                            
		//sbSql.append("							                    DT.ROWID AS DT_ID		\n");                                                                                                                                                                                                           
		//sbSql.append("							                    FROM EPROCUSR.ESIMGDT DT,		\n");                                                                                                                                                                                                          
		//sbSql.append("							                    	 EPROCUSR.ESISALP SL		\n");                                                                                                                                                                                                            
		//sbSql.append("							                            INNER JOIN FMS_UPJANG_BB_WITH BB		\n");                                                                                                                                                                                                  
		//sbSql.append("							                            ON SL.SHOP_CD = BB.UPJANG		\n");                                                                                                                                                                                                      
		//sbSql.append("							                        WHERE DT.SYS_ID = SL.SYS_ID		\n");                                                                                                                                                                                                        
		//sbSql.append("							                        AND DT.COMP_CD = SL.COMP_CD		\n");                                                                                                                                                                                                        
		//sbSql.append("							                        AND DT.MG_NO = SL.MG_NO		\n");                                                                                                                                                                                                            
		//sbSql.append("							                        AND SL.SYS_ID = '100'		\n");                                                                                                                                                                                                              
		//sbSql.append("							                        AND SL.COMP_CD = 'HFC'		\n");                                                                                                                                                                                                             
		//sbSql.append("							                        ORDER BY DT.ROWID		\n");
		//sbSql.append("									) UP		\n");
		
		
		
		sbSql.append("                            WHERE  1=1		\n");
		//sbSql.append("							 AND UP.SL_ID = SL.SL_ID    \n");
		sbSql.append("							 AND DT.SYS_ID  = '100'     \n");
		sbSql.append("                           AND DT.COMP_CD = 'HFC'     \n");
		sbSql.append("                           AND PO.BU_CD   = '2000'     \n");
		sbSql.append("                           AND DT.SYS_ID  = PO.SYS_ID     \n");
		sbSql.append("                           AND DT.COMP_CD = PO.COMP_CD     \n");
		sbSql.append("                           AND DT.PO_NO   = PO.PO_NO     \n");
		sbSql.append("                           AND DT.PO_LNO  = PO.PO_LNO     \n");
		sbSql.append("                           AND PO.SHOP_TYP_CD = '02'     \n");
		sbSql.append("  						 AND DT.MOVEMENT_TYP IN ('115','132','147','148','651','652')     \n");
		sbSql.append("                   AND     DT.SYS_ID  = SL.SYS_ID     \n");
		sbSql.append("                   AND     DT.COMP_CD = SL.COMP_CD     \n");
		sbSql.append("                   AND     DT.MG_NO   = SL.MG_NO     \n");
		sbSql.append("                   AND     DT.STS    <> 'D'     \n");
		sbSql.append("                   AND     SL.SHOP_CD IN     \n");
		sbSql.append("                           (SELECT UPJANG     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                          FROM    FMS_UPJANG_BB_WITH_ALL    \n");
		else
		    sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                         WHERE   MAIN_UPJANG    = 111747     \n");
		sbSql.append("  ----                         AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                         AND     USE_YN         = 'Y'     \n");
		sbSql.append("                           )     \n");
		sbSql.append("  ----                 AND     SL.CUST_GR_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(20161126, 'YYYYMMDD'), -1), 'YYYYMM')|| '01' AND '20161126'     \n");
		sbSql.append("                   AND TO_NUMBER(SL.SHOP_CD) = SALE_WITH.UPJANG     \n");
		//sbSql.append("                   AND SL.CUST_GR_DATE BETWEEN SALE_WITH.SALE_DATE AND '"+ds_Cond.getString(0, "JDATE")+"'     \n");
		sbSql.append("                   AND  DT.MG_DATE BETWEEN SALE_WITH.SALE_DATE AND '"+ds_Cond.getString(0, "JDATE")+"'     \n");
		sbSql.append("                   UNION ALL     \n");
		sbSql.append("           SELECT B.TRANS_ID,     \n");
		sbSql.append("                  B.SOURCE_TYPE ,     \n");
		sbSql.append("                  B.TRANS_DATE,     \n");
		sbSql.append("                  B.TRANS_DATE AS MG_DATE,     \n");
		sbSql.append("                  B.TRANS_TYPE,     \n");
		sbSql.append("                  B.TRANS_QTY,     \n");
		sbSql.append("                  TO_CHAR (B.TRANS_UPJANG) AS TRANS_UPJANG,     \n");
		sbSql.append("                  B.SUBINV_CODE,     \n");
		sbSql.append("                  B.TAX_CODE,     \n");
		sbSql.append("                  B.SALE_PRICE,     \n");
		sbSql.append("                  --SALE_WITH.MAIN_UPJANG     \n");
		sbSql.append("                  SALE_WITH.UPJANG  ,   \n");
		sbSql.append("                  SALE_WITH.HEAD_CREDIT_YN      \n");
		sbSql.append("             FROM FMS_TRANSACTION B     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                               , SALE_WITH_ALL SALE_WITH      \n");
		else
		    sbSql.append("                               , SALE_WITH SALE_WITH       \n");	
		sbSql.append("            WHERE B.TRANS_UPJANG= SALE_WITH.UPJANG     \n");
		sbSql.append("              AND B.TRANS_DATE BETWEEN SALE_WITH.SALE_DATE AND '"+ds_Cond.getString(0, "JDATE")+"'     \n");
		sbSql.append("              AND B.TRANS_UPJANG IN     \n");
		sbSql.append("                           (SELECT UPJANG     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                          FROM    FMS_UPJANG_BB_WITH_ALL    \n");
		else
		    sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                         WHERE   MAIN_UPJANG    = '111747'     \n");
		sbSql.append("  ----                         AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                         AND     USE_YN         = 'Y'     \n");
		sbSql.append("                           )     \n");
		sbSql.append("              ) A     \n");
		sbSql.append("  ----		, FMS_UPJANG C     \n");
		sbSql.append("                  WHERE    1=1      \n");
		sbSql.append("  ----				A.TRANS_UPJANG   = C.UPJANG     \n");
		sbSql.append("  				AND      A.HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("                  AND ( A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE   ='PO'))     \n");
		sbSql.append("  ----			AND      C.MAIN_UPJANG = '111747'     \n");
		sbSql.append("                  --GROUP BY A.MAIN_UPJANG     \n");
		sbSql.append("                  GROUP BY A.MAIN_UPJANG     \n");
		sbSql.append("  ----                )     \n");
		sbSql.append("  ----                X     \n");
		sbSql.append("  ----       GROUP BY X.MAIN_UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         D     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         D.당월 미매출마감된 검수금액     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("         ,     \n");
		sbSql.append("         (     \n");
		sbSql.append("  ----       SELECT  X.MAIN_UPJANG ,     \n");
		sbSql.append("  ----                SUM(X.TR_AMT) AS TR_AMT     \n");
		sbSql.append("  ----       FROM     (     \n");
		sbSql.append("         SELECT     \n");
		sbSql.append("                           /*+ PUSH_PRED(A) */     \n");
		sbSql.append("                           --A.MAIN_UPJANG ,     \n");
		sbSql.append("                           A.UPJANG ,     \n");
		sbSql.append("                           SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I', 1, -1) * ROUND(DECODE(A.TAX_CODE,'100', 1.1, 1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT     \n");
		sbSql.append("                  FROM     (SELECT DT.MG_NO AS TRANS_ID,		-- 자재수불번호     \n");
		sbSql.append("                                   CASE WHEN SUBSTR(DT.MOVEMENT_TYP,0,2)='25' THEN 'FO'     \n");
		sbSql.append("                                        WHEN DT.PROC_TYP_CD IS NULL AND DT.IVT_INSP_NO IS NOT NULL THEN '재고조정'     \n");
		sbSql.append("                                        WHEN DT.PROC_TYP_CD    IS NULL AND DT.IVT_INSP_NO IS NULL THEN 'INV'     \n");
		sbSql.append("                                        ELSE 'PO'     \n");
		sbSql.append("                                   END AS SOURCE_TYPE,		-- FO, PO, INV, 재고조정     \n");
		sbSql.append("                                        \n");
		sbSql.append("                                   SL.CUST_GR_DATE AS TRANS_DATE,		-- 판매일자     \n");
		sbSql.append("                                        \n");
		sbSql.append("                                   DT.MG_DATE AS MG_DATE,		-- 수불일자     \n");
		sbSql.append("                                        \n");
		sbSql.append("                                   CASE WHEN SUBSTR(DT.MOVEMENT_TYP,0,1) = '3' AND DT.GR_QTY IS NULL     \n");
		sbSql.append("                                          THEN 'O002'     \n");
		sbSql.append("                                        WHEN SUBSTR(DT.MOVEMENT_TYP,0,1) = '3' AND DT.GR_QTY IS NOT NULL     \n");
		sbSql.append("                                          THEN 'I002'     \n");
		sbSql.append("                                        WHEN DT.MOVEMENT_TYP    = '251' OR DT.MOVEMENT_TYP = '252'     \n");
		sbSql.append("                                           THEN 'O001'     \n");
		sbSql.append("                                        WHEN DT.MOVEMENT_TYP    = '701' OR DT.MOVEMENT_TYP = '702'     \n");
		sbSql.append("                                          THEN 'O004'     \n");
		sbSql.append("                                        ELSE 'I001'     \n");
		sbSql.append("                                   END AS TRANS_TYPE,     \n");
		sbSql.append("                                   CASE WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=0 AND DT.PROC_TYP_CD IS NOT NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_PURC_QTY*-1,DT.GR_PURC_QTY*-1)     \n");
		sbSql.append("                                        WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=1 AND DT.PROC_TYP_CD IS NOT NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_PURC_QTY,DT.GR_PURC_QTY)     \n");
		sbSql.append("                                        WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=0 AND DT.PROC_TYP_CD IS NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_QTY*-1,DT.GR_QTY*-1)     \n");
		sbSql.append("                                        WHEN MOD(TO_NUMBER(DT.MOVEMENT_TYP),2)=1 AND DT.PROC_TYP_CD IS NULL     \n");
		sbSql.append("                                          THEN DECODE(DT.GR_QTY,NULL,DT.GI_QTY,DT.GR_QTY)     \n");
		sbSql.append("                                   END AS TRANS_QTY,     \n");
		sbSql.append("                                   SL.SHOP_CD AS TRANS_UPJANG,     \n");
		sbSql.append("                                   SL.CUST_WH_CD AS SUBINV_CODE,     \n");
		sbSql.append("                                  CASE WHEN PO.DUTY_FREE_YN ='1' THEN '100'     \n");
		sbSql.append("                                       WHEN PO.DUTY_FREE_YN ='3' THEN '210'     \n");
		sbSql.append("                                       WHEN PO.DUTY_FREE_YN ='2' THEN '220'     \n");
		sbSql.append("                                  END AS TAX_CODE, -- 과세구분코드     \n");
		sbSql.append("                                  SL.SAL_PRICE AS SALE_PRICE,     \n");
		sbSql.append("                                   SALE_WITH.UPJANG,		-- 외부판매단가     \n");
		sbSql.append("                           		 SALE_WITH.HEAD_CREDIT_YN    \n");
		sbSql.append("                             FROM EPROCUSR.ESIMGDT DT  -- 수불상세     \n");
		sbSql.append("                                , EPROCUSR.ESPPODT PO	 -- 발주 상세     \n");
		sbSql.append("                                , EPROCUSR.ESISALP SL -- 판매단가     \n");
		
		
		//sbSql.append("									,(		\n");
		//sbSql.append("										SELECT  /*+ NO_MERGE LEADING(SL) USE_NL(SLD) */		\n");                                                                                                                                                                               
		//sbSql.append("										        SL.SL_ID AS SL_ID,		\n");                                                                                                                                                                                                         
		//sbSql.append("										        SLD.SHOP_CD,		\n");                                                                                                                                                                                                                
		//sbSql.append("										        SLD.SAL_PRICE,		\n");                                                                                                                                                                                                              
		//sbSql.append("										        SL.MAIN_UPJANG   -- GROUP 합계용 MAIN_UPJANG 데이터		\n");                                                                                                                                                                         
		//sbSql.append("										        FROM EPROCUSR.ESISALP SLD,		\n");                                                                                                                                                                                                         
		//sbSql.append("										        	(		\n");                                                                                                                                                                                                                             
		//sbSql.append("										             	SELECT /*+ NO_MERGE */ SL.ROWID AS SL_ID,		\n");                                                                                                                                                                                  
		//sbSql.append("										                		BB.MAIN_UPJANG		\n");                                                                                                                                                                                                      
		//sbSql.append("										                        FROM EPROCUSR.ESISALP SL	-- 판매단가		\n");                                                                                                                                       
		//sbSql.append("										                        	INNER JOIN FMS_UPJANG_BB_WITH BB		\n");                                                                                                                                                                                          
		//sbSql.append("										                                    ON SL.SHOP_CD = BB.UPJANG		\n");                                                                                                                                                                                              
		//sbSql.append("										                                ORDER BY SL.ROWID		\n");                                                                                                                                                                                                          
		//sbSql.append("										             ) SL		\n");                                                                                                                                                                                                                           
		//sbSql.append("										             WHERE SLD.ROWID = SL.SL_ID		\n");                                                                                                                                                                                                     
		//sbSql.append("										             ORDER BY SL.SL_ID		\n");
		//sbSql.append("									) SL		\n");		
		                 
		sbSql.append("                                , SALE_WITH SALE_WITH     \n");
		
		//sbSql.append("								  , (SELECT /*+  NO_MERGE USE_NL(BB SL) USE_HASH(SL DT) INDEX_FFS(DT ESIMGDT_PK)  */		\n");
		//sbSql.append("												SL.ROWID AS SL_ID,		\n");                                            
		//sbSql.append("							                    DT.ROWID AS DT_ID		\n");                                                                                                                                                                                                           
		//sbSql.append("							                    FROM EPROCUSR.ESIMGDT DT,		\n");                                                                                                                                                                                                          
		//sbSql.append("							                    	 EPROCUSR.ESISALP SL		\n");                                                                                                                                                                                                            
		//sbSql.append("							                            INNER JOIN FMS_UPJANG_BB_WITH BB		\n");                                                                                                                                                                                                  
		//sbSql.append("							                            ON SL.SHOP_CD = BB.UPJANG		\n");                                                                                                                                                                                                      
		//sbSql.append("							                        WHERE DT.SYS_ID = SL.SYS_ID		\n");                                                                                                                                                                                                        
		//sbSql.append("							                        AND DT.COMP_CD = SL.COMP_CD		\n");                                                                                                                                                                                                        
		//sbSql.append("							                        AND DT.MG_NO = SL.MG_NO		\n");                                                                                                                                                                                                            
		//sbSql.append("							                        AND SL.SYS_ID = '100'		\n");                                                                                                                                                                                                              
		//sbSql.append("							                        AND SL.COMP_CD = 'HFC'		\n");                                                                                                                                                                                                             
		//sbSql.append("							                        ORDER BY DT.ROWID		\n");
		//sbSql.append("									) UP		\n");
		
		
		
		sbSql.append("                            WHERE  1=1		\n");
		//sbSql.append("							 AND UP.SL_ID = SL.SL_ID    \n");
		sbSql.append("							 AND DT.SYS_ID  = '100'     \n");
		sbSql.append("                           AND DT.COMP_CD = 'HFC'     \n");
		sbSql.append("                           AND PO.BU_CD   = '2000'     \n");
		sbSql.append("                           AND DT.SYS_ID  = PO.SYS_ID     \n");
		sbSql.append("                           AND DT.COMP_CD = PO.COMP_CD     \n");
		sbSql.append("                           AND DT.PO_NO   = PO.PO_NO     \n");
		sbSql.append("                           AND DT.PO_LNO  = PO.PO_LNO     \n");
		sbSql.append("                           AND PO.SHOP_TYP_CD = '02'     \n");
		sbSql.append("  						 AND DT.MOVEMENT_TYP IN ('115','132','147','148','651','652')     \n");
		sbSql.append("                   AND     DT.SYS_ID  = SL.SYS_ID     \n");
		sbSql.append("                   AND     DT.COMP_CD = SL.COMP_CD     \n");
		sbSql.append("                   AND     DT.MG_NO   = SL.MG_NO     \n");
		sbSql.append("                   AND     DT.STS    <> 'D'     \n");
		sbSql.append("                   AND     SL.SHOP_CD IN     \n");
		sbSql.append("                           (SELECT UPJANG     \n");
		sbSql.append("                           FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                         WHERE   MAIN_UPJANG    = 111747     \n");
		sbSql.append("  ----                         AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                         AND     USE_YN         = 'Y'     \n");
		sbSql.append("                           )     \n");
		sbSql.append("  ----                 AND     SL.CUST_GR_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(20161126, 'YYYYMMDD'), -1), 'YYYYMM')|| '01' AND '20161126'     \n");
		sbSql.append("                   AND TO_NUMBER(SL.SHOP_CD) = SALE_WITH.UPJANG     \n");
		//sbSql.append("                   AND SL.CUST_GR_DATE BETWEEN SALE_WITH.SALE_DATE AND '"+ds_Cond.getString(0, "JDATE")+"'     \n");
		sbSql.append("                   AND  DT.MG_DATE BETWEEN SALE_WITH.SALE_DATE AND '"+ds_Cond.getString(0, "JDATE")+"'     \n");
		sbSql.append("                   UNION ALL     \n");
		sbSql.append("           SELECT B.TRANS_ID,     \n");
		sbSql.append("                  B.SOURCE_TYPE ,     \n");
		sbSql.append("                  B.TRANS_DATE,     \n");
		sbSql.append("                  B.TRANS_DATE AS MG_DATE,     \n");
		sbSql.append("                  B.TRANS_TYPE,     \n");
		sbSql.append("                  B.TRANS_QTY,     \n");
		sbSql.append("                  TO_CHAR (B.TRANS_UPJANG) AS TRANS_UPJANG,     \n");
		sbSql.append("                  B.SUBINV_CODE,     \n");
		sbSql.append("                  B.TAX_CODE,     \n");
		sbSql.append("                  B.SALE_PRICE,     \n");
		sbSql.append("                  --SALE_WITH.MAIN_UPJANG     \n");
		sbSql.append("                  SALE_WITH.UPJANG  ,   \n");
		sbSql.append("                  SALE_WITH.HEAD_CREDIT_YN     \n");
		sbSql.append("             FROM FMS_TRANSACTION B     \n");
		sbSql.append("                , SALE_WITH SALE_WITH     \n");
		sbSql.append("            WHERE B.TRANS_UPJANG= SALE_WITH.UPJANG     \n");
		sbSql.append("              AND B.TRANS_DATE BETWEEN SALE_WITH.SALE_DATE AND '"+ds_Cond.getString(0, "JDATE")+"'     \n");
		sbSql.append("              AND B.TRANS_UPJANG IN     \n");
		sbSql.append("                           (SELECT UPJANG     \n");
		sbSql.append("                           FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                         WHERE   MAIN_UPJANG    = '111747'     \n");
		sbSql.append("  ----                         AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                         AND     USE_YN         = 'Y'     \n");
		sbSql.append("                           )     \n");
		sbSql.append("              ) A     \n");
		sbSql.append("  ----		, FMS_UPJANG C     \n");
		sbSql.append("                  WHERE    1=1      \n");
		sbSql.append("  ----				A.TRANS_UPJANG   = C.UPJANG     \n");
		sbSql.append(" -- 				AND      A.HEAD_CREDIT_YN = 'N'     \n");
		sbSql.append("                  AND ( A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE   ='PO'))     \n");
		sbSql.append("  ----			AND      C.MAIN_UPJANG = '111747'     \n");
		sbSql.append("                  --GROUP BY A.MAIN_UPJANG     \n");
		sbSql.append("                  GROUP BY A.UPJANG     \n");
		sbSql.append("  ----                )     \n");
		sbSql.append("  ----                X     \n");
		sbSql.append("  ----       GROUP BY X.MAIN_UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         D_1     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         E.당월 미검수 발주금액     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("         ,     \n");
		sbSql.append("         ( SELECT  A.MAIN_UPJANG ,     \n");
		sbSql.append("  				--A.UPJANG ,     \n");
		sbSql.append("                  SUM(ROUND(DECODE(A.TAX_CODE,'100',     \n");
		sbSql.append("                                   1.1,     \n");
		sbSql.append("                                   1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT     \n");
		sbSql.append("         FROM     ( SELECT SAL.SHOP_CD AS RC_UPJANG	-- 입고업장 코드     \n");
		sbSql.append("                         , CASE WHEN PODT.DUTY_FREE_YN ='1' THEN '100'     \n");
		sbSql.append("                                WHEN PODT.DUTY_FREE_YN ='3' THEN '210'     \n");
		sbSql.append("                                WHEN PODT.DUTY_FREE_YN ='2' THEN '220'     \n");
		sbSql.append("                           END AS TAX_CODE	-- 과세구분코드     \n");
		sbSql.append("                         , PODT.PR_QTY AS PR_QTY	-- 신청 수량     \n");
		sbSql.append("                         , PODT.ITEM_QTY AS PO_QTY	-- 발수 수량     \n");
		sbSql.append("                         , CASE WHEN PODT.PROC_TYP_CD IN('DC','TC') THEN PODT.ITEM_QTY     \n");
		sbSql.append("                             ELSE 0     \n");
		sbSql.append("                           END AS CENTER_DELI_QTY	-- 센터입고수량     \n");
		sbSql.append("                         , 0 AS CENTER_UNDELI_QTY -- 센터미입고 수량     \n");
		sbSql.append("                         , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY     \n");
		sbSql.append("                             ELSE 0     \n");
		sbSql.append("                           END AS DIRECT_DELI_QTY -- 직송 수량     \n");
		sbSql.append("                         , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0)     \n");
		sbSql.append("                             ELSE NVL(PODT.GR_QTY_WMS,0)     \n");
		sbSql.append("                           END AS DELIVERED_QTY --업장입고수량(센터출고)     \n");
		sbSql.append("                         , CASE WHEN PODT.PO_COMP_YN   ='Y' OR PODT.GR_COMP_YN = 'Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료     \n");
		sbSql.append("                                  ELSE 0     \n");
		sbSql.append("                           END AS UNDELIVERED_QTY -- 감량수량     \n");
		sbSql.append("                         , PODT.RTN_QTY AS RETURNED_QTY -- 반품수량     \n");
		sbSql.append("                         , SAL.CUST_GR_DATE AS NEED_DATE -- 입고희망일자     \n");
		sbSql.append("                         , NVL(     \n");
		sbSql.append("                          CASE     \n");
		sbSql.append("                                  WHEN POHD.PO_TYP = 'BP'     \n");
		sbSql.append("                                  THEN     \n");
		sbSql.append("                                          CASE     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'T'     \n");
		sbSql.append("                                                  THEN 'RW' --통합영업에서 뷰 불가     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'P'     \n");
		sbSql.append("                                                  THEN 'PW'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('R',     \n");
		sbSql.append("                                                                            'W')     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('C',     \n");
		sbSql.append("                                                                            'K')     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                          END     \n");
		sbSql.append("                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))     \n");
		sbSql.append("                          END,'PC') AS LINE_STATUS -- 라인 상태 코드     \n");
		sbSql.append("                        , NVL(SAL.SAL_PRICE,0) AS SALE_PRICE -- 판매 단가     \n");
		sbSql.append("                        , SALE_WITH.MAIN_UPJANG     \n");
		sbSql.append("  					  , SALE_WITH.HEAD_CREDIT_YN    AS HEAD_CREDIT_YN   \n");
		sbSql.append("                     FROM EPROCUSR.ESPPOHD POHD              -- PO 헤더     \n");
		sbSql.append("                        , EPROCUSR.ESPPODT PODT -- PO 상세(품목)     \n");
		sbSql.append("                        , EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]     \n");
		sbSql.append("                        , EPROCUSR.ESPPRDT PRDT -- PR 상세(품목)     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) {
			sbSql.append("                               , SALE_WITH_ALL SALE_WITH      \n");
			sbSql.append("                               , MAX_NEED_DATE_WITH_ALL MAX_NEED_DATE_WITH     \n");
		} else {
		    sbSql.append("                               , SALE_WITH SALE_WITH    \n");	
		    sbSql.append("                               , MAX_NEED_DATE_WITH MAX_NEED_DATE_WITH     \n");
		}
		
		
		//sbSql.append("						  ,		\n");
		//sbSql.append("							(		\n");                                                                                                                                                                                   
		//sbSql.append("			        				SELECT /*+ NO_MERGE LEADING(B) */		\n");                                                                                                                                                                                           
		//sbSql.append("			        					B.MAIN_UPJANG, B.UPJANG,		\n");                                                            
		//sbSql.append("			        					SAL.ROWID AS SAL_ID,		\n");                                                                                   
		//sbSql.append("			        					PODT.ROWID AS PODT_ID		\n");                                                                                       
		//sbSql.append("			        					FROM  EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]		\n");                                                                 
		//sbSql.append("			        					,EPROCUSR.ESPPODT PODT  -- PO 상세(품목)		\n");                                                                                
		//sbSql.append("			        					,FMS_UPJANG_BB_WITH B		\n");                                                                                                      
		//sbSql.append("                        				, SALE_WITH SALE_WITH     \n");
		//sbSql.append("                        				, MAX_NEED_DATE_WITH MAX_NEED_DATE_WITH     \n");
		//sbSql.append("			        					WHERE		\n");                                                                                                                   
		//sbSql.append("			            					B.UPJANG = SAL.SHOP_CD		\n");                                                                                              
		//sbSql.append("			        						AND SAL.CUST_GR_DATE BETWEEN SALE_WITH.SALE_DATE AND MAX_NEED_DATE_WITH.NEED_DATE		\n");                                                                             
		//sbSql.append("			        						AND SAL.SYS_ID  = PODT.SYS_ID		\n");                                                        
		//sbSql.append("			        						AND SAL.COMP_CD = PODT.COMP_CD		\n");                                                                                          
		//sbSql.append("			        						AND SAL.PO_NO   = PODT.PO_NO		\n");                                                                                            
		//sbSql.append("			        						AND SAL.PO_LNO  = PODT.PO_LNO		\n");                                                                                           
		//sbSql.append("			        						AND SAL.SYS_ID  = '100'		\n");                                                                                                 
		//sbSql.append("			        						AND SAL.COMP_CD = 'HFC'		\n");                                                                                                 
		//sbSql.append("			        						ORDER BY PODT.ROWID		\n");                                                                                                     
		//sbSql.append("			    			) B		\n");   
		
		sbSql.append("                  WHERE   1=1		\n");
		//sbSql.append("					AND		B.SAL_ID		 = SAL.ROWID		\n");
		//sbSql.append("					AND		B.PODT_ID		 = PODT.ROWID		\n");
		sbSql.append("					AND		PODT.SYS_ID      = POHD.SYS_ID     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = POHD.COMP_CD     \n");
		sbSql.append("                  AND     PODT.PO_NO       = POHD.PO_NO     \n");
		sbSql.append("                  AND     PODT.SYS_ID      = SAL.SYS_ID     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = SAL.COMP_CD     \n");
		sbSql.append("                  AND     PODT.PO_NO       = SAL.PO_NO     \n");
		sbSql.append("                  AND     PODT.PO_LNO      = SAL.PO_LNO     \n");
		sbSql.append("                  AND     PODT.PR_NO       = PRDT.PR_NO     \n");
		sbSql.append("                  AND     PODT.PR_LNO      = PRDT.PR_LNO     \n");
		sbSql.append("                  AND     PODT.SYS_ID      = PRDT.SYS_ID     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = PRDT.COMP_CD     \n");
		sbSql.append("                  AND     PODT.SYS_ID      = '100'     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = 'HFC'     \n");
		sbSql.append("                  AND     PODT.SHOP_TYP_CD = '02'     \n");
		sbSql.append("                  AND     PODT.STS        <> 'D'     \n");
		sbSql.append("                  AND SAL.CUST_GR_DATE BETWEEN SALE_WITH.SALE_DATE AND MAX_NEED_DATE_WITH.NEED_DATE     \n");
		sbSql.append("                  AND TO_NUMBER(SAL.SHOP_CD) = SALE_WITH.UPJANG     \n");
		sbSql.append("                  AND TO_NUMBER(SAL.SHOP_CD) = MAX_NEED_DATE_WITH.RC_UPJANG     \n");
		sbSql.append("                  --AND TO_NUMBER(SAL.SHOP_CD) IN (SELECT UPJANG FROM SALE_WITH)     \n");
		sbSql.append("                  AND SAL.SHOP_CD IN     \n");
		sbSql.append("                          (SELECT UPJANG     \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) 
			sbSql.append("                          FROM    FMS_UPJANG_BB_WITH_ALL    \n");
		else
		    sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                        WHERE   MAIN_UPJANG    = '111747'     \n");
		sbSql.append("  ----                        AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                        AND     USE_YN         = 'Y'     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                  AND     NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN     \n");
		sbSql.append("                                CASE WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'T'     \n");
		sbSql.append("                                                  THEN 'RW' --통합영업에서 뷰 불가     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'P'     \n");
		sbSql.append("                                                  THEN 'PW'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('R',     \n");
		sbSql.append("                                                                            'W')     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('C', 'K')     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                          END     \n");
		sbSql.append("                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y',     \n");
		sbSql.append("                                              'GC',     \n");
		sbSql.append("                                              NVL(PRDT.PR_PROG_STS,'PC'))     \n");
		sbSql.append("                          END,'PC') IN ('PW','PC','DL')     \n");
		sbSql.append("                  )     \n");
		sbSql.append("                  A      \n");
		sbSql.append("  ----                FMS_UPJANG C     \n");
		sbSql.append("  ----       WHERE    A.RC_UPJANG      = C.UPJANG     \n");
		sbSql.append("        WHERE      A.HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----       AND      C.MAIN_UPJANG    = '111747'     \n");
		sbSql.append("         --GROUP BY A.MAIN_UPJANG     \n");
		sbSql.append("         GROUP BY A.MAIN_UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         E     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         E.당월 미검수 발주금액     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("         ,     \n");
		sbSql.append("         ( SELECT  --A.MAIN_UPJANG ,     \n");
		sbSql.append("  				A.UPJANG ,     \n");
		sbSql.append("                  SUM(ROUND(DECODE(A.TAX_CODE,'100',     \n");
		sbSql.append("                                   1.1,     \n");
		sbSql.append("                                   1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT     \n");
		sbSql.append("         FROM     ( SELECT SAL.SHOP_CD AS RC_UPJANG	-- 입고업장 코드     \n");
		sbSql.append("                         , CASE WHEN PODT.DUTY_FREE_YN ='1' THEN '100'     \n");
		sbSql.append("                                WHEN PODT.DUTY_FREE_YN ='3' THEN '210'     \n");
		sbSql.append("                                WHEN PODT.DUTY_FREE_YN ='2' THEN '220'     \n");
		sbSql.append("                           END AS TAX_CODE	-- 과세구분코드     \n");
		sbSql.append("                         , PODT.PR_QTY AS PR_QTY	-- 신청 수량     \n");
		sbSql.append("                         , PODT.ITEM_QTY AS PO_QTY	-- 발수 수량     \n");
		sbSql.append("                         , CASE WHEN PODT.PROC_TYP_CD IN('DC','TC') THEN PODT.ITEM_QTY     \n");
		sbSql.append("                             ELSE 0     \n");
		sbSql.append("                           END AS CENTER_DELI_QTY	-- 센터입고수량     \n");
		sbSql.append("                         , 0 AS CENTER_UNDELI_QTY -- 센터미입고 수량     \n");
		sbSql.append("                         , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN PODT.ITEM_QTY     \n");
		sbSql.append("                             ELSE 0     \n");
		sbSql.append("                           END AS DIRECT_DELI_QTY -- 직송 수량     \n");
		sbSql.append("                         , CASE PODT.PROC_TYP_CD WHEN 'VC' THEN NVL(PODT.GR_QTY,0)     \n");
		sbSql.append("                             ELSE NVL(PODT.GR_QTY_WMS,0)     \n");
		sbSql.append("                           END AS DELIVERED_QTY --업장입고수량(센터출고)     \n");
		sbSql.append("                         , CASE WHEN PODT.PO_COMP_YN   ='Y' OR PODT.GR_COMP_YN = 'Y' THEN NVL(PODT.ITEM_QTY,0) - NVL(PODT.GR_QTY,0) -- 입고완료     \n");
		sbSql.append("                                  ELSE 0     \n");
		sbSql.append("                           END AS UNDELIVERED_QTY -- 감량수량     \n");
		sbSql.append("                         , PODT.RTN_QTY AS RETURNED_QTY -- 반품수량     \n");
		sbSql.append("                         , SAL.CUST_GR_DATE AS NEED_DATE -- 입고희망일자     \n");
		sbSql.append("                         , NVL(     \n");
		sbSql.append("                          CASE     \n");
		sbSql.append("                                  WHEN POHD.PO_TYP = 'BP'     \n");
		sbSql.append("                                  THEN     \n");
		sbSql.append("                                          CASE     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'T'     \n");
		sbSql.append("                                                  THEN 'RW' --통합영업에서 뷰 불가     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'P'     \n");
		sbSql.append("                                                  THEN 'PW'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('R',     \n");
		sbSql.append("                                                                            'W')     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('C',     \n");
		sbSql.append("                                                                            'K')     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                          END     \n");
		sbSql.append("                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y', 'GC', NVL(PRDT.PR_PROG_STS,'PC'))     \n");
		sbSql.append("                          END,'PC') AS LINE_STATUS -- 라인 상태 코드     \n");
		sbSql.append("                        , NVL(SAL.SAL_PRICE,0) AS SALE_PRICE -- 판매 단가     \n");
		sbSql.append("                         , SALE_WITH.UPJANG       \n");
		sbSql.append("  					  , SALE_WITH.HEAD_CREDIT_YN    AS HEAD_CREDIT_YN   \n");
		sbSql.append("                     FROM EPROCUSR.ESPPOHD POHD              -- PO 헤더     \n");
		sbSql.append("                        , EPROCUSR.ESPPODT PODT -- PO 상세(품목)     \n");
		sbSql.append("                        , EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]     \n");
		sbSql.append("                        , EPROCUSR.ESPPRDT PRDT -- PR 상세(품목)     \n");
		sbSql.append("                        , SALE_WITH SALE_WITH     \n");
		sbSql.append("                        , MAX_NEED_DATE_WITH MAX_NEED_DATE_WITH     \n");
		
		//sbSql.append("						  ,		\n");
		//sbSql.append("							(		\n");                                                                                                                                                                                   
		//sbSql.append("			        				SELECT /*+ NO_MERGE LEADING(B) */		\n");                                                                                                                                                                                           
		//sbSql.append("			        					B.MAIN_UPJANG, B.UPJANG,		\n");                                                            
		//sbSql.append("			        					SAL.ROWID AS SAL_ID,		\n");                                                                                   
		//sbSql.append("			        					PODT.ROWID AS PODT_ID		\n");                                                                                       
		//sbSql.append("			        					FROM  EPROCUSR.ESPPODTSAL SAL -- 판매단가정보[통합영업]		\n");                                                                 
		//sbSql.append("			        					,EPROCUSR.ESPPODT PODT  -- PO 상세(품목)		\n");                                                                                
		//sbSql.append("			        					,FMS_UPJANG_BB_WITH B		\n");                                                                                                      
		//sbSql.append("                        				, SALE_WITH SALE_WITH     \n");
		//sbSql.append("                        				, MAX_NEED_DATE_WITH MAX_NEED_DATE_WITH     \n");
		//sbSql.append("			        					WHERE		\n");                                                                                                                   
		//sbSql.append("			            					B.UPJANG = SAL.SHOP_CD		\n");                                                                                              
		//sbSql.append("			        						AND SAL.CUST_GR_DATE BETWEEN SALE_WITH.SALE_DATE AND MAX_NEED_DATE_WITH.NEED_DATE		\n");                                                                             
		//sbSql.append("			        						AND SAL.SYS_ID  = PODT.SYS_ID		\n");                                                        
		//sbSql.append("			        						AND SAL.COMP_CD = PODT.COMP_CD		\n");                                                                                          
		//sbSql.append("			        						AND SAL.PO_NO   = PODT.PO_NO		\n");                                                                                            
		//sbSql.append("			        						AND SAL.PO_LNO  = PODT.PO_LNO		\n");                                                                                           
		//sbSql.append("			        						AND SAL.SYS_ID  = '100'		\n");                                                                                                 
		//sbSql.append("			        						AND SAL.COMP_CD = 'HFC'		\n");                                                                                                 
		//sbSql.append("			        						ORDER BY PODT.ROWID		\n");                                                                                                     
		//sbSql.append("			    			) B		\n");   
		
		sbSql.append("                  WHERE   1=1		\n");
		//sbSql.append("					AND		B.SAL_ID		 = SAL.ROWID		\n");
		//sbSql.append("					AND		B.PODT_ID		 = PODT.ROWID		\n");
		sbSql.append("					AND		PODT.SYS_ID      = POHD.SYS_ID     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = POHD.COMP_CD     \n");
		sbSql.append("                  AND     PODT.PO_NO       = POHD.PO_NO     \n");
		sbSql.append("                  AND     PODT.SYS_ID      = SAL.SYS_ID     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = SAL.COMP_CD     \n");
		sbSql.append("                  AND     PODT.PO_NO       = SAL.PO_NO     \n");
		sbSql.append("                  AND     PODT.PO_LNO      = SAL.PO_LNO     \n");
		sbSql.append("                  AND     PODT.PR_NO       = PRDT.PR_NO     \n");
		sbSql.append("                  AND     PODT.PR_LNO      = PRDT.PR_LNO     \n");
		sbSql.append("                  AND     PODT.SYS_ID      = PRDT.SYS_ID     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = PRDT.COMP_CD     \n");
		sbSql.append("                  AND     PODT.SYS_ID      = '100'     \n");
		sbSql.append("                  AND     PODT.COMP_CD     = 'HFC'     \n");
		sbSql.append("                  AND     PODT.SHOP_TYP_CD = '02'     \n");
		sbSql.append("                  AND     PODT.STS        <> 'D'     \n");
		sbSql.append("                  AND SAL.CUST_GR_DATE BETWEEN SALE_WITH.SALE_DATE AND MAX_NEED_DATE_WITH.NEED_DATE     \n");
		sbSql.append("                  AND TO_NUMBER(SAL.SHOP_CD) = SALE_WITH.UPJANG     \n");
		sbSql.append("                  AND TO_NUMBER(SAL.SHOP_CD) = MAX_NEED_DATE_WITH.RC_UPJANG     \n");
		sbSql.append("                  --AND TO_NUMBER(SAL.SHOP_CD) IN (SELECT UPJANG FROM SALE_WITH)     \n");
		sbSql.append("                  AND SAL.SHOP_CD IN     \n");
		sbSql.append("                          (SELECT UPJANG     \n");
		sbSql.append("                          FROM    FMS_UPJANG_BB_WITH     \n");
		sbSql.append("  ----                        WHERE   MAIN_UPJANG    = '111747'     \n");
		sbSql.append("  ----                        AND     HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("  ----                        AND     USE_YN         = 'Y'     \n");
		sbSql.append("                          )     \n");
		sbSql.append("                  AND     NVL(CASE WHEN POHD.PO_TYP = 'BP' THEN     \n");
		sbSql.append("                                CASE WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'T'     \n");
		sbSql.append("                                                  THEN 'RW' --통합영업에서 뷰 불가     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'P'     \n");
		sbSql.append("                                                  THEN 'PW'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('R',     \n");
		sbSql.append("                                                                            'W')     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='N'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'PD'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN  ='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS = 'B'     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                                  WHEN PODT.GR_COMP_YN='Y'     \n");
		sbSql.append("                                                  AND     POHD.APRV_STS IN ('C', 'K')     \n");
		sbSql.append("                                                  THEN 'GC'     \n");
		sbSql.append("                                          END     \n");
		sbSql.append("                                  ELSE DECODE(PODT.GR_COMP_YN, 'Y',     \n");
		sbSql.append("                                              'GC',     \n");
		sbSql.append("                                              NVL(PRDT.PR_PROG_STS,'PC'))     \n");
		sbSql.append("                          END,'PC') IN ('PW','PC','DL')     \n");
		sbSql.append("                  )     \n");
		sbSql.append("                  A      \n");
		sbSql.append("  ----                FMS_UPJANG C     \n");
		sbSql.append("  ----       WHERE    A.RC_UPJANG      = C.UPJANG     \n");
		sbSql.append("  --       WHERE      A.HEAD_CREDIT_YN = 'N'     \n");
		sbSql.append("  ----       AND      C.MAIN_UPJANG    = '111747'     \n");
		sbSql.append("         --GROUP BY A.MAIN_UPJANG     \n");
		sbSql.append("         GROUP BY A.UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         E_1     \n");
		sbSql.append("         /************************************************************************     \n");
		sbSql.append("         F.당월 미발주 주문금액     \n");
		sbSql.append("         **************************************************************************/     \n");
		sbSql.append("         ,     \n");
		sbSql.append("         --(SELECT  SALE_WITH.MAIN_UPJANG ,     \n");
		sbSql.append("  	   (SELECT  SALE_WITH.UPJANG ,     \n");
		sbSql.append("                  SUM(ROUND(DECODE(A.TAX_CODE,'100', 1.1, 1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT     \n");
		sbSql.append("         FROM     SO_PR A     \n");
		sbSql.append("  ----			FMS_UPJANG B     \n");
		sbSql.append("             , SALE_WITH SALE_WITH     \n");
		sbSql.append("         WHERE  1=1      \n");
		sbSql.append("  ----  	AND A.RC_UPJANG      = B.UPJANG     \n");
		sbSql.append("  ----	AND      B.HEAD_CREDIT_YN = 'Y'     \n");
		sbSql.append("         AND A.RC_UPJANG = SALE_WITH.UPJANG     \n");
		sbSql.append("  ----	AND      A.NEED_DATE     <= 20161126     \n");
		sbSql.append("         AND      A.NEED_DATE BETWEEN SALE_WITH.SALE_DATE AND '"+ds_Cond.getString(0, "JDATE")+"'     \n");
		sbSql.append("         AND      A.LINE_STATUS    = '001'		 /* 진행상태 : 001(신청저장) */     \n");
		sbSql.append("         AND      A.RC_UPJANG IN ( SELECT UPJANG FROM SALE_WITH )     \n");
		sbSql.append("         --GROUP BY SALE_WITH.MAIN_UPJANG     \n");
		sbSql.append("         GROUP BY SALE_WITH.UPJANG     \n");
		sbSql.append("         )     \n");
		sbSql.append("         F     \n");
		sbSql.append("  WHERE  1=1      \n");
		sbSql.append("  --AND		 A.MAIN_UPJANG      = A.UPJANG     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")).equals("")) {
			sbSql.append("  AND    A.MAIN_UPJANG      = "+ds_Cond.getString(0, "MAIN_UPJANG")+"     \n");
		} else {
			sbSql.append("  AND    A.MAIN_UPJANG      IN (SELECT MAIN_UPJANG FROM FMS_UPJANG_BB_WITH_ALL )    \n");
			
		}
		
		if (! nullToBlank(ds_Cond.getString(0, "UPJANG")).equals("")) {
			sbSql.append("  AND    A.UPJANG           = "+ds_Cond.getString(0, "UPJANG")+"     \n");
		}
		
		//sbSql.append("  AND    A.UPJANG            = C.MAIN_UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = C0.MAIN_UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = C0_1.UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = C1.MAIN_UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = C1_1.UPJANG(+)     \n");
		sbSql.append("    AND    A.UPJANG            = D.MAIN_UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = D_1.UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = E.MAIN_UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = E_1.UPJANG(+)     \n");
		sbSql.append("  --AND    A.UPJANG            = F.MAIN_UPJANG(+)     \n");
		sbSql.append("  AND    A.UPJANG            = F.UPJANG(+)     \n");
		sbSql.append("  --AND    A1.HEAD_CREDIT_YN   = 'Y'     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "USE_YN")).equals("")) {
			sbSql.append("  AND    A.USE_YN           = '"+ds_Cond.getString(0, "USE_YN")+"'     \n");	
		}
				
		sbSql.append("  AND    A.CREDIT_CONTROL_YN = 'Y'     \n");
		sbSql.append("  AND    (A.CREDIT_TURN_CONTROL_YN   = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y')     \n");
		
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals("")) {
			sbSql.append("  AND		A.PART_SALES_SABUN = '"+ds_Cond.getString(0, "SALE_SABUN")+"'     \n");
		}
		
		sbSql.append("		START WITH DECODE(A.MAIN_UPJANG, A.UPJANG, 0, 1) = '0'		\n");
		sbSql.append("		CONNECT BY NOCYCLE A.MAIN_UPJANG = PRIOR A.UPJANG		\n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();
		
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
