
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
		
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_Master  		= in_dl.get("ds_Master");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql�� ���ۻ���
		
		String strTestType,strFormCD,strMsg;
		int nCnt,DelRowCnt;
	
	
		DelRowCnt = ds_Master.getRemovedRowCount();
		
		if (DelRowCnt > 0)	// 1. ����
		{
			strTestType = ds_Master.getRemovedData(0, "TEST_TYPE").toString();
			strFormCD = ds_Master.getRemovedData(0, "FORM_CD").toString();
			
			// 1. ��üũ
			sbSql.append("SELECT COUNT(*) AS CNT \n");
			sbSql.append("  FROM FSC_TEST_RESULT_MST \n");
			sbSql.append("WHERE TEST_TYPE = '" + strTestType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
			
			//System.out.println(sbSelSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery(); 
			rs.next();
			nCnt	= rs.getInt("CNT");
			
			rs.close();
			pstmt.close();
			
			if (nCnt > 0)
			{
				strMsg = "�ۼ��� �׽�Ʈ��ϳ����� �ֽ��ϴ�.\nȮ���� �ֽʽÿ�. \n";
				this.setResultMessage(-1, strMsg ,out_vl);
				proc_output(response,out,out_vl,out_dl);
				return;
			}
			
			// 2. �����ͻ���
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_TEST_FORM_MST \n");
			sbSql.append("WHERE TEST_TYPE = '" + strTestType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 3. �����ϻ���
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_TEST_FORM_DTL \n");
			sbSql.append("WHERE TEST_TYPE = '" + strTestType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
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