<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00642V_T001.jsp
■ 프로그램명   : 사업장별 거래실적집계(월 마감용)
■ 작성일자     : 2011-11-15
■ 작성자       : 노규완
■ 이력관리     : 2011-11-15
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
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String strMainUpjang      = nullToBlank(in_vl.getString("strMainUpjang"));		
		String strNeedDate    = nullToBlank(in_vl.getString("strNeedDate"));		
		//FileLog.println("d:\\aaa.txt", ds_cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//내역조회
        sbSql.append("SELECT /*+ PUSH_PRED(A) */ A.TRANS_UPJANG AS NEED_DATE_ORI \n");
        sbSql.append("     , A.SUBINV_CODE \n");
        sbSql.append("     , (SELECT Z.SUBINV_NAME_DISP FROM FMS_SUBINVENTORY Z WHERE Z.SUBINV_CODE = A.SUBINV_CODE) AS NEED_DATE  \n");
        
        //sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE))) AS OP_AMOUNT \n");
        /*
        sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE) END\n");
		sbSql.append("              ) AS OP_AMOUNT\n");
        */
		sbSql.append("         , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY))), 0) AS OP_AMOUNT \n");
		//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE))) AS OP_NOTAX \n");
		/*
        sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0,A.TRANS_QTY) * A.SALE_PRICE) END\n");
		sbSql.append("              ) AS OP_NOTAX\n");
        */
		sbSql.append("         , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))), 0) AS OP_NOTAX \n");
		//		sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE))) AS OP_TAX \n");
		/*
		sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)) \n");
		sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE)) \n");
		sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',A.TRANS_QTY,0) * A.SALE_PRICE) END\n");
		sbSql.append("              ) AS OP_TAX\n");
		*/
		sbSql.append("         , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)),0,0)), 0) AS OP_TAX \n");
		//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE)))) AS OP_VAT \n");
        /*
		sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
		sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
		sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
		sbSql.append("              ) AS OP_VAT\n");
        */
		//sbSql.append("         , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))), 0) AS OP_VAT \n");
		//sbSql.append("     , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(B.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(B.OP_RATE,0) / 100),B.CEIL_VAL),B.OP_PRICE)))) AS OP_TOT \n");
        /*
		sbSql.append("         ,SUM( CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) \n");
		sbSql.append("                    WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL\n");
		sbSql.append("                    THEN DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * DECODE(NVL(D.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL),D.OP_PRICE))) \n");
		sbSql.append("               ELSE DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE)) END\n");
		sbSql.append("              ) AS OP_TOT\n");
        */
		//sbSql.append("         , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * DECODE(A.SAL_OPER_PRICE, 0, ROUND(A.SALE_PRICE*A.TRANS_QTY), ROUND(A.SAL_OPER_PRICE*A.TRANS_QTY)))), 0) AS OP_TOT \n");
      //운영율 적용 부과세
		sbSql.append("     , SUM(DECODE(A.FLAG,1  \n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))\n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(SALE_VAT)  \n");
		sbSql.append("     ))  AS OP_VAT  \n");
		//운영율 적용 토탈금액
		sbSql.append("     , SUM(DECODE(A.FLAG,1   \n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE))\n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SAL_OPER_PRICE + SALE_VAT)  \n");
		sbSql.append("     ))  AS OP_TOT  \n");
        sbSql.append("     , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE*A.TRANS_QTY)), 0) AS OP_AMOUNT1 \n");
        sbSql.append("     , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',0,ROUND(A.SALE_PRICE*A.TRANS_QTY))), 0) AS OP_NOTAX1 \n");
        sbSql.append("     , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * DECODE(A.TAX_CODE,'100',ROUND(A.SALE_PRICE*A.TRANS_QTY),0)), 0) AS OP_TAX1 \n");
        //sbSql.append("     , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.SALE_PRICE*A.TRANS_QTY))), 0) AS OP_VAT1 \n");
        //sbSql.append("     , NVL(SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.SALE_PRICE*A.TRANS_QTY))), 0) AS OP_TOT1 \n");
        //운영율 미적용 부과세
		sbSql.append("     , SUM(DECODE(A.FLAG,1  \n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.TRANS_QTY * A.SALE_PRICE))\n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_VAT)  \n");
		sbSql.append("     ))  AS OP_VAT1  \n");
		//운영율 미적용 토탈금액
		sbSql.append("     , SUM(DECODE(A.FLAG,1   \n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.TRANS_QTY * A.SALE_PRICE))\n");
		sbSql.append("     			,DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.TRANS_QTY * A.SALE_PRICE + SALE_VAT)  \n");
		sbSql.append("     ))  AS OP_TOT1  \n");
        //sbSql.append(" FROM HLDC_PO_TRANSACTION_FM A \n");
        //sbSql.append("    , (SELECT * FROM FMU_OP_RATE WHERE UPJANG = " + strUpjang + ") B \n");
        //sbSql.append(" FROM (SELECT A.* , B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
        //sbSql.append(" FROM (SELECT AA.*, DECODE(SUBSTR(AA.TRANS_DATE,1,6), SUBSTR(AA.MG_DATE,1,6), AA.TRANS_DATE, AA.MG_DATE) AS AA_DATE FROM FMS_TRANSACTION_V AA) A \n");
        //sbSql.append("     ,FMS_UPJANG B											\n");
        sbSql.append("     FROM											\n");
        sbSql.append("     (											\n");
        sbSql.append("SELECT                                                                                 \n");
        sbSql.append("  /*+ PUSH_PRED(A) */                                                                  \n");
        sbSql.append("   A.TRANS_UPJANG                                                                      \n");
        sbSql.append(" , A.SUBINV_CODE                                                                       \n");
        sbSql.append(" , A.TRANS_TYPE                                                                        \n");
        sbSql.append(" , A.ITEM_CODE                                                                         \n");
        sbSql.append(" , A.TRANS_QTY                                                                         \n");
        sbSql.append(" , A.TAX_CODE                                                                          \n");
        sbSql.append(" , A.SALE_PRICE                                                                        \n");
        sbSql.append(" , A.SAL_OPER_PRICE                                                                    \n");
        sbSql.append(" , A.SALE_VAT                                                                          \n");
        sbSql.append(" , A.FLAG                                                                              \n");
        //속도개선 뷰 해체 20170510 맹수영
        //속도개선 : 불필요 필드 및 조인 삭제 김호석 2017.11.06
        sbSql.append("FROM   FMS_TRANSACTION_V A, FMS_UPJANG B                                               \n");        
        /*
        sbSql.append("     ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG											\n");
	    sbSql.append("          FROM FMU_OP_RATE 																					\n");
	    sbSql.append("         WHERE USE_YN = 'Y'																					\n");
	    sbSql.append("           AND ITEM_TYPE = 'M'																				\n");
	    sbSql.append("       ) C																									\n");
	    sbSql.append("      ,( SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG											\n");
	    sbSql.append("           FROM FMU_OP_RATE 																					\n");
	    sbSql.append("          WHERE USE_YN = 'Y'																					\n");
	    sbSql.append("            AND ITEM_TYPE = 'C'																				\n");
	    sbSql.append("        ) D 																									\n");
		*/
        sbSql.append("WHERE 1 =1  \n");
        //sbSql.append("  AND A.TRANS_DATE BETWEEN B.SDATE(+) AND B.EDATE(+) \n");
        //sbSql.append("  AND A.ITEM_CODE BETWEEN B.ITEM_CODE(+) AND B.ITEM_CODE(+)||'9999' \n");
        //sbSql.append("  AND B.USE_YN(+) = 'Y' \n");
        sbSql.append("   AND A.TRANS_UPJANG = B.UPJANG \n");
        sbSql.append("   AND B.MAIN_UPJANG = " + strMainUpjang + " \n");
        /*
       	sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) \n");
        sbSql.append("   AND A.TRANS_UPJANG = D.UPJANG(+) \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
        sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
        sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
        sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
        */
        sbSql.append("  AND A.TRANS_DATE2  BETWEEN  '" + strNeedDate + "'||'01' AND '" + strNeedDate + "' ||'31'    \n");
        sbSql.append("  AND A.SUBINV_CODE LIKE 'S1%' \n");
        sbSql.append("  AND ((A.TRANS_TYPE = 'I001') OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))                                             \n");
        sbSql.append("     )	A										\n");
        sbSql.append("GROUP BY A.TRANS_UPJANG, A.SUBINV_CODE \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql1.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_List = this.makeDataSet(rs, "ds_List");
		//FileLog.println("d:\\aaa.txt", ds_List);

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