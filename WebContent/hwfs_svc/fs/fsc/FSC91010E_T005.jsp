
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement 			stmt  =  null;
	CallableStatement	cstmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log ���� ���� 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//����Ŀ�� ���� false
		conn.setAutoCommit(false);
		
		//�Է� ����Ÿ                                                                                                                                                                                         
		DataSet ds_Detail  		= in_dl.get("ds_Detail1");
		DataSet ds_input     	= in_dl.get("ds_input"); 

		//out ����Ÿ                                                                                                                                                                                        
		DataSet ds_Detail1;
		
	  	String strTestType		= nullToBlank(ds_input.getString(0, "TEST_TYPE"));
	  	String strFormCD 		= nullToBlank(ds_input.getString(0, "FORM_CD"));
		
		StringBuffer sbSql 	= new StringBuffer();	//sql�� ���ۻ���
		
		int nCnt,DelRowCnt;
		String strMsg, strSeq;
	
		DelRowCnt = ds_Detail.getRemovedRowCount();
		
		if (DelRowCnt > 0)	// 1. ����
		{
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
				strMsg = "��ϵ� �׽�Ʈ������ �ֽ��ϴ�.\nȮ���� �ֽʽÿ�. \n";
				out_dl.add(ds_Detail); 
				this.setResultMessage(-1, strMsg ,out_vl);
				proc_output(response,out,out_vl,out_dl);
				return;
			}
			
			strSeq = ds_Detail.getRemovedData(0, "SEQ").toString();
			
			// �����ϻ���
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_TEST_FORM_DTL \n");
			sbSql.append("WHERE TEST_TYPE = '" + strTestType + "' \n");
			sbSql.append("  AND FORM_CD = '" + strFormCD + "' \n");
			sbSql.append("  AND SEQ = '" + strSeq + "' \n");
			
			stmt 		=  conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();

			//�����������
			cstmt = conn.prepareCall( "{call FSC_TEST_FORM_DTL_UPD_PRO(?, ?, ?, ?)}" );		
			int idx = 1;
			cstmt.setString(idx++, strTestType);
			cstmt.setString(idx++, strFormCD);
			cstmt.registerOutParameter(idx++, Types.VARCHAR);  // �����ڵ�
			cstmt.registerOutParameter(idx++, Types.VARCHAR);  // �����޽���
			cstmt.execute();

			if(cstmt.getString(3).equals("E"))	
			{
				conn.rollback();
				out_dl.add(ds_Detail); 
				this.setResultMessage(-1, cstmt.getString(4), out_vl);
			   	proc_output(response,out,out_vl,out_dl);
			   	return;
			}
			
			conn.commit();
		}
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT TEST_TYPE \n");
		sbSql.append("     , FORM_CD \n");
		sbSql.append("     , SEQ \n");
		sbSql.append("     , TEST \n");
		sbSql.append("     , EXAMPLE1 \n");
		sbSql.append("     , EXAMPLE2 \n");
		sbSql.append("     , EXAMPLE3 \n");
		sbSql.append("     , EXAMPLE4 \n");
		sbSql.append("     , APPEND_FILENM \n");
		sbSql.append("     , SERVER_FILENM \n");
		sbSql.append("     , DISTRIBUTION \n");
		sbSql.append("     , ANSWER \n");
		sbSql.append("     , '' AS IMG_FILE \n");
		sbSql.append("     , '' AS ISUPLOAD \n");
		sbSql.append("  FROM FSC_TEST_FORM_DTL \n");
		sbSql.append(" WHERE TEST_TYPE = '" + strTestType + "' \n");
		sbSql.append("   AND FORM_CD = '" + strFormCD + "' \n");
		sbSql.append("ORDER BY TEST_TYPE, FORM_CD, SEQ \n");
		
		//System.out.println(sbSql.toString());                                                                                                                                                             
		pstmt = conn.prepareStatement(sbSql.toString());		                                                                                                                                                
		rs = pstmt.executeQuery();                                                                                                                                                                          
		ds_Detail1 = this.makeDataSet(rs, "ds_Detail1"); 
		
		rs.close();
		pstmt.close();

		out_dl.add(ds_Detail1); 
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