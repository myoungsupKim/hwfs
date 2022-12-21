<%                                                                                                                                                                                                      
/*-----------------------------------------------------------------------------                                                                                                                         
■ 시스템명     : 메뉴관리/식단공유                                                                                                                                                                     
■ 프로그램ID   : FSM00630E_T001.jsp                                                                                                                                                                    
■ 프로그램명   : 미등록사업장관리                                                                                                                                               
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
	
		DataSet ds_upjangList  = in_dl.get("ds_upjangList");    // 공유사업장정보

		String g_EmpNo         = in_vl.getString("g_EmpNo");
		String JOINT_YYMM      = "";
		String UPJANG          = "";
		String JOINT_WEEKSEQ   = "";
		String REMARK          = "";

		int RowStatus;
		StringBuffer sbSql = new StringBuffer();
		
		// 개별식단 등록, 수정
		int RowCnt = ds_upjangList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_upjangList.getRowType(i);

			JOINT_YYMM    = nullToBlank(ds_upjangList.getString(i,"JOINT_YYMM"));
			UPJANG        = nullToBlank(ds_upjangList.getString(i,"UPJANG"));      
			JOINT_WEEKSEQ = nullToBlank(ds_upjangList.getString(i,"JOINT_WEEKSEQ"));
			REMARK        = nullToBlank(ds_upjangList.getString(i,"REMARK"));
			
			sbSql.delete(0, sbSql.length());
			sbSql.append("UPDATE FSM_MENU_JOINT                                \n"); 
			sbSql.append("   SET JOINT_WEEKSEQ = '" + JOINT_WEEKSEQ + "'       \n");
			sbSql.append("     , REMARK        = '" + REMARK        + "'       \n");
			sbSql.append("     , UUSER         = '" + g_EmpNo       + "'       \n"); 
			sbSql.append("     , UDATE         = SYSDATE                       \n"); 
			sbSql.append(" WHERE JOINT_YYMM = '" + JOINT_YYMM + "'             \n");
			sbSql.append("   AND UPJANG = '" + UPJANG + "'                     \n");
			
			stmt = conn.createStatement();
			stmt.execute(sbSql.toString());
			stmt.close();
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