<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 경영관리/주간실적관리■ 프로그램ID   : MAS10021P_T001.jsp■ 프로그램명   : 업장 전체 정수기 목록■ 작성일자     : 2015-04-28■ 작성자       : 박용대■ 이력관리     : 
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
		DataSet ds_Cond = in_dl.get("inDs_Cond");
		
		String MU_CD = nullToBlank(ds_Cond.getString(0, "MU_CD"));
		String TM_CD = nullToBlank(ds_Cond.getString(0, "TM_CD"));
		String UPJANG = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		
		//out 데이타                                                                                                                                                                                        
		DataSet ds_List;
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
	     
		sbSql.delete(0, sbSql.length());
		
	    sbSql.append("SELECT B.TM_CD, B.TM_NM, A.UPJANG,                                                                                                                  \n");
	    sbSql.append("       (SELECT AA.UPJANGNM FROM HLDC_ST_UPJANG AA WHERE AA.UPJANG = A.UPJANG) UPJANGNM,                                           \n");
	    sbSql.append("       --A.PURIFIER_COMPANY,                                                                                                      \n");
	    sbSql.append("       (SELECT AA.CODE_NAME FROM SCC_COMMON_CODE AA WHERE AA.GROUP_CODE = 'MA0024' AND AA.CODE = A.PURIFIER_COMPANY) PURIFIER_COMPANY, \n");
	    sbSql.append("       --A.FILTER_COMPANY,                                                                                                        \n");
	    sbSql.append("       (SELECT AA.CODE_NAME FROM SCC_COMMON_CODE AA WHERE AA.GROUP_CODE = 'MA0025' AND AA.CODE = A.FILTER_COMPANY) FILTER_COMPANY, \n");
	    sbSql.append("       A.RETAL_YN,                                                                                                                \n");
	    sbSql.append("       --A.MGMT_CD,                                                                                                               \n");
	    sbSql.append("       (SELECT AA.CODE_NAME FROM SCC_COMMON_CODE AA WHERE AA.GROUP_CODE = 'MA0025' AND AA.CODE = A.MGMT_CD) MGMT_CD,              \n");
	    sbSql.append("       A.QTY,                                                                                                                     \n");
	    sbSql.append("       A.CTRT_DATE,                                                                                                               \n");
	    sbSql.append("       A.CTRT_END_DATE                                                                                                            \n");
	    sbSql.append("  FROM SCO_UPJANG_PURIFIER A, SCO_UPJANG_MST_V B \n");
	    sbSql.append("    WHERE 1=1 --A.UPJANG = '107007' \n");
	    sbSql.append("    AND A.UPJANG = B.UPJANG \n");
	    sbSql.append("    AND (B.CLOSE_DATE > TO_CHAR(SYSDATE,'YYYYMMDD') OR B.CLOSE_DATE IS NULL) \n");
	    if(!MU_CD.equals(""))
	    {
	    	sbSql.append("    AND B.MU_CD = '" + MU_CD + "' \n");	
	    }
	    
	    if(!TM_CD.equals(""))
	    {
	    	sbSql.append("    AND (B.TM_CD = '" + TM_CD + "' OR B.PT_CD = '" + TM_CD + "') \n");
	    }
	    
	    if(!UPJANG.equals(""))
	    {
	    	sbSql.append("    AND B.UPJANG = '" + UPJANG + "' \n");
	    }
	    
	    sbSql.append("    ORDER BY 1 \n");
		
	    out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");

		pstmt.close();
		rs.close();

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