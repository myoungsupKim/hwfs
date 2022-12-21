<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="../../sc/main/common.jsp"%>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();

		//입력 데이타                                                                                                                                                                                         
		DataSet ds_condi = in_dl.get("ds_condi");

		String SEARCH_TYPE = nullToBlank(ds_condi.getString(0, "SEARCH_TYPE"));	//창고 & 부서구분
		String SEARCH_CODE = nullToBlank(ds_condi.getString(0, "SEARCH_CODE"));	//창고코드 & 부서코드
		String START_DT    = nullToBlank(ds_condi.getString(0, "START_DT"));	//시작일자
		String END_DT      = nullToBlank(ds_condi.getString(0, "END_DT"));		//종료일자
		String CUSTCD      = nullToBlank(ds_condi.getString(0, "CUSTCD"));		//거래처코드
		String CHK1        = nullToBlank(ds_condi.getString(0, "CHK1"));		//
		String CHK2        = nullToBlank(ds_condi.getString(0, "CHK2"));
		String CHK3        = nullToBlank(ds_condi.getString(0, "CHK3"));
		String strIPo      = nullToBlank(ds_condi.getString(0, "I_PO"));
		String strITrans   = nullToBlank(ds_condi.getString(0, "I_TRANS"));
		String MAIN_UPJANG = nullToBlank(ds_condi.getString(0, "MAIN_UPJANG"));
		String UPJANG = nullToBlank(ds_condi.getString(0, "UPJANG"));
		//String PO_NUM      = nullToBlank(ds_condi.getString(0, "PO_NUM"));
		String TRANS_UPJANG = nullToBlank(ds_condi.getString(0, "TRANS_UPJANG"));			// 행선택
		String NEED_DATE = nullToBlank(ds_condi.getString(0, "NEED_DATE"));			// 행선택

		stmt = conn.createStatement();

		//out 데이타                                                                                                                                                                                        
		DataSet ds_out;

		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());
		
			// 구매검수내역
// 종전 Query
/*			
			sbSql.append("SELECT A.ITEM_CODE																	\n");
			sbSql.append("     , A.ITEM_NAME																	\n");
			sbSql.append("     , A.TRANS_DATE																	\n");
			sbSql.append("     , A.TRANS_UPJANG																	\n");
			sbSql.append("     , A.SUBINV_CODE																	\n");
			sbSql.append("     , A.CUSTCD   																	\n");
			sbSql.append("     , A.ITEM_SIZE																	\n");
			sbSql.append("     , A.TRANS_UOM																	\n");
			sbSql.append("     , A.SALE_PRICE																	\n");
			sbSql.append("     , A.TRANS_QTY																	\n");
			//sbSql.append("     , A.SALE_AMOUNT																	\n");
			sbSql.append("	 , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE * A.TRANS_QTY) AS SALE_AMOUNT	\n");
			sbSql.append("     , NVL(TRIM(A.SUBINV_CODE||' '||B.SUBINV_NAME), D.MU_NM||' '||D.CC_NM) AS CC_NM	\n");
			sbSql.append("     , A.TAX_CODE																		\n");
			sbSql.append("     , A.ACCTCD||' '||E.ACCTNM4||' '||E.ACCTNM6 AS ACCTNM								\n");
			sbSql.append("     , F.VD_NM ||'('||F.BIZ_REG_NO ||')' AS CUSTNM									\n");
			sbSql.append("     , DECODE(A.TRANS_TYPE,'I_PO','구매','센터') AS TRANS_GUBUN						\n");
			sbSql.append("     , G.PO_NUM																		\n");
			sbSql.append("  FROM FMS_TRANSACTION_V  A															\n");
			sbSql.append("     , VO_SUBINVENTORY  B																\n");
			sbSql.append("     , FMS_UPJANG C																	\n");
			sbSql.append("     , HLDC_SC_DEPT_V D																\n");
			sbSql.append("     , ST_ACCOUNT E																	\n");
			sbSql.append("     , VO_FC_VENDOR F																	\n");
			sbSql.append("     , HLDC_PO_PO G																	\n");
			sbSql.append(" WHERE A.TRANS_DEPT_ID = D.DEPT_ID													\n");
			sbSql.append("   AND A.SUBINV_CODE   = B.SUBINV_CODE(+)												\n");
			sbSql.append("   AND A.ACCTCD        = E.ACCTCD														\n");
			sbSql.append("   AND A.CUSTCD        = F.VD_CD(+)													\n");
			sbSql.append("   AND D.BU_CD         = E.BU_CD														\n");
			sbSql.append("   AND A.TRANS_DATE	 = G.NEED_DATE													\n");
			sbSql.append("   AND A.TRANS_UPJANG  = G.RC_UPJANG													\n");
			sbSql.append("   AND A.ITEM_CODE     = G.ITEM_CODE													\n");
			sbSql.append("   AND A.SUBINV_CODE   = G.SUBINV_CODE												\n");
			sbSql.append("   AND A.CENTER_CODE   = G.CENTER_CODE												\n");
			sbSql.append("   AND A.TRANS_TYPE    BETWEEN 'I001'     AND 'I002'									\n");
			sbSql.append("   AND A.SOURCE_TYPE   = 'PO'															\n");
			sbSql.append("   AND A.TRANS_UPJANG = C.UPJANG														\n");
			sbSql.append("   AND G.PO_NUM = '" + PO_NUM + "'													\n");
*/
			//sbSql.append("   AND A.TRANS_DATE    BETWEEN '" + START_DT + "' AND '" + END_DT + "'				\n");
			//if(SEARCH_TYPE.equals("S")){	// 창고
			//	sbSql.append("   AND A.SUBINV_CODE   = '" + SEARCH_CODE + "'									\n");
			//}
			//else	// 부서
			//{
//				sbSql.append("   AND A.TRANS_DEPT_ID = '" + SEARCH_CODE + "'									\n");
				//if (CHK2.equals("1"))
//					sbSql.append("   AND A.SUBINV_CODE IS NULL \n");
			//}
			// 거래처코드가 null이 아닐경우
			//if(!CUSTCD.equals(""))
			//	sbSql.append("   AND A.CUSTCD        = '" + CUSTCD + "'											\n");
			
			//if(!MAIN_UPJANG.equals(""))
			//	sbSql.append("   AND C.MAIN_UPJANG   = '" + MAIN_UPJANG + "'											\n");
			
// 2015-11-19 Query 변경 
//		sbSql.append(" SELECT																																					\n");
//		sbSql.append(" 	/*+ PUSH_PRED(A) */																															\n");
//		sbSql.append(" 	  A.ITEM_CODE																																	\n");
//		sbSql.append(" 	 , A.ITEM_NAME																																	\n");
//		sbSql.append(" 	 , A.TRANS_DATE																																	\n");
//		sbSql.append(" 	 , A.TRANS_UPJANG																																\n");
//		sbSql.append(" 	 , A.SUBINV_CODE																																\n");
//		sbSql.append(" 	 , A.CUSTCD																																		\n");
//		sbSql.append(" 	 , A.ITEM_SIZE																																		\n");
//		sbSql.append(" 	 , A.TRANS_UOM																																	\n");	
//		sbSql.append(" 	 , A.SALE_PRICE																																	\n");
//		sbSql.append(" 	 , A.TRANS_QTY																																	\n");
//		sbSql.append(" 	 , DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * ROUND(A.SALE_PRICE * A.TRANS_QTY) AS SALE_AMOUNT		\n");
//		sbSql.append(" 	 , NVL(TRIM(A.SUBINV_CODE||' '||B.SUBINV_NAME), D.MU_NM||' '||D.CC_NM) AS CC_NM								\n");
//		sbSql.append(" 	 , A.TAX_CODE																																	\n");
//		sbSql.append(" 	 , A.ACCTCD||' '||E.ACCTNM4||' '||E.ACCTNM6 AS ACCTNM																			\n");
//		sbSql.append(" 	 , F.VD_NM ||'('||F.BIZ_REG_NO ||')' AS CUSTNM																							\n");
//		sbSql.append(" 	 , DECODE(A.TRANS_TYPE,'I_PO','구매','센터') AS TRANS_GUBUN																	\n");
//		sbSql.append(" 	 , G.PO_NUM																																		\n");
//		sbSql.append("    FROM FMS_TRANSACTION_V A INNER JOIN HLDC_PO_PO G ON G.PO_NUM = '" + PO_NUM + "'					\n");
//		sbSql.append(" 											AND A.PO_NO = G.PO_NO																			\n");
//		sbSql.append(" 											AND A.PO_LNO = G.PO_LNO																			\n");
//		sbSql.append(" 						   LEFT JOIN VO_SUBINVENTORY B ON A.SUBINV_CODE = B.SUBINV_CODE								\n");
//		sbSql.append(" 						   INNER JOIN FMS_UPJANG C ON  1 = 1																			\n");
//		sbSql.append(" 											 AND C.MAIN_UPJANG = '" + MAIN_UPJANG + "'												\n");
//		sbSql.append(" 											 AND C.UPJANG = '" + UPJANG + "'																\n");
//		sbSql.append(" 											 AND A.TRANS_UPJANG = C.UPJANG																\n");
//		sbSql.append(" 						   INNER JOIN HLDC_SC_DEPT_V D ON A.TRANS_DEPT_ID = D.DEPT_ID									\n");
//		sbSql.append(" 						   INNER JOIN ST_ACCOUNT E ON A.ACCTCD = E.ACCTCD														\n");
//		sbSql.append(" 											AND D.BU_CD = E.BU_CD																				\n");
//		sbSql.append(" 						   LEFT JOIN VO_FC_VENDOR F ON A.CUSTCD  = F.VD_CD														\n");
//		sbSql.append(" 	WHERE SUBSTR(A.SUBINV_CODE, 1, 2) = 'S1'																							\n");
//		sbSql.append(" 	AND (A.TRANS_TYPE IN '_002' OR A.TRANS_TYPE = 'I001' )																		\n");	
//		sbSql.append(" 	AND A.SOURCE_TYPE   = 'PO'																												\n");

// 2015-11-26 Query 변경 

	    sbSql.append(" SELECT																																					\n");
	    sbSql.append("   A.ITEM_CODE																																	    \n");
 		sbSql.append(" , A.ITEM_NAME																																	    \n");
 		sbSql.append(" , A.NEED_DATE AS TRANS_DATE																												\n");					
 		sbSql.append(" , A.RC_UPJANG AS TRANS_UPJANG																											\n");					
 		sbSql.append(" , A.SUBINV_CODE																																    \n");
 		sbSql.append(" , A.CUSTCD																																			\n");
 		sbSql.append(" , A.ITEM_SIZE																																			\n");
 		sbSql.append(" , A.PO_UOM AS TRANS_UOM																													\n");					
 		sbSql.append(" , A.SALE_PRICE																																		\n");
		sbSql.append(" , C.PO_QTY-C.RETURNED_QTY AS TRANS_QTY																								\n");
 		sbSql.append(" , ROUND(C.SALE_PRICE * (C.PO_QTY-C.RETURNED_QTY)) AS SALE_AMOUNT													\n");
 		sbSql.append(" , TRIM(A.SUBINV_CODE||' '||B.SUBINV_NAME) AS CC_NM																				\n");
 		sbSql.append(" , A.TAX_CODE																																		\n"); 
 		sbSql.append(" , F.VD_NM ||'('||F.BIZ_REG_NO ||')' AS CUSTNM																							\n");
		sbSql.append(" , TO_CHAR(A.CREATE_DATE, 'YYYY-MM-DD HH24:MI:SS')|| ' ' || A.PR_SABUN || ' ' || (SELECT SCC_CRYPTO.MASKAUTH_FUN (NM_KOR, 12, 'YYYYNNNNNNNNNNN', '0') FROM SCC_USERINFO WHERE SABUN = A.PR_SABUN) AS APPROVE_TIME   \n");                                                 
		sbSql.append(" , C.PO_NUM																																			\n");
		sbSql.append(" FROM SO_PR A  INNER JOIN HLDC_PO_PO C ON C.LINE_STATUS IN ('DL','PC','GC','IV')        -- 발주완료(PC), 배송중(DL), 입고완료(GC), 정산완료(IV)	\n");
		sbSql.append(" 														     AND A.PR_NUM = C.PO_NUM														\n");
		sbSql.append(" 														     AND A.PR_ID = C.PO_ID																\n");
		sbSql.append(" 								   LEFT JOIN VO_SUBINVENTORY B ON A.SUBINV_CODE = B.SUBINV_CODE						\n");	
		sbSql.append(" 								   LEFT JOIN VO_FC_VENDOR F ON A.CUSTCD  = F.VD_CD												\n");
		sbSql.append("  WHERE A.RC_UPJANG = '" + TRANS_UPJANG + "'																						\n");
		sbSql.append("  AND    A.NEED_DATE = '" + NEED_DATE + "'																								\n");
 		if(SEARCH_TYPE.equals("S")){	// 창고
			if(!SEARCH_CODE.equals(""))
			sbSql.append("   AND A.SUBINV_CODE   = '" + SEARCH_CODE + "'										\n");
		}
		sbSql.append("  AND    A.PO_TYPE IN ('07','29', '97')																												\n");
		sbSql.append("  ORDER BY A.ITEM_CODE																															\n");

		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();
		ds_out = this.makeDataSet(rs, "ds_detail");

		/**종료**/
		out_dl.add(ds_out);
		this.setResultMessage(0, "OK", out_vl);

	} catch (Exception ex) {
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(), out_vl);
	} finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
			}
		}
	}

	proc_output(response, out, out_vl, out_dl);
%>























<%-- 
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     	= in_dl.get("ds_input"); 
		
		String strSType 		= nullToBlank(ds_input.getString(0, "STYPE"));                                                                                                                                                                                                        
		String strSCode			= nullToBlank(ds_input.getString(0, "SCODE")); 
	  	String strFromDt 		= nullToBlank(ds_input.getString(0, "FROM_DT"));                                                                                                                                                                                                        
		String strToDt			= nullToBlank(ds_input.getString(0, "TO_DT")); 
		String strCustCD		= nullToBlank(ds_input.getString(0, "CUSTCD"));
		String strChk2 			= nullToBlank(ds_input.getString(0, "CHK2"));                                                                                                                                                                                                        
		String strChk3			= nullToBlank(ds_input.getString(0, "CHK3")); 
		String strChk4			= nullToBlank(ds_input.getString(0, "CHK4"));
		String strIPo			= nullToBlank(ds_input.getString(0, "I_PO"));
		String strITrans		= nullToBlank(ds_input.getString(0, "I_TRANS"));
		
		stmt 		=  conn.createStatement();
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();   
        
		// 구매검수내역
		sbSql.delete(0, sbSql.length());
		if (strChk3.equals("1"))	// 거래처별 조회 체크시
		{
			sbSql.append("SELECT A.TR_NUM, A.TRANS_DATE, B.MU_NM||' '||B.CC_NM AS CC_NM, A.CUSTCD, A.CUSTCD||' '||G.CUSTNM AS CUSTNM, A.ITEM_NAME||DECODE(SIGN(E.CNT - 1),1,' 외 '||TO_CHAR(E.CNT - 1)||'건') AS TITLE \n");
			sbSql.append("     , E.AMT, E.VAT, (E.AMT + E.VAT) AS TOT, A.CREATE_BY||' '||F.NM_KOR AS NM_KOR \n");
			sbSql.append("     , DECODE(A.GANO,-1,NULL,A.GAMU||'-'||A.GADATE||'-'||LPAD(TO_CHAR(A.GANO),4,'0')) AS GANO \n");
			sbSql.append("  FROM HLDC_PO_TRANSACTION A, HLDC_SC_DEPT_V B, HR_PERSONAL F, ST_CUST G \n");
			sbSql.append("     , (SELECT F.TR_NUM, F.CUSTCD, MIN(F.TRANS_ID) AS TRANS_ID, COUNT(*) AS CNT, SUM(F.TRANS_MAMOUNT) AS AMT, SUM(F.TRANS_MAMOUNT * DECODE(F.TAX_CODE,100,0.1,0)) AS VAT \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION F \n");
			sbSql.append("         WHERE F.TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
			
			if (strSType.equals("S"))	// 창고입고 선택시
			{
				sbSql.append("           AND F.SUBINV_CODE = '" + strSCode + "' \n");
			}
			else						// 부서입고 선택시
			{
				sbSql.append("           AND F.TRANS_DEPT_ID = '" + strSCode + "' \n");
				// 부서검수 전체 체크시
				if (strChk2.equals("1")) sbSql.append("           AND F.SUBINV_CODE IS NULL \n");
			}
			sbSql.append("           AND F.TRANS_TYPE BETWEEN '" + strIPo + "' AND '" + strITrans + "'  \n");
			sbSql.append("           AND F.SOURCE_TYPE = 'PO' \n");
			
			//입고거래처 != NULL
			if (strCustCD.length() != 0) sbSql.append("           AND F.CUSTCD = " + strCustCD + " \n");
			sbSql.append("         GROUP BY F.TR_NUM, F.CUSTCD) E \n");
			sbSql.append(" WHERE A.TRANS_DEPT_ID = B.DEPT_ID \n");
			sbSql.append("   AND A.CREATE_BY = F.SABUN \n");
			sbSql.append("   AND A.TRANS_ID = E.TRANS_ID \n");
			sbSql.append("   AND A.CUSTCD = G.CUSTCD \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
			
			if (strSType.equals("S"))	// 창고입고 선택시
			{
				sbSql.append("   AND A.SUBINV_CODE = '" + strSCode + "' \n");
			}
			else						// 부서입고 선택시
			{
				sbSql.append("   AND A.TRANS_DEPT_ID = '" + strSCode + "' \n");
				// 부서검수 전체 체크시
				if (strChk2.equals("1")) sbSql.append("   AND A.SUBINV_CODE IS NULL \n");
			}
			sbSql.append("   AND A.TRANS_TYPE BETWEEN '" + strIPo + "' AND '" + strITrans + "' \n");
			sbSql.append("   AND A.SOURCE_TYPE = 'PO' \n");
			//입고거래처 != NULL
			if (strCustCD.length() != 0) sbSql.append("   AND A.CUSTCD = " + strCustCD + " \n");
		}
		else
		{
			sbSql.append("SELECT A.TR_NUM, A.TRANS_DATE, B.MU_NM||' '||B.CC_NM AS CC_NM, NULL AS CUSTCD,NULL AS CUSTNM, A.ITEM_NAME||DECODE(SIGN(E.CNT - 1),1,' 외 '||TO_CHAR(E.CNT - 1)||'건') AS TITLE \n");
			sbSql.append("     , E.AMT, E.VAT, (E.AMT + E.VAT) AS TOT, A.CREATE_BY||' '||F.NM_KOR AS NM_KOR \n");
			sbSql.append("     , DECODE(A.GANO,-1,NULL,A.GAMU||'-'||A.GADATE||'-'||LPAD(TO_CHAR(A.GANO),4,'0')) AS GANO \n");
			sbSql.append("  FROM HLDC_PO_TRANSACTION A, HLDC_SC_DEPT_V B, HR_PERSONAL F \n");
			sbSql.append("     , (SELECT F.TR_NUM, MIN(F.TRANS_ID) AS TRANS_ID, COUNT(*) AS CNT, SUM(F.TRANS_MAMOUNT) AS AMT, SUM(F.TRANS_MAMOUNT * DECODE(F.TAX_CODE,100,0.1,0)) AS VAT \n");
			sbSql.append("          FROM HLDC_PO_TRANSACTION F \n");
			sbSql.append("         WHERE F.TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
			if (strSType.equals("S"))	// 창고입고 선택시
			{
				sbSql.append("           AND F.SUBINV_CODE = '" + strSCode + "' \n");
			}
			else						// 부서입고 선택시
			{
				sbSql.append("           AND F.TRANS_DEPT_ID = '" + strSCode + "' \n");
				// 부서검수 전체 체크시
				if (strChk2.equals("1")) sbSql.append("           AND F.SUBINV_CODE IS NULL \n");
			}
			sbSql.append("           AND F.TRANS_TYPE BETWEEN '" + strIPo + "' AND '" + strITrans + "'  \n");
			sbSql.append("           AND F.SOURCE_TYPE = 'PO' \n");
			
			//입고거래처 != NULL
			if (strCustCD.length() != 0) sbSql.append("           AND F.CUSTCD = " + strCustCD + " \n");
			
			sbSql.append("         GROUP BY F.TR_NUM) E \n");
			sbSql.append(" WHERE A.TRANS_DEPT_ID = B.DEPT_ID \n");
			sbSql.append("   AND A.CREATE_BY = F.SABUN \n");
			sbSql.append("   AND A.TRANS_ID = E.TRANS_ID \n");
			sbSql.append("   AND A.TRANS_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
			
			if (strSType.equals("S"))	// 창고입고 선택시
			{
				sbSql.append("   AND A.SUBINV_CODE = '" + strSCode + "' \n");
			}
			else						// 부서입고 선택시
			{
				sbSql.append("   AND A.TRANS_DEPT_ID = '" + strSCode + "' \n");
				// 부서검수 전체 체크시
				if (strChk2.equals("1")) sbSql.append("   AND A.SUBINV_CODE IS NULL \n");
			}
			sbSql.append("   AND A.TRANS_TYPE BETWEEN '" + strIPo + "' AND '" + strITrans + "' \n");
			sbSql.append("   AND A.SOURCE_TYPE = 'PO' \n");
			//입고거래처 != NULL
			if (strCustCD.length() != 0) sbSql.append("   AND A.CUSTCD = " + strCustCD + " \n");
		}
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");                                                                                                                                                          
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  
		
	} catch(Exception ex) {
		   ex.printStackTrace();
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
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%> --%>