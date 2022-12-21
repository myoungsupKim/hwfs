<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/위생관리                                                                                                                                                                     
■ 프로그램ID   : FSC00010E_T003.jsp                                                                                                                                                                    
■ 프로그램명   : 점검양식관리                                                                                                                                                 
■ 작성일자     : 2008-03-18                                                                                                                                                                            
■ 작성자       : 박지영                                                                                                                                                                                
■ 이력관리     : 2008-03-18                                                                                                                                                                            
-----------------------------------------------------------------------------*/                                                                                                                         
%>                                                                                                                                                                                                      

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
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		
		//입력 데이타                                                                                                                                                                                         
		DataSet ds_Master  	= in_dl.get("ds_Master");
		DataSet ds_Detail1  = in_dl.get("ds_Detail1");
		DataSet ds_Detail2  = in_dl.get("ds_Detail2");
		DataSet ds_Detail3  = in_dl.get("ds_Detail3");
		DataSet ds_in  		= in_dl.get("ds_in");
		
		String g_EmpNo 		= in_vl.getString("g_EmpNo");
		
		StringBuffer sbSql 	= new StringBuffer();	//sql문 버퍼생성
		
		int RowCnt;
		int i;
		int RowStatus;
		String strFormCD;
	
	
		// 1.Master
		RowCnt = ds_Master.getRowCount();
		
		if (RowCnt > 0)
		{
			RowStatus 	= ds_Master.getRowType(0);
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				// 1.1 inert
				// 1.1.1 Seq생
				sbSql.delete(0, sbSql.length());
				sbSql.append("SELECT TO_CHAR(SYSDATE,'YYYY') || NVL(DECODE(LENGTH(MAX(SUBSTR(FORM_CD,5,2)+1)),1,'0') || MAX(SUBSTR(FORM_CD,5,2)+1),'01') AS FORM_CD \n");
				sbSql.append("  FROM FSC_SAFE_FORM_MST \n");
				sbSql.append(" WHERE TABLE_TYPE = '"	+	nullToBlank(ds_Master.getString(0,"TABLE_TYPE"))		+"' \n");
				sbSql.append("   AND SUBSTR(FORM_CD,0,4) = TO_CHAR(SYSDATE,'YYYY') \n");
				
				//System.out.println(sbSql.toString());
				pstmt = conn.prepareStatement(sbSql.toString());		
				rs = pstmt.executeQuery(); 
				ds_in = this.makeDataSet(rs,"ds_in");
				
				rs.close();
				pstmt.close();
				
				// 1.1.2 insert
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_SAFE_FORM_MST( \n");
				sbSql.append("	  TABLE_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, FORM_NAME \n");
				sbSql.append("	, START_DATE \n");
				sbSql.append("	, END_DATE \n");
				sbSql.append("	, USE_YN \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"	+	nullToBlank(ds_Master.getString(0,"TABLE_TYPE"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_in.getString(0,"FORM_CD"))				+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"FORM_NAME"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"START_DATE"))		+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"END_DATE"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Master.getString(0,"USE_YN"))			+"' \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 														+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				// 1.2 update
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_SAFE_FORM_MST \n");
				sbSql.append("   SET FORM_NAME = '"		+	nullToBlank(ds_Master.getString(0,"FORM_NAME"))			+"' \n");
				sbSql.append("   	 , START_DATE = '"	+	nullToBlank(ds_Master.getString(0,"START_DATE"))		+"' \n");
				sbSql.append("	 , END_DATE = '"		+	nullToBlank(ds_Master.getString(0,"END_DATE"))			+"' \n");
				sbSql.append("	 , USE_YN = '"			+	nullToBlank(ds_Master.getString(0,"USE_YN"))			+"' \n");
				sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 														+ "' \n");
				sbSql.append("	 , UDATE = SYSDATE \n");
				sbSql.append("WHERE TABLE_TYPE = '"		+	nullToBlank(ds_Master.getString(0,"TABLE_TYPE"))		+"' \n");
				sbSql.append("  AND FORM_CD = '"		+	nullToBlank(ds_Master.getString(0,"FORM_CD"))			+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			
		}
		strFormCD	= nullToBlank(ds_in.getString(0,"FORM_CD"));
		
		// 2.Detail
		// 2.1 대분류
		RowCnt = ds_Detail1.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= ds_Detail1.getRowType(i);
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_SAFE_CLASS_MST( \n");
				sbSql.append("	  TABLE_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, CLASS_CD \n");
				sbSql.append("	, CLASS_NAME \n");
				sbSql.append("	, CLASS_TYPE \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"	+	nullToBlank(ds_Detail1.getString(i,"TABLE_TYPE"))			+"' \n");
				sbSql.append("	, '" 	+ 	strFormCD 															+ "' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"CLASS_CD"))				+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"CLASS_NAME"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail1.getString(i,"CLASS_TYPE"))			+"' \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 															+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");


				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_SAFE_CLASS_MST \n");
				sbSql.append("   SET CLASS_NAME = '"	+	nullToBlank(ds_Detail1.getString(i,"CLASS_NAME"))		+"' \n");
				sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 														+ "' \n");
				sbSql.append("	 , UDATE = SYSDATE \n");
				sbSql.append(" WHERE TABLE_TYPE = '"	+	nullToBlank(ds_Detail1.getString(i,"TABLE_TYPE"))		+"' \n");
				sbSql.append("   AND FORM_CD = '" 		+ 	strFormCD 														+ "' \n");
				sbSql.append("   AND CLASS_CD = '"		+	nullToBlank(ds_Detail1.getString(i,"CLASS_CD"))			+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		// 2.2 중분류
		RowCnt = ds_Detail2.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= ds_Detail2.getRowType(i);
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_SAFE_CLASS_MST( \n");
				sbSql.append("	  TABLE_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, CLASS_CD \n");
				sbSql.append("	, CLASS_NAME \n");
				sbSql.append("	, CLASS_TYPE \n");
				sbSql.append("	, MNGM_FLAG \n");
				sbSql.append("	, MNGM_CNT \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"	+	nullToBlank(ds_Detail2.getString(i,"TABLE_TYPE"))			+"' \n");
				sbSql.append("	, '" 	+ 	strFormCD 															+ "' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail2.getString(i,"CLASS_CD"))				+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail2.getString(i,"CLASS_NAME"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail2.getString(i,"CLASS_TYPE"))			+"' \n");
				sbSql.append("	, SCC_YN_FUN('"	+	nullToBlank(ds_Detail2.getString(i,"MNGM_FLAG")) + "','I') \n");
				sbSql.append("	, "		+	nullToZero(ds_Detail2.getString(i,"MNGM_CNT"))				+" \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 															+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");

				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_SAFE_CLASS_MST \n");
				sbSql.append("   SET CLASS_NAME = '"	+	nullToBlank(ds_Detail2.getString(i,"CLASS_NAME"))		+"' \n");
				sbSql.append("     , MNGM_FLAG = SCC_YN_FUN('" + nullToBlank(ds_Detail2.getString(i,"MNGM_FLAG")) + "','U') \n");
				sbSql.append("     , MNGM_CNT = "	+	nullToBlank(ds_Detail2.getString(i,"MNGM_CNT"))		+" \n");
				sbSql.append("	   , UUSER = '" 			+ 	g_EmpNo 														+ "' \n");
				sbSql.append("	   , UDATE = SYSDATE \n");
				sbSql.append(" WHERE TABLE_TYPE = '"	+	nullToBlank(ds_Detail2.getString(i,"TABLE_TYPE"))		+"' \n");
				sbSql.append("   AND FORM_CD = '" 		+ 	strFormCD 														+ "' \n");
				sbSql.append("   AND CLASS_CD = '"		+	nullToBlank(ds_Detail2.getString(i,"CLASS_CD"))			+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		// 2.3 소분류
		RowCnt = ds_Detail3.getRowCount();
		
		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= ds_Detail3.getRowType(i);
			
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_SAFE_CLASS_MST( \n");
				sbSql.append("	  TABLE_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, CLASS_CD \n");
				sbSql.append("	, CLASS_NAME \n");
				sbSql.append("	, CLASS_TYPE \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"	+	nullToBlank(ds_Detail3.getString(i,"TABLE_TYPE"))			+"' \n");
				sbSql.append("	, '" 	+ 	strFormCD 															+ "' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail3.getString(i,"CLASS_CD"))				+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail3.getString(i,"CLASS_NAME"))			+"' \n");
				sbSql.append("	, '"	+	nullToBlank(ds_Detail3.getString(i,"CLASS_TYPE"))			+"' \n");
				sbSql.append("	, '" 	+ 	g_EmpNo 															+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");

				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSC_SAFE_FORM_DTL( \n");
				sbSql.append("	  TABLE_TYPE \n");
				sbSql.append("	, FORM_CD \n");
				sbSql.append("	, CLASS_CD \n");
				sbSql.append("	, LRG_CLASS_CD \n");
				sbSql.append("	, LRG_CLASS_NAME \n");
				sbSql.append("	, MIDDLE_CLASS_CD \n");
				sbSql.append("	, MIDDLE_CLASS_NAME \n");
				sbSql.append("	, CLASS_NAME \n");
				sbSql.append("	, MARK_1 \n");
				sbSql.append("	, MARK_2 \n");
				sbSql.append("	, MARK_3 \n");
				sbSql.append("	, MARK_4 \n");
				sbSql.append("	, MINUS_YN \n");
				sbSql.append("	, NOT_FIT_YN \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	  '"		+	nullToBlank(ds_Detail3.getString(i,"TABLE_TYPE"))			+"' \n");
				sbSql.append("	, '" 		+ 	strFormCD 															+ "' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"CLASS_CD"))				+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"LRG_CLASS_CD"))			+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"LRG_CLASS_NAME"))		+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"MIDDLE_CLASS_CD"))		+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"MIDDLE_CLASS_NAME"))	+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"CLASS_NAME"))			+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"MARK_1"))				+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"MARK_2"))				+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"MARK_3"))				+"' \n");
				sbSql.append("	, '"		+	nullToBlank(ds_Detail3.getString(i,"MARK_4"))				+"' \n");
				sbSql.append("	, DECODE("	+	nullToBlank(ds_Detail3.getString(i,"MINUS_YN"))				+",1,'Y','N') \n");
				sbSql.append("	, DECODE("	+	nullToBlank(ds_Detail3.getString(i,"NOT_FIT_YN"))			+",1,'Y','N') \n");
				sbSql.append("	, '" 		+ 	g_EmpNo 															+ "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED )
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_SAFE_CLASS_MST \n");
				sbSql.append("   SET CLASS_NAME = '"	+	nullToBlank(ds_Detail3.getString(i,"CLASS_NAME"))		+"' \n");
				sbSql.append("	 , UUSER = '" 			+ 	g_EmpNo 														+ "' \n");
				sbSql.append("	 , UDATE = SYSDATE \n");
				sbSql.append(" WHERE TABLE_TYPE = '"	+	nullToBlank(ds_Detail3.getString(i,"TABLE_TYPE"))		+"' \n");
				sbSql.append("   AND FORM_CD = '" 		+ 	strFormCD 														+ "' \n");
				sbSql.append("   AND CLASS_CD = '"		+	nullToBlank(ds_Detail3.getString(i,"CLASS_CD"))			+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSC_SAFE_FORM_DTL \n");
				sbSql.append("   SET LRG_CLASS_CD = '"		+	nullToBlank(ds_Detail3.getString(i,"LRG_CLASS_CD"))			+"' \n");
				sbSql.append("	 , LRG_CLASS_NAME = '"		+	nullToBlank(ds_Detail3.getString(i,"LRG_CLASS_NAME"))		+"' \n");
				sbSql.append("	 , MIDDLE_CLASS_CD = '"		+	nullToBlank(ds_Detail3.getString(i,"MIDDLE_CLASS_CD"))		+"' \n");
				sbSql.append("	 , MIDDLE_CLASS_NAME = '"	+	nullToBlank(ds_Detail3.getString(i,"MIDDLE_CLASS_NAME"))	+"' \n");
				sbSql.append("	 , CLASS_NAME = '"			+	nullToBlank(ds_Detail3.getString(i,"CLASS_NAME"))			+"' \n");
				sbSql.append("	 , MARK_1 = '"				+	nullToBlank(ds_Detail3.getString(i,"MARK_1"))				+"' \n");
				sbSql.append("	 , MARK_2 = '"				+	nullToBlank(ds_Detail3.getString(i,"MARK_2"))				+"' \n");
				sbSql.append("	 , MARK_3 = '"				+	nullToBlank(ds_Detail3.getString(i,"MARK_3"))				+"' \n");
				sbSql.append("	 , MARK_4 = '"				+	nullToBlank(ds_Detail3.getString(i,"MARK_4"))				+"' \n");
				sbSql.append("	 , MINUS_YN = DECODE("		+	nullToBlank(ds_Detail3.getString(i,"MINUS_YN"))				+",1,'Y','N') \n");
				sbSql.append("	 , NOT_FIT_YN = DECODE("	+	nullToBlank(ds_Detail3.getString(i,"NOT_FIT_YN"))			+",1,'Y','N') \n");
				sbSql.append("	 , UUSER = '" 				+	g_EmpNo 															+ "' \n");
				sbSql.append("	 , UDATE = SYSDATE \n");
				sbSql.append("  WHERE TABLE_TYPE = '"		+	nullToBlank(ds_Detail3.getString(i,"TABLE_TYPE"))			+"' \n");
				sbSql.append("   AND FORM_CD = '" 			+	strFormCD 															+ "' \n");
				sbSql.append("   AND CLASS_CD = '"			+	nullToBlank(ds_Detail3.getString(i,"CLASS_CD"))				+"' \n");
				
				stmt 		=  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		conn.commit();
		out_dl.add(ds_in);
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