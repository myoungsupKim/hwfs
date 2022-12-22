<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/예산관리
■ 프로그램ID   : FMO00420E_T001.jsp
■ 프로그램명   : 예산관리/조회
■ 작성일자     : 2018-08-07
■ 작성자       : kihoon
■ 이력관리     : 2018-08-07	신규작성
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		logger.startIndividualLog(in_vl.getString("titLogId"));		
	
		StringBuffer sbSql = new StringBuffer();
		int sRowStatus;
		
		DataSet ds_list   = in_dl.get("ds_list");
		String 	sUser	  = in_vl.getString("sUser");
		
		for ( int i = 0 ; i < ds_list.getRowCount() ; i++ ) {
			
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_list.getRowType(i);
			
			switch ( sRowStatus ) {
					case DataSet.ROW_TYPE_NORMAL :
							break;
							
					case DataSet.ROW_TYPE_INSERTED :
							sbSql.append("\n\n");
							sbSql.append("  INSERT                                									\n");
							sbSql.append("  INTO   FMO_BUDGET_MGMT               									\n");
							sbSql.append("         (                              									\n");
							sbSql.append("               BUDGET_SEQ              									\n");
							sbSql.append("              ,SUBINV_CODE              									\n");
							sbSql.append("              ,START_DATE               									\n");
							sbSql.append("              ,END_DATE                 									\n");
							sbSql.append("              ,BUDGET_AMT               									\n");
							sbSql.append("              ,USE_YN                   									\n");
							sbSql.append("              ,CUSER                   									\n");
							sbSql.append("              ,CDATE                    									\n");
							sbSql.append("              ,UUSER                    									\n");
							sbSql.append("              ,UDATE                    									\n");
							sbSql.append("         )                              									\n");
							sbSql.append("         VALUES                         									\n");
							sbSql.append("         (                              									\n");
							sbSql.append("              FMO_BUDGET_MGMT_S.NEXTVAL 									\n");
							sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"SUBINV_CODE")) + "' \n");
							sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"START_DATE")) + "'  \n");
							sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"END_DATE")) + "'    \n");
							sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"BUDGET_AMT")) + "'  \n");
							sbSql.append("         		, 'Y'                  										\n");
							sbSql.append("         		, '" + sUser + "'      										\n");
							sbSql.append("         		, SYSDATE                   								\n");
							sbSql.append("         		, '" + sUser + "'      										\n");
							sbSql.append("         		, SYSDATE                   								\n");
							sbSql.append("         )                              									\n");
							sbSql.append("\n\n");
							
							break;
							
					case DataSet.ROW_TYPE_UPDATED :
							if ( "".equals(nullToBlank(ds_list.getString(i,"BUDGET_SEQ"))) ) {
								sbSql.append("\n\n");
								sbSql.append("  INSERT                                									\n");
								sbSql.append("  INTO   FMO_BUDGET_MGMT               									\n");
								sbSql.append("         (                              									\n");
								sbSql.append("               BUDGET_SEQ              									\n");
								sbSql.append("              ,SUBINV_CODE              									\n");
								sbSql.append("              ,START_DATE               									\n");
								sbSql.append("              ,END_DATE                 									\n");
								sbSql.append("              ,BUDGET_AMT               									\n");
								sbSql.append("              ,USE_YN                   									\n");
								sbSql.append("              ,CUSER                   									\n");
								sbSql.append("              ,CDATE                    									\n");
								sbSql.append("              ,UUSER                    									\n");
								sbSql.append("              ,UDATE                    									\n");
								sbSql.append("         )                              									\n");
								sbSql.append("         VALUES                         									\n");
								sbSql.append("         (                              									\n");
								sbSql.append("              FMO_BUDGET_MGMT_S.NEXTVAL 									\n");
								sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"SUBINV_CODE")) + "' \n");
								sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"START_DATE")) + "'  \n");
								sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"END_DATE")) + "'    \n");
								sbSql.append("         		, '" + nullToBlank(ds_list.getString(i,"BUDGET_AMT")) + "'  \n");
								sbSql.append("         		, 'Y'                  										\n");
								sbSql.append("         		, '" + sUser + "'      										\n");
								sbSql.append("         		, SYSDATE                   								\n");
								sbSql.append("         		, '" + sUser + "'      										\n");
								sbSql.append("         		, SYSDATE                   								\n");
								sbSql.append("         )                              									\n");
								sbSql.append("\n\n");
							} else {
								sbSql.append("  UPDATE FMO_BUDGET_MGMT                                                         \n");
								sbSql.append("  SET    START_DATE  = '" + nullToBlank(ds_list.getString(i,"START_DATE")) + "'  \n");
								sbSql.append("       , END_DATE    = '" + nullToBlank(ds_list.getString(i,"END_DATE")) + "'    \n");
								sbSql.append("       , BUDGET_AMT  = '" + nullToBlank(ds_list.getString(i,"BUDGET_AMT")) + "'  \n");
								sbSql.append("       , UUSER       = '" + sUser + "' 										   \n");
								sbSql.append("       , UDATE       = SYSDATE                                                   \n");
								sbSql.append("                                                                                 \n");
								sbSql.append("  WHERE                                                                          \n");
								sbSql.append("  BUDGET_SEQ	= '" + nullToBlank(ds_list.getString(i,"BUDGET_SEQ")) + "'		   \n");
								sbSql.append("  AND SUBINV_CODE = '" + nullToBlank(ds_list.getString(i,"SUBINV_CODE")) + "'    \n");
								sbSql.append("\n\n");
							}
							break;
			
			}
			
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			pstmt.close();	
			rs.close();
			
			sbSql.delete(0, sbSql.length());
		}
				
		
		for ( int d = 0 ; d < ds_list.getRemovedRowCount() ; d++ ) {
			sbSql.delete(0, sbSql.length());
			sbSql.append("\n\n");
	        sbSql.append("	DELETE FROM FMO_BUDGET_MGMT		\n");
	        sbSql.append("	WHERE BUDGET_SEQ	= '" + nullToBlank(ds_list.getRemovedStringData(d,"BUDGET_SEQ")) + "'		\n");                                                         
			sbSql.append("  AND SUBINV_CODE		= '" + nullToBlank(ds_list.getRemovedStringData(d,"SUBINV_CODE")) + "'		\n");                                                       
	        sbSql.append("\n\n");
			
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}

		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{		
		logger.debug(ex.getMessage(), ex);		
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
