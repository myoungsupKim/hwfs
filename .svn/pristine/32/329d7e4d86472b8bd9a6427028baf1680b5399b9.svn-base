<%--  <%@page import="tit.service.sqlmap.dataset.DataSetSqlExecutor"%>
<%@page import="tit.service.sqlmap.SqlExecutor"%>
<%@page import="tit.service.sqlmap.SqlMapManagerUtility"%>
<%@page import="tit.service.sqlmap.SqlRequest"%>   --%>

<%@page import="com.sz.service.sqlmap.SqlMapFactoryHelper"%>
<%@page import="com.sz.service.sqlmap.SqlRequest"%>
<%@page import="com.sz.ui.xplatform.DataSetUtility"%>
<%@page import="com.sz.util.AppDataUtility"%>
<%@page import="com.sz.service.sqlmap.SqlExecutor"%>
<%@page import="com.sz.*"%> 

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
		
		String g_EmpNo 		  = in_vl.getString("g_EmpNo");
		DataSet in_ds_item    =  in_dl.get("ds_restrict_item2");
		DataSet in_ds_upjang  =  in_dl.get("ds_add_upjang");
		
		conn.setAutoCommit(false);
		
		//FileLog.println("d:\\aaa.txt",in_ds_item);
		//FileLog.println("d:\\bbb.txt",in_ds_upjang);
	
	
		int intItemRowCnt = 0;
		int intUpjangRowCnt = 0;
		
		StringBuffer sbSelSql = new StringBuffer();
		StringBuffer sbInsSql = new StringBuffer();
		//StringBuffer sbUptSql = new StringBuffer();
		StringBuffer sbDelsql = new StringBuffer();
		
		//ORA-01000: maximum open cursors exceeded 문제 해결을 위한 변경 
		String strInsertSql;
		
		strInsertSql = "INSERT INTO FSI_RESTRICT_SET( ";
		strInsertSql += "		 UPJANG ";
		strInsertSql += "		, RESTRICT_SEQ ";
		strInsertSql += "		, ITEM_CODE ";
		strInsertSql += "		, RESTRICT_START ";
		strInsertSql += "		, RESTRICT_END ";
		strInsertSql += "		, RESTRICT_REASON ";
		strInsertSql += "		, USE_YN ";
		strInsertSql += "		, CUSER ";
		strInsertSql += "		, CDATE ";
		strInsertSql += "		, UUSER ";
		strInsertSql += "		, UDATE ";
		strInsertSql += "	 ) VALUES ( ";
		strInsertSql += "		  #strUpjang# ";
		strInsertSql += "		, #strSeq# ";
		strInsertSql += "		, #strItem# ";
		strInsertSql += "		, #strStart# ";
		strInsertSql += "		, #strEnd# ";
		strInsertSql += "		, #strReason# ";
		strInsertSql += "		, 'Y' ";
		strInsertSql += "		, #g_EmpNo1# ";
		strInsertSql += "		, SYSDATE ";
		strInsertSql += "		, #g_EmpNo2# ";
		strInsertSql += "		, SYSDATE ";
		strInsertSql += "	 ) ";	
		
	  //  SqlRequest insertReq = SqlMapManagerUtility.makeInsertSqlRequestForSql(strInsertSql);
	    
	    SqlRequest insertReq = SqlMapFactoryHelper.makeSqlRequestByInsertSql(strInsertSql);
	    
		SqlExecutor inDb = SqlMapFactoryHelper.makeSqlExecutor(conn, SqlMapFactoryHelper.XDATASET);
		
		String strDeleteSql;
		
		strDeleteSql = "DELETE ";
		strDeleteSql += "  FROM FSI_RESTRICT_SET  ";
		strDeleteSql += " WHERE RESTRICT_SEQ = #strSeq#  ";
		strDeleteSql += "   AND UPJANG = #strUpjang#  ";	
		
 	//	SqlRequest deleteReq = SqlMapManagerUtility.makeInsertSqlRequestForSql(strDeleteSql);
 		
 		SqlRequest deleteReq = SqlMapFactoryHelper.makeSqlRequestByDeleteSql(strDeleteSql);
 		  
		SqlExecutor delDb = SqlMapFactoryHelper.makeSqlExecutor(conn, SqlMapFactoryHelper.XDATASET);

		
		int inCnt = 0; 
		int delCnt = 0;
		
		intItemRowCnt = in_ds_item.getRowCount();	
		intUpjangRowCnt = in_ds_upjang.getRowCount();
		
		String strItem = "";
		String strStart = "";
		String strEnd = "";
		String strSeq = "";
		String strReason = "";
		String strUpjang = "";
		
		for ( int i = 0 ; i < intItemRowCnt ; i++ )
		{
			strItem = in_ds_item.getString(i,"ITEM_CODE");
			strStart= in_ds_item.getString(i,"RESTRICT_START");
			strEnd  = in_ds_item.getString(i,"RESTRICT_END");
			strSeq  = in_ds_item.getString(i,"RESTRICT_SEQ");
			strReason = in_ds_item.getString(i, "RESTRICT_REASON");

			for ( int j = 0 ; j < intUpjangRowCnt ; j++ )
			{
				strUpjang = in_ds_upjang.getString(j, "UPJANG");	
				
				deleteReq.addParamObject("strSeq", strSeq);
				deleteReq.addParamObject("strUpjang", strUpjang);

				if( delCnt == 0 ) {
					delDb.startBatch(deleteReq);
				} else {
					delDb.addBatch(deleteReq);
				}

				delCnt++;
				
				insertReq.addParamObject("strUpjang", strUpjang);
				insertReq.addParamObject("strSeq", strSeq);
				insertReq.addParamObject("strItem", strItem);
				insertReq.addParamObject("strStart", strStart);
				insertReq.addParamObject("strEnd", strEnd);
				insertReq.addParamObject("strReason", strReason);
				insertReq.addParamObject("g_EmpNo1", g_EmpNo);
				insertReq.addParamObject("g_EmpNo2", g_EmpNo);
					
					
				if( inCnt == 0 ) {
					inDb.startBatch(insertReq);
				} else {
					inDb.addBatch(insertReq);
				}
				
				inCnt++;
			}
		}	
		
		if ( delCnt > 0 ) {
			delDb.executeBatch();
		}
		
		if ( inCnt > 0 ) {
			inDb.executeBatch();
		}
		
		deleteReq.clearParam();
		deleteReq = null;
		delDb = null;
		
		insertReq.clearParam();
		insertReq = null;
		inDb = null;
		
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