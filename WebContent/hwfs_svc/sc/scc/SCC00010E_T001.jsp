<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../main/common.jsp" %>
<%
	Statement stmt             =  null;
	try 
	{	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
		String new_menu_id	= "";
		String use_yn="";
		
		DataSet in_ds  =  in_dl.get("SCC00010E_T001");

		int RowCnt = in_ds.getRowCount();
		int i;
		int RowStatus;
		String sql01 = "";
		String sql02 = "";
		StringBuffer sbSql = new StringBuffer();

//		System.out.println("DataSet : " + in_ds);
		RowCnt = in_ds.getRemovedRowCount();

		for ( i = 0 ; i < RowCnt ; i++ )
		{
				sbSql.delete(0, sbSql.length());
				sbSql.append("DELETE FROM SCC_MENU																");
				sbSql.append("WHERE    MENU_ID ='"+ in_ds.getRemovedData(i, "MENU_ID").toString()	+"'			");
				sbSql.append("AND      SYS_ID  ='"+ in_ds.getRemovedData(i, "SYS_ID").toString()	+"'			");
/*				sbSql.append("DELETE FROM SCC_ROLE WHERE ROLE='"+ in_ds.getRemovedData(i, "ROLE").toString()  +"' ");
				sbSql.append("DELETE FROM SCC_ROLE WHERE ROLE='"+ in_ds.getRemovedData(i, "ROLE").toString()  +"' ");
				sbSql.append("DELETE FROM SCC_ROLE WHERE ROLE='"+ in_ds.getRemovedData(i, "ROLE").toString()  +"' ");
				sbSql.append("DELETE FROM SCC_ROLE WHERE ROLE='"+ in_ds.getRemovedData(i, "ROLE").toString()  +"' ");
*/
				stmt =  conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
		}



		RowCnt = in_ds.getRowCount();

		for ( i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus 	= in_ds.getRowType(i);
			use_yn		= nullToBlank(in_ds.getString(i,"USE_YN"));
			if( use_yn.equals("1") )
			{
				use_yn="Y";
			}
			else
			{
				use_yn="N";
			}
//			System.out.println("RowStatus : " + RowStatus);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				sbSql.delete(0, sbSql.length());

 				sbSql.append(" SELECT nvl(max(menu_id), 0) + 1 MAX_MENU_ID		");
				sbSql.append("   FROM SCC_MENU									");

				pstmt = conn.prepareStatement(sbSql.toString());
				
				rs = pstmt.executeQuery();

				rs.next();

				new_menu_id = rs.getString("MAX_MENU_ID");
				
				rs.close();
				pstmt.close();
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO SCC_MENU											\n");
				sbSql.append("         (													\n");
				sbSql.append("           menu_id,											\n");
				sbSql.append("           sys_id,											\n");
				sbSql.append("           menu_name,											\n");
				sbSql.append("           parent_menu_id,									\n");
				sbSql.append("           prg_id,											\n");//ICON_ID
				sbSql.append("           ICON_ID,											\n");
				sbSql.append("           prg_path,											\n");
				sbSql.append("           call_param,										\n");
				sbSql.append("           menu_type,											\n");
				sbSql.append("           levels,											\n");
				sbSql.append("           PRG_TYPE,											\n");
				sbSql.append("           sort_seq,											\n");
				sbSql.append("           remark,											\n");
				sbSql.append("           use_yn,											\n");
				sbSql.append("           attr01,											\n");
				sbSql.append("           attr02,											\n");
				sbSql.append("           attr03,											\n");
				sbSql.append("           attr04,											\n");
				sbSql.append("           attr05,											\n");
				sbSql.append("           attr06,											\n");
				sbSql.append("           attr07,											\n");
				sbSql.append("           attr08,											\n");
				sbSql.append("           attr09,											\n");
				sbSql.append("           attr10,											\n");
				sbSql.append("           cuser,												\n");
				sbSql.append("           uuser												\n");
				sbSql.append("         )													\n");
				sbSql.append("  VALUES (													\n");
				sbSql.append(			new_menu_id													+",			\n");
				sbSql.append(			nullToBlank(in_ds.getString(i,"SYS_ID"))			+",			\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"MENU_NAME"))			+"',		\n"); 
				sbSql.append(			in_ds.getString(i,"PARENT_MENU_ID")					+",			\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"PRG_ID"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ICON_ID"))			+"',		\n");
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"PRG_PATH"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"CALL_PARAM"))		+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"MENU_TYPE"))			+"',		\n"); 
				sbSql.append(			in_ds.getString(i,"LEVELS")							+",			\n"); 
				sbSql.append("'"	+	in_ds.getString(i,"PRG_TYPE")						+"',		\n"); 
				sbSql.append(			in_ds.getString(i,"SORT_SEQ")						+",			\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"REMARK"))			+"',		\n"); 
//				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"USE_YN"))			+"',		\n");
				sbSql.append("'"	+	use_yn														+"',		\n");
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR01"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR02"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR03"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR04"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR05"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR06"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR07"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR08"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR09"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"ATTR10"))			+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"CUSER"))				+"',		\n"); 
				sbSql.append("'"	+	nullToBlank(in_ds.getString(i,"UUSER"))				+"'		\n"); 
				sbSql.append("			)										       			");
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				sbSql.delete(0, sbSql.length());
				//sbSql.append(" ");		//in_ds.getColumn(i,"COL_DATE").getString()
				sbSql.append("UPDATE	SCC_MENU	SET																				\n");
				sbSql.append("			SYS_ID			="	+	nullToBlank(in_ds.getString(i,"SYS_ID"))			+",		\n");
				sbSql.append("			MENU_NAME		='"	+	nullToBlank(in_ds.getString(i,"MENU_NAME"))			+"',	\n");
				sbSql.append("			PARENT_MENU_ID	="	+	in_ds.getString(i,"PARENT_MENU_ID")					+",		\n");
				sbSql.append("			PRG_ID			='"	+	nullToBlank(in_ds.getString(i,"PRG_ID"))			+"',	\n");
				sbSql.append("			ICON_ID			='"	+	nullToBlank(in_ds.getString(i,"ICON_ID"))			+"',	\n");		
				sbSql.append("			PRG_PATH		='"	+	nullToBlank(in_ds.getString(i,"PRG_PATH"))			+"',	\n");
				sbSql.append("			CALL_PARAM		='"	+	nullToBlank(in_ds.getString(i,"CALL_PARAM"))		+"',	\n");
				sbSql.append("			MENU_TYPE		='"	+	nullToBlank(in_ds.getString(i,"MENU_TYPE"))			+"',	\n");
				sbSql.append("			LEVELS			="	+	in_ds.getString(i,"LEVELS")							+",		\n");
				sbSql.append("			PRG_TYPE		='"	+	nullToBlank(in_ds.getString(i,"PRG_TYPE"))			+"',	\n");
				sbSql.append("			SORT_SEQ		="	+	in_ds.getString(i,"SORT_SEQ")						+",		\n");
				sbSql.append("			REMARK			='"	+	nullToBlank(in_ds.getString(i,"REMARK"))			+"',	\n");
//				sbSql.append("			USE_YN			='"	+	nullToBlank(in_ds.getString(i,"USE_YN"))			+"',	\n");
				sbSql.append("			USE_YN			='"	+	use_yn														+"',	\n");
				sbSql.append("			ATTR01			='"	+	nullToBlank(in_ds.getString(i,"ATTR01"))			+"',	\n");
				sbSql.append("			ATTR02			='"	+	nullToBlank(in_ds.getString(i,"ATTR02"))			+"',	\n");
				sbSql.append("			ATTR03			='"	+	nullToBlank(in_ds.getString(i,"ATTR03"))			+"',	\n");
				sbSql.append("			ATTR04			='"	+	nullToBlank(in_ds.getString(i,"ATTR04"))			+"',	\n");
				sbSql.append("			ATTR05			='"	+	nullToBlank(in_ds.getString(i,"ATTR05"))			+"',	\n");
				sbSql.append("			ATTR06			='"	+	nullToBlank(in_ds.getString(i,"ATTR06"))			+"',	\n");
				sbSql.append("			ATTR07			='"	+	nullToBlank(in_ds.getString(i,"ATTR07"))			+"',	\n");
				sbSql.append("			ATTR08			='"	+	nullToBlank(in_ds.getString(i,"ATTR08"))			+"',	\n");
				sbSql.append("			ATTR09			='"	+	nullToBlank(in_ds.getString(i,"ATTR09"))			+"',	\n");
				sbSql.append("			ATTR10			='"	+	nullToBlank(in_ds.getString(i,"ATTR10"))			+"',	\n");
				sbSql.append("			CUSER			='"	+	nullToBlank(in_ds.getString(i,"CUSER"))				+"',	\n");
				sbSql.append("			UUSER			='"	+	nullToBlank(in_ds.getString(i,"UUSER"))				+"',	\n");
				sbSql.append("			UDATE			= SYSDATE																	\n");
				sbSql.append("WHERE    MENU_ID			=" +	in_ds.getString(i,"MENU_ID")			+"			");
			}				 
							 
//			System.out.println(sbSql.toString());
//			String fileUrl = "c:/tomcat-4.1/webapps/hwfs/hwfs_svc/log/test.log";
//			tit.util.FileLog.println(fileUrl, "sql=====>"+sbSql.toString());
//			tit.util.FileLog.println(fileUrl, in_ds);
			stmt =  conn.createStatement();
			stmt.execute(sbSql.toString());

			stmt.close();
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