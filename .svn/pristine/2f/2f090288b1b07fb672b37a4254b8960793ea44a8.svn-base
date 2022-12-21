<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		
		String p_DutySeq	= nullToZero(in_vl.getString("p_DutySeq"));
		String p_Upjang	= nullToZero(in_vl.getString("p_Upjang"));
		
		conn.setAutoCommit(false);
		
		StringBuffer sbDelSql = new StringBuffer();
	
		//전략자재 업장배분 삭제
		sbDelSql.delete(0, sbDelSql.length());
		
		sbDelSql.append("DELETE FROM FSI_DUTY_SET WHERE UPJANG = " + p_Upjang + " AND DUTY_SEQ = " + p_DutySeq + " \n");

		stmt 		=  conn.createStatement();
		stmt.execute(sbDelSql.toString());
		
		conn.commit();
		
	   	this.setResultMessage(0, "OK",out_vl);
		
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