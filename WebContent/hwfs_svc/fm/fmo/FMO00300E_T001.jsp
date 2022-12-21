<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/운영관리/급식운영관리/운영일지등록 및 출력
■ 프로그램ID   : FMO00300E_T001.jsp
■ 프로그램명   : 운영일지 조회
■ 작성일자     : 2008.05.09
■ 작성자       : 박은규
■ 이력관리     : 2008.05.09
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


		//out 데이타
		DataSet ds_Wlist;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//날씨정보조회
		sbSql.append( "SELECT A.WDESC AS WEATHER, 'NEW'||A.WCODE AS WEATHER_IMG \n"); 
	    sbSql.append( "  FROM UPOS_SC_WEATHER_INFO_V A \n");
	    sbSql.append( "	    ,(SELECT NVL(MAX(LOCAL1),'01') LOCAL1 FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + ") B \n"); 
	    sbSql.append( " WHERE A.AREA_CODE = B.LOCAL1 \n");
	    sbSql.append( "   AND A.CUR_DATE = '" + nullToBlank(ds_Cond.getString(0,"SDATE")) + "' \n");
	    
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();		
		
		ds_Wlist = this.makeDataSet(rs, "ds_Wlist");
		
		pstmt.close();
		rs.close();

		//운영일지 기존 등록여부
		String sExist;
		sbSql.delete(0, sbSql.length());
		sbSql.append( "SELECT 'OK' AS CHK \n");
		sbSql.append( "  FROM FMO_OP_DIARY \n");
		sbSql.append( " WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append( "   AND OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		if(rs.next())
			sExist = "OK";
		else
			sExist = "NO";
		pstmt.close();
		rs.close();
		
		//1)운영일지 메뉴
		//out 데이타
		DataSet ds_List;
		//sql문 버퍼RESET
		sbSql.delete(0, sbSql.length());
		//sbSql.append( "/*===1)운영일지 메뉴===*/ \n");
		if (sExist.equals("OK"))
		{
			sbSql.append( "SELECT C.UPJANG \n");
			sbSql.append( "     , C.OP_DATE \n");
			sbSql.append( "     , C.SUBINV_CODE \n");
			sbSql.append( "     , D.SUBINV_NAME_DISP \n");			
			sbSql.append( "     , C.MEAL \n");
			sbSql.append( "     , E.CODE_NAME AS MEAL_NAME \n");			
			sbSql.append( "     , C.CORNER \n");
			sbSql.append( "     , F.CODE_NAME AS CORNER_NAME \n");			
			sbSql.append( "     , C.OFFER_MENU \n");
			sbSql.append( "     , C.EXPECT_MEAL_QTY \n");
			sbSql.append( "     , C.REAL_MEAL_QTY \n");
			sbSql.append( "     , C.GOAL_COST_RATE \n");		
			sbSql.append( "     , C.MEAL_TOT \n");					
			sbSql.append( "  FROM FMO_OP_MENU C, FMS_SUBINVENTORY D, SCC_COMMON_CODE E, SCC_COMMON_CODE F \n");
			sbSql.append( " WHERE C.MEAL = E.CODE \n");
			sbSql.append( "   AND C.CORNER = F.CODE \n");			
			sbSql.append( "   AND C.SUBINV_CODE = D.SUBINV_CODE \n");			
			sbSql.append( "   AND C.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "   AND C.OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "   AND E.GROUP_CODE = 'FS0023' \n");
			sbSql.append( "   AND F.GROUP_CODE = 'FS0022' \n");			
		}
		else
		{
			sbSql.append( "SELECT A.UPJANG \n");
			sbSql.append( "     , A.MENU_DATE AS OP_DATE \n");
			sbSql.append( "     , A.SUBINV_CODE \n");
			sbSql.append( "     , D.SUBINV_NAME_DISP \n");
			sbSql.append( "     , A.MEAL \n");
			sbSql.append( "     , B.CODE_NAME AS MEAL_NAME \n");
			sbSql.append( "     , A.CORNER \n");
			sbSql.append( "     , C.CODE_NAME AS CORNER_NAME \n");
			sbSql.append( "     , FMM_RECIPENAME_FUN(A.UPJANG,A.MENU_CD,'1') OFFER_MENU \n");
			sbSql.append( "     , A.EXPECT_MEAL_QTY \n");
			sbSql.append( "     , A.EXPECT_MEAL_QTY - A.EXPECT_MEAL_QTY AS REAL_MEAL_QTY  \n");
			//sbSql.append( "     , A.EXPECT_MEAL_QTY - A.EXPECT_MEAL_QTY AS GOAL_COST_RATE  \n");
			sbSql.append( "     , A.EXPECT_MEAL_QTY - A.EXPECT_MEAL_QTY - 100 AS GOAL_COST_RATE  \n");
			sbSql.append( "     , A.EXPECT_MEAL_QTY - A.EXPECT_MEAL_QTY AS MEAL_TOT  \n");				
			sbSql.append( "  FROM FMM_MENU A, SCC_COMMON_CODE B, SCC_COMMON_CODE C, FMS_SUBINVENTORY D \n");
			sbSql.append( "     , (SELECT * FROM FMS_MEAL_CORNER WHERE USE_YN = 'Y') E \n");
			sbSql.append( " WHERE A.MEAL = B.CODE \n");
			sbSql.append( "   AND A.CORNER = C.CODE \n");
			sbSql.append( "   AND A.SUBINV_CODE = D.SUBINV_CODE \n");				
			sbSql.append( "   AND A.SUBINV_CODE = E.SUBINV_CODE \n");			
			sbSql.append( "   AND A.MEAL = E.MEAL \n");
			sbSql.append( "   AND A.CORNER = E.CORNER \n");			
			sbSql.append( "   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "   AND A.MENU_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "   AND B.GROUP_CODE = 'FS0023' \n");
			sbSql.append( "   AND C.GROUP_CODE = 'FS0022' \n");	
		}
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

		//2)운영일지
		//out 데이타
		DataSet ds_List1;
		//sql문 버퍼RESET
		sbSql.delete(0, sbSql.length());
		//sbSql.append( "/*===2)운영일지===*/ \n");
		if (sExist.equals("OK"))
		{
			sbSql.append( "SELECT '[운영일지 저장]' AS USTAT \n");
			sbSql.append( "     , A.UPJANG \n");
			sbSql.append( "     , A.OP_DATE \n");
			sbSql.append( "     , NVL(A.LEAVING_QTY,0) AS LEAVING_QTY \n");
			sbSql.append( "     , NVL(A.LEAVING_QTY,0) + NVL(A.OVER_QTY,0) AS LEAVING_SUM \n");
			sbSql.append( "     , NVL(A.OVER_QTY,0) AS OVER_QTY \n");			
			sbSql.append( "     , NVL(B.LEAVING_MM_TOT,0) AS LEAVING_MM_TOT \n");
			sbSql.append( "     , NVL(B.LEAVING_MM_TOT,0) AS LEAVING_MM_TOT_ORG \n");			
			sbSql.append( "     , A.SPECIAL_DESC \n");
			sbSql.append( "     , A.PARTNERS_DISC \n");
			sbSql.append( "     , A.REQUEST_DISC \n");			
			sbSql.append( "       ---- \n");			
			sbSql.append( "     , NVL(A.PRE_STOCK,0) AS PRE_STOCK \n");
			sbSql.append( "     , NVL(A.DD_DELIVER,0) AS DD_DELIVER \n");
			sbSql.append( "     , NVL(A.DD_USE,0) AS DD_USE \n");
			sbSql.append( "     , NVL(A.DD_STOCK,0) AS DD_STOCK \n");
			sbSql.append( "     , NVL(A.RAW_AMT,0) AS RAW_AMT \n");
			sbSql.append( "     , NVL(A.MAN_AVG_QTY,0) AS MAN_AVG_QTY \n");			
			sbSql.append( "       ---- \n");			
			sbSql.append( "     , NVL(A.SALE_PLAN_AMT,0) AS SALE_PLAN_AMT \n");
			sbSql.append( "     , NVL(A.SALE_TOT_PLAN_M,0) AS SALE_TOT_PLAN_M \n");
			sbSql.append( "     , NVL(A.SALE_ACT_AMT,0) AS SALE_ACT_AMT \n");
			sbSql.append( "     , NVL(A.SALE_TOT_ACT_M,0) AS SALE_TOT_ACT_M \n");
			sbSql.append( "     , NVL(A.GOAL_RATE,0) AS GOAL_RATE \n");			
			sbSql.append( "       ---- \n");			
			sbSql.append( "     , NVL(A.PRE_NO_RCV_AMT,0) AS PRE_NO_RCV_AMT \n");
			sbSql.append( "     , NVL(A.RCV_AMT,0) AS RCV_AMT \n");
			sbSql.append( "     , NVL(A.RCV_IN_AMT,0) AS RCV_IN_AMT \n");
			sbSql.append( "     , NVL(A.NO_RCV_AMT,0) AS NO_RCV_AMT \n");
			sbSql.append( "     , NVL(A.PREPAY_AMT,0) AS PREPAY_AMT \n");
			sbSql.append( "     , NVL(A.PREPAY_BALANCE,0) AS PREPAY_BALANCE \n");	
			sbSql.append( "     , NVL(C.DD_STOCK, 0) AS DD_STOCK_2 \n");
			sbSql.append( "  FROM FMO_OP_DIARY A \n");
			sbSql.append( "     , (SELECT UPJANG \n");
			sbSql.append( "             , ROUND(NVL(SUM(LEAVING_QTY) + SUM(OVER_QTY),0)) AS LEAVING_MM_TOT \n");
			sbSql.append( "             , ROUND(NVL(SUM(LEAVING_QTY) + SUM(OVER_QTY),0)) AS LEAVING_MM_TOT_ORG \n");		
			sbSql.append( "          FROM FMO_OP_DIARY \n");			
			sbSql.append( "         WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND OP_DATE BETWEEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "',1,6) || '01' AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "         GROUP BY UPJANG) B \n");
			sbSql.append( "     , (SELECT UPJANG, DD_STOCK FROM  FMO_OP_DIARY WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AND OP_DATE = TO_CHAR(TO_DATE('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "', 'YYYYMMDD')-1, 'YYYYMMDD')) C \n");
			sbSql.append( " WHERE A.UPJANG = B.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = C.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "   AND A.OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		}
		else
		{
			sbSql.append( "SELECT '[운영일지 미저장]' AS USTAT \n");
			sbSql.append( "     , A.UPJANG \n");
			sbSql.append( "     , A.OP_DATE \n");
			sbSql.append( "     , D.LEAVING_MM_TOT \n");
			sbSql.append( "     , D.LEAVING_MM_TOT_ORG \n");		
			sbSql.append( "     , D.LEAVING_QTY \n");
			sbSql.append( "     , D.OVER_QTY \n");
			sbSql.append( "     , D.LEAVING_SUM \n");
			sbSql.append( "     , D.SPECIAL_DESC \n");
			sbSql.append( "     , D.PARTNERS_DISC \n");
			sbSql.append( "     , D.REQUEST_DISC \n");						
			sbSql.append( "       ---- \n");			
			sbSql.append( "     , B.PRE_STOCK \n");
			sbSql.append( "     , B.DD_DELIVER \n");
			sbSql.append( "     , B.DD_USE \n");
			//sbSql.append( "     , B.DD_STOCK \n");
			sbSql.append( "     , B.PRE_STOCK + B.DD_DELIVER - B.DD_USE AS DD_STOCK \n");
			sbSql.append( "     , DECODE(NVL(C.OCCUR_AMT,0),0,0,ROUND(NVL(B.DD_USE,0) / NVL(C.OCCUR_AMT,0) * 100)) AS RAW_AMT \n");
			sbSql.append( "     , 0 AS MAN_AVG_QTY \n");
			sbSql.append( "       ---- \n");			
			sbSql.append( "     , C.OCCUR_AMT AS SALE_ACT_AMT \n");
			sbSql.append( "     , F.SALE_TOT_ACT_M \n");
			sbSql.append( "     , E.EXP_AMT AS SALE_PLAN_AMT \n");
			sbSql.append( "     , G.SALE_TOT_PLAN_M \n");
			sbSql.append( "     , DECODE(NVL(G.SALE_TOT_PLAN_M,0),0,100,ROUND(NVL(F.SALE_TOT_ACT_M,0) / NVL(G.SALE_TOT_PLAN_M,0) * 100)) AS GOAL_RATE \n");
			sbSql.append( "       ---- \n");			
			sbSql.append( "     , NVL(H.전일외매,0) - NVL(I.전일입금,0) AS PRE_NO_RCV_AMT \n");
			sbSql.append( "     , C.RCV_AMT \n");
			sbSql.append( "     , J.RCV_IN_AMT \n");
			sbSql.append( "     , NVL(H.전일외매,0) - NVL(I.전일입금,0) - NVL(J.RCV_IN_AMT,0) AS NO_RCV_AMT \n");
			sbSql.append( "     , K.PREPAY_AMT \n");
			sbSql.append( "     , K.PREPAY_BALANCE AS PREPAY_BALANCE\n");		
			sbSql.append( "  FROM (SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append( "             , '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' AS OP_DATE \n");
			sbSql.append( "          FROM DUAL) A \n");
			sbSql.append( "        /* 당일수불내용 */ \n");
			
			sbSql.append( "     ,(SELECT	B.UPJANG AS UPJANG		\n");
			sbSql.append("                , SUM(ROUND(B.FROM_QTY * B.OP_PRICE)) AS PRE_STOCK \n");
			sbSql.append("                , SUM(ROUND(B.IN_QTY * B.OP_PRICE)) AS DD_DELIVER \n");
			sbSql.append("                , SUM(ROUND(B.OUT_QTY * B.OP_PRICE)) AS DD_USE \n");
			sbSql.append("                , SUM(ROUND(B.TO_QTY * B.OP_PRICE)) AS DD_STOCK \n");
			sbSql.append( "     	FROM	(	\n");
			sbSql.append( "     				SELECT	A.UPJANG		\n");
			sbSql.append( "     					  , A.FROM_QTY		\n");
			sbSql.append( "     					  , A.IN_QTY		\n");
			sbSql.append( "     					  , A.OUT_QTY		\n");
			sbSql.append( "     					  , A.TO_QTY		\n");			
			sbSql.append("                            , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL 	\n");											
            sbSql.append("                              THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.PRICE + (A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n"); 
            sbSql.append("                              WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
            sbSql.append("                              THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.PRICE + (A.PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n"); 
       		sbSql.append("                              ELSE A.OPPRICE END AS OP_PRICE --운영단가  \n");
			sbSql.append( "          			  FROM 	FMP_SUBUL A \n");
			sbSql.append( "     					  , ( \n");   
			sbSql.append( "     					  		SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG  \n");
			sbSql.append( "     					  		  FROM FMU_OP_RATE \n");
			sbSql.append( "     					  		 WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "     					  		   AND USE_YN = 'Y' \n");
			sbSql.append( "     					  		   AND ITEM_TYPE = 'M' \n");
			sbSql.append( "     					  	) C \n");
			sbSql.append( "     					  , ( \n");        
			sbSql.append( "									SELECT ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE, UPJANG \n");
			sbSql.append( "									  FROM FMU_OP_RATE \n");
			sbSql.append( "									 WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "									   AND USE_YN = 'Y' \n");
			sbSql.append( "									   AND ITEM_TYPE = 'C' \n");
			sbSql.append( "							    ) D \n");
			sbSql.append( "                      WHERE A.UPJANG = C.UPJANG(+) \n");
			sbSql.append( "                        AND A.UPJANG = D.UPJANG(+) \n");
			sbSql.append( "                        AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			sbSql.append( "                        AND A.SDATE BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
			sbSql.append( "           			   AND A.ITEM_CODE =  C.ITEM_CODE(+) \n");
			sbSql.append( "           			   AND A.ITEM_CODE =  D.ITEM_CODE(+) \n");
			sbSql.append( "                        AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "                        AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "                        GROUP BY A.UPJANG	, A.FROM_QTY, A.IN_QTY, A.OUT_QTY, A.TO_QTY, C.OP_PRICE, C.OP_RATE, A.PRICE, A.OPPRICE, C.CEIL_VAL, D.OP_PRICE, D.OP_RATE, D.CEIL_VAL \n");
			sbSql.append( "                      	\n");
			sbSql.append( "     		    ) B GROUP BY B.UPJANG  \n");
			sbSql.append( "        ) B   \n");
			//sbSql.append( "     , (SELECT A.UPJANG \n");
			//sbSql.append("              , SUM(ROUND(A.FROM_QTY * DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE))) AS PRE_STOCK \n");
			//sbSql.append("              , SUM(ROUND(A.IN_QTY * DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE))) AS DD_DELIVER \n");
			//sbSql.append("              , SUM(ROUND(A.OUT_QTY * DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE))) AS DD_USE \n");
			//sbSql.append("              , SUM(ROUND(A.TO_QTY * DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.PRICE + ROUND(A.PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE))) AS DD_STOCK \n");
			//sbSql.append( "          FROM FMP_SUBUL A, FMU_OP_RATE C \n");
			//sbSql.append( "         WHERE A.UPJANG = C.UPJANG(+) \n");
			//sbSql.append( "           AND A.SDATE BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
			//sbSql.append( "           AND A.ITEM_CODE =  C.ITEM_CODE(+) \n");
			//sbSql.append( "           AND A.ITEM_CODE BETWEEN C.ITEM_CODE(+) AND C.ITEM_CODE(+)||'9999' \n");
			//sbSql.append( "           AND C.USE_YN(+) = 'Y' \n");
			//sbSql.append( "           AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			//sbSql.append( "           AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			//sbSql.append( "         GROUP BY A.UPJANG	\n");
			//sbSql.append( "         ) B \n");
			
			
			sbSql.append( "        /* 당일매출실적/수금 */ \n");
			sbSql.append( "     , (SELECT A.UPJANG \n");
			sbSql.append( "             , SUM(A.OCCUR_AMT) AS OCCUR_AMT \n");
			sbSql.append( "             , SUM(DECODE(NVL(B.SET1,'N'),'N',A.OCCUR_AMT)) AS RCV_AMT \n");
			sbSql.append( "          FROM FMO_ACCT_OCCUR A \n");
			sbSql.append( "             , (SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = '매출유형') B \n");
			sbSql.append( "         WHERE A.SALE_TYPE = B.CODE \n");
			sbSql.append( "           AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND A.OCCUR_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "         GROUP BY A.UPJANG) C \n");
			sbSql.append( "        /* 잔반잔식월누계 */ \n");
			sbSql.append( "     , (SELECT UPJANG \n");
			sbSql.append( "             , ROUND(NVL(SUM(LEAVING_QTY) + SUM(OVER_QTY),0)) AS LEAVING_MM_TOT \n");
			sbSql.append( "             , ROUND(NVL(SUM(LEAVING_QTY) + SUM(OVER_QTY),0)) AS LEAVING_MM_TOT_ORG \n");		
			sbSql.append( "             , 0 AS LEAVING_QTY \n");
			sbSql.append( "             , 0 AS OVER_QTY \n");
			sbSql.append( "             , 0 AS LEAVING_SUM \n");
			sbSql.append( "             , '' AS SPECIAL_DESC \n");
			sbSql.append( "             , '' AS PARTNERS_DISC \n");
			sbSql.append( "             , '' AS REQUEST_DISC \n");						
			sbSql.append( "          FROM FMO_OP_DIARY \n");			
			sbSql.append( "         WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND OP_DATE BETWEEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "',1,6) || '01' AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "         GROUP BY UPJANG) D \n");
			sbSql.append( "        /* 당일매출계획 */ \n");
			sbSql.append( "     , (SELECT UPJANG \n");
			sbSql.append( "             , SUM(EXP_AMT) AS EXP_AMT \n");
			sbSql.append( "          FROM FMO_MONTH_PLAN_DTL \n");
			sbSql.append( "         WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND YYMM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "',1,6) \n");
			sbSql.append( "           AND DD = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "',7) \n");
			sbSql.append( "         GROUP BY UPJANG) E \n");
			sbSql.append( "        /* 당월매출실적 */ \n");
			sbSql.append( "     , (SELECT UPJANG \n");
			sbSql.append( "             , SUM(OCCUR_AMT) AS SALE_TOT_ACT_M \n");
			sbSql.append( "          FROM FMO_ACCT_OCCUR \n");
			sbSql.append( "         WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND OCCUR_DATE BETWEEN SUBSTR('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "',1,6) || '01' AND '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "         GROUP BY UPJANG) F \n");
			sbSql.append( "        /* 당월매출계획 */ \n");
			sbSql.append( "     , (SELECT UPJANG \n");
			sbSql.append( "             , SUM(EXP_AMT) AS SALE_TOT_PLAN_M \n");
			sbSql.append( "          FROM FMO_MONTH_PLAN_DTL \n");
			sbSql.append( "         WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND YYMM = SUBSTR('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "',1,6) \n");
			sbSql.append( "           AND DD <= SUBSTR('" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "',7) \n");
			sbSql.append( "         GROUP BY UPJANG) G \n");
			sbSql.append( "        /* 전일외매 */ \n");
			sbSql.append( "     , (SELECT A.UPJANG \n");
			sbSql.append( "             , SUM(A.OCCUR_AMT) AS 전일외매 \n");
			sbSql.append( "          FROM FMO_ACCT_OCCUR A \n");
			sbSql.append( "             , (SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = '매출유형') B \n");
			sbSql.append( "         WHERE A.SALE_TYPE = B.CODE \n");
			sbSql.append( "           AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND A.OCCUR_DATE < '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "           AND B.SET1 = 'Y' \n");
			sbSql.append( "         GROUP BY UPJANG) H \n");
			sbSql.append( "        /* 전일입금 */ \n");
			sbSql.append( "     , (SELECT A.UPJANG \n");
			sbSql.append( "             , SUM(A.RCV_AMT) AS 전일입금 \n");
			sbSql.append( "          FROM FMO_RCV A \n");
			sbSql.append( "             , (SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = '입금유형') B \n");
			sbSql.append( "         WHERE A.RCV_TYPE = B.CODE \n");
			sbSql.append( "           AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND A.RCV_DATE < '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "           AND B.SET1 = 'Y' \n");
			sbSql.append( "         GROUP BY UPJANG) I \n");
			sbSql.append( "        /* 당일입금 */ \n");
			sbSql.append( "     , (SELECT A.UPJANG \n");
			sbSql.append( "             , SUM(A.RCV_AMT) AS RCV_IN_AMT \n");
			sbSql.append( "          FROM FMO_RCV A \n");
			sbSql.append( "             , (SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = '입금유형') B \n");
			sbSql.append( "         WHERE A.RCV_TYPE = B.CODE \n");
			sbSql.append( "           AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
			sbSql.append( "           AND A.RCV_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
			sbSql.append( "           AND B.SET1 = 'Y' \n");
			sbSql.append( "         GROUP BY A.UPJANG) J \n");
	        
			sbSql.append( "     , (SELECT " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " AS UPJANG \n");
			sbSql.append( "             , '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' AS OP_DATE \n");
			sbSql.append("              , SUM(OCCUR_AMT) AS PREPAY_AMT, SUM(ADV_AMT)-SUM(TOT_AMT) AS PREPAY_BALANCE   \n");
	        sbSql.append("           FROM (                                                      \n");
	        sbSql.append("                 SELECT SUM(OCCUR_AMT) AS OCCUR_AMT, 0 AS ADV_AMT, 0 AS TOT_AMT      \n");
	        sbSql.append("                   FROM FMO_ACCT_OCCUR                                 \n");
	        sbSql.append("                  WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
	        sbSql.append("                    AND OCCUR_DATE LIKE '" + nullToBlank(ds_Cond.getString(0, "SDATE").substring(0, 6)) + "%' \n");
	        sbSql.append("                    AND ADV_YN = 'Y'                                   \n");
	        sbSql.append("                  UNION ALL                                            \n");
	        sbSql.append("                 SELECT 0 AS OCCUR_AMT, 0 AS ADV_AMT, SUM(OCCUR_AMT) AS TOT_AMT      \n");
	        sbSql.append("                   FROM FMO_ACCT_OCCUR                                 \n");
	        sbSql.append("                  WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
	        sbSql.append("                    AND OCCUR_DATE <= '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
	        sbSql.append("                    AND ADV_YN = 'Y'                                   \n");
	        sbSql.append("                  UNION ALL                                            \n");
	        sbSql.append("                 SELECT 0 AS OCCUR_AMT, SUM(DECODE(ADV_KIND,'회수',ADV_AMOUNT*-1,ADV_AMOUNT)) AS ADV_AMT, 0 AS TOT_AMT     \n");
	        sbSql.append("                   FROM FMO_ADVANCE                                    \n");
	        sbSql.append("                  WHERE UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
	        sbSql.append("                    AND ADV_DATE <= '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "'   \n");
	        sbSql.append("                )) K                                                      \n");
	        
			sbSql.append( " WHERE A.UPJANG = B.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = C.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = D.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = E.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = F.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = G.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = H.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = I.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = J.UPJANG(+) \n");
			sbSql.append( "   AND A.UPJANG = K.UPJANG(+) \n");
		}
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List1 = this.makeDataSet(rs, "ds_List1");
		
		pstmt.close();
		rs.close();

		//3)모니터링
		//out 데이타
		DataSet ds_List3;
		//sql문 버퍼RESET
		sbSql.delete(0, sbSql.length());
		//sbSql.append( "/*===3)모니터링===*/ \n");
		sbSql.append( "SELECT A.UPJANG \n");
		sbSql.append( "     , A.OP_DATE \n");
		sbSql.append( "     , A.SEQ \n");
		sbSql.append( "     , B.CODE_NAME \n");			
		sbSql.append( "     , A.MEAL \n");
		sbSql.append( "     , A.GUBUN \n");
		sbSql.append( "     , A.CLASS \n");
		sbSql.append( "     , A.CONTENTS \n");
		sbSql.append( "     , A.MGMT_DISC \n");			
		sbSql.append( "  FROM FMO_OP_MONITORING A \n");
		sbSql.append( "     ,(SELECT * FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') B \n");
		sbSql.append( " WHERE A.MEAL = B.CODE \n");			
		sbSql.append( "   AND A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append( "   AND A.OP_DATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List3 = this.makeDataSet(rs, "ds_List3");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_Wlist);
		out_dl.add(ds_List);
		out_dl.add(ds_List1);
		out_dl.add(ds_List3);
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
