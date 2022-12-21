<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : �޴�����/��������                                                                                                                                                                     
�� ���α׷�ID   : FSC00022P_T001.jsp                                                                                                                                                                    
�� ���α׷���   : ���˰����� - ��������Ʈ��ȸ                                                                                                                                               
�� �ۼ�����     : 2008-03-21                                                                                                                                                                            
�� �ۼ���       : ������                                                                                                                                                                                
�� �̷°���     : 2008-03-21
             : 2013-08-06 ����� ���� FC��ǰ������ �����MGR
             : �ϳ��� �������� �ǿ� �������� ���˰�� ������ ����Ͽ��� �׿� ���� ���������� ������  
               ���常 ��� �����Ͽ����� ���� �Ŀ� ���˰�� ������ �������� ������ �Է��Ѵ�.
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
	                                                                                                                                                                                                        
	
		String strTableType 	= nullToBlank(ds_input.getString(0, "TABLE_TYPE"));
		String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
		String strUpjang 		= nullToBlank(ds_input.getString(0, "MST_UPJANG"));
		String strCheckDate 	= nullToBlank(ds_input.getString(0, "CHECK_DATE"));
		String strClassCD 		= nullToBlank(ds_input.getString(0, "CLASS_CD"));
                                                                                                                                                                                                        
                                                                                                                                                                                                     
		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_list;                                                                                                                                                                                    
		                                                                                                                                                                                                    
		//sql�� ���ۻ���                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// ��������Ʈ��ȸ
		sbSql.delete(0, sbSql.length());
		//=========================================================================================
		// (2013-08-06 ����) ����
		// ����� 2013-08-06   �ϳ��� �������� �ǿ� �������� ���˰�� ������ ����Ͽ��� �׿� ���� ���������� ������  
        //                  ���常 ��� �����Ͽ����� ���� �Ŀ� ���˰�� ������ �������� ������ �Է��Ѵ�.
		//=========================================================================================		
		//sbSql.append("SELECT TABLE_TYPE \n");
		//sbSql.append("     , FORM_CD \n");
		//sbSql.append("     , UPJANG \n");
		//sbSql.append("     , CHECK_DATE \n");
		//sbSql.append("     , CLASS_CD \n");
		//sbSql.append("     , SEQ \n");
		//sbSql.append("     , PHOTO_TYPE \n");
		//sbSql.append("     , PHOTO \n");
		//sbSql.append("     , SPHOTO \n");
		//sbSql.append("  FROM FSC_RESULT_PHOTO \n");
		//sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
		//sbSql.append("   AND FORM_CD = '" + strFormCD + "' \n");
		//sbSql.append("   AND UPJANG = " + strUpjang + " \n");
		//sbSql.append("   AND CHECK_DATE = '" + strCheckDate + "' \n");
		//sbSql.append("   AND CLASS_CD = '" + strClassCD + "' \n");
		//sbSql.append(" ORDER BY SEQ \n");
		
        sbSql.append("SELECT A.TABLE_TYPE                  \n");
        sbSql.append("     , A.FORM_CD                     \n");
        sbSql.append("     , A.UPJANG                      \n");
        sbSql.append("     , A.CHECK_DATE                  \n");
        sbSql.append("     , A.CLASS_CD                    \n");
        sbSql.append("     , A.SEQ                         \n");
        sbSql.append("     , A.PHOTO_TYPE                  \n");
        sbSql.append("     , A.PHOTO  AS PHOTO          \n");
        sbSql.append("     , A.SPHOTO AS SPHOTO         \n");
        sbSql.append("     , B.SEQ    AS IM_SEQ            \n");
        sbSql.append("     , B.PHOTO  AS IM_PHOTO          \n");
        sbSql.append("     , B.SPHOTO AS IM_SPHOTO         \n");
        sbSql.append("  FROM FSC_RESULT_PHOTO A            \n");
        sbSql.append("     , FSC_RESULT_PHOTO B            \n");
        sbSql.append(" WHERE 1 = 1                         \n");
        sbSql.append("   AND A.TABLE_TYPE = B.TABLE_TYPE(+)\n");
        sbSql.append("   AND A.FORM_CD    = B.FORM_CD(+)   \n");
        sbSql.append("   AND A.UPJANG     = B.UPJANG(+)    \n");
        sbSql.append("   AND A.CHECK_DATE = B.CHECK_DATE(+)\n");
        sbSql.append("   AND A.CLASS_CD   = B.CLASS_CD(+)  \n");
        sbSql.append("   AND A.SEQ        = B.MAP_SEQ(+)   \n");
        sbSql.append("   AND A.TABLE_TYPE = '" + strTableType + "' \n");
        sbSql.append("   AND A.FORM_CD    = '" + strFormCD + "'    \n");
        sbSql.append("   AND A.UPJANG     = " + strUpjang + "      \n");
        sbSql.append("   AND A.CHECK_DATE = '" + strCheckDate + "' \n");
        sbSql.append("   AND A.CLASS_CD   = '" + strClassCD + "'   \n");
        sbSql.append("   AND A.INPT_GUBUN = 'IN'           \n");
        sbSql.append("   AND B.INPT_GUBUN(+) = 'IM'        \n");
        sbSql.append(" ORDER BY SEQ                        \n");		
      	//=========================================================================================
		// (2013-08-06 ����) ��
      	//=========================================================================================
      	//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_list = this.makeDataSet(rs, "ds_list"); 
		
		rs.close();
		pstmt.close();
                                                                                                                                                                                                        
		/**����**/                                                                                                                                                                                          
		out_dl.add(ds_list);                                                                                                                                                          
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