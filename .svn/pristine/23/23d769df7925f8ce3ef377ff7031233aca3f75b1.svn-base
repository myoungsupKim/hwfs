<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 영업관리/마케팅
■ 프로그램ID   : AMG10051S_T001.jsp
■ 프로그램명   : 거래처 자재별 매출집계표
■ 작성일자     : 2008-02-25
■ 작성자       : 황승한
■ 이력관리     : 2008-02-25
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_cond");
		
		//입력 파라메터
		
		//String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		//String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		
	
		String str_in_DEPT_ID            = nullToBlank(ds_cond.getString(0, "DEPT_ID"));
		String str_in_PART_SALES_SABUN   = nullToBlank(ds_cond.getString(0, "PART_SALES_SABUN"));
		String str_in_CENTER_CODE        = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		String str_in_TRANS_DATEFR       = nullToBlank(ds_cond.getString(0, "TRANS_DATEFR"));
		String str_in_TRANS_DATETO       = nullToBlank(ds_cond.getString(0, "TRANS_DATETO"));
		String str_in_MAIN_UPJANG        = nullToBlank(ds_cond.getString(0, "MAIN_UPJANG"));
		String str_in_SUB_UPJANG         = nullToBlank(ds_cond.getString(0, "SUB_UPJANG"));
		
		String str_in_chk_0    = nullToBlank(ds_cond.getString(0, "chk_0"));
		String str_in_chk_1    = nullToBlank(ds_cond.getString(0, "chk_1"));
		String str_in_chk_2    = nullToBlank(ds_cond.getString(0, "chk_2"));
		String str_in_chk_3    = nullToBlank(ds_cond.getString(0, "chk_3"));
		
		String str_in_price = nullToBlank(ds_cond.getString(0, "SCH_PRICE"));
		
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//Master 조회###########################################################################
		
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회	

		
		sbSql.append(" SELECT \n");
		sbSql.append("	  RS.ITEM_CLASS2 AS ITEM_CLASS \n");
		sbSql.append("	, CASE WHEN SUBSTR(RS.ITEM_CODE, 1, 1) = '7' THEN '보정분' ELSE (SELECT CLASS_NAME FROM HLDC_PO_ITEM_CLASS_HLDC_V WHERE CLASS_CODE = RS.ITEM_CLASS2) END  AS CLASS_NAME \n");
		sbSql.append("	, RS.ITEM_CODE \n");
		sbSql.append("	, RS.ITEM_NAME \n");
		sbSql.append("	, RS.ITEM_SIZE \n");
		sbSql.append("	, RS.TRANS_UOM \n");
		sbSql.append("	, RS.TRANS_QTY AS SUM_A	/* 입고수량 */ \n");
		sbSql.append("	, CASE WHEN RS.TRANS_QTY = 0 THEN 0 ELSE ROUND(RS.TRANS_SUM / RS.TRANS_QTY, 0) END AS SUM_B	/* 평균원가 */ \n");
		sbSql.append("	, CASE WHEN RS.TRANS_QTY = 0 THEN 0 ELSE ROUND((RS.SALE_SUM - (RS.CK_SALE_SUM + RS.JI_SALE_SUM)) / RS.TRANS_QTY, 0) END AS SUM_C	/* 평균판매가 */ \n");
		sbSql.append("	, RS.SALE_SUM - (RS.CK_SALE_SUM + RS.JI_SALE_SUM) + \n");
		sbSql.append("	  RS.SALE_VAT - (RS.CK_SALE_VAT + RS.JI_SALE_VAT)  AS SUM_D_TOT	/* 총매출액 */ \n");
		sbSql.append("	, RS.SALE_SUM - (RS.CK_SALE_SUM + RS.JI_SALE_SUM) AS SUM_D	/* 순매출액 */ \n");
		sbSql.append("	, RS.SALE_SUM - (RS.CK_SALE_SUM + RS.JI_SALE_SUM) - RS.TRANS_SUM AS SUM_E  /* 이익액 */ \n");
		sbSql.append("	, CASE WHEN RS.SALE_SUM - (RS.CK_SALE_SUM + RS.JI_SALE_SUM) = 0 THEN 0 \n");
		sbSql.append("	  ELSE ROUND((RS.SALE_SUM - (RS.CK_SALE_SUM + RS.JI_SALE_SUM) - RS.TRANS_SUM) / (RS.SALE_SUM - (RS.CK_SALE_SUM + RS.JI_SALE_SUM)) * 100, 2) \n");
		sbSql.append("	  END AS SUM_F /* 이익율 */ \n");
		sbSql.append(" FROM  \n");
		sbSql.append("	( \n");
		sbSql.append("	SELECT \n");
		sbSql.append("		     X.ITEM_CLASS2 \n");
		sbSql.append("			, X.ITEM_CODE \n");
		sbSql.append("			, X.ITEM_NAME \n");
		sbSql.append("			, X.ITEM_SIZE \n");
		sbSql.append("			, X.TRANS_UOM \n");
		sbSql.append("		, SUM(X.TRANS_QTY) AS TRANS_QTY \n");
		sbSql.append("		, SUM(ROUND(X.TRANS_MAMOUNT * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1)))     AS TRANS_SUM   \n");
		if (str_in_chk_3.equals("1")){
		sbSql.append("	     , SUM(DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(X.TRANS_QTY * ROUND(X.SALE_PRICE / (1 + X.SE_RATE/100)))) AS SALE_SUM \n");
		sbSql.append("		 , SUM( \n");
		sbSql.append("				CASE WHEN X.FLAG = '1' THEN 		 \n");
		sbSql.append("					DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(ROUND(X.TRANS_QTY * ROUND(X.SALE_PRICE / (1 + X.SE_RATE/100))) * DECODE(X.TAX_CODE,'100',0.1,0)) \n");
		sbSql.append("				ELSE \n");
		sbSql.append("					DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(X.TAX_CODE,'100',1,0) * X.SALE_VAT)  \n"); 
		sbSql.append("				END \n");
		sbSql.append("			) AS SALE_VAT \n");
		} else {
        sbSql.append("		, SUM(DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(X.SALE_PRICE * X.TRANS_QTY)) AS SALE_SUM \n");
        //sbSql.append("		, SUM(DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(X.TAX_CODE,'100',0.1,0) * ROUND(X.SALE_PRICE * X.TRANS_QTY))) AS SALE_VAT \n"); 
        sbSql.append("		, SUM(  \n"); 
		sbSql.append("				CASE WHEN X.FLAG = '1' THEN  \n"); 
		sbSql.append("					DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(X.TAX_CODE,'100',0.1,0) * ROUND(X.SALE_PRICE * X.TRANS_QTY))  \n"); 
		sbSql.append("				ELSE  \n"); 
		sbSql.append("					DECODE(SUBSTR(X.TRANS_TYPE,1,1),'I',1,-1) * ROUND(DECODE(X.TAX_CODE,'100',1,0) * X.SALE_VAT)  \n"); 
		sbSql.append("				END  \n"); 
		sbSql.append("		 ) AS SALE_VAT \n"); 
		}
		sbSql.append("		, SUM(ROUND(X.CK_AMOUNT * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1)))          AS CK_SALE_SUM \n");
		sbSql.append("		, SUM(ROUND(DECODE(X.TAX_CODE,100,ROUND(X.CK_AMOUNT * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1) / 10),0))) AS CK_SALE_VAT \n");
		sbSql.append("		, SUM(ROUND(X.JI_AMOUNT * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1)))          AS JI_SALE_SUM \n");
		sbSql.append("		, SUM(ROUND(DECODE(X.TAX_CODE,100,ROUND(X.JI_AMOUNT * DECODE(SUBSTR(X.TRANS_TYPE,1,1), 'I', 1, -1) / 10),0))) AS JI_SALE_VAT \n");
		sbSql.append("	FROM \n");
		sbSql.append("		( \n");
		sbSql.append("		SELECT \n");
		sbSql.append("			   T.MAIN_UPJANG \n");
		sbSql.append("			  , T.UPJANG \n");
		sbSql.append("			  ,	T.TRANS_DATE \n");
		sbSql.append("			  , T.ITEM_CODE \n");
		sbSql.append("			  , T.ITEM_NAME \n");
		sbSql.append("			  , T.ITEM_SIZE \n");
		sbSql.append("			  , T.TRANS_UOM \n");
		sbSql.append("			  , T.TRANS_TYPE \n");
		sbSql.append("			  , T.TRANS_QTY \n");
		sbSql.append("			  , T.TRANS_MPRICE \n");
		sbSql.append("			  , T.TRANS_MAMOUNT \n");
		sbSql.append("			  , T.TRANS_MVAT \n");
		sbSql.append("			  , T.SALE_PRICE \n");
		sbSql.append("			  , T.SALE_AMOUNT \n");
		sbSql.append("			  , T.SALE_VAT \n");
		sbSql.append("			  , T.TAX_CODE \n");
		sbSql.append("			  , T.FLAG \n");
		sbSql.append("			  , T.DEPT_ID \n");
		sbSql.append("			  , T.CC_NM \n");
		sbSql.append("			  , T.UPJANGNM \n");
		sbSql.append("			  , T.ITEM_CLASS2 \n");
		sbSql.append("       		, CASE WHEN NVL(T.SALE_AMOUNT, 0) = 0 THEN 0 \n");
		sbSql.append("	  		  ELSE \n");
		sbSql.append("					CASE WHEN NVL(T.C_SALE_RATE, 0) = 0 THEN   \n");
		sbSql.append("						CASE WHEN NVL(T.C1_SALE_RATE, 0) = 0 THEN 0  \n");
        sbSql.append("                   		ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.C1_SALE_RATE,0) / 100)))) END	  \n");
		sbSql.append("					ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.C_SALE_RATE,0) / 100))))  \n");
		sbSql.append("					END  \n");
		sbSql.append("	  		   END AS CK_AMOUNT \n");
		sbSql.append("    		, CASE WHEN NVL(T.SALE_AMOUNT, 0) = 0 THEN 0 \n");
		sbSql.append("	  		  ELSE \n");
		sbSql.append("					CASE WHEN NVL(T.J_SALE_RATE, 0) = 0 THEN  \n");
		sbSql.append("						CASE WHEN NVL(T.J1_SALE_RATE, 0) = 0 THEN 0 \n"); 
        sbSql.append("               			ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.J1_SALE_RATE,0) / 100)))) END \n");
		sbSql.append("		  			ELSE (T.SALE_AMOUNT - ROUND(T.SALE_AMOUNT / (1 + (NVL(T.J_SALE_RATE,0) / 100)))) \n");
		sbSql.append("					END  \n");
		sbSql.append("			  END AS JI_AMOUNT \n");
		sbSql.append("		 , DECODE(NVL(T.S_SALE_RATE,0), 0, NVL(T.S1_SALE_RATE,0), 0) AS SE_RATE \n");
		sbSql.append("		FROM \n");
		sbSql.append("			( \n");
		sbSql.append("				SELECT \n");
		if (!str_in_SUB_UPJANG.equals("") || !str_in_MAIN_UPJANG.equals("")){
		sbSql.append("					   /*+ PUSH_PRED(A) */ \n");
		}
		sbSql.append("					   Z.MAIN_UPJANG	 \n");
		sbSql.append("					  , A.TRANS_UPJANG AS UPJANG \n");
		sbSql.append("					  , 	A.TRANS_DATE \n");
		sbSql.append("					  , A.ITEM_CODE \n");
		sbSql.append("					  , A.ITEM_NAME \n");
		sbSql.append("					  , A.ITEM_SIZE \n");
		sbSql.append("					  , A.TRANS_UOM \n");
		sbSql.append("					  , A.TRANS_TYPE \n");
		sbSql.append("					  , A.TRANS_QTY \n");

		// 단가구분
		if(str_in_price.equals("2")){ 
		sbSql.append("		      		  , NVL(A.UNIT_PRICE, 0) AS TRANS_MPRICE                                                                                                       \n");
		sbSql.append("		      		  , NVL(A.UNIT_AMOUNT, 0) AS TRANS_MAMOUNT                                                                                              \n");
		sbSql.append("		      		  , ROUND(DECODE(A.TAX_CODE,'100',0.1,0) * NVL(A.UNIT_AMOUNT, 0)) AS TRANS_MVAT                                        \n");
		} else {
		sbSql.append("                      , NVL(A.TRANS_MPRICE,0) AS  TRANS_MPRICE                                                                                                   \n");
		sbSql.append("                      , NVL(A.TRANS_MAMOUNT,0) AS TRANS_MAMOUNT                                                                                          \n");
		sbSql.append("                      , NVL(A.TRANS_MVAT,0) AS TRANS_MVAT                                                                                                        \n");
		}


		sbSql.append("					  , NVL(A.SALE_PRICE,0) AS SALE_PRICE \n");
		sbSql.append("					  , NVL(A.SALE_AMOUNT,0) AS SALE_AMOUNT \n");
		sbSql.append("					  , NVL(A.SALE_VAT,0) AS SALE_VAT \n");
		sbSql.append("					  , A.TAX_CODE \n");
		sbSql.append("					  , A.FLAG \n");
		sbSql.append("					  , B2.DEPT_ID \n");
		sbSql.append("					  , D.CC_NM \n");
		sbSql.append("					  , B2.UPJANGNM \n");
		sbSql.append("					  , M.ITEM_CLASS2			-- 중분류기준 \n");
		if (str_in_chk_1.equals("1")){
		sbSql.append("					  , CASE WHEN A.TAX_CODE = '100' THEN \n");
		sbSql.append("							(CASE WHEN NVL(C2.FM_SALE_RATE, 0) = 0 THEN NVL(C1.FM_SALE_RATE, 0) \n");
		sbSql.append("							ELSE NVL(C2.FM_SALE_RATE, 0) \n");
		sbSql.append("							END) \n");
		sbSql.append("						ELSE  \n");
		sbSql.append("							(CASE WHEN NVL(C2.FM_NOSALE_RATE, 0) = 0 THEN NVL(C1.FM_NOSALE_RATE, 0) \n");
		sbSql.append("							ELSE NVL(C2.FM_NOSALE_RATE, 0) \n");
		sbSql.append("							END) \n");
		sbSql.append("						END AS C1_SALE_RATE									/* 분류 기준 CK 물류비율 */	 \n");
		sbSql.append("					  , FMS_ITEM_SALE_RATE_CODE_FUN(A.TAX_CODE, A.TRANS_UPJANG, A.SUBINV_CODE, '001', A.ITEM_CODE, A.TRANS_DATE) AS C_SALE_RATE		/* 자재별 장려금 비율 */ \n");
		} else {
		sbSql.append("			      	  , 0 AS C1_SALE_RATE									/* 분류 기준 CK 물류비율 */ \n");
		sbSql.append("			      	  , 0 AS C_SALE_RATE									/* 자재 기준 CK 물류비율 */ \n");
		}
		if (str_in_chk_2.equals("1")){
		sbSql.append("					  , CASE WHEN A.TAX_CODE = '100' THEN \n");
		sbSql.append("							(CASE WHEN NVL(J2.FM_SALE_RATE, 0) = 0 THEN NVL(J1.FM_SALE_RATE, 0) \n");
		sbSql.append("							ELSE NVL(J2.FM_SALE_RATE, 0) \n");
		sbSql.append("							END) \n");
		sbSql.append("						ELSE  \n");
		sbSql.append("							(CASE WHEN NVL(J2.FM_NOSALE_RATE, 0) = 0 THEN NVL(J1.FM_NOSALE_RATE, 0) \n");
		sbSql.append("							ELSE NVL(J2.FM_NOSALE_RATE, 0) \n");
		sbSql.append("							END) \n");
		sbSql.append("						END AS J1_SALE_RATE									/* 분류 기준 지급수수료 비율 */	 \n");
		sbSql.append("					  , FMS_ITEM_SALE_RATE_CODE_FUN(A.TAX_CODE, A.TRANS_UPJANG, A.SUBINV_CODE, '002', A.ITEM_CODE, A.TRANS_DATE) AS J_SALE_RATE		/* 자재별 지급수수료 비율 */ \n");
		} else {
		sbSql.append("			      	  , 0 AS J1_SALE_RATE									/* 분류 기준 지급수수료 비율 */ \n");
		sbSql.append("			      	  , 0 AS J_SALE_RATE									/* 자재별 지급수수료 비율 */ \n");
		}
		if (str_in_chk_3.equals("1")){
		sbSql.append("					  , CASE WHEN A.TAX_CODE = '100' THEN \n");
		sbSql.append("							(CASE WHEN NVL(S2.FM_SALE_RATE, 0) = 0 THEN NVL(S1.FM_SALE_RATE, 0) \n");
		sbSql.append("							ELSE NVL(S2.FM_SALE_RATE, 0) \n");
		sbSql.append("							END) \n");
		sbSql.append("						ELSE  \n");
		sbSql.append("							(CASE WHEN NVL(S2.FM_NOSALE_RATE, 0) = 0 THEN NVL(S1.FM_NOSALE_RATE, 0) \n");
		sbSql.append("							ELSE NVL(S2.FM_NOSALE_RATE, 0) \n");
		sbSql.append("							END) \n");
		sbSql.append("						END AS S1_SALE_RATE									/* 분류 기준 장려금 비율 */	 \n");
		sbSql.append("					  , FMS_ITEM_SALE_RATE_CODE_FUN(A.TAX_CODE, A.TRANS_UPJANG, A.SUBINV_CODE, '003', A.ITEM_CODE, A.TRANS_DATE) AS S_SALE_RATE		/* 자재별 장려금 비율 */ \n");
		} else {
		sbSql.append("			      	  , 0 AS S1_SALE_RATE									/* 분류 기준 장려금 비율 */ \n");
		sbSql.append("			      	  , 0 AS S_SALE_RATE									/* 자재별 장려금 비율 */ \n");
		}
		sbSql.append("			    FROM FMS_TRANSACTION_V A \n");

				sbSql.append("    	 					    INNER JOIN ST_UPJANG B2 ON 1 = 1 \n");
					if (!str_in_SUB_UPJANG.equals("")){
						sbSql.append("															AND B2.UPJANG = " + str_in_SUB_UPJANG  + " \n");
					}
					else {
						if (!str_in_MAIN_UPJANG.equals("")){
							sbSql.append("														AND  B2.UPJANG IN (SELECT UPJANG FROM FMS_UPJANG WHERE  MAIN_UPJANG = " + str_in_MAIN_UPJANG  + ") \n");
						}
					}			
				sbSql.append("    	 					    									AND A.TRANS_UPJANG = B2.UPJANG \n");
				sbSql.append("    	 					    INNER JOIN FMS_UPJANG Z ON 1 = 1 \n");
					 if (!str_in_PART_SALES_SABUN.equals("")){
						sbSql.append("															AND Z.PART_SALES_SABUN      = '" + str_in_PART_SALES_SABUN  + "' \n");
					} 
				sbSql.append("																	AND A.TRANS_UPJANG = Z.UPJANG \n");
				sbSql.append("    	 					    INNER JOIN HLDC_SC_DEPT_V D ON 1 = 1 \n");
					if (!str_in_DEPT_ID.equals("")){
						sbSql.append("																	AND D.TM_CD               = '" + str_in_DEPT_ID  + "' \n");
					}
				sbSql.append("    	 																	AND B2.DEPT_ID = D.DEPT_ID \n");
		sbSql.append("										LEFT JOIN HLDC_PO_ITEM_MST M ON SUBSTR(M.ITEM_CODE, 1, 1) = 'F' \n");
		sbSql.append("																AND A.ITEM_CODE = M.ITEM_CODE \n");
		sbSql.append("										-- 추가 : 특약사항관련 : 중분류, 소분류 \n");
		if (str_in_chk_1.equals("1")){
		sbSql.append("										LEFT JOIN FMS_SALE_RATE C1 ON C1.UPJANG = A.TRANS_UPJANG \n");
		sbSql.append("															AND C1.SUBINV_CODE = A.SUBINV_CODE \n");
		sbSql.append("															AND C1.CASH_CODE = '001'			/* CK물류비(001) */ \n");
		sbSql.append("															AND A.TRANS_DATE BETWEEN C1.SDATE AND C1.EDATE \n");
		sbSql.append("															AND M.ITEM_CLASS3 = C1.ITEM_CLASS /* 중분류 */ \n");
		sbSql.append("										LEFT JOIN FMS_SALE_RATE C2 ON C2.UPJANG = A.TRANS_UPJANG \n");
		sbSql.append("															AND C2.SUBINV_CODE = A.SUBINV_CODE \n");
		sbSql.append("															AND C2.CASH_CODE = '001'			/* CK물류비(001) */ \n");
		sbSql.append("															AND A.TRANS_DATE BETWEEN C2.SDATE AND C2.EDATE \n");
		sbSql.append("															AND M.ITEM_CLASS4 = C2.ITEM_CLASS	/* 소분류 */ \n");
		}
		if (str_in_chk_2.equals("1")){
		sbSql.append("										LEFT JOIN FMS_SALE_RATE J1 ON J1.UPJANG = A.TRANS_UPJANG \n");
		sbSql.append("															AND J1.SUBINV_CODE = A.SUBINV_CODE \n");
		sbSql.append("															AND J1.CASH_CODE = '002'			/* 지급수수료(002) */ \n");
		sbSql.append("															AND A.TRANS_DATE BETWEEN J1.SDATE AND J1.EDATE \n");
		sbSql.append("															AND M.ITEM_CLASS3 = J1.ITEM_CLASS /* 중분류 */ \n");
		sbSql.append("										LEFT JOIN FMS_SALE_RATE J2 ON J2.UPJANG = A.TRANS_UPJANG \n");
		sbSql.append("															AND J2.SUBINV_CODE = A.SUBINV_CODE \n");
		sbSql.append("															AND J2.CASH_CODE = '002'			/* 지급수수료(002) */ \n");
		sbSql.append("															AND A.TRANS_DATE BETWEEN J2.SDATE AND J2.EDATE \n");
		sbSql.append("															AND M.ITEM_CLASS4 = J2.ITEM_CLASS	/* 소분류 */ \n");
		}
		if (str_in_chk_3.equals("1")){
		sbSql.append("										LEFT JOIN FMS_SALE_RATE S1 ON S1.UPJANG = A.TRANS_UPJANG \n");
		sbSql.append("															AND S1.SUBINV_CODE = A.SUBINV_CODE \n");
		sbSql.append("															AND S1.CASH_CODE = '003'			/* 장려금(003) */ \n");
		sbSql.append("															AND A.TRANS_DATE BETWEEN S1.SDATE AND S1.EDATE \n");
		sbSql.append("															AND M.ITEM_CLASS3 = S1.ITEM_CLASS /* 중분류 */ \n");
		sbSql.append("										LEFT JOIN FMS_SALE_RATE S2 ON S2.UPJANG = A.TRANS_UPJANG \n");
		sbSql.append("															AND S2.SUBINV_CODE = A.SUBINV_CODE \n");
		sbSql.append("															AND S2.CASH_CODE = '003'			/* 장려금(003) */ \n");
		sbSql.append("															AND A.TRANS_DATE BETWEEN S2.SDATE AND S2.EDATE \n");
		sbSql.append("															AND M.ITEM_CLASS4 = S2.ITEM_CLASS /* 소분류 */ \n");
		}
		sbSql.append("				WHERE SUBSTR(A.SUBINV_CODE, 1, 2) = 'S1' \n");
		sbSql.append("				AND (A.TRANS_TYPE IN '_002' OR A.TRANS_TYPE = 'I001' ) \n");
		sbSql.append("				AND A.TRANS_DATE2 BETWEEN '" + str_in_TRANS_DATEFR + "' AND '" + str_in_TRANS_DATETO + "' \n");
		if (!str_in_CENTER_CODE.equals("")){
			sbSql.append("            AND A.CENTER_CODE           = '" + str_in_CENTER_CODE  + "' \n"); 
		}
		sbSql.append("			) T	 \n");
		sbSql.append("		) X \n");
		sbSql.append("		GROUP BY 	  X.ITEM_CLASS2, X.ITEM_CODE, X.ITEM_NAME, X.ITEM_SIZE, X.TRANS_UOM \n");
		sbSql.append("	) RS \n");
		sbSql.append("	ORDER BY 1, 2, 3 \n");


        //out_vl.add("fa_Sql", sbSql.toString());

        //System.out.println(sbSql.toString());
		//pstmt = conn.prepareStatement(sbSql.toString());
		//rs = pstmt.executeQuery();
		
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSql.toString()); 
		
		ds_list = this.makeDataSet(rs, "ds_list");
		
		rs.close();
		stmt.close();
		
		//FileLog.println("d:\\aaa.txt", ds_list);

		/**종료**/
		out_dl.add(ds_list);
		
		
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
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
		if(stmt != null) {
			try {
				stmt.close();
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