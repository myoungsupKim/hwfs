<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/공통
■ 프로그램ID   : FMZ_CREDIT_INFO_PRT_T002.jsp
■ 프로그램명   : 거래명세서 출력용 여신정보 조회(FMS_CRTCRDINFO_PRO 프로시져 내용과 동일)
■ 작성일자     : 2015.12.10
■ 작성자       : 박용대
■ 이력관리     : 거래명세서 출력용으로만 새로 만듬.
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
		String sIgnorCtrl   = nullToBlank(in_vl.getString("sIgnorCtrl"));
		String strDate;
		String strNeedDate  = nullToBlank(ds_Cond.getString(0, "NEED_DATE"));
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//본사통합 여신관리 여부
		sbSql.append("SELECT NVL(HEAD_CREDIT_YN,'N') AS HEAD_CREDIT_YN \n");
		sbSql.append("     , UPJANG \n");
		sbSql.append("     , MAIN_UPJANG \n");
		sbSql.append("  FROM FMS_UPJANG \n");
		sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
out_vl.add("fa_Sql", sbSql.toString());
		
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		rs.next();
		
		String sHeadYn = rs.getString("HEAD_CREDIT_YN");
		String sUpjang = rs.getString("UPJANG");
		String sMainUpjang = rs.getString("MAIN_UPJANG");
		
		rs.close();
		pstmt.close();

		//본사통합인 경우 업장목록을 IN조건으로 만든다.
		String sUpjangList = ""; 
		if (sHeadYn.equals("Y"))
		{
			sbSql.delete(0,sbSql.length());
			sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
			sbSql.append(" WHERE MAIN_UPJANG = " + sMainUpjang + " \n");
			sbSql.append("   AND HEAD_CREDIT_YN = 'Y' \n");
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				sUpjangList += ", " + rs.getString("UPJANG");
			}
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
			rs.close();
			pstmt.close();
		}
		
		//여신체크할 최종 발주일자 조회
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT NVL(MAX(NEED_DATE), '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "') AS NEED_DATE \n");
		sbSql.append("  FROM SO_PR \n");
		sbSql.append(" WHERE 1=1 \n");
		
		if (sHeadYn.equals("Y")) {
			sbSql.append(" AND RC_UPJANG IN " + sUpjangList + " \n");
		} else {
			sbSql.append(" AND RC_UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		}
		
		//sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "') \n");
		sbSql.append("   AND NEED_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "NEED_DATE")) + "') \n");
		sbSql.append("   AND LINE_STATUS NOT IN('003', '005','999') --신청취소, 결의반려 \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			strDate = rs.getString("NEED_DATE");
		} else {
			strDate = nullToBlank(ds_Cond.getString(0, "NEED_DATE"));
		}
			
		rs.close();
		pstmt.close();
		
		//내역조회(속도관계상 운영율은 적용하지 않는다.)
		sbSql.delete(0,sbSql.length());
		if (sHeadYn.equals("Y"))
		{
			sbSql.append("SELECT /*+ optimizer_features_enable('10.2.0.5') */ A1.MAIN_UPJANG \n");
			sbSql.append("     , A1.UPJANG \n");
			sbSql.append("     , A1.UPJANGNM_DISP \n");
			sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT /* 여신금액 */ \n");            
			sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_EXT_AMOUNT /* 여신연장금액-여신연장금액 삭제 */ \n");
            sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT /* 총 여신책정금액-여신연장금액 삭제 */ \n");
            sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
            sbSql.append("                THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* 여신한도초과액 */ \n");
            sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* 여신회전일 */ \n");
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_EXT_DAYS /* 총 여신회전일 : 여신연장일 삭제 */ \n");
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS_TOT \n");
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,-1,TO_DATE("+strNeedDate+",'YYYYMMDD') - TO_DATE(C.L_BILL_DATE,'YYYYMMDD')) AS LAST_TURN_CNT \n");
            sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT /* 매입예정(신청) */ \n");
            sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT /* 매입예정(발주) */ \n");
            sbSql.append("     , NVL(C0.RMN_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
            sbSql.append("     , NVL(C1.PRE_AMT,0) AS PRE_AMT /* 선수잔액 */ \n");
            sbSql.append("     , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) + NVL(L.L_AMT,0) + NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS BOND_AMT /* 채권잔액*/ \n");
            sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(L.L_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT /* 가용여신 */ \n");
            sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(L.L_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
            sbSql.append("               + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT /* 실주문가능금액*/ \n");
            sbSql.append("     , NVL(C.L_BILL_DATE,'00000000') AS L_BILL_DATE /* 최장 미입금된 외상매출발생일*/ \n");   
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,'채권없음',TO_CHAR(TO_DATE(C.L_BILL_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"')) AS L_BILL_DATE_DISP /* 최장 미입금된 외상매출발생일*/ \n");    
            sbSql.append("     , A.HEAD_CREDIT_YN /*통합관리여부*/ \n");
            sbSql.append("     , A.CREDIT_CONTROL_YN /* 여신통제여부 */ \n");
            sbSql.append("     , A.CREDIT_TURN_CONTROL_YN /* 'Y'이면 여신회전일통제, 'N'이면 '통제안함' */ \n");
            sbSql.append("     , A.CREDIT_AMOUNT_CONTROL_YN /* 'Y'이면 여신금액통제, 'N'이면 '통제안함' */ \n");
            sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD /* 계좌정보*/ \n");
            sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
            sbSql.append("          ,'YYY','금액+회전일' \n");
            sbSql.append("          ,'YYN','회전일통제' \n");
            sbSql.append("          ,'YNY','금액통제','무통제') AS CREDIT_CONTROL_DESC /*통제구분*/ \n");
            sbSql.append("     , A.CREDIT_START /*여신부여일*/ \n");
            sbSql.append("     , A.CREDIT_END /*여신종료일*/ \n");
            sbSql.append("     , NVL(G.RECEIVE_AMT,0) AS RCP_AMT /* 당월입금액 */ \n");
            sbSql.append("     , NVL(I.I_AMT,0) AS I_AMT /* 전월외상매출잔액 */ \n");
            sbSql.append("     , NVL(J.J_AMT,0) AS J_AMT /* 전월 선수금 잔액 */ \n");
            sbSql.append("     , NVL(K.K_AMT,0) AS K_AMT /* 당월 매출액 (매출확정) */ \n");
            sbSql.append("     , NVL(L.L_AMT,0) AS L_AMT /* 입고금액(매출확정 이후 날짜) */ \n");
            sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG A1 \n");
            sbSql.append("       /************************************************************************ \n");
            sbSql.append("        C.외상잔액정보 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
            sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
            sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
            sbSql.append("          FROM SLA_AR_MST M, SLA_AR_RECEIVE_DETAIL D, FMS_UPJANG B \n");
            sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
            sbSql.append("           AND M.RECD_STATUS = 'L' \n");
            sbSql.append("           AND D.RECEIVE_DATE <= "+strNeedDate+" /* 조건 : 입고예정일 */ \n");
            sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
            sbSql.append("           AND D.RECD_STATUS = 'L' \n");
            sbSql.append("           AND M.OCCUR_DATE <= "+strNeedDate+" /* 조건 : 입고예정일 */ \n");
            sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y' \n");  
    	    sbSql.append("           AND M.UPJANG_CD = B.UPJANG \n");
            sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  채권잔액이 있는 자료 기준 */ \n");
            sbSql.append("           AND M.UPJANG_CD IN " + sUpjangList + " \n");
            sbSql.append("         GROUP BY B.MAIN_UPJANG ) C \n"); 
            
            sbSql.append("       /************************************************************************ \n");
            sbSql.append("        C0.선수잔액정보 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("     , (SELECT T.MAIN_UPJANG \n");   
    	    sbSql.append("             , SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT \n"); 
    	    sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n"); 
    	    sbSql.append("                     , NVL(M.AR_AMT, 0) AS AR_AMT \n"); 
    	    sbSql.append("                     , (SELECT NVL(SUM(D.RECEIVE_AMT),0) \n"); 
    	    sbSql.append("                          FROM SLA_AR_RECEIVE_DETAIL D \n"); 
    	    sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
    	    sbSql.append("                           AND D.RECEIVE_DATE <= "+strNeedDate+" \n");   
    	    sbSql.append("                           AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n"); 
    	    sbSql.append("                  FROM SLA_AR_MST M, FMS_UPJANG B \n");  
    	    sbSql.append("                 WHERE M.SYS_CLASS = '13' \n"); 
    	    sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
    	    sbSql.append("                   AND M.OCCUR_DATE <= "+strNeedDate+" \n"); 
    	    sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n");  
    	    sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
    	    sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n");
    	    sbSql.append("                ) T \n"); 
    	    sbSql.append("         GROUP BY T.MAIN_UPJANG \n"); 
    	    //sbSql.append("        HAVING SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) > 0) C0 \n");
    	    sbSql.append("        ) C0 \n");
            
            sbSql.append("       /************************************************************************ \n");
            sbSql.append("        C1.선수잔액정보 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("     , (SELECT T.MAIN_UPJANG \n");   
    	    sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT \n"); 
    	    sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n"); 
    	    sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n"); 
    	    sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0) \n"); 
    	    sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D \n"); 
    	    sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
    	    sbSql.append("                           AND D.ALT_DATE <= "+strNeedDate+" \n");   
    	    sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n"); 
    	    sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B \n");  
    	    sbSql.append("                 WHERE M.SYS_CLASS = '13' \n"); 
    	    sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
    	    sbSql.append("                   AND M.OCCUR_DATE <= "+strNeedDate+" \n"); 
    	    sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y' \n");  
    	    sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
    	    sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + " \n");
    	    sbSql.append("                ) T \n"); 
    	    sbSql.append("         GROUP BY T.MAIN_UPJANG \n"); 
    	    //sbSql.append("        HAVING SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) > 0) C1 \n");
    	    sbSql.append("        ) C1 \n");
            
            sbSql.append("       /************************************************************************ \n");
            //sbSql.append("        D.당월 미매출마감된 검수금액 \n"); 삭제  L.L_AMT로 대체
            sbSql.append("       **************************************************************************/ \n");
            /*
            sbSql.append("     , (SELECT X.MAIN_UPJANG \n");
            sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
            sbSql.append("          FROM (SELECT B.MAIN_UPJANG \n");
            sbSql.append("                     , SUM(A.SAL_AMT) AS TR_AMT \n");
            sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
            sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
            sbSql.append("                   AND A.SALE_DATE <= "+strDate+"   \n");
            sbSql.append("                   AND A.TRANS_YN='N'  \n");
            sbSql.append("                   AND B.HEAD_CREDIT_YN='Y' \n");
            sbSql.append("                   AND A.UPJANG IN " + sUpjangList + " \n");
            sbSql.append("                 GROUP BY B.MAIN_UPJANG \n");
            sbSql.append("                 UNION ALL \n");
            sbSql.append("                SELECT PUSH_PRED(A)  C.MAIN_UPJANG \n");
            //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
            sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
            sbSql.append("                     , (SELECT UPJANG \n");
            sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
            sbSql.append("                          FROM FMS_SALES \n");
            sbSql.append("                         WHERE SALE_DATE <= "+strDate+"    \n");
            sbSql.append("                           AND UPJANG IN " + sUpjangList + " \n");
            sbSql.append("                   		   AND TRANS_YN = 'Y'  \n");
            sbSql.append("                         GROUP BY UPJANG \n");
            sbSql.append("                        ) B \n");
            sbSql.append("                      , FMS_UPJANG C \n");
            sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
            sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
            sbSql.append("                    AND C.HEAD_CREDIT_YN = 'Y' \n");
            sbSql.append("                    AND A.MG_DATE <= "+strDate+"    \n");
			sbSql.append("				   AND    A.MG_DATE >= DECODE(B.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
            sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
            sbSql.append("                    AND A.TRANS_UPJANG IN " + sUpjangList + " \n");
            sbSql.append("                  GROUP BY C.MAIN_UPJANG) X \n");
            sbSql.append("         GROUP BY X.MAIN_UPJANG \n");
            sbSql.append("        ) D \n");
            */
            sbSql.append("       /************************************************************************ \n");
            sbSql.append("       E.당월 미검수 발주금액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("     , ( /* PW(발주진행), PC(발주완료), DL(배송중) 만 집계 */ \n");
            sbSql.append("         /* CENTER_DELI_QTY(센터입고수량), DIRECT_DELI_QTY(직송수량), DELIVERED_QTY(업장입고수량-센터출고), UNDELIVERED_QTY(센터미입고수량) */ \n");
            sbSql.append("        SELECT C.MAIN_UPJANG \n");
            sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
            sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
            sbSql.append("         WHERE A.RC_UPJANG = C.UPJANG \n");
            sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
            sbSql.append("           AND C.HEAD_CREDIT_YN = 'Y' \n");
            sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
            sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
            sbSql.append("         GROUP BY C.MAIN_UPJANG) E \n");
            sbSql.append("       /************************************************************************ \n");
            sbSql.append("       F.당월 미발주 주문금액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
            sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
            sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
            sbSql.append("         WHERE A.RC_UPJANG = B.UPJANG \n");
            sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y' \n");
            sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
            sbSql.append("           AND A.LINE_STATUS = '001' /* 진행상태 : 001(신청저장) */ \n");
            sbSql.append("           AND A.RC_UPJANG IN " + sUpjangList + " \n");
            sbSql.append("         GROUP BY B.MAIN_UPJANG) F \n");	
            sbSql.append("       /************************************************************************ \n");
            sbSql.append("       G.당월 입금금액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("			,(SELECT B.MAIN_UPJANG ,                                    \n");
            sbSql.append("     			  SUM(NVL(M.OCCUR_AMT, 0)) AS RECEIVE_AMT         \n");
            sbSql.append("			  FROM SLA_ADVANCE_MST M,                            \n");
            sbSql.append("      			 FMS_UPJANG B                                  \n");
            sbSql.append(" 			WHERE M.SYS_CLASS = '13'                            \n");
            sbSql.append("  			 AND M.RECD_STATUS = 'L'                           \n");
            sbSql.append(" 			  AND M.OCCUR_DATE BETWEEN SUBSTR('"+strNeedDate+"' , 1, 6)||'01' \n"); 
            sbSql.append(" 								   AND SUBSTR('"+strNeedDate+"' , 1, 6)||'31' \n");
            sbSql.append(" 			  AND B.HEAD_CREDIT_YN = 'Y'                        \n");
            sbSql.append(" 			  AND M.UPJANG_CD = B.UPJANG                        \n");
            sbSql.append(" 			  AND M.UPJANG_CD IN " + sUpjangList + "                          \n");
            sbSql.append(" 			GROUP BY B.MAIN_UPJANG                                   \n");
            sbSql.append("       ) G \n");
            sbSql.append("       /************************************************************************** \n");
            //sbSql.append("       H.전월 기말잔고 \n");  I랑 같음.. 그래서 제거
            sbSql.append("       **************************************************************************/ \n");
            /*
            sbSql.append("     , (SELECT MAIN_UPJANG, SUM(BEFORE_AR_BAL_AMT) AS H_AMT FROM \n"); 
            sbSql.append("             (SELECT B.MAIN_UPJANG, (NVL(A.AR_AMT, 0) - NVL((SELECT SUM(RECEIVE_AMT)  \n"); 
            sbSql.append("           											     FROM SLA_AR_RECEIVE_DETAIL RD\n"); 
            sbSql.append("              										    WHERE RD.AR_NUM=A.AR_NUM\n"); 
            sbSql.append("            											      AND RD.RECEIVE_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+",'YYYYMMDD'),-1),'YYYYMM') || '31'\n");  
            sbSql.append("            											      AND RD.RECD_STATUS='L'), 0)) AS BEFORE_AR_BAL_AMT\n");  
            sbSql.append("               FROM SLA_AR_MST A, FMS_UPJANG B\n");  
            sbSql.append("             WHERE A.RECD_STATUS = 'L'\n"); 
            sbSql.append("               AND A.OCCUR_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+",'YYYYMMDD'),-1),'YYYYMM') || '31'\n"); 
            sbSql.append("               AND A.SYS_CLASS = '13' \n"); 
            sbSql.append("               AND A.UPJANG_CD IN " + sUpjangList + " \n"); 
            sbSql.append("           AND A.UPJANG_CD = B.UPJANG\n");
            sbSql.append("           AND B.HEAD_CREDIT_YN = 'Y'\n");
            sbSql.append("         ) GROUP BY MAIN_UPJANG\n"); 
            sbSql.append("       ) H \n");
            */
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       I.전월 외상매출 잔액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("       ,(SELECT MAIN_UPJANG, SUM(BEFORE_AR_BAL_AMT) AS I_AMT FROM \n");
            sbSql.append("       	(SELECT B.MAIN_UPJANG, (NVL(A.AR_AMT, 0) - NVL((SELECT SUM(RECEIVE_AMT) \n");
            sbSql.append("       												FROM SLA_AR_RECEIVE_DETAIL RD\n");
            sbSql.append("       												WHERE RD.AR_NUM=A.AR_NUM \n");
            sbSql.append("       											      AND RD.RECEIVE_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strNeedDate+",'YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("      											     AND RD.RECD_STATUS='L'), 0)) AS BEFORE_AR_BAL_AMT \n");
            sbSql.append("       	 	FROM SLA_AR_MST A, FMS_UPJANG B \n");
            sbSql.append("       		WHERE A.RECD_STATUS = 'L' \n");
            sbSql.append("      		 AND A.OCCUR_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strNeedDate+",'YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("       		AND A.SYS_CLASS = '13' \n");
            sbSql.append("       		AND A.UPJANG_CD IN " + sUpjangList + " \n");
            sbSql.append("     		  AND A.UPJANG_CD = B.UPJANG \n");
            sbSql.append("       	  AND B.HEAD_CREDIT_YN = 'Y' \n");
            sbSql.append("         ) GROUP BY MAIN_UPJANG \n");
            sbSql.append("       ) I \n");
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       J.전월 선수금 잔액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append(",(SELECT T.MAIN_UPJANG                                                                             \n");
            sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS J_AMT                      \n");
            sbSql.append("          FROM (SELECT B.MAIN_UPJANG                                                             \n");
            sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT                                     \n");
            sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0)                                      \n");
            sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D                                     \n");
            sbSql.append("                         WHERE D.RECD_STATUS  = 'L'                                         \n");
            sbSql.append("                           AND D.ALT_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strNeedDate+",'YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT                  \n");
            sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B                                      \n");
            sbSql.append("                 WHERE M.SYS_CLASS = '13'                                                   \n");
            sbSql.append("                   AND M.RECD_STATUS = 'L'                                                  \n");
            sbSql.append("                   AND M.OCCUR_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strNeedDate+",'YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y'                                               \n");
            sbSql.append("                   AND M.UPJANG_CD = B.UPJANG                                               \n");
            sbSql.append("                   AND M.UPJANG_CD IN " + sUpjangList + "                                                 \n");
            sbSql.append("                ) T                                                                         \n");
            sbSql.append("         GROUP BY T.MAIN_UPJANG                                                                 \n");            
            sbSql.append("       ) J \n");
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       K. 당월 매출액 (매출확정) \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("              ,(SELECT B.MAIN_UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   \n");
            sbSql.append("                   , SUM(A.SAL_AMT) AS K_AMT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \n");
            sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                 WHERE A.UPJANG=B.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("                   AND A.SALE_DATE BETWEEN  SUBSTR("+strNeedDate+" , 1, 6)||'01' AND SUBSTR("+strNeedDate+" , 1, 6)||'31'              \n");
            sbSql.append("                   AND A.TRANS_YN='Y' /* 영업회계 미전송건 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \n");
            sbSql.append("                   AND A.UPJANG IN " + sUpjangList + "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         \n");
            sbSql.append("                   AND B.HEAD_CREDIT_YN = 'Y'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \n");
            sbSql.append("                 GROUP BY B.MAIN_UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                \n");
            sbSql.append("       		) K \n");
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       L. 입고금액(매출확정 이후 날짜) \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("                ,(SELECT /*+ PUSH_PRED(A) */ C.MAIN_UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS L_AMT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      \n");
            sbSql.append("                  FROM FMS_TRANSACTION_V A                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        \n");
            sbSql.append("                      , FMS_UPJANG C                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              \n");
            sbSql.append("                  WHERE A.TRANS_UPJANG = C.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 \n");
            sbSql.append("                    AND C.HEAD_CREDIT_YN = 'Y'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    \n");
            sbSql.append("                    AND    A.MG_DATE BETWEEN (                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    \n");
            sbSql.append("                                        SELECT  NVL(TO_CHAR(TO_DATE(MAX(SALE_DATE), 'YYYYMMDD')+1, 'YYYYMMDD'), TO_CHAR(SYSDATE+1, 'YYYYMMDD'))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   \n");
            sbSql.append("                                          FROM FMS_SALES                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("                                         WHERE SALE_DATE <= "+strDate+" /* 조건 : 입고예정일 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    \n");
            sbSql.append("                                           AND UPJANG IN " + sUpjangList + " \n");
            sbSql.append("                                           AND TRANS_YN = 'Y' /* 영업회계 전송건 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               \n");
            sbSql.append("                                         )                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        \n");
            sbSql.append("                                         AND "+strDate+"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           \n");
            sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO'))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                \n");
            sbSql.append("                    AND C.UPJANG  IN " + sUpjangList + " \n");
            sbSql.append("                    AND A.TRANS_UPJANG IN " + sUpjangList + " \n");
            sbSql.append("                  GROUP BY C.MAIN_UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("       			) L \n");
            sbSql.append(" WHERE A1.MAIN_UPJANG = A.UPJANG \n");
            sbSql.append("   AND A1.MAIN_UPJANG = " + sMainUpjang + " \n");
    		sbSql.append("   AND A1.UPJANG = " + sUpjang + " \n");
            sbSql.append("   AND A.UPJANG = C.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = C0.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = C1.MAIN_UPJANG(+) \n");
            //sbSql.append("   AND A.UPJANG = D.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = E.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = F.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = G.MAIN_UPJANG(+) \n");
            //sbSql.append("   AND A.UPJANG = H.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = I.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = J.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = K.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A.UPJANG = L.MAIN_UPJANG(+) \n");
            sbSql.append("   AND A1.HEAD_CREDIT_YN = 'Y' \n");
            sbSql.append("   AND A1.USE_YN = 'Y' \n");			
            sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");                                             
            sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");  
		}
		else
		{
			sbSql.append("SELECT A.MAIN_UPJANG \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , A.UPJANGNM_DISP \n");
			sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT /* 여신금액 */ \n");            
			sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_EXT_AMOUNT /* 여신연장금액-여신연장금액 삭제 */ \n");
            sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT /* 총 여신책정금액-여신연장금액 삭제 */ \n");
            sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
            sbSql.append("                THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* 여신한도초과액 */ \n");
            //sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
            sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* 여신회전일 */ \n");
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_EXT_DAYS /* 총 여신회전일 : 여신연장일 삭제 */ \n");
            sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS_TOT \n");
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,-1,TO_DATE("+strNeedDate+",'YYYYMMDD') - TO_DATE(C.L_BILL_DATE,'YYYYMMDD')) AS LAST_TURN_CNT \n");
            sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT /* 매입예정(신청) */ \n");
            sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT /* 매입예정(발주) */ \n");
            //sbSql.append("     , NVL(D.TR_AMT,0) AS TR_AMT /* 매입확정 */ \n");
            
            //sbSql.append("     , NVL(C.RMN_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
            //sbSql.append("     , NVL(C0.RMN_AMT,0) - NVL(C1.PRE_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
            sbSql.append("     , NVL(C0.RMN_AMT,0) AS RMN_AMT /* 외상매출잔액 */ \n");
            
            sbSql.append("     , NVL(C1.PRE_AMT,0) AS PRE_AMT /* 선수잔액 */ \n");
            sbSql.append("     , NVL(C.RMN_AMT,0) - NVL(C1.PRE_AMT,0) + NVL(L.L_AMT,0) + NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS BOND_AMT /* 채권잔액*/ \n");
            
            //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            //sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT /* 가용여신 */ \n");
            //sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            //sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
            //sbSql.append("               + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT /* 실주문가능금액*/ \n");
            sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(L.L_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT /* 가용여신 */ \n");
            sbSql.append("     , CASE WHEN "+strNeedDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
            sbSql.append("            THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C0.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(L.L_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) \n");
            sbSql.append("               + NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') THEN A.CREDIT_OVER_AMOUNT ELSE 0 END,0) AS CREDIT_AVAIL_AMT /* 실주문가능금액*/ \n");
            
            sbSql.append("     , NVL(C.L_BILL_DATE,'00000000') AS L_BILL_DATE /* 최장 미입금된 외상매출발생일*/ \n");   
            sbSql.append("     , DECODE(C.L_BILL_DATE,NULL,'채권없음',TO_CHAR(TO_DATE(C.L_BILL_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"')) AS L_BILL_DATE_DISP /* 최장 미입금된 외상매출발생일*/ \n");    
            sbSql.append("     , A.HEAD_CREDIT_YN /*통합관리여부*/ \n");
            sbSql.append("     , A.CREDIT_CONTROL_YN /* 여신통제여부 */ \n");
            sbSql.append("     , A.CREDIT_TURN_CONTROL_YN /* 'Y'이면 여신회전일통제, 'N'이면 '통제안함' */ \n");
            sbSql.append("     , A.CREDIT_AMOUNT_CONTROL_YN /* 'Y'이면 여신금액통제, 'N'이면 '통제안함' */ \n");
            sbSql.append("     , SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3') AS ACNTCD /* 계좌정보*/ \n");
            sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
            sbSql.append("          ,'YYY','금액+회전일' \n");
            sbSql.append("          ,'YYN','회전일통제' \n");
            sbSql.append("          ,'YNY','금액통제','무통제') AS CREDIT_CONTROL_DESC /*통제구분*/ \n");
            sbSql.append("     , A.CREDIT_START /*여신부여일*/ \n");
            sbSql.append("     , A.CREDIT_END /*여신종료일*/ \n");
            sbSql.append("     , NVL(G.RECEIVE_AMT,0) AS RCP_AMT /* 당월입금액 */ \n");
            //sbSql.append("     , NVL(H.H_AMT,0) AS H_AMT /* 전월기말잔고 */ \n");
            sbSql.append("     , NVL(I.I_AMT,0) AS I_AMT /* 전월외상매출잔액 */ \n");
            sbSql.append("     , NVL(J.J_AMT,0) AS J_AMT /* 전월 선수금 잔액 */ \n");
            sbSql.append("     , NVL(K.K_AMT,0) AS K_AMT /* 당월 매출액 (매출확정) */ \n");
            sbSql.append("     , NVL(L.L_AMT,0) AS L_AMT /* 입고금액(매출확정 이후 날짜) */ \n");
	        sbSql.append("  FROM FMS_UPJANG A \n");
	        sbSql.append("       /************************************************************************ \n");
	        sbSql.append("        C.외상잔액정보 \n");
	        sbSql.append("       **************************************************************************/ \n");
	        sbSql.append("     , (SELECT M.UPJANG_CD AS UPJANG \n");
            sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
            sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
            sbSql.append("          FROM SLA_AR_MST M, SLA_AR_RECEIVE_DETAIL D, FMS_UPJANG B \n");
            sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
            sbSql.append("           AND M.RECD_STATUS = 'L' \n");
            sbSql.append("           AND D.RECEIVE_DATE <= "+strNeedDate+" /* 조건 : 입고예정일 */ \n");
            sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
            sbSql.append("           AND D.RECD_STATUS = 'L' \n");
            sbSql.append("           AND M.OCCUR_DATE <= "+strNeedDate+" /* 조건 : 입고예정일 */ \n");
            sbSql.append("           AND B.HEAD_CREDIT_YN = 'N' \n");  
    	    sbSql.append("           AND M.UPJANG_CD = B.UPJANG \n");
            sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  채권잔액이 있는 자료 기준 */ \n");
            sbSql.append("           AND M.UPJANG_CD = " + sUpjang + " \n");
            sbSql.append("         GROUP BY M.UPJANG_CD ) C \n"); 
	        
	        sbSql.append("       /************************************************************************ \n");
	        sbSql.append("        C0.선수잔액정보 \n");
	        sbSql.append("       **************************************************************************/ \n");
	        sbSql.append("     , (SELECT T.UPJANG \n");   
		    sbSql.append("             , SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) AS RMN_AMT \n"); 
		    sbSql.append("          FROM (SELECT B.UPJANG \n"); 
		    sbSql.append("                     , NVL(M.AR_AMT, 0) AS AR_AMT \n"); 
		    sbSql.append("                     , (SELECT NVL(SUM(D.RECEIVE_AMT),0) \n"); 
		    sbSql.append("                          FROM SLA_AR_RECEIVE_DETAIL D \n"); 
		    sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
		    sbSql.append("                           AND D.RECEIVE_DATE <= "+strNeedDate+" \n");   
		    sbSql.append("                           AND D.AR_NUM = M.AR_NUM) AS RECEIVE_AMT \n"); 
		    sbSql.append("                  FROM SLA_AR_MST M, FMS_UPJANG B \n");  
		    sbSql.append("                 WHERE M.SYS_CLASS = '13' \n"); 
		    sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
		    sbSql.append("                   AND M.OCCUR_DATE <= "+strNeedDate+" \n"); 
		    sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N' \n");  
		    sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
		    sbSql.append("                   AND M.UPJANG_CD = " + sUpjang + " \n");
		    sbSql.append("                ) T \n"); 
		    sbSql.append("         GROUP BY T.UPJANG \n"); 
		    //sbSql.append("        HAVING SUM(NVL(T.AR_AMT,0) - NVL(T.RECEIVE_AMT,0)) > 0) C0 \n");
		    sbSql.append("        ) C0 \n");
	        
		    sbSql.append("       /************************************************************************ \n");
	        sbSql.append("        C1.선수잔액정보 \n");
	        sbSql.append("       **************************************************************************/ \n");
	        sbSql.append("     , (SELECT T.UPJANG \n");   
		    sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS PRE_AMT \n"); 
		    sbSql.append("          FROM (SELECT B.UPJANG \n"); 
		    sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT \n"); 
		    sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0) \n"); 
		    sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D \n"); 
		    sbSql.append("                         WHERE D.RECD_STATUS  = 'L' \n"); 
		    sbSql.append("                           AND D.ALT_DATE <= "+strNeedDate+" \n");   
		    sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT \n"); 
		    sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B \n");  
		    sbSql.append("                 WHERE M.SYS_CLASS = '13' \n"); 
		    sbSql.append("                   AND M.RECD_STATUS = 'L' \n"); 
		    sbSql.append("                   AND M.OCCUR_DATE <= "+strNeedDate+" \n"); 
		    sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N' \n");  
		    sbSql.append("                   AND M.UPJANG_CD = B.UPJANG \n");
		    sbSql.append("                   AND M.UPJANG_CD = " + sUpjang + " \n");
		    sbSql.append("                ) T \n"); 
		    sbSql.append("         GROUP BY T.UPJANG \n"); 
		    //sbSql.append("        HAVING SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) > 0) C1 \n");
		    sbSql.append("        ) C1 \n");
	        
	        sbSql.append("       /************************************************************************ \n");
	        //sbSql.append("        D.당월 미매출마감된 검수금액 \n");
	        sbSql.append("       **************************************************************************/ \n");
	        /*
	        sbSql.append("     , (SELECT X.UPJANG \n");
	        sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
	        sbSql.append("          FROM (SELECT B.UPJANG \n");
	        sbSql.append("                     , SUM(A.SAL_AMT) AS TR_AMT \n");
	        sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
	        sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
	        sbSql.append("                   AND A.SALE_DATE <= "+strDate+"  조건 : 입고예정일  \n");
	        sbSql.append("                   AND A.TRANS_YN='N'  영업회계 미전송건  \n");
	        sbSql.append("                   AND B.HEAD_CREDIT_YN='N' \n");
	        sbSql.append("                   AND A.UPJANG = " + sUpjang + " \n");
	        sbSql.append("                 GROUP BY B.UPJANG \n");
	        sbSql.append("                 UNION ALL \n");
	        sbSql.append("                 D2. 식재매출집계(FMS_SALES)의 최종마감일자 이후에서 기준일자 까지  \n");
	        sbSql.append("                SELECT + PUSH_PRED(A)  C.UPJANG \n");
	        //sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
            sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS TR_AMT \n"); 
	        sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
	        sbSql.append("                     , (SELECT UPJANG \n");
	        sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
	        sbSql.append("                          FROM FMS_SALES \n");
	        sbSql.append("                         WHERE SALE_DATE <= "+strDate+" 조건 : 입고예정일  \n");
	        sbSql.append("                        AND UPJANG = " + sUpjang + " \n");
	        sbSql.append("                   		 AND TRANS_YN = 'Y'  영업회계 전송건  \n");
	        sbSql.append("                         GROUP BY UPJANG \n");
	        sbSql.append("                        ) B \n");
	        sbSql.append("                      , FMS_UPJANG C \n");
	        sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
	        sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
	        sbSql.append("                    AND C.HEAD_CREDIT_YN = 'N' \n");
	        sbSql.append("                    AND A.MG_DATE <= "+strDate+"  조건 : 입고예정일  \n");
	        //sbSql.append("                     업장별 최종마감일자 이후 ~ 기준일자까지의 집계 : 만약 마감정보가 없으면 기준일자 대비 1개월 전부터 대입  \n");
	        //sbSql.append("                    AND A.TRANS_DATE>=GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+" , 'YYYYMMDD'),-1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
			sbSql.append("                     업장별 최종마감일자 이후 ~ 기준일자까지의 집계 : 만약 마감정보가 없으면 기준일자 대비 1개월 전부터 대입 : 2015-10-27  \n");
			sbSql.append("				   AND    A.MG_DATE >= DECODE(B.SALE_DATE, NULL, GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+", 'YYYYMMDD'), -1), 'YYYYMM') || '01', NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')),  TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'))  \n");
	        sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
	        sbSql.append("                    AND A.TRANS_UPJANG = " + sUpjang + " \n");
	        sbSql.append("                  GROUP BY C.UPJANG) X \n");
	        sbSql.append("         GROUP BY X.UPJANG \n");
	        sbSql.append("        ) D \n");
	        */
	        sbSql.append("       /************************************************************************ \n");
	        sbSql.append("       E.당월 미검수 발주금액 \n");
	        sbSql.append("       **************************************************************************/ \n");
	        sbSql.append("     , ( /* PW(발주진행), PC(발주완료), DL(배송중) 만 집계 */ \n");
	        sbSql.append("         /* CENTER_DELI_QTY(센터입고수량), DIRECT_DELI_QTY(직송수량), DELIVERED_QTY(업장입고수량-센터출고), UNDELIVERED_QTY(센터미입고수량) */ \n");
	        sbSql.append("        SELECT C.UPJANG \n");
	        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
	        sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
	        sbSql.append("         WHERE A.RC_UPJANG = C.UPJANG \n");
	        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
	        sbSql.append("           AND C.HEAD_CREDIT_YN = 'N' \n");
	        sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
	        sbSql.append("           AND A.RC_UPJANG = " + sUpjang + " \n");
	        sbSql.append("         GROUP BY C.UPJANG) E \n");
	        sbSql.append("       /************************************************************************ \n");
	        sbSql.append("       F.당월 미발주 주문금액 \n");
	        sbSql.append("       **************************************************************************/ \n");
	        sbSql.append("     , (SELECT B.UPJANG \n");
	        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
	        sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
	        sbSql.append("         WHERE A.RC_UPJANG = B.UPJANG \n");
	        sbSql.append("           AND B.HEAD_CREDIT_YN = 'N' \n");
	        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
	        sbSql.append("           AND A.LINE_STATUS = '001' /* 진행상태 : 001(신청저장) */ \n");
	        sbSql.append("           AND A.RC_UPJANG = " + sUpjang + " \n");
	        sbSql.append("         GROUP BY B.UPJANG) F \n");
            sbSql.append("       /************************************************************************ \n");
            sbSql.append("       G.당월 입금금액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("			,(SELECT B.UPJANG ,                                    \n");
            sbSql.append("     			  SUM(NVL(M.OCCUR_AMT, 0)) AS RECEIVE_AMT         \n");
            sbSql.append("			  FROM SLA_ADVANCE_MST M,                            \n");
            sbSql.append("      			 FMS_UPJANG B                                  \n");
            sbSql.append(" 			WHERE M.SYS_CLASS = '13'                            \n");
            sbSql.append("  			 AND M.RECD_STATUS = 'L'                           \n");
            sbSql.append(" 			  AND M.OCCUR_DATE BETWEEN SUBSTR('"+strNeedDate+"' , 1, 6)||'01' \n"); 
            sbSql.append(" 								   AND SUBSTR('"+strNeedDate+"' , 1, 6)||'31' \n");
            sbSql.append(" 			  AND B.HEAD_CREDIT_YN = 'N'                        \n");
            sbSql.append(" 			  AND M.UPJANG_CD = B.UPJANG                        \n");
            sbSql.append(" 			  AND M.UPJANG_CD = " + sUpjang + "                          \n");
            sbSql.append(" 			GROUP BY B.UPJANG                                   \n");
            sbSql.append("       ) G \n");
            sbSql.append("       /************************************************************************** \n");
            //sbSql.append("       H.전월 기말잔고 \n");  I랑 같음.. 그래서 제거
            sbSql.append("       **************************************************************************/ \n");
            /*
            sbSql.append("     , (SELECT UPJANG, SUM(BEFORE_AR_BAL_AMT) AS H_AMT FROM \n"); 
            sbSql.append("             (SELECT B.UPJANG, (NVL(A.AR_AMT, 0) - NVL((SELECT SUM(RECEIVE_AMT)  \n"); 
            sbSql.append("           											     FROM SLA_AR_RECEIVE_DETAIL RD\n"); 
            sbSql.append("              										    WHERE RD.AR_NUM=A.AR_NUM\n"); 
            sbSql.append("            											      AND RD.RECEIVE_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+",'YYYYMMDD'),-1),'YYYYMM') || '31'\n");  
            sbSql.append("            											      AND RD.RECD_STATUS='L'), 0)) AS BEFORE_AR_BAL_AMT\n");  
            sbSql.append("               FROM SLA_AR_MST A, FMS_UPJANG B\n");  
            sbSql.append("             WHERE A.RECD_STATUS = 'L'\n"); 
            sbSql.append("               AND A.OCCUR_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+",'YYYYMMDD'),-1),'YYYYMM') || '31'\n"); 
            sbSql.append("               AND A.SYS_CLASS = '13' \n"); 
            sbSql.append("               AND A.UPJANG_CD = " + sUpjang + " \n"); 
            sbSql.append("           AND A.UPJANG_CD = B.UPJANG\n");
            sbSql.append("           AND B.HEAD_CREDIT_YN = 'N'\n");
            sbSql.append("         ) GROUP BY UPJANG\n"); 
            sbSql.append("       ) H \n"); 
            */
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       I.전월 외상매출 잔액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("       ,(SELECT UPJANG, SUM(BEFORE_AR_BAL_AMT) AS I_AMT FROM \n");
            sbSql.append("       	(SELECT B.UPJANG, (NVL(A.AR_AMT, 0) - NVL((SELECT SUM(RECEIVE_AMT) \n");
            sbSql.append("       												FROM SLA_AR_RECEIVE_DETAIL RD\n");
            sbSql.append("       												WHERE RD.AR_NUM=A.AR_NUM \n");
            sbSql.append("       											      AND RD.RECEIVE_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE('"+strNeedDate+"','YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("      											     AND RD.RECD_STATUS='L'), 0)) AS BEFORE_AR_BAL_AMT \n");
            sbSql.append("       	 	FROM SLA_AR_MST A, FMS_UPJANG B \n");
            sbSql.append("       		WHERE A.RECD_STATUS = 'L' \n");
            sbSql.append("      		 AND A.OCCUR_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE('"+strNeedDate+"','YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("       		AND A.SYS_CLASS = '13' \n");
            sbSql.append("       		AND A.UPJANG_CD = " + sUpjang + " \n");
            sbSql.append("     		  AND A.UPJANG_CD = B.UPJANG \n");
            sbSql.append("       	  AND B.HEAD_CREDIT_YN = 'N' \n");
            sbSql.append("         ) GROUP BY UPJANG \n");
            sbSql.append("       ) I \n");
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       J.전월 선수금 잔액 \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append(",(SELECT T.UPJANG                                                                             \n");
            sbSql.append("             , SUM(NVL(T.OCCUR_AMT,0) - NVL(T.APPLY_AMT,0)) AS J_AMT                      \n");
            sbSql.append("          FROM (SELECT B.UPJANG                                                             \n");
            sbSql.append("                     , NVL(M.OCCUR_AMT, 0) AS OCCUR_AMT                                     \n");
            sbSql.append("                     , (SELECT NVL(SUM(D.APPLY_AMT),0)                                      \n");
            sbSql.append("                          FROM SLA_ADVANCE_ALT_DETAIL D                                     \n");
            sbSql.append("                         WHERE D.RECD_STATUS  = 'L'                                         \n");
            sbSql.append("                           AND D.ALT_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE('"+strNeedDate+"','YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("                           AND D.ADVANCE_NUM = M.ADVANCE_NUM) AS APPLY_AMT                  \n");
            sbSql.append("                  FROM SLA_ADVANCE_MST M, FMS_UPJANG B                                      \n");
            sbSql.append("                 WHERE M.SYS_CLASS = '13'                                                   \n");
            sbSql.append("                   AND M.RECD_STATUS = 'L'                                                  \n");
            sbSql.append("                   AND M.OCCUR_DATE <= TO_CHAR(ADD_MONTHS(TO_DATE('"+strNeedDate+"','YYYYMMDD'),-1),'YYYYMM') || '31' \n");
            sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N'                                               \n");
            sbSql.append("                   AND M.UPJANG_CD = B.UPJANG                                               \n");
            sbSql.append("                   AND M.UPJANG_CD = " + sUpjang + "                                                \n");
            sbSql.append("                ) T                                                                         \n");
            sbSql.append("         GROUP BY T.UPJANG                                                                 \n");            
            sbSql.append("       ) J \n");
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       K. 당월 매출액 (매출확정) \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("              ,(SELECT B.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   \n");
            sbSql.append("                   , SUM(A.SAL_AMT) AS K_AMT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \n");
            sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  \n");
            sbSql.append("                 WHERE A.UPJANG=B.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("                   AND A.SALE_DATE BETWEEN  SUBSTR('"+strNeedDate+"' , 1, 6)||'01' AND SUBSTR('"+strNeedDate+"' , 1, 6)||'31'              \n");
            sbSql.append("                   AND A.TRANS_YN='Y' /* 영업회계 미전송건 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \n");
            sbSql.append("                   AND A.UPJANG = " + sUpjang + "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         \n");
            sbSql.append("                   AND B.HEAD_CREDIT_YN = 'N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     \n");
            sbSql.append("                 GROUP BY B.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                \n");
            sbSql.append("       		) K \n");
            sbSql.append("       /************************************************************************** \n");
            sbSql.append("       L. 입고금액(매출확정 이후 날짜) \n");
            sbSql.append("       **************************************************************************/ \n");
            sbSql.append("                ,(SELECT /*+ PUSH_PRED(A) */ C.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("					,  SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE * A.TRANS_QTY))) AS L_AMT                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      \n");
            sbSql.append("                  FROM FMS_TRANSACTION_V A                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        \n");
            sbSql.append("                      , FMS_UPJANG C                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              \n");
            sbSql.append("                  WHERE A.TRANS_UPJANG = C.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 \n");
            sbSql.append("                    AND C.HEAD_CREDIT_YN = 'N'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    \n");
            sbSql.append("                    AND    A.MG_DATE BETWEEN (                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    \n");
            sbSql.append("                                        SELECT  NVL(TO_CHAR(TO_DATE(MAX(SALE_DATE), 'YYYYMMDD')+1, 'YYYYMMDD'), TO_CHAR(SYSDATE+1, 'YYYYMMDD'))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   \n");
            sbSql.append("                                          FROM FMS_SALES                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("                                         WHERE SALE_DATE <= "+strDate+" /* 조건 : 입고예정일 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    \n");
            sbSql.append("                                           AND UPJANG = " + sUpjang + " \n");
            sbSql.append("                                           AND TRANS_YN = 'Y' /* 영업회계 전송건 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               \n");
            sbSql.append("                                         )                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        \n");
            sbSql.append("                                         AND "+strDate+"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           \n");
            sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO'))                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                \n");
            sbSql.append("                    AND C.UPJANG  = " + sUpjang + " \n");
            sbSql.append("                    AND A.TRANS_UPJANG = " + sUpjang + " \n");
            sbSql.append("                  GROUP BY C.UPJANG                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          \n");
            sbSql.append("       			) L \n");
	        sbSql.append(" WHERE A.UPJANG = C.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = C0.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
	        //sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = G.UPJANG(+) \n");
	        //sbSql.append("   AND A.UPJANG = H.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = I.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = J.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = K.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = L.UPJANG(+) \n");
	        sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
			sbSql.append("   AND A.MAIN_UPJANG = " + sMainUpjang + " \n");
			sbSql.append("   AND A.HEAD_CREDIT_YN = 'N' \n");
			sbSql.append("   AND A.USE_YN = 'Y' \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_list);
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

<%--
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		

		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sIgnorCtrl   = nullToBlank(in_vl.getString("sIgnorCtrl"));
		//String strDate      = nullToBlank(in_vl.getString("strDate"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//본사통합 여신관리 여부
		sbSql.append("SELECT NVL(HEAD_CREDIT_YN,'N') AS HEAD_CREDIT_YN \n");
		sbSql.append("     , MAIN_UPJANG \n");
		sbSql.append("  FROM FMS_UPJANG \n");
		sbSql.append(" WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
//		if(! rs.next())
//		{
//			out_vl.add("v_ErrMsg", "여신정보 조회오류...\n관리자에게 연락하세요.");
//		   	this.setResultMessage(0, "OK", out_vl);
//		   	if (true) return;
//		}
		rs.next();
		String sHeadYn = rs.getString("HEAD_CREDIT_YN");
		String sMainUpjang = rs.getString("MAIN_UPJANG");
		rs.close();
		pstmt.close();

		//본사통합인 경우 업장목록을 IN조건으로 만든다.
		String sUpjangList = ""; 
		if (sHeadYn.equals("Y"))
		{
			sbSql.delete(0,sbSql.length());
			sbSql.append("SELECT UPJANG FROM FMS_UPJANG \n");
			sbSql.append(" WHERE MAIN_UPJANG = " + sMainUpjang + " \n");
			sbSql.append("   AND HEAD_CREDIT_YN = 'Y' \n");
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				sUpjangList += ", " + rs.getString("UPJANG");
			}
			sUpjangList = "(" + sUpjangList.substring(1) + ")";
			rs.close();
			pstmt.close();
		}
		
		//여신체크할 최종 발주일자 조회
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT MAX(NEED_DATE) AS NEED_DATE \n");
		sbSql.append("  FROM SO_PR \n");
		if (sHeadYn.equals("Y"))
			sbSql.append(" WHERE RC_UPJANG IN " + sUpjangList + " \n");
		else
			sbSql.append(" WHERE RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "') \n");
		sbSql.append("   AND LINE_STATUS <> '003' --신청취소 \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		String strDate;
		if(rs.next())
			strDate = rs.getString("NEED_DATE");
		else
			strDate = nullToBlank(ds_cond.getString(0, "NEED_DATE"));
		rs.close();
		pstmt.close();

		String sNeedDate = nullToBlank(ds_cond.getString(0, "NEED_DATE")); 

		//내역조회(속도관계상 운영율은 적용하지 않는다.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END AS CREDIT_AMOUNT_TOT \n");//총 여신책정금액
		sbSql.append("     , NVL(C.PRE_SALE_AMT,0) - NVL(C1.PRE_RCP_AMT,0) AS RMN_AMT \n"); //전월 기준으로 외매잔액
		sbSql.append("     , NVL(D.TR_AMT,0) + NVL(C3.SALE_AMT,0) AS TR_AMT \n"); //당월 매출+입고금액
		sbSql.append("     , NVL(E.PO_AMT,0) AS PO_AMT \n"); //매입예정(발주)
		sbSql.append("     , NVL(F.PR_AMT,0) AS PR_AMT \n"); //매입예정(신청)
		sbSql.append("     , CASE WHEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') THEN NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) ELSE 0 END \n"); //가용여신
		sbSql.append("     - NVL(C.PRE_SALE_AMT,0) + NVL(C1.PRE_RCP_AMT,0) - NVL(C3.SALE_AMT,0) + NVL(C2.RCP_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS CREDIT_RMN_AMT \n"); //가용여신
		sbSql.append("     , '우리은행  '||SC_CRYPTO_FUN('DEC', A.ACNTCD_ENC , '3')||'  한화호텔앤드리조트(주)' AS ACNTCD \n"); //계좌정보
		sbSql.append("     , NVL(C2.RCP_AMT,0) AS RCP_AMT \n");//당월입금
		if (sHeadYn.equals("Y"))
		{
			sbSql.append("  FROM FMS_UPJANG A \n");
			sbSql.append("       --B.여신연장정보 \n");
			sbSql.append("     ,(SELECT SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
			sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
			sbSql.append("         FROM FMS_CREDIT_EXT A \n");
			sbSql.append("        WHERE A.UPJANG = " + sMainUpjang + " \n");
			//sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND A.APPR_YN = 'Y' \n");
			sbSql.append("      ) B \n");
			sbSql.append("       --C.전월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS PRE_SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.BILL_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C \n");
			sbSql.append("       --C1.전월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS PRE_RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.RECEIPT_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C1 \n");
			sbSql.append("       --C2.당월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.RECEIPT_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                                 AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C2 \n");
			sbSql.append("       --C3.당월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.BILL_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                              AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C3 \n");
			sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
			sbSql.append("         FROM FMS_TRANSACTION_V \n");
			sbSql.append("        WHERE TRANS_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND TRANS_UPJANG IN " + sUpjangList + " \n");			
			sbSql.append("          AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
			sbSql.append("          AND SGANO = -1 \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
			sbSql.append("      ) D \n");
			sbSql.append("       --E.당월 미검수 발주금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
			sbSql.append("         FROM HLDC_PO_PO A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
			sbSql.append("      ) E \n");
			sbSql.append("       --F.당월 미발주 주문금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
			sbSql.append("         FROM SO_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG IN " + sUpjangList + " \n");
			sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + sMainUpjang + ") = 'Y' \n");
			sbSql.append("      ) F \n");
			sbSql.append(" WHERE A.UPJANG = " + sMainUpjang + " \n");
			//sbSql.append("   AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		}
		else
		{
			sbSql.append("  FROM FMS_UPJANG A \n");
			sbSql.append("       --B.여신연장정보 \n");
			sbSql.append("     ,(SELECT SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
			sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
			sbSql.append("         FROM FMS_CREDIT_EXT A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
//			sbSql.append("          AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
			sbSql.append("          AND A.APPR_YN = 'Y' \n");
			sbSql.append("      ) B \n");
			sbSql.append("       --C.전월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS PRE_SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.BILL_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C \n");
			sbSql.append("       --C1.전월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS PRE_RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.RECEIPT_DATE < SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C1 \n");
			sbSql.append("       --C2.당월입금정보 \n");
			sbSql.append("     ,(SELECT SUM(A.AMOUNT) AS RCP_AMT \n");
			sbSql.append("         FROM HLDC_FM_RECEIPT A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.RECEIPT_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                                 AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.DCGUBUN = '1' \n");
			sbSql.append("      ) C2 \n");
			sbSql.append("       --C3.당월매출정보 \n");
			sbSql.append("     ,(SELECT SUM(A.BILL_AMOUNT + A.BILL_VAT) AS SALE_AMT \n");
			sbSql.append("         FROM HLDC_FM_BILL A \n");
			sbSql.append("        WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.BILL_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' \n");
			sbSql.append("                              AND GREATEST('" + strDate + "',TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
			sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
			sbSql.append("          AND A.DCGUBUN = '2' \n");
			sbSql.append("      ) C3 \n");
			sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
			sbSql.append("         FROM FMS_TRANSACTION_V \n");
			sbSql.append("        WHERE TRANS_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");			
			sbSql.append("          AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
			sbSql.append("          AND SGANO = -1 \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
			sbSql.append("      ) D \n");
			sbSql.append("       --E.당월 미검수 발주금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
			sbSql.append("         FROM HLDC_PO_PO A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
			sbSql.append("      ) E \n"); 
			sbSql.append("       --F.당월 미발주 주문금액 \n");
			sbSql.append("     ,(SELECT SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
			sbSql.append("         FROM SO_PR A \n");
			sbSql.append("        WHERE A.NEED_DATE BETWEEN SUBSTR('" + sNeedDate + "',1,6)||'01' AND '" + strDate + "' \n");
			sbSql.append("          AND A.RC_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
			sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + ") = 'Y' \n");
			sbSql.append("      ) F \n");
			sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			//sbSql.append("   AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		}
		if (! sIgnorCtrl.equals("Y"))
		{
			sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
			sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
		}
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();

		/**종료**/
		out_dl.add(ds_list);
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

--%>