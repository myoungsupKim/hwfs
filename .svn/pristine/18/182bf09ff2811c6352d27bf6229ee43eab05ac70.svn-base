<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     :                                                                                                                                                                
■ 프로그램ID  : FSA00090E_S001.jsp                                                                                                                                                                  
■ 프로그램명   : 추가구매 승인 신청                                                                                                                                              
■ 작성일자     : 2008-07-21                                                                                                                                                                        
■ 작성자       : 박지영
■ 수정자       : 정영철
■ 이력관리     : 2015-06-10                                                                                                                                     
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
	                                                                                                                                                                                                        
		String strUpjang 		= nullToBlank(ds_input.getString(0, "UPJANG"));                                                                                                                                                                                                        
		String strFromDt		= nullToBlank(ds_input.getString(0, "FROM_DT"));
	  	String strToDt 			= nullToBlank(ds_input.getString(0, "TO_DT")); 
	  	String strAprvYN		= nullToBlank(ds_input.getString(0, "APRV_YN"));
	  	String strMuCD			= nullToBlank(ds_input.getString(0, "MU_CD"));
	  	String strTmCD			= nullToBlank(ds_input.getString(0, "TM_CD"));
                                                                                                                                                                                                                                                                                                                                                                                       
		//out 데이타                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql문 버퍼생성                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// 추가구매 승인 신청 조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT A.UPJANG \n");
		sbSql.append("     , B.UPJANGNM \n");
		sbSql.append("     , A.START_DATE \n");
		sbSql.append("     , A.END_DATE \n");
		sbSql.append("     , DECODE(A.ATTR01, '', '기타사유', A.ATTR01)  AS REASON_CD \n");
		sbSql.append("     , A.PR_REASON \n");
		//sbSql.append("     , DECODE(NVL(A.ATTR01,''),'',A.PR_REASON,SCC_CODE_NM('FS0124',A.PR_REASON)) PR_REASON \n");
		sbSql.append("     , A.PR_DATE \n");
		sbSql.append("     , A.APRV_YN \n");
		sbSql.append("     , DECODE(A.APRV_YN,'Y','1','0') AS APRV_10 \n");
		sbSql.append("     , A.START_DATE AS OLD_START \n");
		sbSql.append("     , A.END_DATE AS OLD_END \n");
		sbSql.append("     , B.MU_CD AS MU_CD \n");
		sbSql.append("     , B.MU_NAME AS MU_NAME \n");
		sbSql.append("     , B.TM_CD AS TM_CD \n");
		sbSql.append("     , B.TM_NAME AS TM_NAME \n");
		sbSql.append("  FROM FSA_PR_CHECK A \n");
		sbSql.append("     , MAC_UPJANG_V B \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSql.append("   AND A.PR_DATE BETWEEN '" + strFromDt + "' AND '" + strToDt + "' \n");
		if (strUpjang.length() != 0)		sbSql.append("   AND A.UPJANG = '" + strUpjang + "' \n");
		if (strMuCD.length() != 0)			sbSql.append("   AND B.MU_CD = '" + strMuCD + "' \n");
		if (strTmCD.length() != 0)			sbSql.append("   AND B.TM_CD = '" + strTmCD + "' \n");
		if (strAprvYN.length() != 0)		sbSql.append("   AND A.APRV_YN = '" + strAprvYN + "' \n");
		sbSql.append(" ORDER BY A.UPJANG, A.PR_DATE, A.START_DATE, A.END_DATE \n");
		
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