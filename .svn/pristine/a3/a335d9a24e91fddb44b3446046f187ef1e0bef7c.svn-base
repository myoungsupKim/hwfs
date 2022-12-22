<%@page import="com.sz.util.AppDataUtility"%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));			
				
		String UPJANG 			= in_vl.getString("UPJANG");		
		String MENU_DATE 		= in_vl.getString("MENU_DATE");
		String SUBINV_CODE 		= in_vl.getString("SUBINV_CODE");
		String MEAL				= in_vl.getString("MEAL");
		String CORNER			= in_vl.getString("CORNER");
		String MENU_CD			= in_vl.getString("MENU_CD");
		
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		
		sbSql.append(" SELECT A.UPJANG \n");
		sbSql.append(" 	     ,A.MENU_CD \n");
		sbSql.append(" 	     ,A.RECIPE_TYPE \n");
		sbSql.append(" 	     ,A.CUISINE_TYPE \n");
		sbSql.append(" 	     ,A.RECIPE_CD \n");
		sbSql.append(" 	     ,A.RECIPE_NAME \n");
		sbSql.append(" 	     ,A.DISUSE_RATE \n");
		sbSql.append(" 	     ,A.ITEM_CODE \n");
		sbSql.append(" 	     ,A.ITEM_SEQ \n");
		sbSql.append(" 	     ,A.PHF \n");
		sbSql.append(" 	     ,A.FEATURE_NAME \n");
		sbSql.append(" 	     ,A.ITEM_NAME \n");
		sbSql.append(" 	     ,A.ITEM_SIZE \n");
		sbSql.append(" 	     ,A.PO_UOM \n");
		sbSql.append(" 	     ,A.OTCUSTCD \n");
		sbSql.append(" 	     ,NVL(A.EDIBLE_QTY,0) EDIBLE_QTY \n");
		sbSql.append(" 	     ,A.CUT_SPEC \n");
		sbSql.append(" 	     ,NVL(A.NEED_QTY,0) NEED_QTY, A.PR_QTY \n");
		sbSql.append(" 	     ,A.EXPECT_MEAL_QTY \n");
		sbSql.append(" 	     ,ROUND(A.NEED_QTY*A.EXPECT_MEAL_QTY/1000,2) TOT_QTY \n");
		sbSql.append(" 	     ,A.OP_PRICE \n");
		sbSql.append(" 	     ,A.ORDER_YN \n");
		sbSql.append(" 	     ,NVL(A.PR_ID,0) AS PR_ID \n");
		sbSql.append(" 	     ,A.SALE_PRICE \n");
		sbSql.append("       --,A.SALE_PRICE AS UNIT_PRICE \n");
		sbSql.append(" 	     ,A.UNIT_PRICE \n");		
		sbSql.append(" 	     ,A.G_ITEM_PRICE \n");
		sbSql.append(" 	     ,A.OP_RATE \n");
		sbSql.append(" 	     ,A.NEED_DATE \n");
		sbSql.append(" 	     ,A.ORD_EXP_YN \n");
		sbSql.append(" 	     ,NVL(LENGTH(DECODE(B.MON,'Y','Y','') || DECODE(B.TUE,'Y','Y','') || DECODE(B.WED,'Y','Y','') || DECODE(B.THU,'Y','Y','') || DECODE(B.FRI,'Y','Y','') || DECODE(B.SAT,'Y','Y','') || DECODE(B.SUN,'Y','Y','')),0) WEEK_CHK \n");
		sbSql.append(" 	     ,TRIM(DECODE(B.MON,'Y','월 ')||DECODE(B.TUE,'Y','화 ')||DECODE(B.WED,'Y','수 ')||DECODE(B.THU,'Y','목 ')||DECODE(B.FRI,'Y','금 ')||DECODE(B.SAT,'Y','토 ')||DECODE(B.SUN,'Y','일')) AS WEEK_DISP \n");     //--CSR NUM : 25577		        
		sbSql.append(" 	     ,B.MON \n");
		sbSql.append(" 	     ,B.TUE \n");
		sbSql.append(" 	     ,B.WED \n");
		sbSql.append(" 	     ,B.THU \n");
		sbSql.append(" 	     ,B.FRI \n");
		sbSql.append(" 	     ,B.SAT \n");
		sbSql.append(" 	     ,B.SUN \n");
		sbSql.append(" 	     --,'D-' || DECODE(D.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(D.D_TIMES,'',24,0,24,D.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + D.D_DAYS + 1) D_DAYS \n");
		sbSql.append(" 	     --,DECODE(D.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(D.D_TIMES,'',24,0,24,D.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + D.D_DAYS + 1) D_DAY \n");
		sbSql.append(" 	     /* 구매 D_DAYS 사용(기존 +1 삭제) */ \n");
		sbSql.append(" 	     ,DECODE(A.OTCUSTCD,'0000','D-'||DECODE(D.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(D.D_TIMES,'',24,0,24,D.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + D.D_DAYS ) \n");
		sbSql.append(" 	             ,'D-'||(SELECT X.D_DAYS + 1 FROM FMP_OTCUST_ITEM X WHERE X.ITEM_CODE = A.ITEM_CODE)) D_DAYS \n");
		sbSql.append(" 	     ,A.CUSTCD \n");
		sbSql.append(" 	     ,A.CENTER_CODE \n");
// 		sbSql.append(" 	     ,G.IMG_PATH AS IMAGE_PATH \n");
		sbSql.append(" 	     ,'' AS IMAGE_PATH \n");
		sbSql.append(" 	     ,G.MIN_ORD_QTY \n");
		sbSql.append(" 	     ,G.POINT_FLAG \n");
		sbSql.append(" 	     ,DECODE(FMS_ISHOLIDAY_FUN(A.NEED_DATE), '', 'N', 'Y') AS DAY_COLOR \n");
		sbSql.append(" 	     ,A.ORIGIN_TYPE \n");
		sbSql.append(" 	     ,A.ITEM_CLASS2 \n");
		sbSql.append(" 	     ,A.ITEM_CLASS3 \n");
		sbSql.append(" 	     ,A.ITEM_CLASS4 \n");
		sbSql.append("   FROM ( \n");
		sbSql.append("         SELECT B.RECIPE_TYPE, \n");
		sbSql.append("                B.CUISINE_TYPE, \n");
		sbSql.append("                A.MENU_CD, \n");
		sbSql.append("                B.RECIPE_CD, \n");
		sbSql.append("                B.RECIPE_NAME, \n");
		sbSql.append("                DECODE(C.ATTR01,'Y','1','0') AS ORD_EXP_YN, \n");
		sbSql.append("                C.ITEM_CODE, \n");
		//sbSql.append("                D.FEATURE_NAME, \n");
		sbSql.append("	    		  FMS_ITEM_FEATURE_FUN("+UPJANG+", TO_CHAR(SYSDATE, 'YYYYMMDD'), C.ITEM_CODE, 'N') AS FEATURE_NAME, --자재특성 \n");
		sbSql.append("                C.EDIBLE_QTY, \n");
		sbSql.append("                C.CUT_SPEC, \n");
		sbSql.append("                C.NEED_QTY, C.PR_QTY, \n");
		sbSql.append("                C.ITEM_SEQ, \n");
		sbSql.append("                F.ITEM_NAME, \n");
		sbSql.append("                F.ITEM_SIZE, \n");
		sbSql.append("                F.PO_UOM, \n");		
		sbSql.append("                F.OTCUSTCD, \n");
		sbSql.append("                F.ORIGIN_TYPE, \n");
		sbSql.append("                F.ITEM_CLASS2, \n");
		sbSql.append("                F.ITEM_CLASS3, \n");
		sbSql.append("                F.ITEM_CLASS4, \n");
		sbSql.append("                B.PHF, \n");
		sbSql.append("                A.EXPECT_MEAL_QTY, \n");
		sbSql.append("                NVL(C.PR_YN,'N') ORDER_YN, \n");
		sbSql.append("                C.PR_ID, \n");
		sbSql.append("                C.NEED_DATE, \n");
		sbSql.append("                A.UPJANG, \n");
		sbSql.append("                NVL(C.OP_RATE,0) OP_RATE, \n");
		sbSql.append("                E.DISUSE_RATE, \n");
		sbSql.append("                H.CENTER_CODE, \n");
		sbSql.append("                (SELECT MAX(CUSTCD) FROM HLDC_PO_CONTRACT_FSALE X WHERE X.UPJANG = G.AP_UNITPRICE_UPJANG AND X.ITEM_CODE = C.ITEM_CODE) AS CUSTCD, \n");
		sbSql.append("               -- NVL(C.UNIT_PRICE,0) SALE_PRICE, \n");
		sbSql.append("                NVL(C.UNIT_PRICE,0) UNIT_PRICE, \n");		
		sbSql.append("                DECODE(NVL(C.OP_RATE,0),0,NVL(C.UNIT_PRICE,0),OP_PRICE) SALE_PRICE, \n");		
		sbSql.append("               -- DECODE(NVL(F.KG_CONVERT_RATE,0),0,0, ROUND(C.NEED_QTY * (NVL(C.UNIT_PRICE,0) / F.KG_CONVERT_RATE / 1000) )) OP_PRICE, \n");
		sbSql.append("                DECODE(NVL(F.KG_CONVERT_RATE,0),0,0, ROUND(C.NEED_QTY * (DECODE(NVL(C.OP_RATE,0),0,NVL(C.UNIT_PRICE,0),OP_PRICE) / F.KG_CONVERT_RATE / 1000) )) OP_PRICE, \n");		
		sbSql.append("               -- ROUND(NVL(C.UNIT_PRICE,0) / F.KG_CONVERT_RATE / 1000,2) AS G_ITEM_PRICE \n");
		sbSql.append("                DECODE(NVL(C.OP_RATE,0),0,ROUND(NVL(C.UNIT_PRICE,0) / F.KG_CONVERT_RATE / 1000,2),ROUND(NVL(C.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000,2)) AS G_ITEM_PRICE \n");		
		sbSql.append("           FROM FMM_MENU A, FMM_RECIPE B, FMM_RECIPE_ITEM C, FMS_ITEM_V F, \n");
// 		sbSql.append("                ( \n");
// 		sbSql.append("                SELECT ITEM_CODE, \n");
// 		sbSql.append("                       ( \n");
// 		sbSql.append("                       SELECT CODE_NAME \n");
// 		sbSql.append("                         FROM SCC_COMMON_CODE \n");
// 		sbSql.append("                        WHERE GROUP_CODE = 'FS0033' \n");
// 		sbSql.append("                          AND CODE = ITEM_FEATURE \n");
// 		sbSql.append("                       ) AS FEATURE_NAME \n");
// 		sbSql.append("                  FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("                 WHERE (ITEM_CODE, CDATE) IN \n");
// 		sbSql.append("                       ( \n");
// 		sbSql.append("                       SELECT ITEM_CODE, MAX(CDATE) AS CDATE \n");
// 		sbSql.append("                         FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("                        WHERE (1=1) \n");
// 		sbSql.append("                          AND (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN \n");
// 		sbSql.append("                              ( \n");
// 		sbSql.append("                              SELECT CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
// 		sbSql.append("                                FROM FSI_ITEM_FEATURE \n");
// 		sbSql.append("                               WHERE CENTER_CODE = '300001' \n");
// 		sbSql.append("                                 AND TO_CHAR(SYSDATE,'YYYYMMDD' ) BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD' ) \n");
// 		sbSql.append("                               GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
// 		sbSql.append("                              ) \n");
// 		sbSql.append("                        GROUP BY ITEM_CODE \n");
// 		sbSql.append("                       ) \n");
// 		sbSql.append("                ) D, \n");
		sbSql.append("                ( \n");
		sbSql.append("                   SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                     FROM	FMP_ITEM_NUT \n");
		sbSql.append("                    WHERE	UPJANG = "+UPJANG+" \n");
		sbSql.append("                    UNION ALL \n");
		sbSql.append("                          ( \n");
		sbSql.append("                          SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                            FROM	FSI_ITEM_NUT \n");
		sbSql.append("                           WHERE ITEM_CODE IN \n");
		sbSql.append("                                 ( \n");
		sbSql.append("                                 SELECT ITEM_CODE \n");
		sbSql.append("                                   FROM FSI_ITEM_NUT MINUS \n");
		sbSql.append("                                 SELECT ITEM_CODE \n");
		sbSql.append("                                   FROM FMP_ITEM_NUT \n");
		sbSql.append("                                  WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                                 ) \n");
		sbSql.append("                          ) \n");
		sbSql.append("                ) E, \n");
		sbSql.append("                HLDC_ST_UPJANG G, \n");
		sbSql.append("                HLDC_PO_UPJANG_CENTER H \n");
		sbSql.append("          WHERE A.UPJANG=B.UPJANG \n");
		sbSql.append("            AND B.UPJANG=C.UPJANG \n");
		sbSql.append("            AND B.RECIPE_CD=C.RECIPE_CD \n");
		sbSql.append("            AND B.MENU_CD=C.MENU_CD \n");
		sbSql.append("            AND A.MENU_CD=B.MENU_CD \n");
// 		sbSql.append("            AND C.ITEM_CODE=D.ITEM_CODE(+) \n");
		sbSql.append("            AND C.ITEM_CODE=E.ITEM_CODE(+) \n");
		sbSql.append("            AND C.ITEM_CODE=F.ITEM_CODE \n");
		sbSql.append(" 			  AND A.UPJANG= "+UPJANG+" \n");
		sbSql.append(" 			  --AND A.UPJANG = G.AP_UNITPRICE_UPJANG \n");
		sbSql.append(" 			  AND A.UPJANG = G.UPJANG \n");		
		sbSql.append(" 			  AND G.AP_UNITPRICE_UPJANG = H.UPJANG \n");
		sbSql.append(" 			  AND A.MENU_CD='"+MENU_DATE+"'||'-'||'"+SUBINV_CODE+"'||'"+MEAL+"'||'"+CORNER+"'                                                                                                                                                                  \n");
		sbSql.append("        ) A , \n");
		sbSql.append("        ( \n");
		sbSql.append("         SELECT A.CENTER_CODE, A.CUSTCD, "+UPJANG+" AS UPJANG, A.ITEM_CODE, A.NWD_GR_YN \n"); 
	    sbSql.append("              , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n"); 
	    sbSql.append("           FROM HLDC_PO_ORDER_SCHEDULE A, HLDC_PO_UPJANG_CENTER B, HLDC_ST_UPJANG C \n"); 
	    sbSql.append("          WHERE A.CENTER_CODE = B.CENTER_CODE \n");
	    sbSql.append("            AND A.UPJANG = B.UPJANG \n");
	    sbSql.append("            AND B.UPJANG = C.AP_UNITPRICE_UPJANG \n");
	    sbSql.append("            AND C.UPJANG = "+UPJANG+" \n");
	    sbSql.append("            AND A.UPJANG_TYPE = '02' \n");
		sbSql.append("        ) B \n");
		sbSql.append("      , HLDC_PO_PREORDER_LIST D \n");
		sbSql.append("      , HLDC_PO_ITEM_MST G \n");		
		sbSql.append("  WHERE A.CENTER_CODE = B.CENTER_CODE(+) \n");
		sbSql.append("    AND A.CUSTCD = B.CUSTCD(+) \n");
		sbSql.append("    AND A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("    AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("    AND A.CENTER_CODE = D.CENTER_CODE(+) \n");
		sbSql.append("    AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append("    AND A.ITEM_CODE = G.ITEM_CODE(+) \n");		
		sbSql.append("  ORDER BY A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD, A.NEED_QTY DESC \n");
	
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_Item = this.makeDataSet(rs,"ds_Item");
		out_dl.add(ds_Item);
		rs.close();
		pstmt.close();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
						
			String UPJANG 			= in_vl.getString("UPJANG");		
			String MENU_DATE 		= in_vl.getString("MENU_DATE");
			String SUBINV_CODE 		= in_vl.getString("SUBINV_CODE");
			String MEAL				= in_vl.getString("MEAL");
			String CORNER			= in_vl.getString("CORNER");
			String MENU_CD			= in_vl.getString("MENU_CD");
		
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();

	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
	
		sbSql.delete(0, sbSql.length());
		
		
		
		sbSql.append(" SELECT	A.UPJANG          \n");
		sbSql.append(" 	,A.MENU_CD                \n");
		sbSql.append(" 	,A.RECIPE_TYPE            \n");
		sbSql.append(" 	,A.CUISINE_TYPE           \n");
		sbSql.append(" 	,A.RECIPE_CD \n");
		sbSql.append(" 	,A.RECIPE_NAME \n");
		sbSql.append(" 	,A.DISUSE_RATE \n");
		sbSql.append(" 	,A.ITEM_CODE \n");
		sbSql.append(" 	,A.ITEM_SEQ \n");
		sbSql.append(" 	,A.PHF \n");
		sbSql.append(" 	,A.FEATURE_NAME \n");
		sbSql.append(" 	,A.ITEM_NAME \n");
		sbSql.append(" 	,A.ITEM_SIZE \n");
		sbSql.append(" 	,A.PO_UOM \n");
		sbSql.append(" 	,A.OTCUSTCD \n");
		sbSql.append(" 	,nvl(A.EDIBLE_QTY,0) EDIBLE_QTY \n");
		sbSql.append(" 	,A.CUT_SPEC \n");
		sbSql.append(" 	,nvl(A.NEED_QTY,0) NEED_QTY, A.PR_QTY \n");
		sbSql.append(" 	,A.EXPECT_MEAL_QTY \n");
		sbSql.append(" 	,ROUND(A.NEED_QTY*A.EXPECT_MEAL_QTY/1000,2) TOT_QTY \n");
		sbSql.append(" 	,A.OP_PRICE \n");
		sbSql.append(" 	,A.ORDER_YN \n");
		sbSql.append(" 	,NVL(A.PR_ID,0) AS PR_ID \n");
		sbSql.append(" 	,A.SALE_PRICE \n");
		sbSql.append(" --	,A.SALE_PRICE AS UNIT_PRICE \n");
		sbSql.append(" 	,A.UNIT_PRICE \n");		
		sbSql.append(" 	,A.G_ITEM_PRICE \n");
		sbSql.append(" 	,A.OP_RATE \n");
		sbSql.append(" 	,A.NEED_DATE \n");
		sbSql.append(" 	,A.ORD_EXP_YN \n");
		sbSql.append(" 	,NVL(LENGTH(DECODE(B.MON,'Y','Y','') || DECODE(B.TUE,'Y','Y','') || DECODE(B.WED,'Y','Y','') || DECODE(B.THU,'Y','Y','') || DECODE(B.FRI,'Y','Y','') || DECODE(B.SAT,'Y','Y','') || DECODE(B.SUN,'Y','Y','')),0) WEEK_CHK \n");
		sbSql.append(" 	,TRIM(DECODE(B.MON,'Y','월 ')||DECODE(B.TUE,'Y','화 ')||DECODE(B.WED,'Y','수 ')||DECODE(B.THU,'Y','목 ')||DECODE(B.FRI,'Y','금 ')||DECODE(B.SAT,'Y','토 ')||DECODE(B.SUN,'Y','일')) AS WEEK_DISP \n");     //--CSR NUM : 25577		        
		sbSql.append(" 	,B.MON \n");
		sbSql.append(" 	,B.TUE \n");
		sbSql.append(" 	,B.WED \n");
		sbSql.append(" 	,B.THU \n");
		sbSql.append(" 	,B.FRI \n");
		sbSql.append(" 	,B.SAT \n");
		sbSql.append(" 	,B.SUN \n");
		sbSql.append(" 	--,'D-' || DECODE(D.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(D.D_TIMES,'',24,0,24,D.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + D.D_DAYS + 1) D_DAYS \n");
		sbSql.append(" 	--,DECODE(D.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(D.D_TIMES,'',24,0,24,D.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + D.D_DAYS + 1) D_DAY \n");
		sbSql.append(" 	/*공급업체면 공급업체 테이블에서 D-DAY를 가져옴, 한화 공급업체 모두 실제데이터가 1이면 보여주는건 2로 보인다.*/ \n");
		sbSql.append(" 	,DECODE(A.OTCUSTCD,'0000','D-'||DECODE(D.D_DAYS,0,1,'',1,DECODE(SIGN(DECODE(D.D_TIMES,'',24,0,24,D.D_TIMES) - TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))),1,0,1) + D.D_DAYS + 1) \n");
		sbSql.append(" 	                         ,'D-'||(SELECT X.D_DAYS + 1 FROM FMP_OTCUST_ITEM X WHERE X.ITEM_CODE = A.ITEM_CODE)) D_DAYS \n");
		sbSql.append(" 	,A.CUSTCD \n");
		sbSql.append(" 	,A.CENTER_CODE \n");
		sbSql.append(" 	,G.IMG_PATH AS IMAGE_PATH \n");
		sbSql.append(" 	,G.MIN_ORD_QTY \n");
		sbSql.append(" 	,G.POINT_FLAG \n");
		sbSql.append("   FROM ( \n");
		sbSql.append("               SELECT B.RECIPE_TYPE, \n");
		sbSql.append("                      B.CUISINE_TYPE, \n");
		sbSql.append("                      A.MENU_CD, \n");
		sbSql.append("                      B.RECIPE_CD, \n");
		sbSql.append("                      B.RECIPE_NAME, \n");
		sbSql.append("                      DECODE(C.ATTR01,'Y','1','0') AS ORD_EXP_YN, \n");
		sbSql.append("                      C.ITEM_CODE, \n");
		sbSql.append("                      D.FEATURE_NAME, \n");
		sbSql.append("                      C.EDIBLE_QTY, \n");
		sbSql.append("                      C.CUT_SPEC, \n");
		sbSql.append("                      C.NEED_QTY, C.PR_QTY, \n");
		sbSql.append("                      C.ITEM_SEQ, \n");
		sbSql.append("                      F.ITEM_NAME, \n");
		sbSql.append("                      F.ITEM_SIZE, \n");
		sbSql.append("                      F.PO_UOM, \n");		
		sbSql.append("                      F.OTCUSTCD, \n");
		sbSql.append("                      B.PHF, \n");
		sbSql.append("                      A.EXPECT_MEAL_QTY, \n");
		sbSql.append("                      NVL(NVL(C.PR_YN,'N'),'N' ) ORDER_YN, \n");
		sbSql.append("                      C.PR_ID, \n");
		sbSql.append("                      C.NEED_DATE, \n");
		sbSql.append("                      A.UPJANG, \n");
		sbSql.append("                      NVL(C.OP_RATE,0) OP_RATE, \n");
		sbSql.append("                      E.DISUSE_RATE, \n");
		sbSql.append("                      H.CENTER_CODE, \n");
		sbSql.append("                      (SELECT CUSTCD FROM HLDC_PO_TREAT_UPJANG X WHERE X.UPJANG = G.AP_UNITPRICE_UPJANG AND X.ITEM_CODE = C.ITEM_CODE) AS CUSTCD, \n");
		sbSql.append("                     -- NVL(C.UNIT_PRICE,0) SALE_PRICE, \n");
		sbSql.append("                      NVL(C.UNIT_PRICE,0) UNIT_PRICE, \n");		
		sbSql.append("                      DECODE(NVL(C.OP_RATE,0),0,NVL(C.UNIT_PRICE,0),OP_PRICE) SALE_PRICE, \n");		
		sbSql.append("                     -- DECODE(NVL(F.KG_CONVERT_RATE,0),0,0, ROUND(C.NEED_QTY * (NVL(C.UNIT_PRICE,0) / F.KG_CONVERT_RATE / 1000) )) OP_PRICE, \n");
		sbSql.append("                      DECODE(NVL(F.KG_CONVERT_RATE,0),0,0, ROUND(C.NEED_QTY * (DECODE(NVL(C.OP_RATE,0),0,NVL(C.UNIT_PRICE,0),OP_PRICE) / F.KG_CONVERT_RATE / 1000) )) OP_PRICE, \n");		
		sbSql.append("                     -- ROUND(NVL(C.UNIT_PRICE,0) / F.KG_CONVERT_RATE / 1000,2) AS G_ITEM_PRICE \n");
		sbSql.append("                      DECODE(NVL(C.OP_RATE,0),0,ROUND(NVL(C.UNIT_PRICE,0) / F.KG_CONVERT_RATE / 1000,2),ROUND(NVL(C.OP_PRICE,0) / F.KG_CONVERT_RATE / 1000,2)) AS G_ITEM_PRICE \n");		
		sbSql.append("                 FROM FMM_MENU A, FMM_RECIPE B, FMM_RECIPE_ITEM C, FMS_ITEM_V F, \n");
		sbSql.append("                      ( \n");
		sbSql.append("                      SELECT ITEM_CODE, \n");
		sbSql.append("                             ( \n");
		sbSql.append("                             SELECT CODE_NAME \n");
		sbSql.append("                               FROM SCC_COMMON_CODE \n");
		sbSql.append("                              WHERE GROUP_CODE = 'FS0033' \n");
		sbSql.append("                                AND CODE = ITEM_FEATURE \n");
		sbSql.append("                             ) AS FEATURE_NAME \n");
		sbSql.append("                        FROM FSI_ITEM_FEATURE \n");
		sbSql.append("                       WHERE (ITEM_CODE, CDATE) IN \n");
		sbSql.append("                             ( \n");
		sbSql.append("                             SELECT ITEM_CODE, MAX(CDATE) AS CDATE \n");
		sbSql.append("                               FROM FSI_ITEM_FEATURE \n");
		sbSql.append("                              WHERE (1=1) \n");
		sbSql.append("                                AND (CENTER_CODE, CUSTCD, ITEM_CODE, APPLY_DATE) IN \n");
		sbSql.append("                                    ( \n");
		sbSql.append("                                    SELECT CENTER_CODE, CUSTCD, ITEM_CODE, MAX(APPLY_DATE) AS APPLY_DATE \n");
		sbSql.append("                                      FROM FSI_ITEM_FEATURE \n");
		sbSql.append("                                     WHERE CENTER_CODE = '300001' \n");
		sbSql.append("                                       AND TO_CHAR(SYSDATE,'YYYYMMDD' ) BETWEEN APPLY_DATE AND TO_CHAR(ADD_MONTHS(TO_DATE(APPLY_DATE,'YYYYMMDD'),1)-1,'YYYYMMDD' ) \n");
		sbSql.append("                                     GROUP BY CENTER_CODE, CUSTCD, ITEM_CODE \n");
		sbSql.append("                                    ) \n");
		sbSql.append("                              GROUP BY ITEM_CODE \n");
		sbSql.append("                             ) \n");
		sbSql.append("                      ) D, \n");
		sbSql.append("                      ( \n");
		sbSql.append("                         SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                           FROM	FMP_ITEM_NUT \n");
		sbSql.append("                          WHERE	UPJANG = "+UPJANG+" \n");
		sbSql.append("                          UNION ALL \n");
		sbSql.append("                                ( \n");
		sbSql.append("                                SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                                  FROM	FSI_ITEM_NUT \n");
		sbSql.append("                                 WHERE ITEM_CODE IN \n");
		sbSql.append("                                       ( \n");
		sbSql.append("                                       SELECT ITEM_CODE \n");
		sbSql.append("                                         FROM FSI_ITEM_NUT MINUS \n");
		sbSql.append("                                       SELECT ITEM_CODE \n");
		sbSql.append("                                         FROM FMP_ITEM_NUT \n");
		sbSql.append("                                        WHERE UPJANG = "+UPJANG+" \n");
		sbSql.append("                                       ) \n");
		sbSql.append("                                ) \n");
		sbSql.append("                      ) E, \n");
		sbSql.append("                      HLDC_ST_UPJANG G, \n");
		sbSql.append("                      HLDC_PO_UPJANG_CENTER H \n");
		sbSql.append("                WHERE A.UPJANG=B.UPJANG \n");
		sbSql.append("                  AND B.UPJANG=C.UPJANG \n");
		sbSql.append("                  AND B.RECIPE_CD=C.RECIPE_CD \n");
		sbSql.append("                  AND B.MENU_CD=C.MENU_CD \n");
		sbSql.append("                  AND A.MENU_CD=B.MENU_CD \n");
		sbSql.append("                  AND C.ITEM_CODE=D.ITEM_CODE(+) \n");
		sbSql.append("                  AND C.ITEM_CODE=E.ITEM_CODE(+) \n");
		sbSql.append("                  AND C.ITEM_CODE=F.ITEM_CODE \n");
		sbSql.append(" 				 AND A.UPJANG= "+UPJANG+" \n");
		sbSql.append(" 			--	 AND A.UPJANG = G.AP_UNITPRICE_UPJANG \n");
		sbSql.append(" 				 AND A.UPJANG = G.UPJANG \n");		
		sbSql.append(" 				 AND G.AP_UNITPRICE_UPJANG = H.UPJANG \n");
		sbSql.append(" 				 AND A.MENU_CD='"+MENU_DATE+"'||'-'||'"+SUBINV_CODE+"'||'"+MEAL+"'||'"+CORNER+"'                                                                                                                                                                  \n");
		sbSql.append("        ) A , \n");
		sbSql.append("        ( \n");
		sbSql.append("              SELECT A.CENTER_CODE, A.CUSTCD, "+UPJANG+" UPJANG, A.ITEM_CODE \n");
		sbSql.append("                  , A.MON, A.TUE, A.WED, A.THU, A.FRI, A.SAT, A.SUN \n");
		sbSql.append("               FROM HLDC_PO_ORDER_SCHEDULE A \n");
		sbSql.append("                  ,(SELECT CENTER_CODE, CUSTCD, MAX(UPJANG) AS UPJANG \n");
		sbSql.append("                      FROM HLDC_PO_ORDER_SCHEDULE \n");
		sbSql.append("                     WHERE CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = "+UPJANG+") \n");
		sbSql.append("                       AND UPJANG IN (-2,(SELECT AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG WHERE UPJANG = "+UPJANG+")) \n");
		sbSql.append("                     GROUP BY CENTER_CODE, CUSTCD) B \n");
		sbSql.append("              WHERE A.CENTER_CODE = B.CENTER_CODE \n");
		sbSql.append("                AND A.CUSTCD = B.CUSTCD \n");
		sbSql.append("                AND A.UPJANG = B.UPJANG \n");
		sbSql.append("        ) B \n");
		sbSql.append("      , HLDC_PO_PREORDER_LIST D \n");
		sbSql.append("      , HLDC_PO_ITEM_MST G \n");		
		sbSql.append("  WHERE A.CENTER_CODE = B.CENTER_CODE(+) \n");
		sbSql.append("    AND A.CUSTCD = B.CUSTCD(+) \n");
		sbSql.append("    AND A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("    AND A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("    AND A.CENTER_CODE = D.CENTER_CODE(+) \n");
		sbSql.append("    AND A.ITEM_CODE = D.ITEM_CODE(+) \n");
		sbSql.append("    AND A.ITEM_CODE = G.ITEM_CODE(+) \n");		
		sbSql.append("  ORDER BY A.RECIPE_TYPE, A.CUISINE_TYPE, A.RECIPE_CD, A.NEED_QTY DESC \n");
	
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_Item = this.makeDataSet(rs,"ds_Item");
		out_dl.add(ds_Item);
		rs.close();
		pstmt.close();
	   	this.setResultMessage(0, "OK",out_vl);
	} catch(Exception ex) {
		//ex.printStackTrace();
		//jsp 로그남기기
		logger.debug(ex.getMessage(), ex);
		this.setResultMessage(-1, ex.toString(),out_vl);
		} finally {
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