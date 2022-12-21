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
		
		String strMENU_CD	= "";
	
		String g_EmpNo = in_vl.getString("g_EmpNo");
		
		DataSet ds_master  	=  in_dl.get("ds_master");
		DataSet ds_cond  	=  in_dl.get("ds_cond");
	
		String UPJANG         	="";	
		String MENU_CD			="";	
		String MENU_DATE      	="";	
		String HALL_CD        	="";	
		String MEAL           	="";	
		String CORNER         	="";	
		String SUBINV_CODE		="";
		String SALE_PRICE     	="";	
		String EXPECT_MEAL_QTY	="";	
		String GOAL_COST_RATE 	="";	
		String MENU_FEATURE		="";	
					
		int RowCnt = ds_master.getRowCount();
		int i;
		int RowStatus;
		StringBuffer sbSql = new StringBuffer();

		RowCnt = ds_master.getRowCount();

		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= ds_master.getRowType(i);


//			System.out.println("RowStatus : " + RowStatus);

			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				UPJANG         	=	ds_master.getString(i,"UPJANG");
				MENU_CD			=	ds_master.getString(i,"MENU_CD");
				MENU_DATE      	=	ds_master.getString(i,"MENU_DATE");
				HALL_CD        	=	ds_master.getString(i,"HALL_CD");
				MEAL           	= 	ds_master.getString(i,"MEAL");
				CORNER         	=	ds_master.getString(i,"CORNER");
				SUBINV_CODE		=	ds_master.getString(i,"SUBINV_CODE");
				SALE_PRICE     	=	ds_master.getString(i,"SALE_PRICE");
				EXPECT_MEAL_QTY	=	ds_master.getString(i,"EXPECT_MEAL_QTY");
				GOAL_COST_RATE 	=	ds_master.getString(i,"GOAL_COST_RATE");
				MENU_FEATURE	=	ds_master.getString(i,"MENU_FEATURE");
				
				sbSql.delete(0, sbSql.length());
				sbSql.append(" SELECT 	TO_NUMBER(SUBSTR(NVL(MAX(MENU_CD), 											\n");
				sbSql.append(" 			'"+MENU_DATE+"'||'-'||'"+HALL_CD+"'||-000000) , 15, 6))+1 AS MENU_CD		\n");
				sbSql.append(" FROM FSM_REAL_MENU_MST				\n");
				sbSql.append(" WHERE UPJANG 	= "+UPJANG+"		\n");
				sbSql.append(" AND MENU_DATE 	= '"+MENU_DATE+"'	\n");
				sbSql.append(" AND MEAL IS NULL						\n");
				sbSql.append(" AND CORNER IS NULL					\n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();

				rs.next();

				strMENU_CD = rs.getString("MENU_CD");

				rs.close();
				pstmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSM_REAL_MENU_MST( \n");
				sbSql.append("	 UPJANG \n");
				sbSql.append("	, MENU_CD \n");
				sbSql.append("	, MENU_NAME \n");
				sbSql.append("	, MENU_DATE \n");
				sbSql.append("	, HALL_CD \n");
				sbSql.append("	, MEAL \n");
				sbSql.append("	, CORNER \n");
				sbSql.append("	, SUBINV_CODE \n");
				sbSql.append("	, SALE_PRICE \n");
				sbSql.append("	, EXPECT_MEAL_QTY \n");
				sbSql.append("	, GOAL_COST_RATE \n");
				sbSql.append("	, MENU_FEATURE \n");
				sbSql.append("	, MEAL_PUBLISH_YN \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append("	, UUSER \n");
				sbSql.append("	, UDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	 "+UPJANG+" \n");
				sbSql.append("	, '"+MENU_DATE+"'||'-'||'"+HALL_CD+"' || LPAD( '"+strMENU_CD+"', 6, '0') \n");
				sbSql.append("	, NULL \n");
				sbSql.append("	, '"+MENU_DATE+"' \n");
				sbSql.append("	, '"+HALL_CD+"' \n");
				sbSql.append("	, NULL \n");
				sbSql.append("	, NULL \n");
				sbSql.append("	, '"+SUBINV_CODE+"' \n");
				sbSql.append("	, "+SALE_PRICE+" \n");
				sbSql.append("	, "+EXPECT_MEAL_QTY+" \n");
				sbSql.append("	, "+GOAL_COST_RATE+" \n");
				sbSql.append("	, '"+MENU_FEATURE+"' \n");
				sbSql.append("	, 'N' \n");
				sbSql.append("	, '"+g_EmpNo+"' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append("	, '"+g_EmpNo+"' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");	
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("  SELECT 1 						 	\n");
				sbSql.append("    FROM FSM_GOAL_COST_RATE 		 	\n");
				sbSql.append("   WHERE UPJANG ="+UPJANG+" 		 	\n");
				sbSql.append("     AND HALL_CD='"+HALL_CD+"' 	 	\n");
				sbSql.append("     AND MENU_DATE='"+MENU_DATE+"' 	\n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				rs = pstmt.executeQuery();

				int iCnt = 0;
				while( rs.next() ) {
					iCnt++;
				}
				//System.out.println("iCnt="+iCnt);
				
				rs.close();
				pstmt.close();
				
				if(iCnt == 0)
				{
					sbSql.delete(0, sbSql.length());
					sbSql.append("INSERT INTO FSM_GOAL_COST_RATE( \n");
					sbSql.append("	 UPJANG \n");
					sbSql.append("	, HALL_CD \n");
					sbSql.append("	, MENU_DATE \n");
					sbSql.append("	, GOAL_COST_RATE \n");
					sbSql.append("	, CUSER \n");
					sbSql.append("	, CDATE \n");
					sbSql.append("	, UUSER \n");
					sbSql.append("	, UDATE \n");
					sbSql.append(" ) VALUES ( \n");
					sbSql.append("	 "+UPJANG+" \n");
					sbSql.append("	, '"+HALL_CD+"' \n");
					sbSql.append("	, '"+MENU_DATE+"' \n");
					sbSql.append("	, 0  \n");
					sbSql.append("	, '"+g_EmpNo+"' \n");
					sbSql.append("	, SYSDATE \n");
					sbSql.append("	, '"+g_EmpNo+"' \n");
					sbSql.append("	, SYSDATE \n");
					sbSql.append(" ) \n");
					
					stmt = conn.createStatement();
					stmt.execute(sbSql.toString());
					stmt.close();		
				}
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				UPJANG         	=	ds_master.getString(i,"UPJANG");
				MENU_CD			=	ds_master.getString(i,"MENU_CD");
				MENU_DATE      	=	ds_master.getString(i,"MENU_DATE");
				HALL_CD        	=	ds_master.getString(i,"HALL_CD");
				MEAL           	= 	ds_master.getString(i,"MEAL");
				CORNER         	=	ds_master.getString(i,"CORNER");
				SUBINV_CODE		=	ds_master.getString(i,"SUBINV_CODE");
				SALE_PRICE     	=	ds_master.getString(i,"SALE_PRICE");
				EXPECT_MEAL_QTY	=	ds_master.getString(i,"EXPECT_MEAL_QTY");
				GOAL_COST_RATE 	=	ds_master.getString(i,"GOAL_COST_RATE");
				MENU_FEATURE	=	ds_master.getString(i,"MENU_FEATURE");
				
				sbSql.delete(0, sbSql.length());
				//sbSql.append(" ");		//in_ds.getColumn(i,"COL_DATE").getString()
				sbSql.append("UPDATE \n");
				sbSql.append(" 	FSM_REAL_MENU_MST \n");
				sbSql.append("SET \n");
				sbSql.append("	 MENU_DATE = '"+MENU_DATE+"' \n");
				sbSql.append("	, HALL_CD = '"+HALL_CD+"' \n");
				sbSql.append("	, SUBINV_CODE = '"+SUBINV_CODE+"' \n");
				sbSql.append("	, SALE_PRICE = "+SALE_PRICE+" \n");
				sbSql.append("	, EXPECT_MEAL_QTY = "+EXPECT_MEAL_QTY+" \n");
				sbSql.append("	, GOAL_COST_RATE = "+GOAL_COST_RATE+" \n");
				sbSql.append("	, MENU_FEATURE = '"+MENU_FEATURE+"' \n");
				sbSql.append("	, UUSER = '"+g_EmpNo+"' \n");
				sbSql.append("	, UDATE = SYSDATE \n");
				sbSql.append("WHERE \n");
				sbSql.append("	 UPJANG = "+UPJANG+" \n");
				sbSql.append("	 AND MENU_CD = '"+MENU_CD+"' \n");		
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}				 
							 
//			System.out.println(sbSql.toString());
//			String fileUrl = "c:/tomcat-4.1/webapps/hwfs/hwfs_svc/log/test.log";
//			tit.util.FileLog.println(fileUrl, "sql=====>"+sbSql.toString());
//			tit.util.FileLog.println(fileUrl, in_ds);
			
		}
		
	   conn.commit();
	   this.setResultMessage(0, "OK",out_vl);

		
	} catch(Exception ex) {
		conn.rollback();
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