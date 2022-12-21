<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/현황관리
■ 프로그램ID   : FMM00240V_T002.jsp
■ 프로그램명   : 영양성분 분석표(하단상세)
■ 작성일자     : 2008-04-08
■ 작성자       : 박은규
■ 이력관리     : 2008-04-08 - 최초작성
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
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String sItemFlag = nullToBlank(ds_cond.getString(0,"ITEM_FLAG"));
		String sRateFlag = nullToBlank(ds_cond.getString(0,"RATE_FLAG"));
		String strNeedQty= ""; // 폐기율 적용과 미적용했을경우 Round함수에 들어갈 컬럼 담기

		//if(sItemFlag.equals("1"))
			//System.out.println("#### 상품별 영양조회 시작 ####");
		//else
			//System.out.println("#### 레시피별 영양조회 시작 ####");
		if(sRateFlag.equals("1"))
		{
			strNeedQty = "EDIBLE_QTY";
		//	System.out.println("#### 폐기율 적용 했음 ####");
		}
		else
		{
			strNeedQty = "NEED_QTY";
		//	System.out.println("#### 폐기율 미적용 ####");
		}
		//내역조회
		sbSql.append("SELECT A.UPJANG, A.SUBINV_CODE \n");
		sbSql.append("     , TO_CHAR(TO_DATE(A.MENU_DATE,'YYYYMMDD'),'YYYY\"년\"MM\"월\"DD\"일\"') AS MENU_DATE \n");
		sbSql.append("     , A.MEAL, A.CORNER, A.RECIPE_CD, A.RECIPE_NAME \n");
		sbSql.append("     ,(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0023' AND X.CODE = A.MEAL) \n");
		sbSql.append("      ||(SELECT CODE_NAME FROM SCC_COMMON_CODE X WHERE X.GROUP_CODE = 'FS0022' AND X.CODE = A.CORNER) AS MEAL_CORNER \n");
		if(sItemFlag.equals("1"))
			sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME, A.EDIBLE_QTY, NVL(B.DISUSE_RATE,0) AS DISUSE_RATE \n");
		//sbSql.append("     , SUM(A." + strNeedQty + ") AS NEED_QTY \n");
		sbSql.append("     , SUM(A.NEED_QTY) AS NEED_QTY \n");
		sbSql.append("     , ROUND(SUM(NVL(A." + strNeedQty + ",0)*A.G_ITEM_PRICE)) AS ITEM_COST \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.CAL,0),NVL(B.CAL,0))*A." + strNeedQty + ")/100,2) CAL		-- 열량 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.WATER,0),NVL(B.WATER,0))*A." + strNeedQty + ")/100,2) WATER	-- 수분 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.PROT,0),NVL(B.PROT,0))*A." + strNeedQty + ")/100,2) PROT		-- 단백질 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.FAT,0),NVL(B.FAT,0))*A." + strNeedQty + ")/100,2) FAT		-- 지방 (지질) \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.CARBO,0),NVL(B.CARBO,0))*A." + strNeedQty + ")/100,2) CARBO	-- 탄수화물(당질) \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.FIBER,0),NVL(B.FIBER,0))*A." + strNeedQty + ")/100,2) FIBER	-- 섬유 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.ASH,0),NVL(B.ASH,0))*A." + strNeedQty + ")/100,2) ASH		-- 회분 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.CA,0),NVL(B.CA,0))*A." + strNeedQty + ")/100,2) CA		-- 칼슘 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.P,0),NVL(B.P,0))*A." + strNeedQty + ")/100,2) P		-- 인분 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.FE,0),NVL(B.FE,0))*A." + strNeedQty + ")/100,2) FE		-- 철분 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.NA,0),NVL(B.NA,0))*A." + strNeedQty + ")/100,2) NA		-- 나트륨 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.K,0),NVL(B.K,0))*A." + strNeedQty + ")/100,2) K		-- 칼륨 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.VITA_A,0),NVL(B.VITA_A,0))*A." + strNeedQty + ")/100,2) VITA_A	-- 비타민A \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.RETIN,0),NVL(B.RETIN,0))*A." + strNeedQty + ")/100,2) RETIN	-- 레티놀 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.B_CAROT,0),NVL(B.B_CAROT,0))*A." + strNeedQty + ")/100,2) B_CAROT	-- 베타카로틴 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.THIA,0),NVL(B.THIA,0))*A." + strNeedQty + ")/100,2) THIA		-- 티아민(비타민b1) \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.RIBO,0),NVL(B.RIBO,0))*A." + strNeedQty + ")/100,2) RIBO		-- 리보플라빈(비타민B2) \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.NIACIN,0),NVL(B.NIACIN,0))*A." + strNeedQty + ")/100,2) NIACIN	-- 나이아아신 \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.VITA_C,0),NVL(B.VITA_C,0))*A." + strNeedQty + ")/100,2) VITA_C	-- 비타민C \n");
		sbSql.append("     , ROUND(SUM(DECODE(B.ITEM_CODE,NULL,NVL(C.CHOLE,0),NVL(B.CHOLE,0))*A." + strNeedQty + ")/100,2) CHOLE	-- 콜레스테롤 \n");
		sbSql.append("  FROM \n");
		sbSql.append("      (SELECT A.UPJANG, A.SUBINV_CODE, A.MENU_DATE \n");
		sbSql.append("            , A.MEAL, A.CORNER \n");
		sbSql.append("            , B.RECIPE_CD, B.RECIPE_NAME, C.ITEM_CODE, D.ITEM_NAME \n");
		sbSql.append("            , D.ORI_ITEM_CODE \n");
		//sbSql.append("            , DECODE(D.OTCUSTCD,'0000',D.ITEM_CODE, \n");
		//sbSql.append("                DECODE((SELECT 1 FROM FMP_ITEM_NUT Z WHERE Z.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + ") \n");
		//sbSql.append("                                                       AND Z.ITEM_CODE = D.ITEM_CODE AND ROWNUM = 1),1,D.ITEM_CODE,D.ORI_ITEM_CODE)) AS ORI_ITEM_CODE \n");
		sbSql.append("            , C.EDIBLE_QTY, C.NEED_QTY \n");
		sbSql.append("            , ROUND(NVL(G.OP_PRICE,0) / D.KG_CONVERT_RATE / 1000, 2) AS G_ITEM_PRICE \n");
		sbSql.append("         FROM FMM_MENU A, FMM_RECIPE B, FMM_RECIPE_ITEM C, FMS_ITEM_V D \n");
		sbSql.append("            ,(SELECT /*+ USE_HASH(A C) */ A.ITEM_CODE \n");
		sbSql.append("                     , CASE WHEN C.OP_PRICE IS NOT NULL OR C.OP_RATE IS NOT NULL \n");
		sbSql.append("                            THEN DECODE(SIGN(NVL(C.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) \n");
		sbSql.append("                            WHEN D.OP_PRICE IS NOT NULL OR D.OP_RATE IS NOT NULL \n");
		sbSql.append("                            THEN DECODE(SIGN(NVL(D.OP_PRICE,0) ),0, SCC_CEIL(A.SALE_PRICE + (A.SALE_PRICE * NVL(D.OP_RATE,0) / 100),D.CEIL_VAL), D.OP_PRICE) \n");
		sbSql.append("                       ELSE A.SALE_PRICE END AS OP_PRICE --운영단가 \n");
		
		//sbSql.append("                   , DECODE(SIGN(NVL(C.OP_PRICE,0)),0, SCC_CEIL(A.SALE_PRICE + ROUND(A.SALE_PRICE * NVL(C.OP_RATE,0) / 100),C.CEIL_VAL), C.OP_PRICE) AS OP_PRICE \n");
		
		//sbSql.append("                FROM FMU_OP_RATE C \n");
		
		sbSql.append("               FROM (SELECT A.UPJANG, A.ITEM_CODE, B.ITEM_CLASS4 \n");
		sbSql.append("                          , DECODE(A.USE_YN,'N',0,NVL(A.SALE_PRICE,0)) AS SALE_PRICE \n");
		sbSql.append("                       FROM HLDC_PO_CONTRACT_FSALE A, HLDC_PO_ITEM_MST B \n");
		sbSql.append("                      WHERE A.CENTER_CODE = (SELECT A.CENTER_CODE FROM HLDC_PO_UPJANG_CENTER A, HLDC_ST_UPJANG B WHERE A.UPJANG = B.AP_UNITPRICE_UPJANG AND B.UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + ") \n");
		sbSql.append("                        AND A.UPJANG = (SELECT B.AP_UNITPRICE_UPJANG FROM HLDC_ST_UPJANG B WHERE B.UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + ") \n");
		sbSql.append("                        AND '" + nullToBlank(ds_cond.getString(0,"MENU_DATE")) + "' BETWEEN A.CONTRACT_START AND NVL(A.CONTRACT_END,'99999999') \n");
		sbSql.append("                        AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                      UNION ALL \n");
		sbSql.append("                     SELECT A.UPJANG, A.ITEM_CODE, B.ITEM_CLASS4 \n");
		sbSql.append("                          , DECODE(A.USE_YN,'N',0,NVL(A.SALE_PRICE,0)) AS SALE_PRICE \n");
		sbSql.append("                       FROM FMP_OTCUST_PRICE_AVA_V A, FMP_OTCUST_ITEM B \n");
		sbSql.append("                      WHERE A.UPJANG = (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + ") \n");
		sbSql.append("                        AND '" + nullToBlank(ds_cond.getString(0,"MENU_DATE")) + "' BETWEEN A.SDATE AND NVL(A.EDATE,'99999999') \n");
		sbSql.append("                        AND A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("                     ) A \n");
		
		sbSql.append("                  , (SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE  \n");
		sbSql.append("                       FROM FMU_OP_RATE \n");
		sbSql.append("                      WHERE UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + " \n");
		sbSql.append("                        AND USE_YN = 'Y' \n");
		sbSql.append("                        AND ITEM_TYPE = 'M' \n");
		sbSql.append("                    ) C \n");
		sbSql.append("                  , (SELECT UPJANG, ITEM_CODE, OP_RATE, OP_PRICE, CEIL_VAL, SDATE, EDATE \n");
		sbSql.append("                       FROM FMU_OP_RATE \n");
		sbSql.append("                      WHERE UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + " \n");
		sbSql.append("                        AND USE_YN = 'Y' \n");
		sbSql.append("                        AND ITEM_TYPE = 'C' \n");
		sbSql.append("                    ) D \n");
		
		sbSql.append("               WHERE A.UPJANG = C.UPJANG(+) \n");
		sbSql.append("                 AND '" + nullToBlank(ds_cond.getString(0,"MENU_DATE")) + "' BETWEEN C.SDATE(+) AND C.EDATE(+) \n");
		sbSql.append("                 AND A.ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append("                 AND A.UPJANG = D.UPJANG(+) \n");
		sbSql.append("                 AND '" + nullToBlank(ds_cond.getString(0,"MENU_DATE")) + "' BETWEEN D.SDATE(+) AND D.EDATE(+) \n");
		sbSql.append("                 AND A.ITEM_CLASS4 = D.ITEM_CODE(+) \n");
		
		sbSql.append("             ) G \n");
		sbSql.append("        WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("          AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("          AND B.UPJANG = C.UPJANG \n");
		sbSql.append("          AND B.MENU_CD = C.MENU_CD \n");
		sbSql.append("          AND B.RECIPE_CD = C.RECIPE_CD \n");
		sbSql.append("          AND C.ITEM_CODE = D.ITEM_CODE \n");
		sbSql.append("          AND C.ITEM_CODE = G.ITEM_CODE(+) \n");
		sbSql.append("          AND A.UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + " \n");
		sbSql.append("          AND A.MENU_CD IN ( " + nullToBlank(ds_cond.getString(0,"MENU_LIST")) + " ) \n");
		sbSql.append("          AND A.MENU_DATE = '" + nullToBlank(ds_cond.getString(0,"MENU_DATE")) + "' \n");
		sbSql.append("          AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0,"SUBINV_CODE")) + "' \n");
		sbSql.append("      ) A \n");
		sbSql.append("     ,(SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("         FROM FMP_ITEM_NUT A \n");
		sbSql.append("        WHERE A.UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + ") \n");
		sbSql.append("          AND A.USE_YN = 'Y' \n");
		sbSql.append("        UNION ALL \n");
		sbSql.append("       SELECT A.ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("         FROM FSI_ITEM_NUT A \n");
		sbSql.append("            ,(SELECT ITEM_CODE \n");
		sbSql.append("                FROM FSI_ITEM_NUT \n");
		sbSql.append("               MINUS \n");
		sbSql.append("              SELECT ITEM_CODE \n");
		sbSql.append("                FROM FMP_ITEM_NUT \n");
		sbSql.append("               WHERE UPJANG = (SELECT MAIN_UPJANG FROM FMS_UPJANG WHERE UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + ") \n");
		sbSql.append("                 AND USE_YN = 'Y') B \n");
		sbSql.append("        WHERE A.ITEM_CODE = B.ITEM_CODE \n");
		sbSql.append("      ) B \n");
		sbSql.append("     , FSI_ITEM_NUT C \n");
		sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE(+) \n");
		sbSql.append("   AND A.ORI_ITEM_CODE = C.ITEM_CODE(+) \n");
		sbSql.append(" GROUP BY A.UPJANG, A.SUBINV_CODE, A.MENU_DATE \n");
		sbSql.append("        , A.MEAL, A.CORNER \n");
		sbSql.append("        , A.RECIPE_CD, A.RECIPE_NAME \n");
		if(sItemFlag.equals("1"))
			sbSql.append("        , A.ITEM_CODE, A.ITEM_NAME, A.EDIBLE_QTY, B.DISUSE_RATE \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();		
		
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();
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