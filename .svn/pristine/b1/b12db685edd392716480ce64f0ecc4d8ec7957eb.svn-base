<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단관리                                                                                                                                                                     
■ 프로그램ID   : FSM00281P_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 학교직군레시피수정-자재추가리스트조회                                                                                                                                                 
■ 작성일자     : 2008.02.19                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008.02.19                                                                                                                                                                            
1)박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
기획자재 배분 안함, 기획자재(명칭이 ▶으로 시작)인 경우 조회상단에 뜨게.
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
		//FileLog.println("d:\\aaa.txt", ds_cond);                                                                                                                                                            
		                                                                                                                                                                                                      
	                                                                                                                                                                                                        
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                           
		String strHalCD			= nullToBlank(ds_input.getString(0, "HALL_CD"));                                                                                                                          
		String strMenuDate		= nullToBlank(ds_input.getString(0, "MENU_DATE"));                                                                                                                      
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_item;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
                                                                                                                                                                                                        
		//내역조회                                                                                                                                                                                          
		sbSql.delete(0, sbSql.length());                                                                                                                                                                                                                                                                                                                                     
		sbSql.append("SELECT " + strUpjang + " AS UPJANG \n");                                                                                                                                               
		sbSql.append("     , '' AS MENU_CD \n");                                                                                                                                                            
		sbSql.append("     , '" + strMenuDate + "' AS MENU_DATE \n");                                                                                                                                       
		sbSql.append("     , '' AS MENU_NAME \n");                                                                                                                                                          
		sbSql.append("     , '" + strHalCD + "' AS HALL_CD \n");                                                                                                                                            
		sbSql.append("     , '' AS RECIPE_CD \n");                                                                                                                                                          
		sbSql.append("     , '' AS RECIPE_NAME \n");                                                                                                                                                        
		sbSql.append("     , A.ITEM_CODE \n");                                                                                                                                                              
		sbSql.append("     , C.ITEM_NAME \n");                                                                                                                                                              
		sbSql.append("     , C.ITEM_SIZE \n");                                                                                                                                                              
		sbSql.append("     , C.PO_UOM \n");                                                                                                                                                                 
		sbSql.append("     , 0 AS NEED_QTY \n");                                                                                                                                                            
		sbSql.append("     , 0 AS EDIBLE_QTY \n");                                                                                                                                                          
		sbSql.append("     , 0 AS TOT_QTY \n");                                                                                                                                                             
		sbSql.append("     , A.TRANS_QTY PR_QTY \n");                                                                                                                                                       
		sbSql.append("     , 0 AS TOT_AMT \n");                                                                                                                                                             
		//sbSql.append("     , NVL(ROUND(A.TRANS_QTY*DECODE(A.OUTVAT_FLAG, 'Y', DECODE(A.TAX_CODE, '100', ROUND( A.TRANS_MPRICE * 1.1 / 10 ) * 10, A.TRANS_MPRICE), A.TRANS_MPRICE)/10)*10,0) PR_AMT \n");    
		//sbSql.append("     , NVL(ROUND(DECODE(A.OUTVAT_FLAG, 'Y', DECODE(A.TAX_CODE, '100', ROUND( A.TRANS_MPRICE * 1.1 / 10 ) * 10, A.TRANS_MPRICE), A.TRANS_MPRICE)/C.KG_CONVERT_RATE,2),0) KG_PRICE \n");
		//sbSql.append("     , A.TRANS_UPRICE UNIT_PRICE \n");                                                                                                                                                
		//sbSql.append("     , DECODE(A.OUTVAT_FLAG, 'Y', DECODE(A.TAX_CODE, '100', ROUND( A.TRANS_MPRICE * 1.1 / 10 ) * 10, A.TRANS_MPRICE), A.TRANS_MPRICE) MARGIN_PRICE \n");                              
		//sbSql.append("     , ROUND(((A.TRANS_MPRICE / A.TRANS_UPRICE)-1)*100) MARGIN_RATE \n");
		sbSql.append("     , A.TRANS_MPRICE  -- 관리단가 \n");
		sbSql.append("     , C.KG_CONVERT_RATE \n");                                                                                                                                                        
		sbSql.append("     , C.POINT_FLAG \n");                                                                                                                                                             
		sbSql.append("     , C.MIN_ORD_QTY \n");                                                                                                                                                            
		sbSql.append("     , C.MULTIPLIER_QTY \n");                                                                                                                                                         
		sbSql.append("     , 0 AS SALE_PRICE \n");                                                                                                                                                          
		sbSql.append("     , 0 AS EXPECT_MEAL_QTY \n");                                                                                                                                                     
		sbSql.append("     , D.CAL --열량 \n");
		sbSql.append("     , D.WATER --수분 \n");
		sbSql.append("     , D.PROT --단백질 \n");
		sbSql.append("     , D.FAT --지질 \n");
		sbSql.append("     , D.CARBO --당질 \n");
		sbSql.append("     , D.FIBER --섬유 \n");
		sbSql.append("     , D.ASH --회분 \n");
		sbSql.append("     , D.CA --칼슘 \n");
		sbSql.append("     , D.P --인 \n");
		sbSql.append("     , D.FE --철 \n");
		sbSql.append("     , D.NA --나트륨 \n");
		sbSql.append("     , D.K --칼륨 \n");
		sbSql.append("     , D.VITA_A --비타민A \n");
		sbSql.append("     , D.RETIN --레티놀 \n");
		sbSql.append("     , D.B_CAROT --B_카르틴 \n");
		sbSql.append("     , D.THIA --비타민B1 \n");
		sbSql.append("     , D.RIBO --비타민B2 \n");
		sbSql.append("     , D.NIACIN --나이아신 \n");
		sbSql.append("     , D.VITA_C --비타민C \n");
		sbSql.append("     , D.CHOLE --콜레스테롤 \n");
		sbSql.append("     , D.DISUSE_RATE \n");                                                                                                                                                            
		sbSql.append("  FROM HLDC_PO_TRANSACTION A \n");                                                                                                                                                    
		sbSql.append("     , HLDC_PO_ITEM_MST C \n");                                                                                                                                                       
		sbSql.append("     , FSI_ITEM_NUT D \n");                                                                                                                                                           
		sbSql.append(" WHERE A.SOURCE_TYPE = 'PO' \n");                                                                                                                                                       
		sbSql.append("   AND A.TRANS_UPJANG = '" + strUpjang + "' \n");                                                                                                                                       
		sbSql.append("   AND A.SUBINV_CODE IN ('" + nullToBlank(ds_input.getString(0, "SUBINV_CODE")) + "') \n");                                                                                                                                            
		sbSql.append("   AND A.TRANS_DATE = '" + strMenuDate + "' \n");                                                                                                                                       
		sbSql.append("   AND A.TRANS_TYPE = 'I001' \n");                                                                                                                                                      
		sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");                                                                                                                                                
		sbSql.append("   AND A.ITEM_CODE = D.ITEM_CODE(+) \n");                                                                                                                                             
		//============================================================================================
		//(2012-11-05수정) 시작
		// 박은규 2012-11-05 CSR#(CH201210_00143) 요청자:박현정(FS기획팀)
		// 기획자재 배분 안함, 기획자재(명칭이 ▶으로 시작)인 경우 조회상단에 뜨게.
		//============================================================================================
		//sbSql.append(" ORDER BY A.ITEM_CODE \n");                                                                                                                                             
		sbSql.append(" ORDER BY A.ITEM_NAME \n");                                                                                                                                             
		//============================================================================================
		//(2012-11-05수정) 끝
		//============================================================================================
		                                                                                                                                                                                                    
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_item = this.makeDataSet(rs, "ds_item");  
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**종료**/                                                                                                                                                                                          
		out_dl.add(ds_item);                                                                                                                                                          
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