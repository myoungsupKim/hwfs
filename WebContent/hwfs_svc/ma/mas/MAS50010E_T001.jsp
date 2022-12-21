<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	try {
	
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);
	
		DataSet ds_DocList = in_dl.get("ds_DocList");
		DataSet ds_Cond    = in_dl.get("ds_Cond");

		String g_EmpNo     = in_vl.getString("g_EmpNo");
		String DOC_NUM     = "";    
		String DOC_KIND_CD = "";
		String UPJANG      = "";
		String STATUS_CD   = "";
		
		int RowCnt = ds_DocList.getRowCount();
		int RowStatus;
		
		StringBuffer sbSql = new StringBuffer();
		for (int i = 0 ; i < RowCnt ; i++ )
		{
			RowStatus = ds_DocList.getRowType(i);

			System.out.println("RowStatus : " + RowStatus);
			System.out.println("DOC_KIND_CD : " + ds_DocList.getString(i,"DOC_KIND_CD"));

			if ( RowStatus == DataSet.ROW_TYPE_INSERTED )
			{ 
				DOC_KIND_CD     = ds_DocList.getString(i,"DOC_KIND_CD");
				UPJANG          = ds_DocList.getString(i,"UPJANG");
				STATUS_CD      	= ds_DocList.getString(i,"STATUS_CD");

				sbSql = new StringBuffer();
				sbSql.append("SELECT NVL(MAX(DOC_NUM) + 1, 1) AS DOC_NUM FROM MAS_DOC_MGMT WHERE DOC_KIND_CD = ? \n");
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(1, DOC_KIND_CD);
				rs = pstmt.executeQuery();
				rs.next();
				
				// 문서번호 채번
				DOC_NUM = rs.getString("DOC_NUM");
				
				sbSql = new StringBuffer();
				sbSql.append("INSERT INTO MAS_DOC_MGMT (    \n");
				sbSql.append("       DOC_NUM                \n");
				sbSql.append("     , DOC_KIND_CD            \n");
				sbSql.append("     , UPJANG                 \n");
				sbSql.append("     , STATUS_CD              \n");
				sbSql.append("     , CUSER                  \n");
				sbSql.append("     , CDATE                  \n");
				sbSql.append("     , UUSER                  \n");
				sbSql.append("     , UDATE                  \n");
				sbSql.append(") VALUES (                    \n");
				sbSql.append("       ?                      \n");
				sbSql.append("     , ?                      \n");
				sbSql.append("     , ?                      \n");
				sbSql.append("     , ?                      \n");
				sbSql.append("     , ?                      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append("     , ?                      \n");
				sbSql.append("     , SYSDATE                \n");
				sbSql.append(")                             \n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(1, DOC_NUM);
				pstmt.setString(2, DOC_KIND_CD);
				pstmt.setString(3, UPJANG);
				pstmt.setString(4, "01");
				pstmt.setString(5, g_EmpNo);
				pstmt.setString(6, g_EmpNo);
				pstmt.executeUpdate();
			}
			else if ( RowStatus == DataSet.ROW_TYPE_UPDATED ) 
			{
				DOC_KIND_CD = ds_DocList.getString(i,"DOC_KIND_CD");
				DOC_NUM     = ds_DocList.getString(i,"DOC_NUM");
				UPJANG      = ds_DocList.getString(i,"UPJANG");
				STATUS_CD   = ds_DocList.getString(i,"STATUS_CD");
				
				sbSql = new StringBuffer();
				sbSql.append("UPDATE MAS_DOC_MGMT        \n"); 
				sbSql.append("   SET UPJANG    = ?       \n"); 
				sbSql.append("     , STATUS_CD = ?       \n"); 
				sbSql.append("     , UUSER     = ?       \n"); 
				sbSql.append("     , UDATE     = SYSDATE \n"); 
				sbSql.append(" WHERE DOC_KIND_CD = ?     \n");
				sbSql.append("   AND DOC_NUM = ?         \n");
				
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.setString(1, UPJANG);
				pstmt.setString(2, STATUS_CD);
				pstmt.setString(3, g_EmpNo);
				pstmt.setString(4, DOC_KIND_CD);
				pstmt.setString(5, DOC_NUM);
				pstmt.executeUpdate();
			}
			
			// 이력 등록
			sbSql = new StringBuffer();
			sbSql.append("INSERT INTO MAS_DOC_MGMT_LOG            \n");
			sbSql.append("SELECT DOC_NUM                          \n");
			sbSql.append("     , DOC_KIND_CD                      \n");			
			sbSql.append("     , (SELECT NVL(MAX(LOG_SEQ) + 1, 1) \n");
			sbSql.append("          FROM MAS_DOC_MGMT_LOG         \n");
			sbSql.append("         WHERE DOC_KIND_CD = ?          \n");
			sbSql.append("           AND DOC_NUM = ?)             \n");
			sbSql.append("     , UPJANG                           \n");
			sbSql.append("     , STATUS_CD                        \n");
			sbSql.append("     , CUSER                            \n");
			sbSql.append("     , CDATE                            \n");
			sbSql.append("     , UUSER                            \n");
			sbSql.append("     , UDATE                            \n");
			sbSql.append("  FROM MAS_DOC_MGMT                     \n");
			sbSql.append(" WHERE DOC_KIND_CD = ?			      \n");
			sbSql.append("   AND DOC_NUM = ?                      \n");

			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.setString(1, DOC_KIND_CD);
			pstmt.setString(2, DOC_NUM);
			pstmt.setString(3, DOC_KIND_CD);
			pstmt.setString(4, DOC_NUM);
			pstmt.executeUpdate();			
		}
		
	   conn.commit();
	   this.setResultMessage(0, "OK", out_vl);
		
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