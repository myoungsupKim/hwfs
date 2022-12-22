
<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt          =  null;
	CallableStatement cstmt = null;
	PreparedStatement pstmt1 = null;
	
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));		
		String v_SubinvCode 	= in_vl.getString("v_UpjangCode");
		String v_Date 			= in_vl.getString("v_Date");
		String v_Cuser		    = in_vl.getString("v_Cuser");
		
		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn();
		
		conn.setAutoCommit(false);
		
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		pstmt1.close();
		
		//재고실사 반영 프로시저 호출
		//1.재고수량,금액,로스량 재평가... Stored Procedure 호출
		cstmt = conn.prepareCall( "{call FMP_GREEN_AMT_PRO(?, ?, ?, ?)}" );		
		
		cstmt.setString(1,v_SubinvCode);
		cstmt.setString(2,v_Date);
	    cstmt.setString(3,v_Cuser);
		cstmt.registerOutParameter(4, Types.VARCHAR);

		cstmt.execute();
		
		//System.out.println(cstmt.getString(5));
		cstmt.close();
	
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
			if(pstmt1 != null) {
				try {
					pstmt1.close();
				}catch(Exception e) {}
			}			
			if(cstmt != null) {
				try {
					cstmt.close();
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