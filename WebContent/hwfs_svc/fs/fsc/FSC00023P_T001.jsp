<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 특별교육
■ 프로그램ID   : FSC00023P_T001.jsp
■ 프로그램명   : 특별교육 등록
■ 작성일자     : 20161226
■ 작성자       : 박용대
■ 이력관리     : 20161226
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
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_List  	= in_dl.get("ds_List");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int RowStatus;
		
		RowCnt = ds_List.getRowCount();
		
		if (RowCnt > 0)
		{
			for(int j=0; j<ds_List.getRowCount(); j++)
			{
				RowStatus 	= ds_List.getRowType(j);
			
				if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
				{ 
					// 1. insert
					sbSql.delete(0, sbSql.length());
					sbSql.append("INSERT INTO FSC_EDULIST( \n");
					sbSql.append("	  EDU_ID \n");
					sbSql.append("	, EDU_DATE \n");
					sbSql.append("	, EDU_SABUN \n");
					sbSql.append("	, EDU_SCORE \n");
					sbSql.append("	, EDU_APPLY_YN \n");
					sbSql.append("	, HW \n");
					sbSql.append("	, HW1 \n");
					sbSql.append("	, HW2 \n");
					sbSql.append("	, HW3 \n");
					sbSql.append("	, LV \n");
					sbSql.append("	, USE_YN \n");
					sbSql.append("	, TABLE_TYPE \n");
					sbSql.append("	, FORM_CD \n");
					sbSql.append("	, UPJANG \n");
					sbSql.append("	, CHECK_DATE \n");
					sbSql.append("	, CHECK_TYPE \n");
					sbSql.append("	, CUSER \n");
					sbSql.append("	, CDATE \n");
					sbSql.append("	, UUSER \n");
					sbSql.append("	, UDATE \n");
					sbSql.append(" ) VALUES ( \n");
					sbSql.append("	  FSC_EDULIST_S.NEXTVAL \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"EDU_DATE"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"EDU_SABUN"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"EDU_SCORE"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"EDU_APPLY_YN"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"HW"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"HW1"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"HW2"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"HW3"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"LV"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"USE_YN"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"TABLE_TYPE"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"FORM_CD"))			+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"UPJANG"))			+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"CHECK_DATE"))		+"' \n");
					sbSql.append("	, '"	+	nullToBlank(ds_List.getString(j,"CHECK_TYPE"))		+"' \n");
					sbSql.append("	, '" 	+ 	g_EmpNo 														+"' \n");
					sbSql.append("	, SYSDATE \n");
					sbSql.append("	, '" 	+ 	g_EmpNo 														+"' \n");
					sbSql.append("	, SYSDATE \n");
					sbSql.append(" ) \n");
					
					stmt 		=  conn.createStatement();
					stmt.execute(sbSql.toString());
					stmt.close();
				}
				else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
				{
					// 2. update
					sbSql.delete(0, sbSql.length());
					sbSql.append("UPDATE FSC_EDULIST \n");
					sbSql.append("   SET EDU_DATE = '"		+	nullToBlank(ds_List.getString(j,"EDU_DATE"))		+"' \n");
					sbSql.append("	 , EDU_SABUN = '"			+	nullToBlank(ds_List.getString(j,"EDU_SABUN"))		+"' \n");
					sbSql.append("	 , EDU_SCORE = '"	+	nullToBlank(ds_List.getString(j,"EDU_SCORE"))														+"' \n");
					sbSql.append("	 , EDU_APPLY_YN = '"		+	nullToBlank(ds_List.getString(j,"EDU_APPLY_YN"))														+"' \n");
					sbSql.append("	 , HW = '"		+	nullToBlank(ds_List.getString(j,"HW"))					+"' \n");
					sbSql.append("	 , HW1 = '"		+	nullToBlank(ds_List.getString(j,"HW1"))					+"' \n");
					sbSql.append("	 , HW2 = '"		+	nullToBlank(ds_List.getString(j,"HW2"))					+"' \n");
					sbSql.append("	 , HW3 = '"		+	nullToBlank(ds_List.getString(j,"HW3"))					+"' \n");
					sbSql.append("	 , LV = '"		+	nullToBlank(ds_List.getString(j,"LV"))					+"' \n");
					sbSql.append("	 , USE_YN = '"			+	nullToBlank(ds_List.getString(j,"USE_YN"))			+"' \n");
					sbSql.append("	 , TABLE_TYPE = '"			+	nullToBlank(ds_List.getString(j,"TABLE_TYPE"))		+"' \n");
					sbSql.append("	 , FORM_CD = '"				+	nullToBlank(ds_List.getString(j,"FORM_CD"))			+"' \n");
					sbSql.append("	 , UPJANG = '"				+	nullToBlank(ds_List.getString(j,"UPJANG"))				+"' \n");
					sbSql.append("	 , CHECK_DATE = '"		+	nullToBlank(ds_List.getString(j,"CHECK_DATE"))	+"' \n");
					sbSql.append("	 , CHECK_TYPE = '"		+	nullToBlank(ds_List.getString(j,"CHECK_TYPE"))	+"' \n");
					sbSql.append("	 , UUSER = '" 				+ 	g_EmpNo 														+"' \n");
					sbSql.append("	 , UDATE = SYSDATE \n");
					sbSql.append(" WHERE EDU_ID = '"		+	nullToBlank(ds_List.getString(j,"EDU_ID"))		+"' \n");
					
					stmt 		=  conn.createStatement();
					stmt.execute(sbSql.toString());
					stmt.close();
				}
			}
		}

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