<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/수불관리
■ 프로그램ID   : FMP00640V_T001.jsp
■ 프로그램명   : 사업장별 거래실적집계
■ 작성일자     : 2008-01-31
■ 작성자       : 박은규
■ 이력관리     : 2008-01-31
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sOtCust = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		//내역조회
		if (sOtCust.equals(""))
		{
			sbSql.append("SELECT A.NEED_DATE_ORI \n");
			sbSql.append("     , A.NEED_DATE \n");
			sbSql.append("     , A.UPJANG \n");
			sbSql.append("     , SUM(OP_AMOUNT) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(OP_NOTAX) AS OP_NOTAX \n");
			sbSql.append("     , SUM(OP_TAX) AS OP_TAX \n");
			sbSql.append("     , SUM(OP_VAT) AS OP_VAT \n");
			sbSql.append("     , SUM(OP_TOT) AS OP_TOT \n");
			sbSql.append("     , SUM(OP_AMOUNT1) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(OP_NOTAX1) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(OP_TAX1) AS OP_TAX1 \n");
			sbSql.append("     , SUM(OP_VAT1) AS OP_VAT1 \n");
			sbSql.append("     , SUM(OP_TOT1) AS OP_TOT1 \n");
			sbSql.append("  FROM \n");
			sbSql.append("( \n");
		}
		if (sOtCust.equals("0000") || sOtCust.equals(""))
		{
				
			sbSql.append("SELECT T.NEED_DATE_ORI, T.NEED_DATE, T.UPJANG \n");
			
			sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.TRANS_QTY * T.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',0,T.TRANS_QTY) * T.OP_PRICE)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',T.TRANS_QTY,0) * T.OP_PRICE)) AS OP_TAX \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.TRANS_QTY * T.OP_PRICE))) AS OP_VAT \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * ROUND(T.TRANS_QTY * T.OP_PRICE))) AS OP_TOT \n");
			//운영율 적용 부과세
			sbSql.append("     , SUM(DECODE(T.FLAG,1  \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.TRANS_QTY * T.SAL_OPER_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.SALE_VAT)\n");
			sbSql.append("     ))  AS OP_VAT  \n");
			//운영율 적용 토탈금액
			sbSql.append("     , SUM(DECODE(T.FLAG,1   \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * ROUND(T.TRANS_QTY * T.SAL_OPER_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.TRANS_QTY * T.SAL_OPER_PRICE + T.SALE_VAT)\n");
			sbSql.append("     ))  AS OP_TOT  \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.TRANS_QTY * T.SALE_PRICE)) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.TAX_CODE,'100',0,ROUND(T.TRANS_QTY * T.SALE_PRICE))) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * DECODE(T.TAX_CODE,'100',ROUND(T.TRANS_QTY * T.SALE_PRICE),0)) AS OP_TAX1 \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.TRANS_QTY * T.SALE_PRICE))) AS OP_VAT1 \n");
			//sbSql.append("     , SUM(DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * ROUND(T.TRANS_QTY * T.SALE_PRICE))) AS OP_TOT1 \n");
			//운영율 미적용 부과세
			sbSql.append("     , SUM(DECODE(T.FLAG,1  \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.TRANS_QTY * T.SALE_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.SALE_VAT)\n");
			sbSql.append("     ))  AS OP_VAT1  \n");
			//운영율 미적용 토탈금액
			sbSql.append("     , SUM(DECODE(T.FLAG,1   \n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * ROUND(T.TRANS_QTY * T.SALE_PRICE))\n");
			sbSql.append("     			,DECODE(SUBSTR(T.TRANS_TYPE,1,1),'I',1,-1) * ROUND(T.TRANS_QTY * T.SALE_PRICE + SALE_VAT)  \n");
			sbSql.append("     ))  AS OP_TOT1  \n");
			
			
			sbSql.append("  FROM ( \n");
			sbSql.append("				SELECT \n");
					if (sType.equals("001"))
						//sbSql.append("				TO_CHAR(A.TRANS_UPJANG) AS NEED_DATE_ORI, E.SUBINV_NAME_DISP AS NEED_DATE, B.UPJANG \n");
						sbSql.append("				TO_CHAR(A.TRANS_UPJANG) AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE, B.UPJANG \n");
					else
						//sbSql.append("				A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE, B.UPJANG \n");
						sbSql.append("				A.TRANS_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.TRANS_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE, '' AS UPJANG \n");
					
					/*
					sbSql.append("				, CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
					sbSql.append("				THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
					sbSql.append("				WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
					sbSql.append("            	THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
					sbSql.append("       		ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
					*/
					sbSql.append("              , DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE \n");
					sbSql.append("				, A.TRANS_TYPE \n");
					sbSql.append("     			, A.TRANS_QTY \n");
					sbSql.append("     			, A.TAX_CODE \n");
					sbSql.append("     			, A.SALE_VAT \n");
					sbSql.append("     			, A.FLAG \n");
					//sbSql.append("     			, '1' AS FLAG \n");
					sbSql.append("     			, A.SALE_PRICE \n");
					sbSql.append("     			, A.SAL_OPER_PRICE \n");
					sbSql.append("     			, A.SALE_AMOUNT \n");									
					//sbSql.append("  	FROM (SELECT A.*, DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE,B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B \n");
					//속도개선 : 불필요 필드 및 조인 삭제 김호석 2017.11.06
					sbSql.append("  	FROM FMS_TRANSACTION_V A, FMS_UPJANG B \n");
 		            
					/*
					sbSql.append("     , ( \n");   
					sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
					sbSql.append("           FROM FMU_OP_RATE \n");
					sbSql.append("          WHERE USE_YN = 'Y' \n");
					sbSql.append("            AND ITEM_TYPE = 'M' \n");
					sbSql.append("       ) C \n");
					sbSql.append("     , ( \n");        
					sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
					sbSql.append("           FROM FMU_OP_RATE \n");
					sbSql.append("          WHERE USE_YN = 'Y' \n");
					sbSql.append("            AND ITEM_TYPE = 'C' \n");
					sbSql.append("       ) D \n");					
					*/
// 					if (sType.equals("001"))
// 						sbSql.append("     , FMS_SUBINVENTORY E \n");
					
					sbSql.append(" WHERE 1=1 \n");
					sbSql.append("   AND A.TRANS_UPJANG = B.UPJANG \n");
					/*
					sbSql.append("   AND A.TRANS_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
					sbSql.append("   AND A.TRANS_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
					sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
					sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
					sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG(+) 					\n");
		        	sbSql.append("   AND A.TRANS_UPJANG = D.UPJANG(+) 					\n");
		        	*/
// 					if (sType.equals("001"))
// 						sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE \n");
					
					//sbSql.append("   AND A.AA_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
					//속도개선 : TRANS_DATE2로 변경 김호석 2017.11.06
					sbSql.append("   AND A.TRANS_DATE2 BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
					sbSql.append("   AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
					sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
					
					if (! sUpjang.equals(""))
						sbSql.append("   AND A.TRANS_UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
					
			sbSql.append("  ) T \n");	
			
			sbSql.append(" GROUP BY T.NEED_DATE_ORI, T.NEED_DATE, T.UPJANG \n");
			
			
		}
		if (sOtCust.equals(""))
			sbSql.append(" UNION ALL \n");
		if ((! sOtCust.equals("0000")) || sOtCust.equals(""))
		{
			
			
			sbSql.append("SELECT T.NEED_DATE_ORI, T.NEED_DATE, T.UPJANG \n");					
			
			sbSql.append("     , SUM(ROUND(T.PO_QTY * T.OP_PRICE)) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(DECODE(T.TAX_CODE,'100',0,T.PO_QTY) * T.OP_PRICE)) AS OP_NOTAX \n");
			sbSql.append("     , SUM(ROUND(DECODE(T.TAX_CODE,'100',T.PO_QTY,0) * T.OP_PRICE)) AS OP_TAX \n");
			sbSql.append("     , SUM(ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * ROUND(T.PO_QTY * T.OP_PRICE))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * ROUND(T.PO_QTY * T.OP_PRICE))) AS OP_TOT \n");
			sbSql.append("     , SUM(T.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(T.TAX_CODE,'100',0,T.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(T.TAX_CODE,'100',T.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(ROUND(DECODE(T.TAX_CODE,'100',0.1,0) * T.SALE_AMOUNT)) AS OP_VAT1 \n");
			sbSql.append("     , SUM(ROUND(DECODE(T.TAX_CODE,'100',1.1,1) * T.SALE_AMOUNT)) AS OP_TOT1 \n");

			sbSql.append("  FROM ( \n");
			sbSql.append("				SELECT \n");
				if (sType.equals("001"))
					//sbSql.append("				TO_CHAR(A.UPJANG) AS NEED_DATE_ORI, E.SUBINV_NAME_DISP AS NEED_DATE, B.UPJANG \n");
					sbSql.append("				TO_CHAR(A.UPJANG) AS NEED_DATE_ORI, B.UPJANGNM_DISP AS NEED_DATE, B.UPJANG \n");
				else
					sbSql.append("				A.NEED_DATE AS NEED_DATE_ORI, TO_CHAR(TO_DATE(A.NEED_DATE,'YYYYMMDD'),'YYYY-MM-DD') AS NEED_DATE, '' AS UPJANG \n");
			    /*
				sbSql.append("				, CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
				sbSql.append("				THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
				sbSql.append("				WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
				sbSql.append("            	THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
				sbSql.append("       		ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
				*/
				sbSql.append("     			, SUM(A.OP_PRICE) AS OP_PRICE \n");
				sbSql.append("     			, A.PO_QTY \n");
				sbSql.append("     			, A.TAX_CODE \n");
				sbSql.append("     			, SUM(A.SALE_AMOUNT) AS SALE_AMOUNT \n");									
				//sbSql.append("  	FROM (SELECT A.*, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG B \n");
				//속도개선 : 불필요 필드 및 조인 삭제 김호석 2017.11.06
				sbSql.append("  	FROM FMP_OTCUST_PR A, FMS_UPJANG B \n");
				/*
				sbSql.append("     , ( \n");   
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'M' \n");
				sbSql.append("       ) C \n");
				sbSql.append("     , ( \n");        
				sbSql.append("         SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
				sbSql.append("           FROM FMU_OP_RATE \n");
				sbSql.append("          WHERE USE_YN = 'Y' \n");
				sbSql.append("            AND ITEM_TYPE = 'C' \n");
				sbSql.append("       ) D \n");
				*/
// 				if (sType.equals("001"))
// 					sbSql.append("     , FMS_SUBINVENTORY E \n");
				
				sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
				/*
				sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
				sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
				sbSql.append("   AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
				sbSql.append("   AND A.UPJANG = C.UPJANG(+) 					\n");
	        	sbSql.append("   AND A.UPJANG = D.UPJANG(+) 					\n");
				*/
// 				if (sType.equals("001"))
// 					sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE \n");
				sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
				if (! sUpjang.equals(""))
					sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
				sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
				if (! sOtCust.equals(""))
					sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
				sbSql.append("   AND A.LINE_STATUS <> '003' \n");
				if (sType.equals("001"))
					//sbSql.append(" GROUP BY A.UPJANG, B.UPJANG, E.SUBINV_NAME_DISP, C.OP_PRICE, C.OP_RATE , A.SALE_PRICE, C.CEIL_VAL, D.OP_PRICE, D.OP_RATE, D.OP_PRICE, D.CEIL_VAL, A.PO_QTY, A.TAX_CODE, A.SALE_AMOUNT \n");
					sbSql.append(" GROUP BY A.UPJANG, B.UPJANG, B.UPJANGNM_DISP, A.PO_QTY, A.TAX_CODE \n");
				else   
					sbSql.append(" GROUP BY A.NEED_DATE,A.UPJANG, B.UPJANG, A.PO_QTY, A.TAX_CODE \n");
				
			sbSql.append("  ) T \n");	
			
			sbSql.append(" GROUP BY T.NEED_DATE_ORI, T.NEED_DATE, T.UPJANG \n");
/* 				
			sbSql.append("     , SUM(ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_AMOUNT \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0,A.PO_QTY) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_NOTAX \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',A.PO_QTY,0) * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE))) AS OP_TAX \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_VAT \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * ROUND(A.PO_QTY * DECODE(NVL(C.OP_PRICE,0),0,SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL),C.OP_PRICE)))) AS OP_TOT \n");
			sbSql.append("     , SUM(A.SALE_AMOUNT) AS OP_AMOUNT1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',0,A.SALE_AMOUNT)) AS OP_NOTAX1 \n");
			sbSql.append("     , SUM(DECODE(A.TAX_CODE,'100',A.SALE_AMOUNT,0)) AS OP_TAX1 \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * A.SALE_AMOUNT)) AS OP_VAT1 \n");
			sbSql.append("     , SUM(ROUND(DECODE(A.TAX_CODE,'100',1.1,1) * A.SALE_AMOUNT)) AS OP_TOT1 \n");
			sbSql.append("  FROM FMP_OTCUST_PR A, FMS_UPJANG B, FMU_OP_RATE C \n"); 
			
			sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
			sbSql.append("   AND A.UPJANG = C.UPJANG(+) \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append("   AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			sbSql.append("   AND C.USE_YN(+) = 'Y' \n");
			if (sType.equals("001"))
				sbSql.append("   AND A.SUBINV_CODE = E.SUBINV_CODE \n");
			sbSql.append("   AND B.MAIN_UPJANG = " + nullToBlank(ds_cond.getString(0, "MAIN_UPJANG")) + " \n");
			if (! sUpjang.equals(""))
				sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0, "UPJANG")) + " \n");
			sbSql.append("   AND A.NEED_DATE BETWEEN '" + nullToBlank(ds_cond.getString(0, "NEED_DATE")) + "' AND '" + nullToBlank(ds_cond.getString(0, "NEED_DATET")) + "' \n");
			if (! sOtCust.equals(""))
				sbSql.append("   AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
			sbSql.append("   AND A.LINE_STATUS <> '003' \n");
			if (sType.equals("001"))
				//sbSql.append(" GROUP BY A.UPJANG, B.UPJANGNM_DISP \n");
				sbSql.append(" GROUP BY A.UPJANG, E.SUBINV_NAME_DISP \n");
			else
				sbSql.append(" GROUP BY A.NEED_DATE \n"); 	*/
		}
		if (sOtCust.equals(""))
		{
			sbSql.append(") A \n");
			sbSql.append(" GROUP BY A.NEED_DATE_ORI, A.NEED_DATE, A.UPJANG \n");
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
