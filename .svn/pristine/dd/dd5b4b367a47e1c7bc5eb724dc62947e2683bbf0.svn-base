
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
		
		String v_PoType 	= in_vl.getString("v_PoType");
		
/* 		if(conn != null && !conn.isClosed()) conn.close();
		
		conn = getIRISConn(); */
		
		DataSet ds_out;
		StringBuffer sbSelSql = new StringBuffer();
	
		sbSelSql.delete(0, sbSelSql.length());
		
		sbSelSql.append("SELECT /*+ INDEX_ASC(A PO_ITEM_CLASS_HLDC_V_PK) */ \n");
		sbSelSql.append("       A.CLASS_CODE \n");
		sbSelSql.append("     , A.CLASS_NAME \n");
		sbSelSql.append("  FROM HLDC_PO_ITEM_CLASS_HLDC_V A \n");
		sbSelSql.append(" WHERE CLASS_TYPE = 'L' \n");
		sbSelSql.append("   AND USE_YN = 'Y' \n");
		stmt = conn.createStatement();		
		rs = stmt.executeQuery(sbSelSql.toString());
		
		DataSet ds_itemclass1 = this.makeDataSet(rs,"ds_out");
		out_dl.add(ds_itemclass1);
		
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