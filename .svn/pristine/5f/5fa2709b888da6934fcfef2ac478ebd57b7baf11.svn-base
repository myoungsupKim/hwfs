
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     	= in_dl.get("ds_input"); 
		
		String MU_CD		= nullToBlank(ds_input.getString(0, "MU_CD"));
	  	String UPJANG 		= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                                                                                                        
		String MST_TM_CD		= nullToBlank(ds_input.getString(0, "MST_TM_CD")); 
		String DATE			= nullToBlank(ds_input.getString(0, "DATE"));

		stmt 		=  conn.createStatement();
	
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();   
        
		// 운영부서 사업장별 상세내역
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT B.JOB_NAME \n");
		sbSql.append("     , B.SUB_JOB_NAME \n");
		sbSql.append("     , B.UPJANGNM \n");
		sbSql.append("     , SUM(AMT01) AS AMT01 \n");
		sbSql.append("     , SUM(AMT02) AS AMT02 \n");
		sbSql.append("     , SUM(AMT03) AS AMT03 \n");
		sbSql.append("     , SUM(AMT04) AS AMT04 \n");
		sbSql.append("     , SUM(AMT05) AS AMT05 \n");
		sbSql.append("     , SUM(AMT06) AS AMT06 \n");
		sbSql.append("     , SUM(AMT07) AS AMT07 \n");
		sbSql.append("     , SUM(AMT08) AS AMT08 \n");
		sbSql.append("     , SUM(AMT09) AS AMT09 \n");
		sbSql.append("     , SUM(AMT10) AS AMT10 \n");
		sbSql.append("     , SUM(AMT11) AS AMT11 \n");
		sbSql.append("     , SUM(AMT12) AS AMT12 \n");
		sbSql.append("     , SUM(AMT13) AS AMT13 \n");
		sbSql.append("     , SUM(AMT14) AS AMT14 \n");
		sbSql.append("     , SUM(AMT15) AS AMT15 \n");
		sbSql.append("     , SUM(AMT16) AS AMT16 \n");
		sbSql.append("     , SUM(AMT17) AS AMT17 \n");
		sbSql.append("     , SUM(AMT18) AS AMT18 \n");
		sbSql.append("     , SUM(AMT01 + AMT02 + AMT03 + AMT04 + AMT05 + AMT06 + AMT07 + AMT09 + AMT10 + AMT11 + AMT12 + AMT13 + AMT14 + AMT15 + AMT16 + AMT17 + AMT18) AS AMT_TOT \n");
		//sbSql.append("     , 0 RATE01, 0 RATE02, 0 RATE03, 0 RATE04 \n");
		//sbSql.append("     , 0 RATE05, 0 RATE06, 0 RATE07, 0 RATE_TOT \n");
		sbSql.append("  FROM ( \n");
		sbSql.append("        SELECT D.UPJANG, D.UPJANGNM \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F10', SUM(D.AMT01), 0) AS AMT01  -- 양곡 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F11', SUM(D.AMT01), 0) AS AMT02  -- 과실 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F12', SUM(D.AMT01), 0) AS AMT03  -- 채소 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F13', SUM(D.AMT01), 0) AS AMT04  -- 축산물 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F14', SUM(D.AMT01), 0) AS AMT05  -- 수산물 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F15', SUM(D.AMT01), 0) AS AMT06  -- 조미/양념 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F16', SUM(D.AMT01), 0) AS AMT07  -- 조리식재 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F17', SUM(D.AMT01), 0) AS AMT08  -- 김치 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F18', SUM(D.AMT01), 0) AS AMT09  -- 빵/떡류 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F19', SUM(D.AMT01), 0) AS AMT10  -- 유가공품 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F20', SUM(D.AMT01), 0) AS AMT11  -- 음료/주류 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F21', SUM(D.AMT01), 0) AS AMT12  -- 공산식품 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F22', SUM(D.AMT01), 0) AS AMT13  -- 가공식품(농산) \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F23', SUM(D.AMT01), 0) AS AMT14  -- 가공식품(수산) \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F24', SUM(D.AMT01), 0) AS AMT15  -- 가공식품(축산) \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F25', SUM(D.AMT01), 0) AS AMT16  -- 식사대용/경관식 \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F26', SUM(D.AMT01), 0) AS AMT17  -- 식자재(호텔/외식) \n");
		sbSql.append("             , DECODE(A.CLASS_CODE,'F99', SUM(D.AMT01), 0) AS AMT18  -- 기타식자재(가공) \n");
		sbSql.append("          FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSql.append("             , ( \n");
		sbSql.append("                SELECT B.UPJANG \n");
		sbSql.append("                     , B.UPJANGNM \n");
		sbSql.append("                     , A.ITEM_CODE \n");
		sbSql.append("                     , D.ITEM_CLASS2 \n");
		sbSql.append("                     , SUM(MARGIN_AMOUNT) AMT01 \n");
		sbSql.append("                  FROM HLDC_PO_TRANSACTION A, \n");
		sbSql.append("                       ST_UPJANG B, \n");
		sbSql.append("                       HLDC_SC_DEPT_V C, \n");
		sbSql.append("                       HLDC_PO_ITEM_MST D \n");
		sbSql.append("                 WHERE TRANS_DATE BETWEEN '" + DATE + "' || '01' AND '" + DATE + "' || '31' -- [기간] \n");
		sbSql.append("                   AND C.TM_CD = '" + MST_TM_CD + "'  --[운영부서-] \n");
		sbSql.append("                   AND D.ITEM_CLASS1  = 'F' \n");
		sbSql.append("                   AND A.ITEM_CODE    = D.ITEM_CODE \n");
		if (UPJANG.length() != 0) 
			sbSql.append("                   AND B.UPJANG = " + UPJANG + " --[사업장] \n");
		sbSql.append("                   AND A.TRANS_MU_CD  = '" + MU_CD+ "' \n");
		sbSql.append("                   AND TRANS_TYPE LIKE 'O%' \n");
		sbSql.append("                   AND TRANS_TYPE <> 'O002' \n");
		sbSql.append("                   AND A.TRANS_UPJANG = TO_CHAR(B.UPJANG) \n");
		sbSql.append("                   AND B.DEPT_ID = C.DEPT_ID \n");
		sbSql.append("                 GROUP BY B.UPJANG, B.UPJANGNM, D.ITEM_CLASS2, A.ITEM_CODE \n");
		sbSql.append("                ) D \n");
		sbSql.append("         WHERE A.CLASS_CODE  = D.ITEM_CLASS2 \n");
		sbSql.append("         GROUP BY D.UPJANG, D.UPJANGNM, A.CLASS_CODE \n");
		sbSql.append("       ) A \n");
		sbSql.append("      ,MAC_UPJANG_V B \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append(" GROUP BY B.JOB_NAME, B.SUB_JOB_NAME, B.UPJANGNM, B.CLOSE_DATE \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");  
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
		this.setResultMessage(0, "OK", out_vl);  
		
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