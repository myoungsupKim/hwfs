<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : ��������/�ܺα�����˰���                                                                                                                                                                     
�� ���α׷�ID   : FSC91030P_T001.jsp                                                                                                                                                                    
�� ���α׷���   : ���˻�������                                                                                                                                                 
�� �ۼ�����     : 2019-07-04                                                                                                                                                                            
�� �ۼ���       : ���                                                                                                                                                                                
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ include file = "../../sc/main/common.jsp" %>                                                                                                                                                        
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();  
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_input     = in_dl.get("ds_input");                                                                                                                                                  
	                                                                                                                                                                                                        
	  	String strUpjang		= ds_input.getString(0, "UPJANG");
	  	String strVisitDt 		= ds_input.getString(0, "VISIT_DT");
	  	String strSeqNo 		= ds_input.getString(0, "SEQNO");
	  	String strCheckSeq 		= ds_input.getString(0, "CHECKSEQ");
                                                                                                                                                                                                     
		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_imgeList;
		                                                                                                                                                                                                    
		//sql�� ���ۻ���                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// �з���ȸ
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT UPJANG \n");
		sbSql.append("     , VISIT_DT \n");
		sbSql.append("     , SEQNO \n");
		sbSql.append("     , CHECKSEQ \n");
		sbSql.append("     , IMGESEQ \n");
		sbSql.append("     , ORG_IMGE \n");
		sbSql.append("     , SVR_IMGE \n");
		sbSql.append("     , '' AS IMG_FILE \n");
		sbSql.append("     , '' AS ISUPLOAD \n");
		sbSql.append("     , IMPROV_ORG_IMGE \n");
		sbSql.append("     , IMPROV_SVR_IMGE \n");
		sbSql.append("     , '' AS IMPROV_IMG_FILE \n");
		sbSql.append("     , '' AS IMPROV_ISUPLOAD \n");
		sbSql.append("  FROM FSC_TEST_EXTERNAL_IMGE \n");
		sbSql.append(" WHERE UPJANG = '" + strUpjang + "' \n");
		sbSql.append("   AND VISIT_DT = '" + strVisitDt + "' \n");
		sbSql.append("   AND SEQNO = " + strSeqNo + " \n");
		sbSql.append("   AND CHECKSEQ = " + strCheckSeq + " \n");
		sbSql.append("ORDER BY IMGESEQ \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_imgeList = this.makeDataSet(rs, "ds_imgeList"); 
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**����**/                                                                                                                                                                                          
		out_dl.add(ds_imgeList); 
		this.setResultMessage(0, "OK", out_vl);                                                                                                                                                             
                                                                                                                                                                                                        
	}                                                                                                                                                                                                     
	catch(Exception ex)                                                                                                                                                                                   
	{                                                                                                                                                                                                     
		//ex.printStackTrace();
		//jsp �α׳����
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
		
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}                                                                                                                                                                                                     
                                                                                                                                                                                                        
	proc_output(response,out,out_vl,out_dl);                                                                                                                                                              
                                                                                                                                                                                                        
%>