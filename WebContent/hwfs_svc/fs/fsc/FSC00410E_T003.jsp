<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : ��������/CS���ܰ���                                                                                                                                                              
�� ���α׷�ID   : FSC00410E_T003.jsp                                                                                                                                                                    
�� ���α׷���   : ��Ʈ�����˰����� - ���˰������                                                                                                                                               
�� �ۼ�����     : 2015-02-25                                                                                                                                                                            
�� �ۼ���       : ��μ�                                                                                                                                                                                
�� �̷°���     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
		
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_resultList = in_dl.get("ds_resultList");

		StringBuffer sbSql = new StringBuffer();	//sql�� ���ۻ���
		
		int nCnt,DelRowCnt;
		DelRowCnt = ds_resultList.getRemovedRowCount();
		if (DelRowCnt > 0)	// 1. ����
		{
			String TABLE_TYPE = ds_resultList.getRemovedData(0, "TABLE_TYPE").toString();
			String FORM_CD 	  = ds_resultList.getRemovedData(0, "FORM_CD").toString();
			String UPJANG 	  = ds_resultList.getRemovedData(0, "UPJANG").toString();
			String CHK_DD     = ds_resultList.getRemovedData(0, "CHK_DD").toString();
			
			// 1. ��������ͻ��� 
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE                                   \n");
			sbSql.append("  FROM FSC_PATL_RESULT                 \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG     + "' \n");
			sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 2. ��������ϻ���
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE                                   \n");
			sbSql.append("  FROM FSC_PATL_RESULT_DTL                    \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG     + "' \n");
			sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 2. ���ϻ���
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE                                   \n");
			sbSql.append("  FROM FSC_PATL_CHK_IMGE               \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + TABLE_TYPE + "' \n");
			sbSql.append("   AND FORM_CD    = '" + FORM_CD    + "' \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG     + "' \n");
			sbSql.append("   AND CHK_DD     = '" + CHK_DD     + "' \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		ex.printStackTrace();
		//jsp �α׳����
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
		
		//jsp log ���� �ݱ� 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}
		
    proc_output(response,out,out_vl,out_dl);
%>	