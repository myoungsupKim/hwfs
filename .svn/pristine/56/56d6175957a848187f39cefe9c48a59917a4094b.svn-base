<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 위생관리/협력업체위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00310E_T004.jsp                                                                                                                                                                    
■ 프로그램명   : 협력업체점검결과등록 - 중복체크                                                                                                                                               
■ 작성일자     : 2015-02-17                                                                                                                                                                            
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
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
		DataSet ds_resultMst = in_dl.get("ds_resultMst");                                                                                                                                                                                                    
                                                                                                                                                                                                     
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		String TABLE_TYPE = ds_resultMst.getString(0, "TABLE_TYPE");
		String FORM_CD 	  = ds_resultMst.getString(0, "FORM_CD");
		String CUSTCD 	  = ds_resultMst.getString(0, "CUSTCD");
		String CHK_DD     = ds_resultMst.getString(0, "CHK_DD");
		
		// 정검양식조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT COUNT(1) AS CNT                   \n");
		sbSql.append("  FROM FSC_CONTRT_RESULT                 \n");
		sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
		sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
		sbSql.append("   AND CUSTCD     = '" + CUSTCD     + "' \n");
		sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");

		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();
		rs.next();
		int iCnt = rs.getInt("CNT");
		
		rs.close();
		pstmt.close();

		/**종료**/
		if (iCnt > 0) {
			this.setResultMessage(-1, "해당 점검일의 점검 결과가 존재합니다.", out_vl);
		} else {
			this.setResultMessage(0, "OK", out_vl);
		}
	}                                                                                                                                                                                                     
	catch(Exception ex)                                                                                                                                                                                   
	{                                                                                                                                                                                                     
		ex.printStackTrace();
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