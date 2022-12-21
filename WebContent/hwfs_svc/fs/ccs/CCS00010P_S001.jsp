<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
			
		DataSet ds_input = in_dl.get("ds_input");
		String UPJANG 		= ds_input.getString(0, "UPJANG");
		String EDU_SEQ 		= ds_input.getString(0, "EDU_SEQ");
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		
		// 사진리스트조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT SRLNUM							    \n");
		sbSql.append("     , UPJANG                             \n");
		sbSql.append("     , EDU_SEQ                            \n");
		sbSql.append("     , ORGNL_IMGE                         \n");
		sbSql.append("     , SVR_IMGE                           \n");
		sbSql.append("     , FILE_SIZE                          \n");
		sbSql.append("     , CUSER                              \n");
		sbSql.append("     , CDATE                              \n");
		sbSql.append("     , UUSER                              \n");
		sbSql.append("     , UDATE                              \n");
		sbSql.append("     , SVR_IMGE AS PRE_VIEW               \n");		
		sbSql.append("     , '' AS FILE_PATH                    \n");	
		sbSql.append("     , '0' AS CHK                         \n");
		sbSql.append("  FROM FCUS.CCS_EDU_MGMT_IMGE             \n");
		sbSql.append(" WHERE 1=1								\n");		
		sbSql.append("   AND UPJANG     = '" + UPJANG + "'      \n");	
		sbSql.append("   AND EDU_SEQ   = '" + EDU_SEQ + "'    	\n");
		sbSql.append(" ORDER BY CDATE DESC                      \n");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		
		DataSet ds_List = this.makeDataSet(rs,"ds_imgeList");
		out_dl.add(ds_List);
		this.setResultMessage(0, "OK",out_vl);
		
	} catch(Exception ex) {
	   ex.printStackTrace();
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
		proc_output(response,out,out_vl,out_dl);
	}
%>