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
		DataSet ds_tableList  		= in_dl.get("ds_tableList");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql�� ���ۻ���
		
		String strTableType,strFormCD,strMsg;
		int nCnt,DelRowCnt;
	
	
		DelRowCnt = ds_tableList.getRemovedRowCount();
		
		if (DelRowCnt > 0)	// 1. ����
		{
			strTableType = ds_tableList.getRemovedData(0, "TABLE_TYPE").toString();
			strFormCD = ds_tableList.getRemovedData(0, "FORM_CD").toString();
			
			// 1. ��üũ
			sbSql.append("SELECT COUNT(*) AS CNT                    \n");
			sbSql.append("  FROM FSC_CONTRT_RESULT                  \n");
			sbSql.append("WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "'       \n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery(); 
			rs.next();
			nCnt = rs.getInt("CNT");
			
			rs.close();
			pstmt.close();
			
			if (nCnt > 0)
			{
				strMsg = "�ۼ��� ���˵�ϳ����� �ֽ��ϴ�.\nȮ���� �ֽʽÿ�. \n";
				this.setResultMessage(-1, strMsg ,out_vl);
				proc_output(response,out,out_vl,out_dl);
				return;
			}
			
			// 2. ��ĸ����ͻ���
			// �ڵ����
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_FORM                \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// 3. �з�����
			// �ڵ����
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_CLASS               \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
			
			// ��ĵ����ϻ���
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_FORM_DTL            \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();

			// ���׸� ����
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_CONTRT_QUST_ARTICLE        \n");
			sbSql.append(" WHERE TABLE_TYPE = '" + strTableType + "' \n");
			sbSql.append("   AND FORM_CD = '" + strFormCD + "'       \n");
			
			stmt = conn.createStatement();
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