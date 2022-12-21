<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 관리지표                                                                                                                                                                     
■ 프로그램ID   : MAS30010V_S001.jsp                                                                                                                                                                    
■ 프로그램명   : 관리지표                                                                                                                                                 
■ 작성일자     : 2008-07-16                                                                                                                                                                           
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-07-16                                                                                                                                                                            
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
		DataSet ds_input	= in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strGBN 		= nullToBlank(ds_input.getString(0, "GBN"));
	  	String strStdDT 	= nullToBlank(ds_input.getString(0, "STD_DT"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
        
		if (strGBN.equals("1"))			// 안정성 지표
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("-- " + strGBN + " \n");
			sbSql.append("SELECT A_01 AS INDEX_1, B_01 AS INDEX_2, C_01 AS INDEX_3, D_01  AS INDEX_4-- 순서 : 전전년  전년   전월  해당월 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT A_02 AS INDEX_1, B_02 AS INDEX_2, C_02 AS INDEX_3, D_02 AS INDEX_4 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT A_03 AS INDEX_1, B_03 AS INDEX_2, C_03 AS INDEX_3, D_03 AS INDEX_4 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
		}
		else if (strGBN.equals("2"))	// 수익성 지표
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("-- " + strGBN + " \n");
			sbSql.append("SELECT A_04 AS INDEX_1, B_04 AS INDEX_2, C_04 AS INDEX_3, D_04 AS INDEX_4 -- 순서 : 전전년  전년   전월  해당월 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT A_05 AS INDEX_1, B_05 AS INDEX_2, C_05 AS INDEX_3, D_05 AS INDEX_4 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT A_06 AS INDEX_1, B_06 AS INDEX_2, C_06 AS INDEX_3, D_06 AS INDEX_4 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
		}
		else							// 성장성 지표
		{
			sbSql.delete(0, sbSql.length());
			sbSql.append("-- " + strGBN + " \n");
			sbSql.append("SELECT A_07 AS INDEX_1, B_07 AS INDEX_2, C_07 AS INDEX_3, D_07 AS INDEX_4-- 순서 : 전전년  전년   전월  해당월 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT A_08 AS INDEX_1, B_08 AS INDEX_2, C_08 AS INDEX_3, D_08 AS INDEX_4 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
			sbSql.append("UNION ALL \n");
			sbSql.append("SELECT A_09 AS INDEX_1, B_09 AS INDEX_2, C_09 AS INDEX_3, D_09 AS INDEX_4 \n");
			sbSql.append("  FROM MAS_EIS_INDEX \n");
			sbSql.append("  WHERE YYYYMM = '" + strStdDT + "' \n");
		}
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list");   
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
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