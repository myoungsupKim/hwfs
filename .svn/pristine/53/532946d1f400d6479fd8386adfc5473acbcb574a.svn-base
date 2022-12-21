<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 
■ 프로그램ID   : FSA00040E_T001.jsp
■ 프로그램명   : 월말목표재고비율 설정
■ 작성일자     : 2008-06-26
■ 작성자       : 
■ 이력관리     : 2008-06-26 - 최초작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt             =  null;
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//입력 데이타
		DataSet dsInput      = in_dl.get("ds_Input");
		DataSet dsList      = in_dl.get("ds_List");
		
		//입력 파라메터
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		
		// 변수 설정 
		double dGoalRate   = dsInput.getDouble(0, "GOAL_RATE"   );
		int    iStartMonth = dsInput.getInt(0, "START_MONTH");
		
		int    iUpjang     = 0;
		String sGoalMm     = "";
		String sYear       = "";
    
	    // Query StringBuffer
	    StringBuffer sbQuery = new StringBuffer();
		
	    // Query Setting
	    for( int i = 0; i < dsList.getRowCount(); i++ ) {
	    	sYear   = dsList.getString (i, "GOAL_YEAR");
	    	iUpjang = dsList.getInt(i, "UPJANG"   );
	    	
	    	for( int j = iStartMonth; j <= 12; j++ ) {

	    		if( Integer.toString(j).length() == 1 ) {
	    			sGoalMm = sYear + "0" + Integer.toString(j);
	    		} else {
	    			sGoalMm = sYear + Integer.toString(j);
	    		}
	    		sbQuery.setLength(0);
	    		sbQuery.append("\n MERGE INTO FSA_STOCK_GOAL_SET                        									");
	    		sbQuery.append("\n      USING DUAL                                      									");
	    		sbQuery.append("\n         ON (UPJANG = " + iUpjang + "          										    ");
	    		sbQuery.append("\n   AND GOAL_MM = '" + sGoalMm + "')                  										");
	    		sbQuery.append("\n  WHEN MATCHED THEN           									                        ");
	    		sbQuery.append("\n UPDATE                           									                    ");
	    		sbQuery.append("\n  SET GOAL_RATE = " + dGoalRate + "										                ");
	    		sbQuery.append("\n  , UUSER = '" + g_EmpNo + "'            										            ");
	    		sbQuery.append("\n  , UDATE = SYSDATE                        										        ");
	    		sbQuery.append("\n   WHEN NOT MATCHED THEN                          									    ");
	    		sbQuery.append("\n INSERT       										                                    ");
	    		sbQuery.append("\n        (UPJANG, GOAL_MM, GOAL_RATE, CUSER, CDATE)                                        ");
	    		sbQuery.append("\n  VALUES(" + iUpjang + ",'" + sGoalMm + "'," + dGoalRate + ",'" + g_EmpNo +"', SYSDATE) ");

				//out_vl.add("fa_Sql", sbQuery.toString());
				//System.out.println(sbQuery.toString());
				stmt 		=  conn.createStatement();
				stmt.execute(sbQuery.toString());
				stmt.close();
				
	    	} // End for
	    } // End for
			
		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	catch(Exception ex)
	{
		conn.rollback();
		ex.printStackTrace();
		this.setResultMessage(-1, ex.toString(),out_vl);
	}
	finally
	{
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
	}

	proc_output(response,out,out_vl,out_dl);

%>
