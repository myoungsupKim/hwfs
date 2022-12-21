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
		
		DataSet in_ds  =  in_dl.get("ds_add_item");
	
		int intRowCnt = 0;
		int intErrCnt = 0;
		String strRtn = "";
		StringBuffer sbSql = new StringBuffer();
		intRowCnt = in_ds.getRowCount();	
		
		String strItem = "";
		String strStart = "";
		String strEnd = "";
		String strSeq = "";
		
		for ( int i = 0 ; i < intRowCnt ; i++ )
		{
			strItem = in_ds.getString(i,"ITEM_CODE");
			strStart= in_ds.getString(i,"RESTRICT_START");
			strEnd  = in_ds.getString(i,"RESTRICT_END");
			strSeq  = nullToBlank(in_ds.getString(i,"RESTRICT_SEQ"));
			
			//FileLog.println("c:\\aaa.txt",in_ds);
			
			sbSql.delete(0, sbSql.length());
			
			sbSql.append("SELECT DISTINCT ITEM_CODE \n");
			sbSql.append("  FROM FSI_RESTRICT_MST \n");
			sbSql.append(" WHERE USE_YN = 'Y' \n");
			sbSql.append("   AND ITEM_CODE = '" + strItem + "' \n");
			if(strSeq != "")
				sbSql.append("   AND RESTRICT_SEQ <> " + strSeq + " \n");
			sbSql.append("   AND ( (RESTRICT_START BETWEEN '" + strStart + "' AND '" + strEnd + "') \n");
			sbSql.append("       OR (RESTRICT_END BETWEEN '" + strStart + "' AND '" + strEnd + "') \n");
			sbSql.append("       OR (RESTRICT_START <= '" + strStart + "' AND RESTRICT_END >= '" + strEnd + "') )	 \n");		
			
			stmt = conn.createStatement();		
			rs = stmt.executeQuery(sbSql.toString()); 
			//pstmt = conn.prepareStatement(sbSql.toString());
			//rs = pstmt.executeQuery(); 			
			
			if(rs.next())
			{
				if(intErrCnt > 0) strRtn += ",";
				strRtn += rs.getString("ITEM_CODE");
				
				//System.out.println(out_vl.getString("v_SvrItem"));
				
				intErrCnt++;
			}
			
			rs.close();
			stmt.close();
		}
	
		out_vl.add("v_SvrItem", strRtn);				
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