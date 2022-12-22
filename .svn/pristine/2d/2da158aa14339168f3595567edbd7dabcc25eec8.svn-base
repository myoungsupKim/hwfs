<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식채권관리
■ 프로그램ID   : FMO00530V_T003.jsp
■ 프로그램명   : 입금 및 여신현황조회(전체업장)
■ 작성일자     : 2008.08.19
■ 작성자       : 박은규
■ 이력관리     : 2008.08.19
* HISTORY    : 
	  1. 변경 일자 : 2009/06/12(금)  변경번호 : #28264 인시던트 : 116727
	     수정자 : 노규완
	     변경내용 : 기존 Grid에서 여신한도 초과액에 따른 여신 한도 초과 종료일을 추가.
	     요청자 : FS 식재사업 김진희씨
	  2. 변경 일자 : 2009/08/18(화)  변경번호 : #29877 인시던트 : 123488
	     수정자 : 노규완
	     변경 내용 : 외상/선수 잔액을 먼저 등록 한  경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 
	               최고 2달치 까지 끌고 오게 수정.
	     요청자 : FS 식재사업 김진희씨
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

		//본사 통합 업장 대상 여신체크할 최종 발주일자 조회
		sbSql.delete(0,sbSql.length());
		sbSql.append("SELECT \n");
		sbSql.append("       MAX(A.NEED_DATE) AS NEED_DATE \n");
		sbSql.append("  FROM SO_PR A, FMS_UPJANG B\n");
		sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND A.NEED_DATE BETWEEN TO_CHAR(SYSDATE,'YYYYMMDD') AND GREATEST(TO_CHAR(SYSDATE+31,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		sbSql.append("   AND A.SUBINV_CODE LIKE 'S1%' \n");
		sbSql.append("   AND A.LINE_STATUS NOT IN('003', '005', '999') --신청취소, 결의반려 \n");
		//sbSql.append("   AND B.HEAD_CREDIT_YN = 'Y' \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		String strDate;
		if(rs.next())
			strDate = rs.getString("NEED_DATE");
		else
			strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
		rs.close();
		pstmt.close();

		//본사통합 업장내역조회(속도관계상 운영율은 적용하지 않는다.)
		sbSql.delete(0,sbSql.length());
		sbSql.append("/* FMO00530V_T003_1.jsp */ \n");
		sbSql.append("SELECT A.MAIN_UPJANG, DECODE(A.MAIN_UPJANG,A.UPJANG,'0','1') AS BON_GB \n");
		sbSql.append("     , A.UPJANG \n");
		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NULL,' - ')||A.UPJANGNM_DISP AS UPJANGNM_DISP \n");
		sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) \n");
        sbSql.append("       ELSE 0 \n");
        sbSql.append("       END AS AMT1 /* 총 여신책정금액-여신연장금액 삭제 */ \n"); //AMT1            
		sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) \n");
        sbSql.append("       ELSE 0 \n");
        sbSql.append("       END AS AMT1_0 /* 여신금액 */ \n"); //AMT1_0
        sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) \n");
        sbSql.append("       ELSE 0 \n");
        sbSql.append("       END AS AMT1_1 /* 여신연장금액-여신연장금액 삭제 */ \n");//AMT1_1
        sbSql.append("     , NVL(F.PR_AMT,0) + NVL(E.PO_AMT, 0) AS AMT1_2 /* 매입예정(신청) */ \n");
        sbSql.append("     , NVL(D.TR_AMT,0) AS AMT1_3 /* 매입확정 */ \n");
        sbSql.append("     , NVL(C.RMN_AMT,0) AS AMT2 /* 외상매출잔액 */ \n");
        sbSql.append("     , CASE WHEN "+strDate+" BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
        sbSql.append("       THEN NVL(A.CREDIT_AMOUNT,0) ELSE 0 END - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 /* 가용여신 */ \n");
        sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN \n");
        sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
        sbSql.append("          ,'YYY','금액+회전일' \n");
        sbSql.append("          ,'YYN','회전일통제' \n");
        sbSql.append("          ,'YNY','금액통제','무통제') AS CTRL /*통제구분*/ \n");
        sbSql.append("     , NVL(A.CREDIT_TURN_DAYS,0) AS CREDIT_TURN_DAYS /* 여신회전일 */ \n");
        sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");//통제기간
        sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,'Y','N') AS SUM_FLAG \n");
        sbSql.append("     , NVL(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= TO_CHAR(SYSDATE,'YYYYMMDD') \n");
        sbSql.append("           THEN A.CREDIT_OVER_AMOUNT \n");
        sbSql.append("           ELSE 0 END,0) AS CREDIT_OVER_AMOUNT /* 여신한도초과액 */ \n");
        sbSql.append("     , CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= "+strDate+" THEN A.CREDIT_OVER_END ELSE '' END AS CREDIT_OVER_END /*한도초과종료*/ \n");
        sbSql.append("  FROM FMS_UPJANG A, FMS_UPJANG A1 \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C.외상잔액정보 \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT C.MAIN_UPJANG \n");
        sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        sbSql.append("             , SUM(NVL(M.AR_AMT,0)-NVL(D.RECEIVE_AMT,0)) AS RMN_AMT \n");
        sbSql.append("          FROM SLA_AR_MST M \n");
        sbSql.append("             , SLA_AR_RECEIVE_DETAIL D \n");
        sbSql.append("             , FMS_UPJANG C \n");
        sbSql.append("         WHERE M.UPJANG_CD = C.UPJANG \n");
        sbSql.append("           AND M.SYS_CLASS = '13' \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        sbSql.append("           AND D.RECEIVE_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
        sbSql.append("           AND M.AR_NUM = D.AR_NUM \n");
        sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
        sbSql.append("           AND NVL(M.AR_AMT,0) - NVL(D.RECEIVE_AMT,0) > 0  /*  채권잔액이 있는 자료 기준 */ \n");
        sbSql.append("         GROUP BY C.MAIN_UPJANG) C \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        C1.선수잔액정보 \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT C.MAIN_UPJANG \n");
        sbSql.append("             , MIN(M.OCCUR_DATE) AS L_BILL_DATE \n");
        sbSql.append("             , SUM(NVL(M.OCCUR_AMT,0)-NVL(D.APPLY_AMT,0)) AS PRE_AMT \n");
        sbSql.append("          FROM SLA_ADVANCE_MST M \n");
        sbSql.append("             , SLA_ADVANCE_ALT_DETAIL D \n");
        sbSql.append("             , FMS_UPJANG C \n");
        sbSql.append("         WHERE M.SYS_CLASS = '13' \n");
        sbSql.append("           AND M.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.OCCUR_DATE <= "+strDate+" \n");
        sbSql.append("           AND D.RECD_STATUS = 'L' \n");
        sbSql.append("           AND M.UPJANG_CD = C.UPJANG \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND D.ALT_DATE <= "+strDate+" \n");
        sbSql.append("           AND M.ADVANCE_NUM = D.ADVANCE_NUM \n");
        sbSql.append("           AND NVL(M.OCCUR_AMT,0)-NVL(D.APPLY_AMT,0) > 0 /*  선수잔액이 있는 자료 기준 */ \n");
        sbSql.append("         GROUP BY C.MAIN_UPJANG) C1 \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("        D.당월 미매출마감된 검수금액 \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT X.MAIN_UPJANG \n");
        sbSql.append("             , SUM(X.TR_AMT) AS TR_AMT \n");
        sbSql.append("          FROM ( \n");
        //sbSql.append("                  SELECT B.MAIN_UPJANG \n");
        //sbSql.append("                     , SUM(A.SAL_AMT) AS TR_AMT \n");
        //sbSql.append("                  FROM FMS_SALES A, FMS_UPJANG B \n");
        //sbSql.append("                 WHERE A.UPJANG=B.UPJANG \n");
        //sbSql.append("                   AND A.SALE_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
        //sbSql.append("                   AND A.TRANS_YN='N' /* 영업회계 미전송건 */ \n");
        //sbSql.append("                   --AND B.HEAD_CREDIT_YN='Y' \n");
        //sbSql.append("                 GROUP BY B.MAIN_UPJANG \n");
        //sbSql.append("                 UNION ALL \n");
        sbSql.append("                /* D2. 식재매출집계(FMS_SALES)의 최종마감일자 이후에서 기준일자 까지 */ \n");
        sbSql.append("                SELECT C.MAIN_UPJANG \n");
        sbSql.append("                     , SUM(ROUND(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1)*DECODE(A.TAX_CODE,'100',1.1,1)*A.SALE_AMOUNT)) AS TR_AMT \n");
        sbSql.append("                  FROM FMS_TRANSACTION_V A \n");
        sbSql.append("                     , (SELECT UPJANG \n");
        sbSql.append("                             , MAX(SALE_DATE) AS SALE_DATE \n");
        sbSql.append("                          FROM FMS_SALES \n");
        sbSql.append("                         WHERE SALE_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
        sbSql.append("                   		 AND TRANS_YN = 'Y' /* 영업회계 전송건 */ \n");
        sbSql.append("                         GROUP BY UPJANG \n");
        sbSql.append("                        ) B \n");
        sbSql.append("                      , FMS_UPJANG C \n");
        sbSql.append("                  WHERE A.TRANS_UPJANG = B.UPJANG(+) \n");
        sbSql.append("                    AND A.TRANS_UPJANG = C.UPJANG \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("                    AND A.MG_DATE <= "+strDate+" /* 조건 : 입고예정일 */ \n");
        sbSql.append("                    /* 업장별 최종마감일자 이후 ~ 기준일자까지의 집계 : 만약 마감정보가 없으면 기준일자 대비 1개월 전부터 대입 */ \n");
        sbSql.append("                    AND A.MG_DATE>=GREATEST(TO_CHAR(ADD_MONTHS(TO_DATE("+strDate+" , 'YYYYMMDD'),-1), 'YYYYMMDD'), NVL(TO_CHAR(TO_DATE(B.SALE_DATE, 'YYYYMMDD')+1, 'YYYYMMDD'),' ')) \n");
        sbSql.append("                    AND (A.TRANS_TYPE='I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE='PO')) \n");
        sbSql.append("                  GROUP BY C.MAIN_UPJANG) X \n");
        sbSql.append("         GROUP BY X.MAIN_UPJANG \n");
        sbSql.append("        ) D \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       E.당월 미검수 발주금액 \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , ( /* PW(발주진행), PC(발주완료), DL(배송중) 만 집계 */ \n");
        sbSql.append("         /* CENTER_DELI_QTY(센터입고수량), DIRECT_DELI_QTY(직송수량), DELIVERED_QTY(업장입고수량-센터출고), UNDELIVERED_QTY(센터미입고수량) */ \n");
        sbSql.append("        SELECT C.MAIN_UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND((A.CENTER_DELI_QTY+A.DIRECT_DELI_QTY-A.DELIVERED_QTY-A.UNDELIVERED_QTY)*A.SALE_PRICE))) AS PO_AMT \n");
        sbSql.append("          FROM HLDC_PO_PO A , FMS_UPJANG C \n");
        sbSql.append("         WHERE A.PR_UPJANG = C.UPJANG \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("                   --AND C.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND A.LINE_STATUS IN('PW', 'PC', 'DL') \n");
        sbSql.append("         GROUP BY C.MAIN_UPJANG) E \n");
        sbSql.append("       /************************************************************************ \n");
        sbSql.append("       F.당월 미발주 주문금액 \n");
        sbSql.append("       **************************************************************************/ \n");
        sbSql.append("     , (SELECT B.MAIN_UPJANG \n");
        sbSql.append("             , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1)*ROUND(A.PR_QTY*A.SALE_PRICE))) AS PR_AMT \n");
        sbSql.append("          FROM SO_PR A, FMS_UPJANG B \n");
        sbSql.append("         WHERE A.PR_UPJANG = B.UPJANG \n");
        sbSql.append("           --AND B.HEAD_CREDIT_YN = 'Y' \n");
        sbSql.append("           AND A.NEED_DATE <= "+strDate+" \n");
        sbSql.append("           AND A.LINE_STATUS = '001' /* 진행상태 : 001(신청저장) */ \n");
        sbSql.append("         GROUP BY B.MAIN_UPJANG)F \n");
        //sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0)) AS AMT1 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0)) AS AMT1_0 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(B.CREDIT_EXT_AMOUNT,0)) AS AMT1_1 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0),NVL(E_1.PO_AMT,0) + NVL(F_1.PR_AMT,0)) AS AMT1_2 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(D.TR_AMT,0),NVL(D_1.TR_AMT,0)) AS AMT1_3 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(C.RMN_AMT,0)) AS AMT2 \n");
		////sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,A.CREDIT_AMOUNT + NVL(B.CREDIT_EXT_AMOUNT,0) - NVL(C.RMN_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0)) AS AMT3 \n");
		//sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN \n");
		//sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		//sbSql.append("             ,'YYY','금액+회전일' \n");
		//sbSql.append("             ,'YYN','회전일통제' \n");
		//sbSql.append("             ,'YNY','금액통제','무통제') AS CTRL \n");
		//sbSql.append("     , A.CREDIT_TURN_DAYS + NVL(B.CREDIT_EXT_DAYS,0) AS CREDIT_TURN_DAYS \n");
		//sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");
		//sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,'Y','N') AS SUM_FLAG \n");
//		sbSql.append("     , DECODE(A.MAIN_UPJANG,A.UPJANG,A.CREDIT_OVER_AMOUNT) AS CREDIT_OVER_AMOUNT \n");
		
		// 2009-04-06 추가 수정. 내용 : 여신한도초과일 이전 여신한도초과액을 가지고 오기 위해 추가 한 부분. BY 노규완.		
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN DECODE(A.MAIN_UPJANG,A.UPJANG,A.CREDIT_OVER_AMOUNT) ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		// 2009-06-16 추가 수정. 내용 : 여신한도초과 금액 종료일 필드  추가 한 부분. BY 노규완. #28264
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		//sbSql.append("      ,A.CREDIT_OVER_END \n");
		
		
		
		
		//sbSql.append("  FROM FMS_UPJANG A \n");
		//sbSql.append("       --B.여신연장정보 \n");
		//sbSql.append("     ,(SELECT B.MAIN_UPJANG \n");
		//sbSql.append("            , SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
		//sbSql.append("            , SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
		//sbSql.append("         FROM FMS_CREDIT_EXT A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG AND B.UPJANG = B.MAIN_UPJANG \n");
		//sbSql.append("          AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
		//sbSql.append("          AND A.APPR_YN = 'Y' \n");
		//sbSql.append("        GROUP BY B.MAIN_UPJANG) B \n");
		//sbSql.append("       --C.외상잔액정보 \n");
		//sbSql.append("     ,(SELECT B.MAIN_UPJANG \n");
		//sbSql.append("            , SUM((A.BILL_AMOUNT + A.BILL_VAT) - NVL(C.RCP_AMT,0)) AS RMN_AMT \n");
		//sbSql.append("         FROM HLDC_FM_BILL A, FMS_UPJANG B \n");
		//sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
		//sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//sbSql.append("               GROUP BY C.BILL_ID) C \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.BILL_ID = C.BILL_ID(+) \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		//sbSql.append("          AND A.BILL_DATE <= '" + strDate + "' \n");
		//// 2009-07-28 추가 수정. 내용 : 외상/선수 기준일을 구한 것 보다 이후의 데이터가 존재 할 때 데이터를 불러 오지 못하므로 , 조회일의 마지막 까지 범위를 준다. BY 노규완. 
		//sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");		
		//// (#29877)2009-08-18 추가 수정 시작. 
		//// 내용 : 외상/선수 잔액을 먼저 등록 한  경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 최고 2달치 까지 끌고 오게 수정.
		////       관련 화면 : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001
		//sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");
		//// (#29877)2009-08-18 추가 수정 끝.
		//
		//sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		//sbSql.append("          AND A.DCGUBUN = '1' \n");
		//sbSql.append("          AND A.ACCTCD = '1110411' \n");
		//sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(C.RCP_AMT,0)) != 0 \n");
		
		
		
		//----------------------------------------------------------
		// 튜닝적용 시작--------------------------------------------
		//----------------------------------------------------------
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}		
		//----------------------------------------------------------
		// 튜닝적용 종료--------------------------------------------
		//----------------------------------------------------------
		
		//sbSql.append("        GROUP BY B.MAIN_UPJANG) C \n");
		//sbSql.append("       --C1.선수잔액정보 \n");
		//sbSql.append("     ,(SELECT B.MAIN_UPJANG \n");
		//sbSql.append("            , SUM(A.AMOUNT - NVL(C.USE_AMT,0)) AS PRE_AMT \n");
		//sbSql.append("            , MIN(A.RECEIPT_DATE) AS L_RECEIPT_DATE \n");
		//sbSql.append("         FROM HLDC_FM_RECEIPT A, FMS_UPJANG B \n");
		//sbSql.append("            ,(SELECT C.RECEIPT_ID, SUM(C.AMOUNT) AS USE_AMT \n");
		//sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//sbSql.append("               GROUP BY C.RECEIPT_ID) C \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.RECEIPT_ID = C.RECEIPT_ID(+) \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		////sbSql.append("          AND A.RECEIPT_DATE <= '" + strDate + "' \n");
		//// 2009-07-28 추가 수정. 내용 : 외상/선수 기준일을 구한 것 보다 이후의 데이터가 존재 할 때 데이터를 불러 오지 못하므로 , 조회일의 마지막 까지 범위를 준다. BY 노규완. 
		////sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");		
		//// (#29877)2009-08-18 추가 수정 시작. 
		//// 내용 : 외상/선수 잔액을 먼저 등록 한  경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 최고 2달치 까지 끌고 오게 수정.
		////       관련 화면 : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001 
		//sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");		
		//// (#29877)2009-08-18 추가 수정 끝.
		//
		//sbSql.append("          AND A.DCGUBUN = '2' \n");
		//sbSql.append("          AND A.ACCTCD = '2110441' \n");
		//sbSql.append("          --AND A.GANO > 0 --가상계좌 전표화 시킨 것만 인정하려면 주석제거. \n");
		//sbSql.append("          AND (A.AMOUNT - NVL(C.USE_AMT,0)) != 0 \n");
		//
		////----------------------------------------------------------
		//// 튜닝적용 시작
		////----------------------------------------------------------
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
	
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}			
		//----------------------------------------------------------
		// 튜닝적용 종료
		//----------------------------------------------------------
		
		
		
		//sbSql.append("        GROUP BY B.MAIN_UPJANG) C1 \n");
		//sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
		//sbSql.append("     ,(SELECT B.MAIN_UPJANG \n");
		//sbSql.append("            , SUM(A.TR_AMT) AS TR_AMT \n");
		//sbSql.append("         FROM FMS_UPJANG B \n");
		//sbSql.append("            , (SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_UPJANG B, FMS_TRANSACTION_V A \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		//sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//
		////----------------------------------------------------------
		//// 튜닝적용 시작
		////----------------------------------------------------------
		//sbSql.append("                  AND A.TRANS_UPJANG = B.UPJANG \n");
		//sbSql.append("                  AND B.HEAD_CREDIT_YN = 'Y' \n");
		//
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
	    //
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}			
		////----------------------------------------------------------
		//// 튜닝적용 종료
		////----------------------------------------------------------		
		//
		//
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("                UNION ALL \n");
		//sbSql.append("               SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_UPJANG B, FMS_TRANSACTION_V A \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//
		//
		////----------------------------------------------------------
		//// 튜닝적용 시작
		////----------------------------------------------------------
		//sbSql.append("                  AND A.TRANS_UPJANG = B.UPJANG \n");
		//sbSql.append("                  AND B.HEAD_CREDIT_YN = 'Y' \n");
		//
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
	    //
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}			
		////----------------------------------------------------------
		//// 튜닝적용 종료
		////----------------------------------------------------------		
		//
		//
		//
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("              ) A \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		//
		//
		////----------------------------------------------------------
		//// 튜닝적용 시작
		////----------------------------------------------------------
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
	    //
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}			
		////----------------------------------------------------------
		//// 튜닝적용 종료
		////----------------------------------------------------------		
		//
		//
		//sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		//sbSql.append("      ) D \n");
		//sbSql.append("       --E.당월 미검수 발주금액 \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              B.MAIN_UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
		//sbSql.append("         FROM HLDC_PO_PO A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		//sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		//sbSql.append("      ) E \n");
		//sbSql.append("       --F.당월 미발주 주문금액 \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              B.MAIN_UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
		//sbSql.append("         FROM SO_PR A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		//sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY B.MAIN_UPJANG \n");
		//sbSql.append("      ) F \n");
		//업장별 매입예정/확정액
		//sbSql.append("       --업장별 매입예정/확정액-- \n");
		//sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
		//sbSql.append("     ,(SELECT A.UPJANG, SUM(A.TR_AMT) AS TR_AMT \n");
		//sbSql.append("         FROM FMS_UPJANG B \n");
		//sbSql.append("            , (SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_UPJANG B, FMS_TRANSACTION_V A \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		//sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//
		//
		//
		////----------------------------------------------------------
		//// 튜닝적용 시작
		////----------------------------------------------------------
		//sbSql.append("                  AND A.TRANS_UPJANG = B.UPJANG \n");
		//sbSql.append("                  AND B.HEAD_CREDIT_YN = 'Y' \n");
		//
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
	    //
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}			
		////----------------------------------------------------------
		//// 튜닝적용 종료
		////----------------------------------------------------------
		//
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("                UNION ALL \n");
		//sbSql.append("               SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_UPJANG B, FMS_TRANSACTION_V A \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//
		//
		//
		////----------------------------------------------------------
		//// 튜닝적용 시작
		////----------------------------------------------------------
		//sbSql.append("                  AND A.TRANS_UPJANG = B.UPJANG \n");
		//sbSql.append("                  AND B.HEAD_CREDIT_YN = 'Y' \n");
		//
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
	    //
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}			
		////----------------------------------------------------------
		//// 튜닝적용 종료
		////----------------------------------------------------------		
		//
		//
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("              ) A \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		//
		//
		//
		////----------------------------------------------------------
		//// 튜닝적용 시작
		////----------------------------------------------------------
		//sbSql.append("          AND B.USE_YN = 'Y' \n");
	    //
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND B.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = B.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}			
		////----------------------------------------------------------
		//// 튜닝적용 종료
		////----------------------------------------------------------			
		//
		//
		//
		//
		//
		//sbSql.append("        GROUP BY A.UPJANG \n");
		//sbSql.append("      ) D_1 \n");
		//sbSql.append("       --E.당월 미검수 발주금액 \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              A.RC_UPJANG AS UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
		//sbSql.append("         FROM HLDC_PO_PO A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		//sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//sbSql.append("      ) E_1 \n");
		//sbSql.append("       --F.당월 미발주 주문금액 \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              A.RC_UPJANG AS UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
		//sbSql.append("         FROM SO_PR A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'Y' \n");
		//sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//sbSql.append("      ) F_1 \n");
		//
		sbSql.append(" WHERE A.MAIN_UPJANG = C.MAIN_UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = C1.MAIN_UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = D.MAIN_UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = E.MAIN_UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = F.MAIN_UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = D_1.UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = E_1.UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = F_1.UPJANG(+) \n");
		sbSql.append("   AND A.HEAD_CREDIT_YN = 'Y' \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append("   AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
		sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
		if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
			sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		{
			sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
			sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
			sbSql.append("                  AND Y.UPJANG = A.UPJANG \n");
			sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close();
		pstmt.close();
		
		////본사 미 통합 업장 대상 여신체크할 최종 발주일자 조회
		//sbSql.delete(0,sbSql.length());
		//sbSql.append("SELECT \n");
		//sbSql.append("       A.NEED_DATE \n");
		//sbSql.append("  FROM SO_PR A, FMS_UPJANG B\n");
		//sbSql.append(" WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' AND GREATEST(TO_CHAR(SYSDATE+15,'YYYYMMDD'),'" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "') \n");
		//sbSql.append("   AND A.SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("   AND A.LINE_STATUS <> '003' --신청취소 \n");
		//sbSql.append("   AND B.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("   AND ROWNUM <= 1 \n");
//out_vl//.add("fa_Sql", sbSql.toString());
		////System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		//if(rs.next())
		//	strDate = rs.getString("NEED_DATE");
		//else
		//	strDate = nullToBlank(ds_Cond.getString(0, "JDATE"));
		//rs.close();
		//pstmt.close();
        //
		////본사 미 통합 업장내역조회(속도관계상 운영율은 적용하지 않는다.)
		//sbSql.delete(0,sbSql.length());
		//sbSql.append("/* FMO00530V_T003_2.jsp */ \n");
		//sbSql.append("SELECT A.MAIN_UPJANG, '1' AS BON_GB \n");
		//sbSql.append("     , A.UPJANG \n");
		//sbSql.append("     , A.UPJANGNM_DISP \n");
		//sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) AS AMT1 \n");
		//sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) AS AMT1_0 \n");
		//sbSql.append("     , NVL(B.CREDIT_EXT_AMOUNT,0) AS AMT1_1 \n");
		//sbSql.append("     , NVL(E.PO_AMT,0) + NVL(F.PR_AMT,0) AS AMT1_2 \n");
		//sbSql.append("     , NVL(D.TR_AMT,0) AS AMT1_3 \n");
		//sbSql.append("     , NVL(C.RMN_AMT,0) AS AMT2 \n");
		////sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) - NVL(C.RMN_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 \n");
		//sbSql.append("     , NVL(A.CREDIT_AMOUNT,0) + NVL(B.CREDIT_EXT_AMOUNT,0) - NVL(C.RMN_AMT,0) + NVL(C1.PRE_AMT,0) - NVL(D.TR_AMT,0) - NVL(E.PO_AMT,0) - NVL(F.PR_AMT,0) AS AMT3 \n");
		//sbSql.append("     , A.HEAD_CREDIT_YN AS TOT_YN \n");
		//sbSql.append("     , DECODE(A.CREDIT_CONTROL_YN||A.CREDIT_TURN_CONTROL_YN||A.CREDIT_AMOUNT_CONTROL_YN \n");
		//sbSql.append("             ,'YYY','금액+회전일' \n");
		//sbSql.append("             ,'YYN','회전일통제' \n");
		//sbSql.append("             ,'YNY','금액통제','무통제') AS CTRL \n");
		//sbSql.append("     , A.CREDIT_TURN_DAYS + NVL(B.CREDIT_EXT_DAYS,0) AS CREDIT_TURN_DAYS \n");
		//sbSql.append("     , NVL(A.CREDIT_START,'00000000')||' ~ '||NVL(A.CREDIT_END,'99999999') AS PERIOD \n");
		//sbSql.append("     , 'Y' AS SUM_FLAG \n");
//		//sbSql.append("     , A.CREDIT_OVER_AMOUNT \n");
		//
		//// 2009-04-06 추가 수정. 내용 : 여신한도초과일 이전 여신한도초과액을 가지고 오기 위해 추가 한 부분. BY 노규완.
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN A.CREDIT_OVER_AMOUNT ELSE 0 END) AS CREDIT_OVER_AMOUNT \n");
		//// 2009-06-16 추가 수정. 내용 : 여신한도초과 금액 종료일 필드  추가 한 부분. BY 노규완. #28264
		//sbSql.append("      ,(CASE WHEN NVL(A.CREDIT_OVER_END,'99999999') >= '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' THEN TO_CHAR(TO_DATE(A.CREDIT_OVER_END,'YYYYMMDD'),'YYYY-MM-DD') ELSE '' END) AS CREDIT_OVER_END \n");		
		////sbSql.append("      ,A.CREDIT_OVER_END \n");
		//sbSql.append("  FROM FMS_UPJANG A \n");
		//sbSql.append("       --B.여신연장정보 \n");
		//sbSql.append("     ,(SELECT B.UPJANG, SUM(A.CREDIT_EXT_AMOUNT) AS CREDIT_EXT_AMOUNT \n");
		//sbSql.append("            , SUM(A.CREDIT_EXT_DAYS) AS CREDIT_EXT_DAYS \n");
		//sbSql.append("         FROM FMS_CREDIT_EXT A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("          AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN A.SUPPLY_START AND A.SUPPLY_END \n");
		//sbSql.append("          AND A.APPR_YN = 'Y' \n");
		//sbSql.append("        GROUP BY B.UPJANG) B \n");
		//sbSql.append("       --C.외상잔액정보 \n");
		//sbSql.append("     ,(SELECT A.UPJANG, SUM((A.BILL_AMOUNT + A.BILL_VAT) - NVL(C.RCP_AMT,0)) AS RMN_AMT \n");
		//sbSql.append("         FROM HLDC_FM_BILL A, FMS_UPJANG B \n");
		//sbSql.append("            ,(SELECT C.BILL_ID, SUM(C.AMOUNT) AS RCP_AMT \n");
		//sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//sbSql.append("               GROUP BY C.BILL_ID) C \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.BILL_ID = C.BILL_ID(+) \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		////sbSql.append("          AND A.BILL_DATE <= '" + strDate + "' \n");
		//// 2009-07-28 추가 수정. 내용 : 외상/선수 기준일을 구한 것 보다 이후의 데이터가 존재 할 때 데이터를 불러 오지 못하므로 , 조회일의 마지막 까지 범위를 준다. BY 노규완. 
		////sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");		
		//// (#29877)2009-08-18 추가 수정 시작.
		//// 내용 : 외상/선수 잔액을 먼저 등록 한  경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 최고 2달치 까지 끌고 오게 수정.
		////       관련 화면 : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001 
		//sbSql.append("          AND A.BILL_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");		
		//// (#29877)2009-08-18 추가 수정 끝.
		//sbSql.append("          AND A.CANCEL_FLAG = 'N' \n");
		//sbSql.append("          AND A.DCGUBUN = '1' \n");
		//sbSql.append("          AND A.ACCTCD = '1110411' \n");
		//sbSql.append("          AND ((A.BILL_AMOUNT + A.BILL_VAT) - NVL(C.RCP_AMT,0)) != 0 \n");
		//sbSql.append("        GROUP BY A.UPJANG) C \n");
		//sbSql.append("       --C1.선수잔액정보 \n");
		//sbSql.append("     ,(SELECT A.UPJANG, SUM(A.AMOUNT - NVL(C.USE_AMT,0)) AS PRE_AMT \n");
		//sbSql.append("            , MIN(A.RECEIPT_DATE) AS L_RECEIPT_DATE \n");
		//sbSql.append("         FROM HLDC_FM_RECEIPT A, FMS_UPJANG B \n");
		//sbSql.append("            ,(SELECT C.RECEIPT_ID, SUM(C.AMOUNT) AS USE_AMT \n");
		//sbSql.append("                FROM HLDC_FM_RECEIPT B, HLDC_FM_BILL_RECEIPT C \n");
		//sbSql.append("               WHERE B.RECEIPT_ID = C.RECEIPT_ID \n");
		//sbSql.append("               GROUP BY C.RECEIPT_ID) C \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.RECEIPT_ID = C.RECEIPT_ID(+) \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		////sbSql.append("          AND A.RECEIPT_DATE <= '" + strDate + "' \n");
		//// 2009-07-28 추가 수정. 내용 : 외상/선수 기준일을 구한 것 보다 이후의 데이터가 존재 할 때 데이터를 불러 오지 못하므로 , 조회일의 마지막 까지 범위를 준다. BY 노규완. 
		////sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(LAST_DAY(SYSDATE),'YYYYMMDD')) \n");
		//// (#29877)2009-08-18 추가 수정 시작. 
		//// 내용 : 외상/선수 잔액을 먼저 등록 한  경우를 대비 하여 수정(ADD_MONTHS(날짜,1))를 통하여 최고 2달치 까지 끌고 오게 수정.
		////       관련 화면 : FMO00570V,FMO00550V,FMO00530V,MAK10170S,FMZ_CREDIT_INFO_T001 
		//sbSql.append("          AND A.RECEIPT_DATE <= GREATEST('" + strDate + "', TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE),1),'YYYYMMDD')) \n");		
		//// (#29877)2009-08-18 추가 수정 끝.
		//
		//sbSql.append("          AND A.DCGUBUN = '2' \n");
		//sbSql.append("          AND A.ACCTCD = '2110441' \n");
		//sbSql.append("          --AND A.GANO > 0 --가상계좌 전표화 시킨 것만 인정하려면 주석제거. \n");
		//sbSql.append("          AND (A.AMOUNT - NVL(C.USE_AMT,0)) != 0 \n");
		//sbSql.append("        GROUP BY A.UPJANG) C1 \n");
		//sbSql.append("       --D.당월 미매출마감된 검수금액 \n");
		//sbSql.append("     ,(SELECT A.UPJANG, SUM(A.TR_AMT) AS TR_AMT \n");
		//sbSql.append("         FROM FMS_UPJANG B \n");
		//sbSql.append("            , (SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_UPJANG A, FMS_TRANSACTION_V B \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') \n");
		//sbSql.append("                                     AND TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"31\"') \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//
		////---------------------------------------------------
		//// 튜닝 적용시작
		////---------------------------------------------------
		//sbSql.append("                  AND b.TRANS_UPJANG = a.UPJANG \n");
		//sbSql.append("                  AND A.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("                  AND A.USE_YN = 'Y' \n");
		//
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = A.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}
		////---------------------------------------------------
		//// 튜닝 적용 종료
		////---------------------------------------------------
		//
		//
		//
		//
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("                UNION ALL \n");
		//sbSql.append("               SELECT \n");
		//sbSql.append("                      TRANS_UPJANG AS UPJANG \n");
		////sbSql.append("                    , SUM(ROUND(DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                    , SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE,'100',1.1,1) * SALE_AMOUNT)) AS TR_AMT \n");
		//sbSql.append("                 FROM FMS_UPJANG A, FMS_TRANSACTION_V B \n");
		//sbSql.append("                WHERE TRANS_DATE BETWEEN SUBSTR('" + strDate + "',1,6)||'01' AND '" + strDate + "' \n");
		////sbSql.append("                  AND TRANS_TYPE = 'I001' \n");
		//sbSql.append("                  AND (TRANS_TYPE = 'I001' OR (TRANS_TYPE LIKE '_002' AND SOURCE_TYPE = 'PO')) \n");
		//sbSql.append("                  AND SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("                  AND GANO = -1 \n");
		////sbSql.append("                  AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//
		//
		//
		////---------------------------------------------------
		//// 튜닝 적용시작
		////---------------------------------------------------
		//sbSql.append("                  AND B.TRANS_UPJANG = A.UPJANG \n");
		//sbSql.append("                  AND A.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("                  AND A.USE_YN = 'Y' \n");
		//
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = A.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}
		////---------------------------------------------------
		//// 튜닝 적용 종료
		////---------------------------------------------------
		//		
		//
		//
		//sbSql.append("                GROUP BY TRANS_UPJANG \n");
		//sbSql.append("              ) A \n");
		//sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("        GROUP BY A.UPJANG \n");
		//sbSql.append("      ) D \n");
		//sbSql.append("       --E.당월 미검수 발주금액 \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              A.RC_UPJANG AS UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND((A.CENTER_DELI_QTY + A.DIRECT_DELI_QTY - A.DELIVERED_QTY - A.UNDELIVERED_QTY) * A.SALE_PRICE))) AS PO_AMT \n");
		//sbSql.append("         FROM HLDC_PO_PO A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("          AND A.LINE_STATUS BETWEEN '006' AND '010' \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//sbSql.append("      ) E \n");
		//sbSql.append("       --F.당월 미발주 주문금액 \n");
		//sbSql.append("     ,(SELECT \n");
		//sbSql.append("              A.RC_UPJANG AS UPJANG \n");
		//sbSql.append("            , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PR_QTY * A.SALE_PRICE))) AS PR_AMT \n");
		//sbSql.append("         FROM SO_PR A, FMS_UPJANG B \n");
		//sbSql.append("        WHERE A.RC_UPJANG = B.UPJANG \n");
		//sbSql.append("          AND A.NEED_DATE BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE('" + strDate + "','YYYYMMDD'),-1),'YYYYMM\"01\"') AND '" + strDate + "' \n");
		//sbSql.append("          AND A.SUBINV_CODE LIKE 'S1%' \n");
		//sbSql.append("          AND B.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("          AND A.LINE_STATUS IN ('001','002','004') \n");
		////sbSql.append("          AND (SELECT CREDIT_AMOUNT_CONTROL_YN FROM FMS_UPJANG WHERE UPJANG =  " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + ") = 'Y' \n");
		//sbSql.append("        GROUP BY A.RC_UPJANG \n");
		//sbSql.append("      ) F \n");
		//sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = C1.UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = D.UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = E.UPJANG(+) \n");
		//sbSql.append("   AND A.UPJANG = F.UPJANG(+) \n");
		//sbSql.append("   AND A.HEAD_CREDIT_YN = 'N' \n");
		//sbSql.append("   AND A.USE_YN = 'Y' \n");
		////sbSql.append("   AND '" + nullToBlank(ds_Cond.getString(0, "JDATE")) + "' BETWEEN NVL(A.CREDIT_START,'00000000') AND NVL(A.CREDIT_END,'99999999') \n");
		////sbSql.append("   AND A.CREDIT_CONTROL_YN = 'Y' \n");
		////sbSql.append("   AND (A.CREDIT_TURN_CONTROL_YN = 'Y' OR A.CREDIT_AMOUNT_CONTROL_YN = 'Y') \n");
		//if (! nullToBlank(ds_Cond.getString(0, "SALE_SABUN")).equals(""))
		//	sbSql.append("   AND A.PART_SALES_SABUN = '" + nullToBlank(ds_Cond.getString(0, "SALE_SABUN")) + "' \n");
		//if (! nullToBlank(ds_Cond.getString(0, "CENTER_CODE")).equals(""))
		//{
		//	sbSql.append("   AND EXISTS (SELECT 1 FROM HLDC_PO_UPJANG_CENTER X, HLDC_ST_UPJANG Y \n");
		//	sbSql.append("                WHERE X.UPJANG = Y.AP_UNITPRICE_UPJANG \n");
		//	sbSql.append("                  AND Y.UPJANG = A.UPJANG \n");
		//	sbSql.append("                  AND X.CENTER_CODE = " + nullToBlank(ds_Cond.getString(0, "CENTER_CODE")) + ") \n");
		//}
		//
//out_vl//.add("fa_Sql", sbSql.toString());
		////System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());		
		//rs = pstmt.executeQuery(); 
		//ds_ListTmp = this.makeDataSet(rs, "ds_ListTmp");
		//rs.close();
		//pstmt.close();

		/**종료**/
		//out_dl.add(ds_ListTmp);
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
