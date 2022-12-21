<%
//-----------------------------------------------------------------------------
//■ 시스템명          : 식재영업/수불관리/실적관리/분류별 거래실적 조회
//■ 프로그램ID   : FMP00730V_T001.jsp
//■ 프로그램명       : 분류별 거래실적 조회
//■ 작성일자          : 2008.02.01
//■ 작성자             : 노규완
//■ 이력관리          : 2008.02.01
//-----------------------------------------------------------------------------*/
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
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
	//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sUpjang = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String sOtcustcd = nullToBlank(ds_cond.getString(0, "OTCUSTCD"));
		String sSubinv_Code = nullToBlank(ds_cond.getString(0, "SUBINV_CODE"));
		String sSdate = nullToBlank(ds_cond.getString(0, "SDATE"));
		String sEdate = nullToBlank(ds_cond.getString(0, "EDATE"));
		String sUserKind = nullToBlank(ds_cond.getString(0, "USER_KIND"));
		String sMain_Upjang = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));		
		String sTax = nullToBlank(ds_cond.getString(0, "TAX_CODE"));		

// alert기능	 System.out.println(nullToBlank(ds_cond.getString(0, "ITEM_DETAIL")));
	
		//내역조회
			if ( sOtcustcd.equals("0000")){	
		//공급업체가 한화(OTCUSTCD = '0000')일 경우.	*************************************************************************************************		
		
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( " SELECT  NEED_DATE \n");
		        }
		        else {
					sbSql.append( " SELECT  SUBSTR(NEED_DATE,1,4)||'-'||SUBSTR(NEED_DATE,5,2)||'-'||SUBSTR(NEED_DATE,7,2) NEED_DATE \n");
		        }	
				sbSql.append( "             ,SUM(NVL(OP_PRICE,0)) AS OP_PRICE  \n");
				sbSql.append( "             ,SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F10',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_1  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F11',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_2  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F12',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_3  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F13',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_4  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F14',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_5  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F15',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_6  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F16',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_7  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F17',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_8  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F18',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_9  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F19',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_10 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F20',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_11 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F21',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_12 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F22',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_13 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F23',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_14 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F24',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_15 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F25',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_16 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F26',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_17 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F27',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_18 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F99',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_19 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F28',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_20 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F29',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_21 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F70',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_22 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F80',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_23 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F90',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_24 \n");
				sbSql.append( "             ,SUM(ROUND(OP_PRICE * PR_QTY)) AS TOT\n");
				//sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY))) AS VAT \n");
				//sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY))) AS TOT_SUM   \n");
				//운영율 적용 부과세
				sbSql.append( "       , SUM(DECODE(FLAG,1 \n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(PR_QTY * SAL_OPER_PRICE))\n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(SALE_VAT)\n");
				sbSql.append( "       ))  AS VAT\n");
				//운영율 적용 토탈금액
				sbSql.append( "       , SUM(DECODE(FLAG,1 \n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(TAX_CODE,'100',1.1,1) * ROUND(PR_QTY * SAL_OPER_PRICE))\n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(PR_QTY * SAL_OPER_PRICE + SALE_VAT)\n");
				sbSql.append( "       ))  AS TOT_SUM\n");
				sbSql.append( "       FROM ( \n");
		
		
		        if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( " SELECT D.UPJANGNM_DISP AS NEED_DATE \n");
		        }
		        else {
					sbSql.append( " SELECT A.TRANS_DATE AS NEED_DATE \n");
		        }
		        sbSql.append( "       ,A.TRANS_TYPE \n"); 
		        sbSql.append( "       ,A.ITEM_CLASS2 \n");
		        sbSql.append( "       ,A.TAX_CODE \n");
		        //운영율 FMU_OP_RATE -> FMS_TRANSACTION_V 수정 문형광 20150919 시작
		        /*
		        sbSql.append( "       ,CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");              
	            sbSql.append( "              THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n"); 
	            sbSql.append( "              WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
	            sbSql.append( "              THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
	            sbSql.append( "              ELSE A.SALE_PRICE \n");
	            sbSql.append( "          END AS OP_PRICE \n");
	            */
	            sbSql.append("        ,DECODE(A.SAL_OPER_PRICE, 0, A.SALE_PRICE, A.SAL_OPER_PRICE) AS OP_PRICE --운영단가 \n");
	            sbSql.append("        ,A.TRANS_QTY AS PR_QTY, A.SALE_VAT, A.SAL_OPER_PRICE, A.FLAG \n");
				
		        if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( "   FROM (SELECT A.*, DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
		        }
		        else {
		        	sbSql.append( "   FROM (SELECT A.*, DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		        }
		        /*
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
				sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
		        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) E  \n");
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
		        sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
		        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) F \n");
		        */
		        sbSql.append( "    WHERE 1=1 \n");
		        
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					sbSql.append( "	  AND A.TRANS_UPJANG = D.UPJANG  \n");
					sbSql.append( "	  AND D.MAIN_UPJANG = '" +sMain_Upjang+ "'  \n");				
				}
				else {				
					sbSql.append( "     AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");					
				}
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}		
				/*
				sbSql.append( "   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");  
				sbSql.append( "   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
				sbSql.append( "   AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
				sbSql.append( "   AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
				*/
				sbSql.append( "    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				sbSql.append( "    AND A.SUBINV_CODE LIKE 'S1%' \n");
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.AA_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				if ( !sTax.equals(""))							
					sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					//sbSql.append( "  GROUP BY D.UPJANGNM_DISP \n");					
		        }
		        else {
		        	//sbSql.append( "    GROUP BY A.TRANS_DATE , A.TRANS_TYPE, A.ITEM_CLASS2, A.TAX_CODE \n");
		        }
				sbSql.append( "  ) \n");
				sbSql.append( " GROUP BY NEED_DATE");    
				sbSql.append( " ORDER BY NEED_DATE");    
	     	}			
			//공급업체가 전체(OTCUSTCD = '')일 경우.	*************************************************************************************************			
			else if (sOtcustcd.equals("")){		
				
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( " SELECT  NEED_DATE \n");
		        }
		        else {
					sbSql.append( " SELECT  SUBSTR(NEED_DATE,1,4)||'-'||SUBSTR(NEED_DATE,5,2)||'-'||SUBSTR(NEED_DATE,7,2) NEED_DATE \n");
		        }				
				
				sbSql.append( "             ,SUM(NVL(OP_PRICE,0)) AS OP_PRICE  \n");
				sbSql.append( "             ,SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F10',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_1  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F11',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_2  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F12',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_3  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F13',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_4  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F14',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_5  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F15',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_6  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F16',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_7  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F17',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_8  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F18',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_9  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F19',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_10 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F20',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_11 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F21',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_12 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F22',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_13 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F23',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_14 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F24',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_15 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F25',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_16 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F26',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_17 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F27',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_18 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F99',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_19 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F28',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_20 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F29',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_21 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F70',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_22 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F80',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_23 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F90',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_24 \n");
				sbSql.append( "             ,SUM(ROUND(OP_PRICE * PR_QTY)) AS TOT\n");
				//sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY))) AS VAT \n");
				//sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY))) AS TOT_SUM   \n");
				//운영율 적용 부과세
				sbSql.append( "       , SUM(DECODE(FLAG,1 \n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(TAX_CODE,'100',0.1,0) * ROUND(PR_QTY * OP_PRICE))\n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(SALE_VAT)\n");
				sbSql.append( "       ))  AS VAT\n");
				//운영율 적용 토탈금액
				sbSql.append( "       , SUM(DECODE(FLAG,1 \n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(TAX_CODE,'100',1.1,1) * ROUND(PR_QTY * OP_PRICE))\n");
				sbSql.append( "       		,DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * ROUND(PR_QTY * OP_PRICE + SALE_VAT)\n");
				sbSql.append( "       ))  AS TOT_SUM\n");

				sbSql.append( "       FROM ( \n");
				
				
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( " SELECT D.UPJANGNM_DISP AS NEED_DATE \n");
		        }
		        else {
					sbSql.append( " SELECT A.TRANS_DATE AS NEED_DATE \n");
		        }	
				
				sbSql.append( "       ,A.TRANS_TYPE \n"); 
		        sbSql.append( "       ,A.ITEM_CLASS2 \n");
		        sbSql.append( "       ,A.TAX_CODE \n");
		        /*
		        sbSql.append( "       ,CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");              
	            sbSql.append( "              THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n"); 
	            sbSql.append( "              WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
	            sbSql.append( "              THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
	            sbSql.append( "              ELSE A.SALE_PRICE \n");
	            sbSql.append( "          END AS OP_PRICE \n");
	            */
	            sbSql.append("        ,A.SAL_OPER_PRICE AS OP_PRICE --운영단가 \n");
	            sbSql.append("        ,A.TRANS_QTY AS PR_QTY, A.SALE_VAT, A.FLAG  \n");
				
		        if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( "   FROM (SELECT A.*, DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
		        }
		        else {
		        	sbSql.append( "   FROM (SELECT A.*, DECODE(SUBSTR(A.TRANS_DATE,1,6), SUBSTR(A.MG_DATE,1,6), A.TRANS_DATE, MG_DATE) AS AA_DATE, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMS_TRANSACTION_V A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		        }
		        /*
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
				sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
		        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) E  \n");
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
		        sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
		        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) F \n");
		        */
		        sbSql.append( "    WHERE 1=1 \n");
		        
				//sbSql.append( "  AND A.TRANS_UPJANG = B.UPJANG(+) \n");
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					sbSql.append( "	  AND A.TRANS_UPJANG = D.UPJANG  \n");
					sbSql.append( "	  AND D.MAIN_UPJANG = '" +sMain_Upjang+ "'  \n");				
				} else {				
					sbSql.append( "     AND A.TRANS_UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");					
				}
				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "     AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}
				/*
				sbSql.append( "   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");  
				sbSql.append( "   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
				sbSql.append( "   AND A.TRANS_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
				sbSql.append( "   AND A.TRANS_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
				*/
				sbSql.append( "    AND (A.TRANS_TYPE = 'I001' OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO')) \n");
				sbSql.append( "    AND A.SUBINV_CODE LIKE 'S1%' \n");
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.AA_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				if ( !sTax.equals(""))							
					sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					//sbSql.append( "  GROUP BY D.UPJANGNM_DISP \n");
		        }
		        else {
					//sbSql.append( "  GROUP BY  A.TRANS_DATE , A.TRANS_TYPE, A.ITEM_CLASS2, A.TAX_CODE \n");
		        }				
				
				sbSql.append( "  UNION ALL \n");
				
				
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( " SELECT D.UPJANGNM_DISP AS NEED_DATE \n");
		        }
		        else {
					sbSql.append( "   SELECT A.NEED_DATE AS NEED_DATE \n");
		        }
				sbSql.append( "       ,'I' AS TRANS_TYPE \n"); 
		        sbSql.append( "       ,A.ITEM_CLASS2 \n");
		        sbSql.append( "       ,A.TAX_CODE \n");
		        /*
		        sbSql.append( "       ,CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");              
	            sbSql.append( "              THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n"); 
	            sbSql.append( "              WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
	            sbSql.append( "              THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
	            sbSql.append( "              ELSE A.SALE_PRICE \n");
	            sbSql.append( "          END AS OP_PRICE \n");
	            */
	            sbSql.append("        ,A.OP_PRICE AS OP_PRICE \n");
	            sbSql.append("        ,A.PR_QTY AS PR_QTY, ROUND(A.PR_QTY * A.OP_PRICE * 0.1) AS SALE_VAT, '1' AS FLAG\n");
	            
	            if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	//sbSql.append( "     FROM FMP_OTCUST_PR A, FMS_ITEM_V C, FMS_UPJANG D \n");
		        	sbSql.append( "     FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
		        }
		        else {
		        	//sbSql.append( "     FROM FMP_OTCUST_PR A, FMS_ITEM_V C \n");
		        	sbSql.append( "     FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		        }	
	            /*
	            sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
				sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
		        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) E  \n");
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
		        sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
		        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) F \n");
		        */
		        sbSql.append( "    WHERE 1=1 \n");
		        
		        //sbSql.append( "    AND A.UPJANG = B.UPJANG(+) \n");
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					sbSql.append( "	  AND A.UPJANG = D.UPJANG  \n");
					sbSql.append( "	  AND D.MAIN_UPJANG = '" +sMain_Upjang+ "'  \n");					
				}
				else {				
					sbSql.append( "   AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");					
				}
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}
				/*
				sbSql.append( "   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");  
				sbSql.append( "   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
				sbSql.append( "   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
				sbSql.append( "   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
				*/
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				if ( !sTax.equals(""))							
					sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					//sbSql.append( "  GROUP BY D.UPJANGNM_DISP) GROUP BY NEED_DATE \n");
					sbSql.append( "  ) GROUP BY NEED_DATE \n");
		        }
		        else {
					//sbSql.append( "   GROUP BY A.NEED_DATE, A.ITEM_CLASS2,  A.TAX_CODE) GROUP BY NEED_DATE \n");
					sbSql.append( "   ) GROUP BY NEED_DATE \n");
		        }	
			}	
			else{
		//공급업체가 한화 를 제외 한 경우.	*********************************************************************************************************
		        	
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( " SELECT  NEED_DATE \n");
		        }
		        else {
					sbSql.append( " SELECT  SUBSTR(NEED_DATE,1,4)||'-'||SUBSTR(NEED_DATE,5,2)||'-'||SUBSTR(NEED_DATE,7,2) NEED_DATE \n");
		        }	
		
				sbSql.append( "             ,SUM(NVL(OP_PRICE,0)) AS OP_PRICE  \n");
				sbSql.append( "             ,SUM(NVL(PR_QTY,0)) AS PR_QTY \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F10',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_1  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F11',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_2  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F12',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_3  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F13',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_4  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F14',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_5  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F15',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_6  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F16',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_7  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F17',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_8  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F18',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_9  \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F19',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_10 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F20',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_11 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F21',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_12 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F22',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_13 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F23',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_14 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F24',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_15 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F25',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_16 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F26',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_17 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F27',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_18 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F99',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_19 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F28',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_20 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F29',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_21 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F70',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_22 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F80',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_23 \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(ITEM_CLASS2,'F90',ROUND(OP_PRICE * PR_QTY),0))) AS  CLASS2_24 \n");
				sbSql.append( "             ,SUM(ROUND(OP_PRICE * PR_QTY)) AS TOT\n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 0.1, 0) * ROUND(OP_PRICE * PR_QTY))) AS VAT \n");
				sbSql.append( "             ,SUM(ROUND(DECODE(SUBSTR(TRANS_TYPE,1,1),'I',1,-1) * DECODE(TAX_CODE, '100', 1.1, 1) * ROUND(OP_PRICE * PR_QTY))) AS TOT_SUM   \n");
				sbSql.append( "       FROM ( \n");
				
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	sbSql.append( " SELECT D.UPJANGNM_DISP AS NEED_DATE \n");
		        }
		        else {
					sbSql.append( "   SELECT A.NEED_DATE AS NEED_DATE \n");
		        }
				sbSql.append( "       ,'I' AS TRANS_TYPE \n"); 
		        sbSql.append( "       ,A.ITEM_CLASS2 \n");
		        sbSql.append( "       ,A.TAX_CODE \n");
		        /*
		        sbSql.append( "       ,CASE WHEN E.OP_PRICE IS NOT NULL OR E.OP_RATE IS NOT NULL \n");              
	            sbSql.append( "              THEN DECODE(SIGN(NVL(E.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(E.OP_RATE,0) / 100),E.CEIL_VAL), E.OP_PRICE) \n"); 
	            sbSql.append( "              WHEN F.OP_PRICE IS NOT NULL OR F.OP_RATE IS NOT NULL \n");
	            sbSql.append( "              THEN DECODE(SIGN(NVL(F.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(F.OP_RATE,0) / 100),F.CEIL_VAL), F.OP_PRICE) \n"); 
	            sbSql.append( "              ELSE A.SALE_PRICE \n");
	            sbSql.append( "          END AS OP_PRICE \n");
	            */
	            sbSql.append("        ,A.OP_PRICE AS OP_PRICE \n");
	            sbSql.append("        ,A.PR_QTY AS PR_QTY \n");
	            
	            if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
		        	//sbSql.append( "     FROM FMP_OTCUST_PR A, FMS_ITEM_V C, FMS_UPJANG D \n");
		        	sbSql.append( "     FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A, FMS_UPJANG D \n");
		        }
		        else {
		        	//sbSql.append( "     FROM FMP_OTCUST_PR A, FMS_ITEM_V C \n");
		        	sbSql.append( "     FROM (SELECT A.*, B.ITEM_CLASS2, B.ITEM_CLASS4 FROM FMP_OTCUST_PR A, FMS_ITEM_V B WHERE A.ITEM_CODE = B.ITEM_CODE) A \n");
		        }	
	            /*
	            sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE \n");
				sbSql.append( "       FROM FMU_OP_RATE A \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");
		        sbSql.append( "        AND A.ITEM_TYPE = 'M'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) E  \n");
		        sbSql.append( "  , (SELECT A.ITEM_CODE, A.OP_PRICE, A.OP_RATE, A.CEIL_VAL, A.SDATE, A.EDATE  \n");
		        sbSql.append( "       FROM FMU_OP_RATE A, FMS_ITEM_V B \n");
		        sbSql.append( "      WHERE A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n"); 
		        sbSql.append( "        AND A.ITEM_TYPE = 'C'  \n");
		        sbSql.append( "        AND A.USE_YN = 'Y' \n");
		        sbSql.append( "    ) F \n");
		        */
		        sbSql.append( "    WHERE 1=1 \n");
		        if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					sbSql.append( "	  AND A.UPJANG = D.UPJANG  \n");
					sbSql.append( "	  AND D.MAIN_UPJANG = '" +sMain_Upjang+ "'  \n");					
				}
		        else {				
					sbSql.append( "     AND A.UPJANG = '" + nullToBlank(ds_cond.getString(0, "UPJANG")) + "' \n");					
				}
		        if ( !sOtcustcd.equals("")){							
					sbSql.append( "     AND A.OTCUSTCD = '" + nullToBlank(ds_cond.getString(0, "OTCUSTCD")) + "' \n");
				}				
				if ( !sSubinv_Code.equals("")){							
					sbSql.append( "  AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0, "SUBINV_CODE")) + "' \n");
				}
				/*
				sbSql.append( "   AND A.ITEM_CODE = E.ITEM_CODE(+) \n");  
				sbSql.append( "   AND A.ITEM_CLASS4 = F.ITEM_CODE(+) \n");
				sbSql.append( "   AND A.NEED_DATE BETWEEN E.SDATE(+) AND E.EDATE(+) \n");
				sbSql.append( "   AND A.NEED_DATE BETWEEN F.SDATE(+) AND F.EDATE(+) \n");
				*/
				if ( !sSdate.equals("") && !sEdate.equals("")){
					sbSql.append( " AND A.NEED_DATE BETWEEN '" +sSdate+ "' AND '" +sEdate+ "' \n");
				}
				if ( !sTax.equals(""))							
					sbSql.append( "   AND A.TAX_CODE = '" + sTax + "' \n");
				if ( (sUserKind.equals("본사")) && (sUpjang.equals("")) ){
					//sbSql.append( "  GROUP BY D.UPJANGNM_DISP) GROUP BY NEED_DATE \n");
					sbSql.append( "  ) GROUP BY NEED_DATE \n");
		        }
		        else {
					//sbSql.append( "   GROUP BY A.NEED_DATE, A.ITEM_CLASS2,  A.TAX_CODE ) GROUP BY NEED_DATE \n");
		        	sbSql.append( "   ) GROUP BY NEED_DATE \n");
		        }
			}			
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());		
			rs = pstmt.executeQuery(); 
			ds_list = this.makeDataSet(rs, "ds_list");
			
			pstmt.close();
			rs.close();

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