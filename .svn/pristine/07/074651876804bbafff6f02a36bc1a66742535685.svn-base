
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
		
		stmt 		=  conn.createStatement();
	
		DataSet ds_out;
		StringBuffer sbSql = new StringBuffer();
		sbSql.delete(0, sbSql.length());
		
		/* sbSql.append("\n SELECT A.PO_TYPE, A.TYPE_NAME  ");
		sbSql.append("\n   FROM PO_TYPE A, PO_USER_POSITION B  ");
		sbSql.append("\n  WHERE A.PO_TYPE  = B.PO_TYPE  ");
		if(! v_EmpNo.equals("")){
			sbSql.append("\n    AND B.SABUN    = '"+v_EmpNo+"'   --'900101004'  -- [g_EmpNo]  ");
		}
		sbSql.append("\n    AND B.POS_CODE = '004'        -- [PO_COMMON.js => dsPoAuthType.GetColumn(0,'Pr') ]  ");
		sbSql.append("\n    AND B.USE_YN   = 'Y'  ");
		sbSql.append("\n    AND A.USE_YN   = 'Y'  ");
		sbSql.append("\n  ORDER BY 2  "); */
		
		sbSql.append("\n SELECT A.PO_TYPE, A.TYPE_NAME  ");
		sbSql.append("\n   FROM HLDC_PO_TYPE_FS A");
		sbSql.append("\n  ORDER BY 2  ");
		
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		DataSet ds_poType = this.makeDataSet(rs,"ds_poType");
		out_dl.add(ds_poType);
		
		rs.close();
		pstmt.close();
		
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
			//jsp log 서비스 닫기 
			try {
				logger.endIndividualLog();
			} catch( Exception logE) {
				logE.printStackTrace();
			}			
		}
		
	  proc_output(response,out,out_vl,out_dl);
	
%>