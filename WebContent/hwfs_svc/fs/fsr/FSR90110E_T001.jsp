<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
�� �ý��۸�     : �޴�����/����������                                                                                                                                                                   
�� ���α׷�ID   : FSR90100E_T001.jsp                                                                                                                                                                    
�� ���α׷���   : �׷췹���Ǵ�������� ���                                                                                                                                               
�� �ۼ�����     : 2015-02-23                                                                                                                                                                           
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
		// �Է� �����ͼ¸���Ʈ
		in_dl = platformRequest.getData().getDataSetList();
		// �Է�  ��������Ʈ
		in_vl = platformRequest.getData().getVariableList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		String g_EmpNo 	   	      = in_vl.getString("g_EmpNo");
		String UPJANG_GRP_SEQ     = nullToBlank(in_vl.getString("GRP_SEQ"));
		String RECIPE_GRP_SEQ     = "";
		String CHK                = "";
		DataSet ds_recipeGrpList  = in_dl.get("ds_recipeGrpList");		
		
		StringBuffer sbSql = new StringBuffer();				
		int RowCnt = ds_recipeGrpList.getRowCount();

		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			CHK            = nullToBlank(ds_recipeGrpList.getString(i,"CHK"));
			RECIPE_GRP_SEQ = nullToBlank(ds_recipeGrpList.getString(i,"GRP_SEQ"));
			
			System.out.println(RECIPE_GRP_SEQ);
			// ����
			if(CHK.equals("0")) {
				sbSql.delete(0, sbSql.length());	
				sbSql.append("DELETE FROM FSR_ENF_RECIPE_UPJANG WHERE RECIPE_GRP_SEQ = " + RECIPE_GRP_SEQ + " AND UPJANG_GRP_SEQ = '" + UPJANG_GRP_SEQ + "'");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			// ���
			} else if(CHK.equals("1")) {
				sbSql.delete(0, sbSql.length());	
				sbSql.append("INSERT INTO FSR_ENF_RECIPE_UPJANG(RECIPE_GRP_SEQ, UPJANG_GRP_SEQ, CUSER, CDATE, UUSER, UDATE) \n");
				sbSql.append("VALUES (" + RECIPE_GRP_SEQ + ", '" + UPJANG_GRP_SEQ + "', '" + g_EmpNo + "', SYSDATE, '" + g_EmpNo + "', SYSDATE) \n");
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
 			}
		}
		
		//Ʈ����� ����
		conn.commit();		 
		this.setResultMessage(0, "OK", out_vl);
	
	} catch(Exception ex) {	
		ex.printStackTrace();
		//Ʈ����� ����
		conn.rollback();
		//jsp �α׳����
		logger.debug(ex.getMessage(), ex);
		//�޼�����ȯ
		this.setResultMessage(-1, ex.toString(),out_vl);
	} finally {
		if(rs != null) {
			try {
				rs.close();
			}catch(Exception e) {}
		}			
		
		if(pstmt != null) {
			try {
				stmt.close();
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