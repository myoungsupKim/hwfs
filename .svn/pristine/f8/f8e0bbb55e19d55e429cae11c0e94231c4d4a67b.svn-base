<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//데이타               
		String g_EmpNo        = in_vl.getString("g_EmpNo");
		String strUpjang      = nullToBlank(in_vl.getString("UPJANG"));		
		String strVisitDt     = nullToBlank(in_vl.getString("VISIT_DT"));		
		String strSeqNo       = nullToBlank(in_vl.getString("SEQNO"));		
		String strCheckSeq    = nullToBlank(in_vl.getString("CHECKSEQ"));		
		String strImgeSeq     = nullToBlank(in_vl.getString("IMGESEQ"));		
		
		int RowStatus;
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		
		sbSql.delete(0, sbSql.length());
		sbSql.append("DELETE FROM FSC_TEST_EXTERNAL_IMGE   \n");
		sbSql.append(" WHERE UPJANG = '" + strUpjang  + "' \n");
		sbSql.append("   AND VISIT_DT = '" + strVisitDt  + "' \n");
		sbSql.append("   AND SEQNO = " + strSeqNo  + " \n");
		sbSql.append("   AND CHECKSEQ = " + strCheckSeq  + " \n");
		sbSql.append("   AND IMGESEQ = " + strImgeSeq  + " \n");
				
		stmt = conn.createStatement();
		stmt.execute(sbSql.toString());
		stmt.close();
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
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
		
		//jsp log 서비스 닫기 
		try {
			logger.endIndividualLog();
		} catch( Exception logE) {
			logE.printStackTrace();
		}
	}
		
	proc_output(response,out,out_vl,out_dl);
	
%>	