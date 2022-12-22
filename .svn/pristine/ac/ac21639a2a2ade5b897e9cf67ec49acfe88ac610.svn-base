<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단공유                                                                                                                                                                     
■ 프로그램ID   : FSM00600E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 공유대상사업장 등록                                                                                                                                               
■ 작성일자     : 2015-03-13                                                                                                                                                                           
■ 작성자       : 김민수                                                                                                                                                                                
■ 이력관리     :                                                                                                                                                                             
-----------------------------------------------------------------------------*/                                                                                                                         
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt = null;
	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		DataSet ds_Cond           = in_dl.get("ds_cond");		    // 조회조건
		DataSet ds_menu1JointList = in_dl.get("ds_menu1JointList");	// 개별식단
		DataSet ds_menu2JointList = in_dl.get("ds_menu2JointList");	// 기간식단
		DataSet ds_menu3JointList = in_dl.get("ds_menu3JointList");	// 오븐식단
		DataSet ds_menu4JointList = in_dl.get("ds_menu4JointList");	// 신규레시피

		String g_EmpNo         = in_vl.getString("g_EmpNo");
		String JOINT_YYMM      = "";
		String UPJANG          = "";
		String JOINT_CLASS     = "";
		String CHARGE_SABUN    = "";
		String JOINT_WEEKSEQ   = "";
		String STATUS_CD       = "";
		String JOINT_YN        = "";

		int RowStatus;
		StringBuffer sbSql = new StringBuffer();
		
		// 개별식단 삭제
		int RowCnt = ds_menu1JointList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			JOINT_YYMM    = ds_menu1JointList.getRemovedData(i,"JOINT_YYMM").toString(); 
			UPJANG        = ds_menu1JointList.getRemovedData(i,"UPJANG").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSM_MENU_JOINT                        \n"); 
			sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'     \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG + "'         \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 기간식단 삭제
		RowCnt = ds_menu2JointList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			JOINT_YYMM    = ds_menu2JointList.getRemovedData(i,"JOINT_YYMM").toString(); 
			UPJANG        = ds_menu2JointList.getRemovedData(i,"UPJANG").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSM_MENU_JOINT                        \n"); 
			sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'     \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG + "'         \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 오븐식단 삭제
		RowCnt = ds_menu3JointList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			JOINT_YYMM    = ds_menu3JointList.getRemovedData(i,"JOINT_YYMM").toString(); 
			UPJANG        = ds_menu3JointList.getRemovedData(i,"UPJANG").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSM_MENU_JOINT                        \n"); 
			sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'     \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG + "'         \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 신규레시피 삭제
		RowCnt = ds_menu4JointList.getRemovedRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			JOINT_YYMM    = ds_menu4JointList.getRemovedData(i,"JOINT_YYMM").toString(); 
			UPJANG        = ds_menu4JointList.getRemovedData(i,"UPJANG").toString();
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("DELETE FSM_MENU_JOINT                        \n"); 
			sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'     \n");
			sbSql.append("   AND UPJANG     = '" + UPJANG + "'         \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
		}
		
		// 개별식단 등록, 수정
		RowCnt = ds_menu1JointList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_menu1JointList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				JOINT_YYMM    = nullToBlank(ds_menu1JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu1JointList.getString(i,"UPJANG"));      
				JOINT_CLASS   = nullToBlank(ds_menu1JointList.getString(i,"JOINT_CLASS"));
				CHARGE_SABUN  = nullToBlank(ds_menu1JointList.getString(i,"CHARGE_SABUN"));
				JOINT_WEEKSEQ = nullToBlank(ds_menu1JointList.getString(i,"JOINT_WEEKSEQ"));
				STATUS_CD     = nullToBlank(ds_menu1JointList.getString(i,"STATUS_CD"));
				JOINT_YN      = nullToBlank(ds_menu1JointList.getString(i,"JOINT_YN"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSM_MENU_JOINT (     \n");
				sbSql.append("       JOINT_YYMM                \n");
				sbSql.append("     , UPJANG                    \n");
				sbSql.append("     , JOINT_CLASS               \n");
				sbSql.append("     , CHARGE_SABUN              \n");
				sbSql.append("     , JOINT_WEEKSEQ             \n");
				sbSql.append("     , STATUS_CD                 \n");
				sbSql.append("     , JOINT_YN                  \n");
				sbSql.append("     , CUSER                     \n");
				sbSql.append("     , CDATE                     \n");
				sbSql.append("     , UUSER                     \n");
				sbSql.append("     , UDATE                     \n");
				sbSql.append(") VALUES (                       \n");
				sbSql.append("       '" + JOINT_YYMM + "'      \n");
				sbSql.append("     , '" + UPJANG + "'          \n");
				sbSql.append("     , '" + JOINT_CLASS + "'     \n");
				sbSql.append("     , '" + CHARGE_SABUN + "'    \n");
				sbSql.append("     , '" + JOINT_WEEKSEQ + "'   \n");
				sbSql.append("     , '01'                      \n");
				sbSql.append("     , 'N'                       \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append(")                                \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				JOINT_YYMM    = nullToBlank(ds_menu1JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu1JointList.getString(i,"UPJANG"));      
				JOINT_WEEKSEQ = nullToBlank(ds_menu1JointList.getString(i,"JOINT_WEEKSEQ"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSM_MENU_JOINT                                \n"); 
				sbSql.append("   SET JOINT_WEEKSEQ = '" + JOINT_WEEKSEQ + "'       \n"); 
				sbSql.append("     , UUSER         = '" + g_EmpNo + "'             \n"); 
				sbSql.append("     , UDATE         = SYSDATE                       \n"); 
				sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'             \n");
				sbSql.append("   AND UPJANG = '" + UPJANG + "'                     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}		
		
		// 기간식단 등록, 수정
		RowCnt = ds_menu2JointList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_menu2JointList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				JOINT_YYMM    = nullToBlank(ds_menu2JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu2JointList.getString(i,"UPJANG"));      
				JOINT_CLASS   = nullToBlank(ds_menu2JointList.getString(i,"JOINT_CLASS"));
				CHARGE_SABUN  = nullToBlank(ds_menu2JointList.getString(i,"CHARGE_SABUN"));
				JOINT_WEEKSEQ = nullToBlank(ds_menu2JointList.getString(i,"JOINT_WEEKSEQ"));
				STATUS_CD     = nullToBlank(ds_menu2JointList.getString(i,"STATUS_CD"));
				JOINT_YN      = nullToBlank(ds_menu2JointList.getString(i,"JOINT_YN"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSM_MENU_JOINT (     \n");
				sbSql.append("       JOINT_YYMM                \n");
				sbSql.append("     , UPJANG                    \n");
				sbSql.append("     , JOINT_CLASS               \n");
				sbSql.append("     , CHARGE_SABUN              \n");
				sbSql.append("     , JOINT_WEEKSEQ             \n");
				sbSql.append("     , STATUS_CD                 \n");
				sbSql.append("     , JOINT_YN                  \n");
				sbSql.append("     , CUSER                     \n");
				sbSql.append("     , CDATE                     \n");
				sbSql.append("     , UUSER                     \n");
				sbSql.append("     , UDATE                     \n");
				sbSql.append(") VALUES (                       \n");
				sbSql.append("       '" + JOINT_YYMM + "'      \n");
				sbSql.append("     , '" + UPJANG + "'          \n");
				sbSql.append("     , '" + JOINT_CLASS + "'     \n");
				sbSql.append("     , '" + CHARGE_SABUN + "'    \n");
				sbSql.append("     , '" + JOINT_WEEKSEQ + "'   \n");
				sbSql.append("     , '01'                      \n");
				sbSql.append("     , 'N'                       \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append(")                                \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				JOINT_YYMM    = nullToBlank(ds_menu2JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu2JointList.getString(i,"UPJANG"));      
				JOINT_WEEKSEQ = nullToBlank(ds_menu2JointList.getString(i,"JOINT_WEEKSEQ"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSM_MENU_JOINT                                \n"); 
				sbSql.append("   SET JOINT_WEEKSEQ = '" + JOINT_WEEKSEQ + "'       \n"); 
				sbSql.append("     , UUSER         = '" + g_EmpNo + "'             \n"); 
				sbSql.append("     , UDATE         = SYSDATE                       \n"); 
				sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'             \n");
				sbSql.append("   AND UPJANG = '" + UPJANG + "'                     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		// 오븐식단 등록, 수정
		RowCnt = ds_menu3JointList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_menu3JointList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				JOINT_YYMM    = nullToBlank(ds_menu3JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu3JointList.getString(i,"UPJANG"));      
				JOINT_CLASS   = nullToBlank(ds_menu3JointList.getString(i,"JOINT_CLASS"));
				CHARGE_SABUN  = nullToBlank(ds_menu3JointList.getString(i,"CHARGE_SABUN"));
				JOINT_WEEKSEQ = nullToBlank(ds_menu3JointList.getString(i,"JOINT_WEEKSEQ"));
				STATUS_CD     = nullToBlank(ds_menu3JointList.getString(i,"STATUS_CD"));
				JOINT_YN      = nullToBlank(ds_menu3JointList.getString(i,"JOINT_YN"));
				 
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSM_MENU_JOINT (     \n");
				sbSql.append("       JOINT_YYMM                \n");
				sbSql.append("     , UPJANG                    \n");
				sbSql.append("     , JOINT_CLASS               \n");
				sbSql.append("     , CHARGE_SABUN              \n");
				sbSql.append("     , JOINT_WEEKSEQ             \n");
				sbSql.append("     , STATUS_CD                 \n");
				sbSql.append("     , JOINT_YN                  \n");
				sbSql.append("     , CUSER                     \n");
				sbSql.append("     , CDATE                     \n");
				sbSql.append("     , UUSER                     \n");
				sbSql.append("     , UDATE                     \n");
				sbSql.append(") VALUES (                       \n");
				sbSql.append("       '" + JOINT_YYMM + "'      \n");
				sbSql.append("     , '" + UPJANG + "'          \n");
				sbSql.append("     , '" + JOINT_CLASS + "'     \n");
				sbSql.append("     , '" + CHARGE_SABUN + "'    \n");
				sbSql.append("     , '" + JOINT_WEEKSEQ + "'   \n");
				sbSql.append("     , '01'                      \n");
				sbSql.append("     , 'N'                       \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append(")                                \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				JOINT_YYMM    = nullToBlank(ds_menu3JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu3JointList.getString(i,"UPJANG"));      
				JOINT_WEEKSEQ = nullToBlank(ds_menu3JointList.getString(i,"JOINT_WEEKSEQ"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSM_MENU_JOINT                                \n"); 
				sbSql.append("   SET JOINT_WEEKSEQ = '" + JOINT_WEEKSEQ + "'       \n"); 
				sbSql.append("     , UUSER         = '" + g_EmpNo + "'             \n"); 
				sbSql.append("     , UDATE         = SYSDATE                       \n"); 
				sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'             \n");
				sbSql.append("   AND UPJANG = '" + UPJANG + "'                     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		// 신규레시피 등록, 수정
		RowCnt = ds_menu4JointList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_menu4JointList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{
				JOINT_YYMM    = nullToBlank(ds_menu4JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu4JointList.getString(i,"UPJANG"));      
				JOINT_CLASS   = nullToBlank(ds_menu4JointList.getString(i,"JOINT_CLASS"));
				CHARGE_SABUN  = nullToBlank(ds_menu4JointList.getString(i,"CHARGE_SABUN"));
				JOINT_WEEKSEQ = nullToBlank(ds_menu4JointList.getString(i,"JOINT_WEEKSEQ"));
				STATUS_CD     = nullToBlank(ds_menu4JointList.getString(i,"STATUS_CD"));
				JOINT_YN      = nullToBlank(ds_menu4JointList.getString(i,"JOINT_YN"));
				 
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FSM_MENU_JOINT (     \n");
				sbSql.append("       JOINT_YYMM                \n");
				sbSql.append("     , UPJANG                    \n");
				sbSql.append("     , JOINT_CLASS               \n");
				sbSql.append("     , CHARGE_SABUN              \n");
				sbSql.append("     , JOINT_WEEKSEQ             \n");
				sbSql.append("     , STATUS_CD                 \n");
				sbSql.append("     , JOINT_YN                  \n");
				sbSql.append("     , CUSER                     \n");
				sbSql.append("     , CDATE                     \n");
				sbSql.append("     , UUSER                     \n");
				sbSql.append("     , UDATE                     \n");
				sbSql.append(") VALUES (                       \n");
				sbSql.append("       '" + JOINT_YYMM + "'      \n");
				sbSql.append("     , '" + UPJANG + "'          \n");
				sbSql.append("     , '" + JOINT_CLASS + "'     \n");
				sbSql.append("     , '" + CHARGE_SABUN + "'    \n");
				sbSql.append("     , '" + JOINT_WEEKSEQ + "'   \n");
				sbSql.append("     , '03'                      \n");
				sbSql.append("     , 'Y'                       \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append("     , '" + g_EmpNo + "'         \n");
				sbSql.append("     , SYSDATE                   \n");
				sbSql.append(")                                \n");

				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				JOINT_YYMM    = nullToBlank(ds_menu4JointList.getString(i,"JOINT_YYMM"));
				UPJANG        = nullToBlank(ds_menu4JointList.getString(i,"UPJANG"));      
				JOINT_WEEKSEQ = nullToBlank(ds_menu4JointList.getString(i,"JOINT_WEEKSEQ"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FSM_MENU_JOINT                                \n"); 
				sbSql.append("   SET JOINT_WEEKSEQ = '" + JOINT_WEEKSEQ + "'       \n"); 
				sbSql.append("     , UUSER         = '" + g_EmpNo + "'             \n"); 
				sbSql.append("     , UDATE         = SYSDATE                       \n"); 
				sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'             \n");
				sbSql.append("   AND UPJANG = '" + UPJANG + "'                     \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
		
	} catch(Exception ex) {
		ex.printStackTrace();
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