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
		
		conn.setAutoCommit(false);
		
		//StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbDelSql = new StringBuffer();
	
		//업장배분 여부 확인
		//sbSelSql.delete(0, sbSelSql.length());
		//sbSelSql.append("SELECT 1 FROM FSI_DUTY_SET WHERE DUTY_SEQ = " + p_DutySeq + " AND ROWNUM = 1 \n");

		//stmt = conn.createStatement();		
		//rs = stmt.executeQuery(sbSelSql.toString()); 
		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery(); 
		
		//if(rs.next())
		//{
			//out_vl.add("strSetCnt", "해당 자재는 이미 업장배분이 되어 삭제할 수 없습니다.");
			//System.out.println("strSetCnt:해당 자재는 이미 업장배분이 되어 삭제할 수 없습니다.");
		   	//this.setResultMessage(0, "OK",out_vl);	
		   	//proc_output(response,out,out_vl,out_dl);
		   	//return;
		//}
		
		//rs.close();
		//stmt.close();
		
		//전략자재마스터 삭제
		sbDelSql.delete(0, sbDelSql.length());
		
		sbDelSql.append("DELETE FROM FSI_DUTY_MST WHERE DUTY_SEQ = " + p_DutySeq + " \n");

		//System.out.println(sbInsSql.toString());
		stmt = conn.createStatement();
		stmt.execute(sbDelSql.toString());
		
		//배분자료 삭제
		sbDelSql.delete(0, sbDelSql.length());
		
		sbDelSql.append("DELETE FROM FSI_DUTY_SET WHERE DUTY_SEQ = " + p_DutySeq + " \n");

		//System.out.println(sbInsSql.toString());
		stmt = conn.createStatement();
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