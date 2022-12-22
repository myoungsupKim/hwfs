<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00670V_T001.jsp
■ 프로그램명   : 분류별 거래실적 조회(본사)
■ 작성일자     : 2008-08-07
■ 작성자       : 박은규
■ 이력관리     : 2008-08-07
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
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_Cond.getString(0, "OTCUSTCD"));
		String sUpjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String sSubinv = nullToBlank(ds_Cond.getString(0, "SUBINV_CODE"));
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.NEED_DATE_ORI, A.NEED_DATE \n");
			sbSql.append("     , SUM(A.CLASS2_1) AS CLASS2_1 \n");
			sbSql.append("     , SUM(A.CLASS2_2) AS CLASS2_2 \n");
			sbSql.append("     , SUM(A.CLASS2_3) AS CLASS2_3 \n");
			sbSql.append("     , SUM(A.CLASS2_4) AS CLASS2_4 \n");
			sbSql.append("     , SUM(A.CLASS2_5) AS CLASS2_5 \n");
			sbSql.append("     , SUM(A.CLASS2_6) AS CLASS2_6 \n");
			sbSql.append("     , SUM(A.CLASS2_7) AS CLASS2_7 \n");
			sbSql.append("     , SUM(A.CLASS2_8) AS CLASS2_8 \n");
			sbSql.append("     , SUM(A.CLASS2_9) AS CLASS2_9 \n");
			sbSql.append("     , SUM(A.CLASS2_10) AS CLASS2_10 \n");
			sbSql.append("     , SUM(A.CLASS2_11) AS CLASS2_11 \n");
			sbSql.append("     , SUM(A.CLASS2_12) AS CLASS2_12 \n");
			sbSql.append("     , SUM(A.CLASS2_13) AS CLASS2_13 \n");
			sbSql.append("     , SUM(A.CLASS2_14) AS CLASS2_14 \n");
			sbSql.append("     , SUM(A.CLASS2_15) AS CLASS2_15 \n");
			sbSql.append("     , SUM(A.CLASS2_16) AS CLASS2_16 \n");
			sbSql.append("     , SUM(A.CLASS2_17) AS CLASS2_17 \n");
			sbSql.append("     , SUM(A.CLASS2_18) AS CLASS2_18 \n");
			sbSql.append("     , SUM(A.CLASS2_19) AS CLASS2_19 \n");
			sbSql.append("     , SUM(A.TOT_SUM) AS TOT_SUM \n");
			sbSql.append("     , SUM(A.VAT) AS VAT \n");
			sbSql.append("     , SUM(A.TOT) AS TOT \n");
			sbSql.append("  FROM \n"); 
			sbSql.append("( \n");
			
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
			sbSql.append("SELECT \n");
			if (sType.equals("001")) {
				sbSql.append("       T.TRANS_UPJANG AS NEED_DATE_ORI, T.UPJANGNM_DISP AS NEED_DATE \n");
			}
			else {
				sbSql.append("       T.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(T.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");
			}
			
			sbSql.append( "             ,SUM(NVL(T.SALE_PRICE,0)) AS OP_PRICE  \n");
			sbSql.append( "             ,SUM(NVL(T.PR_QTY,0)) AS PR_QTY \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F10',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_1  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F11',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_2  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F12',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_3  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F13',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_4  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F14',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_5  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F15',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_6  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F16',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_7  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F17',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_8  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F18',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_9  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F19',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_10 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F20',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_11 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F21',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_12 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F22',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_13 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F23',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_14 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F24',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_15 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F25',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_16 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F26',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_17 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F27',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_18 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.ITEM_CLASS2,'F99',ROUND(T.SALE_AMOUNT),0))) AS  CLASS2_19 \n");
			sbSql.append( "             ,SUM(ROUND(T.SALE_AMOUNT)) AS TOT\n");
			//sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.TAX_CODE, '100', 0.1, 0) * ROUND(T.SALE_AMOUNT))) AS VAT \n");
			//sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.TAX_CODE, '100', 1.1, 1) * ROUND(T.SALE_AMOUNT))) AS TOT_SUM   \n");
			//운영율 미적용 부과세
			sbSql.append("     , SUM(DECODE(T.FLAG,1  \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.PR_QTY * T.SALE_PRICE))  \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.SALE_VAT)  \n");
			sbSql.append("     ))  AS VAT  \n");
			//운영율 미적용 토탈금액
			sbSql.append("     , SUM(DECODE(T.FLAG,1   \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * ROUND(T.TRANS_QTY * T.SALE_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.PR_QTY * T.SALE_PRICE + T.SALE_VAT)  \n");
			sbSql.append("     ))  AS TOT_SUM  \n");
			sbSql.append( "       FROM ( \n");
			sbSql.append( "       SELECT A.TRANS_DATE\n");
			sbSql.append( "				,A.TRANS_TYPE \n"); 
	        //sbSql.append( "       		,A.ITEM_CLASS2 \n");
	        sbSql.append( "       		,(SELECT ITEM_CLASS2 FROM FMS_ITEM_V WHERE ITEM_CODE = A.ITEM_CODE) AS ITEM_CLASS2  \n");
	        sbSql.append( "       		,A.TRANS_UPJANG \n");
	        sbSql.append( "       		,D.UPJANGNM_DISP \n");
	        sbSql.append( "       		,A.TAX_CODE \n");
	        sbSql.append( "       		,A.SALE_VAT \n");
	        sbSql.append( "       		,A.FLAG \n");
	        sbSql.append( "       		,A.TRANS_QTY \n");
	        sbSql.append( "       		,A.SALE_PRICE \n");
	        /*
	        sbSql.append( "       		,CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");              
            sbSql.append( "                	  THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n"); 
            sbSql.append( "              	  WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
            sbSql.append( "              	  THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
            sbSql.append( "              	  ELSE A.SALE_PRICE \n");
            sbSql.append( "          	  END AS OP_PRICE \n");
            */
            //sbSql.append( "             ,DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE \n");
            sbSql.append("        		,A.SALE_AMOUNT AS SALE_AMOUNT \n");
            sbSql.append("        		,A.TRANS_QTY AS PR_QTY \n");
        	sbSql.append( "   		FROM \n");
        	//sbSql.append("				 (SELECT A.*,DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
        	sbSql.append("				 FMS_TRANSACTION_V A, FMS_UPJANG D \n");
        	/*
			sbSql.append( "  		   , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE, A.UPJANG \n");
			sbSql.append( "       			FROM FMU_OP_RATE A \n");
	        sbSql.append( "      		   WHERE A.ITEM_TYPE = 'M'  \n");
	        sbSql.append( "        			 AND A.USE_YN = 'Y' \n");
	        sbSql.append( "    			  ) E  \n");
	        sbSql.append( "  		   , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE, A.UPJANG  \n");
	        sbSql.append( "       			FROM FMU_OP_RATE A \n");
	        sbSql.append( "      		   WHERE A.ITEM_TYPE = 'C'  \n");
	        sbSql.append( "        			 AND A.USE_YN = 'Y' \n");
	        sbSql.append( "    			  ) F \n");
	        */
	        sbSql.append( "        WHERE 1=1 \n");
	        /*
	        sbSql.append( "        AND A.ITEM_CODE = E.ITEM_CODE(+) \n");  
			sbSql.append( "        AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
			sbSql.append( "        AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
			sbSql.append( "        AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			sbSql.append("         AND A.TRANS_UPJANG = E.UPJANG(+) \n");
			sbSql.append("         AND A.TRANS_UPJANG = F.UPJANG(+) \n");
			*/
			sbSql.append("   	   AND A.TRANS_DATE2 BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "EDATE")) + "' \n");
			sbSql.append( "        AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
			sbSql.append("         AND A.TRANS_UPJANG = D.UPJANG \n");
			
			if (! sUpjang.equals("")) {
				sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			}
			if (! sSubinv.equals("")) {
				sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "' \n");
			}
			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
			//sbSql.append(" ) T \n");
			if (sType.equals("001")) {
				sbSql.append("  ) T \n"); 
				sbSql.append(" GROUP BY T.TRANS_UPJANG, T.UPJANGNM_DISP \n"); 
			}
			else {
				sbSql.append("  ) T \n"); 
				sbSql.append(" GROUP BY T.TRANS_DATE, T.TRANS_UPJANG, T.UPJANGNM_DISP \n");
				
				//sbSql.append(" GROUP BY T.TRANS_DATE \n");
			}
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			if (sType.equals("001"))
				sbSql.append("SELECT TT.UPJANG AS NEED_DATE_ORI, TT.UPJANGNM_DISP AS NEED_DATE \n");
			else
				sbSql.append("SELECT TT.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(TT.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE \n");

			sbSql.append( "             ,SUM(NVL(TT.OP_PRICE,0)) AS OP_PRICE  \n");
			sbSql.append( "             ,SUM(NVL(TT.PR_QTY,0)) AS PR_QTY \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F10',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_1  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F11',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_2  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F12',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_3  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F13',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_4  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F14',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_5  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F15',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_6  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F16',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_7  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F17',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_8  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F18',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_9  \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F19',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_10 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F20',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_11 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F21',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_12 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F22',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_13 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F23',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_14 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F24',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_15 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F25',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_16 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F26',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_17 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F27',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_18 \n");
			sbSql.append( "             ,SUM(ROUND(DECODE(TT.ITEM_CLASS2,'F99',ROUND(TT.SALE_AMOUNT),0))) AS  CLASS2_19 \n");
			sbSql.append( "             ,SUM(ROUND(TT.SALE_AMOUNT)) AS TOT\n");
			//sbSql.append( "             ,SUM(ROUND(DECODE(TT.TAX_CODE, '100', 0.1, 0) * ROUND(TT.SALE_AMOUNT))) AS VAT \n");
			//sbSql.append( "             ,SUM(ROUND(DECODE(TT.TAX_CODE, '100', 1.1, 1) * ROUND(TT.SALE_AMOUNT))) AS TOT_SUM   \n");
			//운영율 미적용 부과세
			sbSql.append("     , SUM(DECODE(T.FLAG,1  \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.PR_QTY * T.SALE_PRICE))  \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.SALE_VAT)  \n");
			sbSql.append("     ))  AS VAT  \n");
			//운영율 미적용 토탈금액
			sbSql.append("     , SUM(DECODE(T.FLAG,1   \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * ROUND(T.TRANS_QTY * T.SALE_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.PR_QTY * T.SALE_PRICE + T.SALE_VAT)  \n");
			sbSql.append("     ))  AS TOT_SUM  \n");
			sbSql.append( "       FROM ( \n");
			sbSql.append( "       			SELECT A.NEED_DATE  \n");
			sbSql.append( "       				  ,A.ITEM_CLASS2 \n");
	        sbSql.append( "       				  ,A.UPJANG \n");
	        sbSql.append( "       				  ,D.UPJANGNM_DISP \n");
	        sbSql.append( "       				  ,A.TAX_CODE \n");
	        sbSql.append( "       				  ,A.SALE_AMOUNT \n");
	        /*
	        sbSql.append( "       				  ,CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");              
            sbSql.append( "              				  THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n"); 
            sbSql.append( "              				  WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
            sbSql.append( "              				  THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
            sbSql.append( "              				  ELSE A.SALE_PRICE \n");
            sbSql.append( "          				  END AS OP_PRICE \n");
            */
            sbSql.append("        				  ,SUM(A.SALE_PRICE) AS OP_PRICE \n");		
            sbSql.append("        				  ,A.PO_QTY AS PR_QTY \n");
            sbSql.append( "   				  FROM \n");
            sbSql.append("				 			(SELECT A.*, DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
            /*
            sbSql.append( "  		   			  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
			sbSql.append( "       					   FROM FMU_OP_RATE A \n");
	        sbSql.append( "      		   			  WHERE A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n");
	        sbSql.append( "                  			AND A.ITEM_TYPE = 'M'  \n");
	        sbSql.append( "        			 			AND A.USE_YN = 'Y' \n");
	        sbSql.append( "    			  			) E  \n");
	        sbSql.append( "  		   			  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
	        sbSql.append( "       					   FROM FMU_OP_RATE A \n");
	        sbSql.append( "      		   			  WHERE A.UPJANG = '" + nullToBlank(ds_Cond.getString(0, "UPJANG")) + "' \n"); 
	        sbSql.append( "        			 			AND A.ITEM_TYPE = 'C'  \n");
	        sbSql.append( "        			 			AND A.USE_YN = 'Y' \n");
	        sbSql.append( "    			  			) F \n");
	        */
	        sbSql.append( "        			WHERE 1=1 \n");
	        /*
	        sbSql.append( "        			AND A.ITEM_CODE = E.ITEM_CODE(+) \n");  
			sbSql.append( "        			AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
			sbSql.append( "        			AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
			sbSql.append( "        			AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
			*/
			sbSql.append("   				AND A.AA_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' AND '" + nullToBlank(ds_Cond.getString(0, "EDATE")) + "' \n");
			sbSql.append("                  AND A.UPJANG = D.UPJANG \n");
			if (! sUpjang.equals("")) {
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			}
			if (! sSubinv.equals("")) {
				sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_Cond.getString(0, "SUBINV_CODE")) + "' \n");
			}
			
			sbSql.append("   AND D.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
			
			if (! sOtCust.equals("")) {
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "' \n");
			}
			
			sbSql.append( "   				AND A.LINE_STATUS <> '003' \n");			
			if (sType.equals("001")) {
				sbSql.append(" GROUP BY A.NEED_DATE, A.ITEM_CLASS2, A.TAX_CODE, A.UPJANG, D.UPJANGNM_DISP, A.PO_QTY ) TT \n");
				sbSql.append(" GROUP BY TT.UPJANG, TT.UPJANGNM_DISP, TT.NEED_DATE,TT.ITEM_CLASS2,TT.OP_PRICE,TT.PR_QTY,TT.TAX_CODE \n"); 
			}
			else {
				sbSql.append(" GROUP BY A.NEED_DATE, A.ITEM_CLASS2, A.TAX_CODE, A.UPJANG, D.UPJANGNM_DISP, A.PO_QTY ) TT \n");
				sbSql.append(" GROUP BY TT.UPJANG, TT.UPJANGNM_DISP, TT.NEED_DATE,TT.ITEM_CLASS2,TT.OP_PRICE,TT.PR_QTY,TT.TAX_CODE \n");
			}
		}
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.NEED_DATE_ORI, A.NEED_DATE \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

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