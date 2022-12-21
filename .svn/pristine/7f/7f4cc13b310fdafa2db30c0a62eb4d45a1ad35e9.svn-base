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
	//	String v_EmpNo 		= in_vl.getString("g_EmpNo");	
	//	DataSet in_ds  =  in_dl.get("ds_Input");
	//	String sCode = in_ds.getString(0, "CD");
						
			String UPJANG 			= in_vl.getString("UPJANG");		
			String MENU_DATE 		= in_vl.getString("MENU_DATE");
			String SUBINV_CODE 		= in_vl.getString("SUBINV_CODE");
			String MEAL				= in_vl.getString("MEAL");
			String CORNER			= in_vl.getString("CORNER");
		
			
	//	if(conn != null && !conn.isClosed()) conn.close();
		
	//	conn = getIRISConn();
	
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		sbSql.delete(0, sbSql.length());		
		sbSql.append(" SELECT 0 CREAT,                                                                                                    \n");
		sbSql.append("        AA.RECIPE_CD,                                                                                               \n");
		sbSql.append("        AA.RECIPE_NAME,                                                                                             \n");
		sbSql.append("        ROUND(SUM(NVL(AA.RECIPE_COST, 0) )) RECIPE_COST,                                                            \n");
		sbSql.append("        SUM(NVL(AA.CORN_SALE_PRICE, 0) ) CORN_SALE_PRICE,   --코너별 식단가                                                                                        \n");
		sbSql.append("        AA.UPJANG,                                                                                                  \n");
		sbSql.append("        AA.MENU_CD,                                                                                                 \n");
		sbSql.append("        AA.ATTR04,                                                                                                 \n");
		sbSql.append("        AA.RECIPE_COLOR,                                                                                            \n");
		sbSql.append("        (                                                                                                           \n");
		sbSql.append("        SELECT SET1                                                                                                 \n");
		sbSql.append("          FROM SCC_COMMON_CODE                                                                                      \n");
		sbSql.append("         WHERE CODE=AA.RECIPE_COLOR                                                                                 \n");
		sbSql.append("           AND GROUP_CODE='FS0007'                                                                                \n");
		sbSql.append("        ) COLOR,                                                                                                    \n");
		sbSql.append("        SUM(NVL(AA.NEED_QTY, 0) ) NEED_QTY,AA.CDATE,                                                                \n");
		sbSql.append("        0 V_STA,                                                                                                    \n");
		sbSql.append("        0 V_RATE,                                                                                                   \n");
		sbSql.append("        SUM(NVL(AA.CAL, 0) ) CAL,                          --열량,                                                   \n");
		sbSql.append("        SUM(NVL(AA.WATER, 0) ) WATER,                      --수분,                                                   \n");
		sbSql.append("        SUM(NVL(AA.PROT, 0) ) PROT,                        --단백질,                                                  \n");
		sbSql.append("        SUM(NVL(AA.FAT, 0) ) FAT,                          --지질,                                                   \n");
		sbSql.append("        SUM(NVL(AA.CARBO, 0) ) CARBO,                      --당질,                                                   \n");
		sbSql.append("        SUM(NVL(AA.FIBER, 0) ) FIBER,                      --섬유,                                                   \n");
		sbSql.append("        SUM(NVL(AA.ASH, 0) ) ASH,                          --회분,                                                   \n");
		sbSql.append("        SUM(NVL(AA.CA, 0) ) CA,                            --칼슘,                                                   \n");
		sbSql.append("        SUM(NVL(AA.P, 0) ) P,                              --인,                                                     \n");
		sbSql.append("        SUM(NVL(AA.FE, 0) ) FE,                            --철,                                                     \n");
		sbSql.append("        SUM(NVL(AA.NA, 0) ) NA,                            --나트륨,                                                  \n");
		sbSql.append("        SUM(NVL(AA.K, 0) ) K,                              --칼륨,                                                    \n");
		sbSql.append("        SUM(NVL(AA.VITA_A, 0) ) VITA_A,                    --비타민A, 												   \n");
		sbSql.append("        SUM(NVL(AA.RETIN, 0) ) RETIN,                      --레티놀, 												   \n");
		sbSql.append("        SUM(NVL(AA.B_CAROT, 0) ) B_CAROT,                  --B_카르틴, 											       \n");
		sbSql.append("        SUM(NVL(AA.THIA, 0) ) THIA,                        --비타민B1, 												   \n");
		sbSql.append("        SUM(NVL(AA.RIBO, 0) ) RIBO,                        --비타민B2, 												   \n");
		sbSql.append("        SUM(NVL(AA.NIACIN, 0) ) NIACIN,                    --나이아신, 												   \n");
		sbSql.append("        SUM(NVL(AA.VITA_C, 0) ) VITA_C,                    --비타민C, 												   \n");
		sbSql.append("        SUM(NVL(AA.CHOLE, 0) ) CHOLE,                      --콜레스테롤 												   \n");
		sbSql.append(" -- 폐기율 적용 영양소 보기체크시 ==> 가식부량에 의한 영양소 																	   \n");
		sbSql.append("        SUM(ROUND( (NVL(CAL, 0) 	* AA.EDIBLE_QTY / 100), 2) ) S_KCAL,              --열량,    					   \n");
		sbSql.append("        SUM(ROUND( (NVL(WATER, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_WATER,        --수분,  						   \n");
		sbSql.append("        SUM(ROUND( (NVL(PROT, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_PROT,             --단백질, \n");
		sbSql.append("        SUM(ROUND( (NVL(FAT, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_FAT,              --지질, \n");
		sbSql.append("        SUM(ROUND( (NVL(CARBO, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_CARBO,        --당질, \n");
		sbSql.append("        SUM(ROUND( (NVL(FIBER, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_FIBER,        --섬유, \n");
		sbSql.append("        SUM(ROUND( (NVL(ASH, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_ASH,              --회분, \n");
		sbSql.append("        SUM(ROUND( (NVL(CA, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_CA,               --칼슘, \n");
		sbSql.append("        SUM(ROUND( (NVL(P, 0) 		* AA.EDIBLE_QTY / 100) , 2) ) S_P,            --인, \n");
		sbSql.append("        SUM(ROUND( (NVL(FE, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_FE,               --철, \n");
		sbSql.append("        SUM(ROUND( (NVL(NA, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_NA,               --나트륨, \n");
		sbSql.append("        SUM(ROUND( (NVL(K, 0) 		* AA.EDIBLE_QTY / 100) , 2) ) S_K,            --칼륨, \n");
		sbSql.append("        SUM(ROUND( (NVL(VITA_A, 0) * AA.EDIBLE_QTY / 100) , 2) ) S_VITA,            --비타민A, \n");
		sbSql.append("        SUM(ROUND( (NVL(RETIN, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_RETIN,        --레티놀, \n");
		sbSql.append("        SUM(ROUND( (NVL(B_CAROT, 0)* AA.EDIBLE_QTY / 100) , 2) ) S_B_CAROT,      	  --B_카르틴, \n");
		sbSql.append("        SUM(ROUND( (NVL(THIA, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_THIA,             --비타민B1, \n");
		sbSql.append("        SUM(ROUND( (NVL(RIBO, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_RIBO,             --비타민B2, \n");
		sbSql.append("        SUM(ROUND( (NVL(NIACIN, 0) * AA.EDIBLE_QTY / 100) , 2) ) S_NIASIN,          --나이아신, \n");
		sbSql.append("        SUM(ROUND( (NVL(VITA_C, 0) * AA.EDIBLE_QTY / 100) , 2) ) S_VITA_C,          --비타민C, \n");
		sbSql.append("        SUM(ROUND( (NVL(CHOLE, 0) 	* AA.EDIBLE_QTY / 100) , 2) ) S_CHOLE,        --콜레스테롤 \n");
		sbSql.append(" -- 폐기율 미적용 영양소 보기체크시==> 1인소요량에의한 영양가 계산 \n");
		sbSql.append("        SUM(ROUND( (NVL(CAL, 0) 	* AA.NEED_QTY / 100), 2) ) SS_KCAL,               --열량, \n");
		sbSql.append("        SUM(ROUND( (NVL(WATER, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_WATER,         --수분, \n");
		sbSql.append("        SUM(ROUND( (NVL(PROT, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_PROT,              --단백질, \n");
		sbSql.append("        SUM(ROUND( (NVL(FAT, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_FAT,               --지질, \n");
		sbSql.append("        SUM(ROUND( (NVL(CARBO, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_CARBO,         --당질, \n");
		sbSql.append("        SUM(ROUND( (NVL(FIBER, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_FIBER,         --섬유, \n");
		sbSql.append("        SUM(ROUND( (NVL(ASH, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_ASH,               --회분, \n");
		sbSql.append("        SUM(ROUND( (NVL(CA, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_CA,                --칼슘, \n");
		sbSql.append("        SUM(ROUND( (NVL(P, 0) 		* AA.NEED_QTY / 100) , 2) ) SS_P,             --인, \n");
		sbSql.append("        SUM(ROUND( (NVL(FE, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_FE,                --철, \n");
		sbSql.append("        SUM(ROUND( (NVL(NA, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_NA,                --나트륨, \n");
		sbSql.append("        SUM(ROUND( (NVL(K, 0) 		* AA.NEED_QTY / 100) , 2) ) SS_K,             --칼륨, \n");
		sbSql.append("        SUM(ROUND( (NVL(VITA_A, 0) * AA.NEED_QTY / 100) , 2) ) SS_VITA,             --비타민A, \n");
		sbSql.append("        SUM(ROUND( (NVL(RETIN, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_RETIN,         --레티놀, \n");
		sbSql.append("        SUM(ROUND( (NVL(B_CAROT, 0)* AA.NEED_QTY / 100) , 2) ) SS_B_CAROT,          --B_카르틴, \n");
		sbSql.append("        SUM(ROUND( (NVL(THIA, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_THIA,              --비타민B1, \n");
		sbSql.append("        SUM(ROUND( (NVL(RIBO, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_RIBO,              --비타민B2, \n");
		sbSql.append("        SUM(ROUND( (NVL(NIACIN, 0) * AA.NEED_QTY / 100) , 2) ) SS_NIASIN,           --나이아신, \n");
		sbSql.append("        SUM(ROUND( (NVL(VITA_C, 0) * AA.NEED_QTY / 100) , 2) ) SS_VITA_C,           --비타민C, \n");
		sbSql.append("        SUM(ROUND( (NVL(CHOLE, 0) 	* AA.NEED_QTY / 100) , 2) ) SS_CHOLE          --콜레스테롤 \n");
		sbSql.append("   FROM \n");
		sbSql.append("        ( \n");
		sbSql.append("        SELECT /*+ USE_HASH(B A) */ \n");
		sbSql.append("               A.UPJANG, \n");
		sbSql.append("               A.MENU_CD, \n");
		sbSql.append("               A.RECIPE_CD, \n");
		sbSql.append("               A.RECIPE_NAME, \n");
		sbSql.append("               A.RECIPE_COLOR, \n");
		sbSql.append("               A.SALE_PRICE,               					 --판매가 \n");
		sbSql.append("               A.PHF, \n");
		sbSql.append("               A.CORN_SALE_PRICE,			                     --코너별 식단가 \n");
		sbSql.append("               NVL(A.OP_PRICE,0) * A.NEED_QTY RECIPE_COST,     --레시피원가 \n");
		sbSql.append("               A.ITEM_CODE, \n");
		sbSql.append("               A.NEED_QTY,A.EDIBLE_QTY,A.CDATE, \n");
		sbSql.append("               A.ATTR04, \n");
		sbSql.append("               C.CAL, \n");
		sbSql.append("               C.WATER, \n");
		sbSql.append("               C.PROT, \n");
		sbSql.append("               C.FAT, \n");
		sbSql.append("               C.CARBO, \n");
		sbSql.append("               C.FIBER, \n");
		sbSql.append("               C.ASH, \n");
		sbSql.append("               C.CA, \n");
		sbSql.append("               C.P , \n");
		sbSql.append("               C.FE, \n");
		sbSql.append("               C.NA, \n");
		sbSql.append("               C.K, \n");
		sbSql.append("               C.VITA_A, \n");
		sbSql.append("               C.RETIN, \n");
		sbSql.append("               C.B_CAROT, \n");
		sbSql.append("               C.THIA, \n");
		sbSql.append("               C.RIBO, \n");
		sbSql.append("               C.NIACIN , \n");
		sbSql.append("               C.VITA_C, \n");
		sbSql.append("               C.CHOLE, \n");
		sbSql.append("               C.DISUSE_RATE \n");
		sbSql.append("          FROM \n");
		sbSql.append("               ( \n");
		sbSql.append("               SELECT A.UPJANG, \n");
		sbSql.append("                      A.RECIPE_CD, \n");
		sbSql.append("                      A.RECIPE_NAME, \n");
		sbSql.append("                      A.RECIPE_CLASS, \n");
		sbSql.append("                      A.RECIPE_TYPE, \n");
		sbSql.append("                      A.CUISINE_TYPE, \n");
		sbSql.append("                      A.SALE_PRICE, \n");
		sbSql.append("                      B.ITEM_CODE, \n");
		sbSql.append("                      B.NEED_QTY,B.EDIBLE_QTY, \n");
		sbSql.append("                      A.PHF, \n");
		sbSql.append("                      A.EXPECT_SALE_QTY, \n");
		sbSql.append("                      A.MAJOR_DISH_INFO, \n");
		sbSql.append("                      C.SALE_PRICE CORN_SALE_PRICE, \n");
		sbSql.append("               --       ROUND(B.UNIT_PRICE/D.KG_CONVERT_RATE/1000,2) AS OP_PRICE, \n");
		sbSql.append("                      DECODE(NVL(B.OP_RATE,0),0,ROUND(B.UNIT_PRICE/D.KG_CONVERT_RATE/1000,2),ROUND(B.OP_PRICE/D.KG_CONVERT_RATE/1000,2)) AS OP_PRICE, \n");		
		sbSql.append("                      C.MENU_CD, \n");
		sbSql.append("                      A.RECIPE_COLOR,A.CDATE, \n");
		sbSql.append("                      A.ATTR04 \n");
		sbSql.append("                 FROM FMM_RECIPE A , \n");
		sbSql.append("                      FMM_RECIPE_ITEM B , \n");
		sbSql.append("                      FMM_MENU C, \n");
		sbSql.append("                      FMS_ITEM_V D \n");
		sbSql.append("                WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("                  AND A.MENU_CD = B.MENU_CD \n");
		sbSql.append("                  AND A.RECIPE_CD = B.RECIPE_CD \n");
		sbSql.append("                  AND A.UPJANG = C.UPJANG \n");
		sbSql.append("                  AND A.MENU_CD = C.MENU_CD \n");
		sbSql.append("                  AND B.ITEM_CODE = D.ITEM_CODE \n");
		sbSql.append("                  AND C.MENU_CD = '"+MENU_DATE+"'||'-'||'"+SUBINV_CODE+"'||'"+MEAL+"'||'"+CORNER+"'                                                                                               							\n");
		sbSql.append("                  AND A.UPJANG  =  "+UPJANG+"  -- 업장                                                                                                                                							\n");
		sbSql.append("               ) A,   --메뉴별 레시피및 자재조회 \n");
		sbSql.append("               ( \n");
		sbSql.append("                      SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                        FROM	FMP_ITEM_NUT \n");
		sbSql.append("                       WHERE	UPJANG =  "+UPJANG+"  -- 업장                                                                                                                                							\n");
		sbSql.append("                       UNION ALL \n");
		sbSql.append("                             ( \n");
		sbSql.append("                             SELECT ITEM_CODE, CAL, WATER, PROT, FAT, CARBO, FIBER, ASH, CA, P, FE, NA, K, VITA_A, RETIN, B_CAROT, THIA, RIBO, NIACIN, VITA_C, CHOLE, DISUSE_RATE \n");
		sbSql.append("                               FROM	FSI_ITEM_NUT \n");
		sbSql.append("                              WHERE ITEM_CODE IN \n");
		sbSql.append("                                    ( \n");
		sbSql.append("                                    SELECT ITEM_CODE \n");
		sbSql.append("                                      FROM FSI_ITEM_NUT MINUS \n");
		sbSql.append("                                    SELECT ITEM_CODE \n");
		sbSql.append("                                      FROM FMP_ITEM_NUT \n");
		sbSql.append("                                     WHERE UPJANG =  "+UPJANG+"  -- 업장                                                                                                                                							\n");
		sbSql.append("                                    ) \n");
		sbSql.append("                             ) \n");
		sbSql.append("               ) C    --영양가 \n");
		sbSql.append("         WHERE A.ITEM_CODE=C.ITEM_CODE(+)  --영양가 \n");
		sbSql.append("        ) AA \n");
		sbSql.append("  GROUP BY AA.RECIPE_CD, \n");
		sbSql.append("        AA.RECIPE_NAME, \n");
		sbSql.append("        AA.UPJANG, \n");
		sbSql.append("        AA.MENU_CD, \n");
		sbSql.append("        AA.RECIPE_COLOR ,AA.ATTR04,AA.CDATE  ORDER BY AA.CDATE \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 

		DataSet ds_Menu = this.makeDataSet(rs,"ds_Menu");
		out_dl.add(ds_Menu);
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