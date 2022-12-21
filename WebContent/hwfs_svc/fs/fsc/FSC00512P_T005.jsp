<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : �޴�����/���¾�ü��������                                                                                                                                                                     
�� ���α׷�ID   : FSC00312P_T005.jsp                                                                                                                                                                    
�� ���α׷���   : ���˰����� - ������������Ʈ��ȸ                                                                                                                                               
�� �ۼ�����     : 2015-02-09                                                                                                                                                                            
�� �ۼ���       : ��μ�                                                                                                                                                                                
�� �̷°���     : 2015-02-09                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      
                                                                                                                                                                    
<%@ page contentType="text/html; charset=EUC-KR" %>                                                                                                                                                     
<%@ page language="java" import="java.util.*,java.io.*" %>
<%@ page language="java" import="java.util.*,java.net.*" %>
<%@ include file = "../../sc/main/common.jsp" %>       
                                                                                                                                                 
<%
	try {
		PlatformRequest platformRequest = this.proc_input(request);                                                                                                                                           
		in_vl = platformRequest.getData().getVariableList();                                                                                                                                                            
		in_dl = platformRequest.getData().getDataSetList();  
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
	                                                                                                                                                                                                        
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_cond     = in_dl.get("ds_cond");                                                                                                                                                  
		String RGST_DATE 	= nullToBlank(ds_cond.getString(0, "RGST_DATE"));
		String GUBUN 	    = nullToBlank(ds_cond.getString(0, "GUBUN"));
		String UPJANG 	    = nullToBlank(ds_cond.getString(0, "UPJANG"));
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_imgeSvrList = new DataSet("output"); 
		
		//sql�� ���ۻ���                                                                                                                                                                                    
		StringBuffer sbSql = new StringBuffer();                                                                                                                                                            
         
		// ��������Ʈ��ȸ
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT 0 AS CHK                                \n");
		sbSql.append("     , RGST_SEQ                                \n");		
		sbSql.append("     , UPJANG                                  \n");
		sbSql.append("     , RGST_DATE                               \n");
		sbSql.append("     , GUBUN                                   \n");
		sbSql.append("     , FILE_NM                                 \n");
		sbSql.append("     , REL_PATH                                \n");
		sbSql.append("     , REL_PATH || '/' || FILE_NM AS PRE_VIEW  \n");
		sbSql.append("     , FILE_SIZE                               \n");
		sbSql.append("     , BIGO                                    \n");
		sbSql.append("     , CUSER                                   \n");
		sbSql.append("     , CDATE                                   \n");
		sbSql.append("     , UUSER                                   \n");
		sbSql.append("     , UDATE                                   \n");
		sbSql.append("     , '' PHOTO_TYPE                           \n");
		sbSql.append("  FROM SCZ_PHOTO_IMGSEND                       \n");
		sbSql.append(" WHERE RGST_DATE = '" + RGST_DATE + "'         \n");
		sbSql.append("   AND GUBUN     = '" + GUBUN + "'             \n");
		sbSql.append("   AND UPJANG     = '" + UPJANG + "'           \n");
		//sbSql.append("   AND CUSER     = '" + g_EmpNo + "'         \n");
		sbSql.append(" ORDER BY CDATE DESC                           \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_imgeSvrList = this.makeDataSet(rs, "ds_imgeSvrList");                                                                                                                                                          

		rs.close();
		pstmt.close();
		
		/**����**/
		out_dl.add(ds_imgeSvrList);                                                                                                                                                          
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