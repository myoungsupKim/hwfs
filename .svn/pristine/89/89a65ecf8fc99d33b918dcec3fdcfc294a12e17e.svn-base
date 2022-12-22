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
		
		//DataSet ds_input  	= in_dl.get("");
		
		String p_SubinvCode	= nullToBlank(in_vl.getString("p_SubinvCode"));
		
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		    	
		sbSelSql.append("SELECT B.SAUP_TYPE \n");
		sbSelSql.append("  FROM PO_SUBINVENTORY A, HWFS_SCO_UPJANG_MST B \n");
		sbSelSql.append(" WHERE A.UPJANG = B.UPJANG \n");
		sbSelSql.append("   AND A.SUBINV_CODE = '" + p_SubinvCode + "' \n");
		
		//pstmt = conn.prepareStatement(sbSelSql.toString());		
		//rs = pstmt.executeQuery();
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());		

		rs.next();
		String strRtn = rs.getString("SAUP_TYPE");;
		out_vl.add("v_SaupType", strRtn);	
		
	   	this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
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