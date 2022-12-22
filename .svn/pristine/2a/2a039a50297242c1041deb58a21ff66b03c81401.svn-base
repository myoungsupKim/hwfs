
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
		
		//입력 데이타               
		DataSet ds_CommentList = in_dl.get("ds_CommentList");
		
		String ITEM_CODE = "";
		String SABUN 	 = "";
		String ADD_INFO  = "";
		String ITEM_SEQ  = "";
		
		int RowStatus;
		
		StringBuffer sbSql 	= new StringBuffer();		//sql문 버퍼생성
		
		int RowCnt = ds_CommentList.getRowCount();
		for ( int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_CommentList.getRowType(i);
			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				ITEM_CODE        = nullToBlank(ds_CommentList.getString(i, "ITEM_CODE"));          
				SABUN            = nullToBlank(ds_CommentList.getString(i, "SABUN"));
				ADD_INFO         = nullToBlank(ds_CommentList.getString(i, "ADD_INFO"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append(" INSERT INTO FMP_ITEM_ADD_INFO (																   \n");
				sbSql.append(" 		  ITEM_SEQ,																				   \n");
				sbSql.append("		  ITEM_CODE,																			   \n");
				sbSql.append("		  SABUN,																				   \n");
				sbSql.append("		  ADD_INFO,																				   \n");
				sbSql.append("		  CUSER,																				   \n");
				sbSql.append("		  CDATE,																				   \n");
				sbSql.append("		  UUSER,																				   \n");
				sbSql.append("		  UDATE																					   \n");
				sbSql.append("		  )       																				   \n");
				sbSql.append(" SELECT FMP_ITEM_ADD_INFO_S.NEXTVAL                                                              \n");
				sbSql.append("      , '" + ITEM_CODE + "'                                                                      \n");
				sbSql.append("      , '" + SABUN + "'                                                                          \n");
				sbSql.append("      , '" + ADD_INFO + "'                                                                       \n");
				sbSql.append("      , '" + SABUN + "'                                                                          \n");
				sbSql.append("      , SYSDATE                                                                                  \n");
				sbSql.append("      , '" + SABUN + "'                                                                          \n");
				sbSql.append("      , SYSDATE                                                                                  \n");
				sbSql.append("   FROM DUAL  			                                                                       \n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) {
				ITEM_SEQ         = nullToBlank(ds_CommentList.getString(i, "ITEM_SEQ"));          
				SABUN            = nullToBlank(ds_CommentList.getString(i, "SABUN"));
				ADD_INFO         = nullToBlank(ds_CommentList.getString(i, "ADD_INFO"));
				
				sbSql.delete(0, sbSql.length());
				sbSql.append(" UPDATE FMP_ITEM_ADD_INFO           		\n");
				sbSql.append("    SET ADD_INFO = '" + ADD_INFO + "'   	\n");
				sbSql.append("      , UUSER    = '" + SABUN + "'      	\n");
			    sbSql.append("      , UDATE    = SYSDATE		  		\n");
			    sbSql.append("  WHERE ITEM_SEQ = '" + ITEM_SEQ + "' 	\n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();				
			}
		}
		
		// 삭제
		if ( ds_CommentList.getRemovedRowCount() > 0 ) {

			for ( int i = 0 ; i < ds_CommentList.getRemovedRowCount() ; i++ )
			{
				
				sbSql.delete(0, sbSql.length());
				sbSql.append(" DELETE FROM FMP_ITEM_ADD_INFO           		\n");
				sbSql.append("  WHERE ITEM_SEQ = '" + ds_CommentList.getRemovedData(i, "ITEM_SEQ") + "' 	\n");
				sbSql.append("  AND ITEM_CODE = '" + ds_CommentList.getRemovedData(i, "ITEM_CODE") + "' 	\n");
				
				stmt = conn.createStatement();
				stmt.execute(sbSql.toString());
				stmt.close();
			}
		}
		
		conn.commit();
	   	this.setResultMessage(0, "OK", out_vl);
		
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