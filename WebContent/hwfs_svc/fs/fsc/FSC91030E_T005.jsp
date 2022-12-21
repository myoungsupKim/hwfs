
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
		DataSet ds_Detail1  		= in_dl.get("ds_Detail1");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql�� ���ۻ���
		
		int DelRowCnt;
	
		DelRowCnt = ds_Detail1.getRemovedRowCount();
		
		if (DelRowCnt > 0)	// 1. ����
		{
		  	String strUpjang		= ds_Detail1.getRemovedData(0, "UPJANG").toString();
		  	String strVisitDt 		= ds_Detail1.getRemovedData(0, "VISIT_DT").toString();
		  	Integer intSeqNo 		= Integer.parseInt(ds_Detail1.getRemovedData(0, "SEQNO").toString());
		  	Integer intCheckSeq		= Integer.parseInt(ds_Detail1.getRemovedData(0, "CHECKSEQ").toString());
			
			// ����
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FROM FSC_TEST_EXTERNAL_DTL_PICK \n");
			sbSql.append("WHERE UPJANG = '" + strUpjang + "' \n");
			sbSql.append("  AND VISIT_DT = '" + strVisitDt + "' \n");
			sbSql.append("  AND SEQNO = " + intSeqNo + " \n");
			sbSql.append("  AND CHECKSEQ = " + intCheckSeq + " \n");
			
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