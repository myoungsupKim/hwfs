<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/노무관리
■ 프로그램ID   : FMO00720E_T002.jsp
■ 프로그램명   : 제세공과금 저장
■ 작성일자     : 2012.08.26
■ 작성자       : 문형광
■ 이력관리     : 
-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	Statement stmt              =  null;
	try {
		PlatformRequest platformRequest = this.proc_input(request);  
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();	
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));	
		//오토커밋 강제 false
		conn.setAutoCommit(false);
		//In 데이타
		DataSet ds_List  	    = in_dl.get("ds_List");
		DataSet ds_Cond  	    = in_dl.get("ds_Cond");
		
		String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));
		
	    //out 데이타
		StringBuffer sbSql = new StringBuffer();
	    //그리드 상태값
		int sRowStatus;

		for ( int i = 0 ; i < ds_List.getRowCount() ; i++ )
        {
			sbSql.delete(0, sbSql.length());
			sRowStatus = ds_List.getRowType(i);
			
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{	
				sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FMO_CHARGE            \n");
		        sbSql.append("     ( SABUN                      \n");
		        sbSql.append("     , DU_MONTH                   \n");
		        sbSql.append("     , UPJANG                     \n");
		        sbSql.append("     , MED_INS                    \n");
		        sbSql.append("     , NAT_PES                    \n");
		        sbSql.append("     , EMP_INS                    \n");
		        sbSql.append("     , ACC_INS                    \n");
		        sbSql.append("     , OUT_PAY                    \n");
		        sbSql.append("     , ADD_PAY                    \n");
		        sbSql.append("     , CUSER                      \n");
		        sbSql.append("     , CDATE                      \n");
		        sbSql.append("     , UUSER                      \n");
		        sbSql.append("     , UDATE            		    \n");
		        sbSql.append("     ) VALUES                     \n");
		        sbSql.append("     ( '" + nullToBlank(ds_List.getString(i, "SABUN")) + "'   \n");
		        sbSql.append("     , '" + nullToBlank(ds_Cond.getString(0, "DATE")) + "'    \n");
		        sbSql.append("     , '" + nullToBlank(ds_List.getString(i, "UPJANG")) + "'  \n");
		        sbSql.append("     , NVL('" + nullToBlank(ds_List.getString(i, "MED_INS")) + "', 0)   \n");
		        sbSql.append("     , NVL('" + nullToBlank(ds_List.getString(i, "NAT_PES")) + "', 0)   \n");
		        sbSql.append("     , NVL('" + nullToBlank(ds_List.getString(i, "EMP_INS")) + "', 0)   \n");
		        sbSql.append("     , NVL('" + nullToBlank(ds_List.getString(i, "ACC_INS")) + "', 0)   \n");
		        sbSql.append("     , NVL('" + nullToBlank(ds_List.getString(i, "OUT_PAY")) + "', 0)   \n");
		        sbSql.append("     , NVL('" + nullToBlank(ds_List.getString(i, "ADD_PAY")) + "', 0)   \n");
		        sbSql.append("     , '" + g_EmpNo + "'                          	                \n");
		        sbSql.append("     , SYSDATE                   										\n");
		        sbSql.append("     , '" + g_EmpNo + "'                          					\n");
		        sbSql.append("     , SYSDATE                  										\n");
		        sbSql.append("     )                  												\n");
out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();			
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
				sbSql.append("UPDATE FMO_CHARGE            \n");
		        sbSql.append("   SET MED_INS = NVL('" + nullToBlank(ds_List.getString(i, "MED_INS")) + "', 0) \n");
		        sbSql.append("     , NAT_PES = NVL('" + nullToBlank(ds_List.getString(i, "NAT_PES")) + "', 0) \n");
		        sbSql.append("     , EMP_INS = NVL('" + nullToBlank(ds_List.getString(i, "EMP_INS")) + "', 0) \n");
		        sbSql.append("     , ACC_INS = NVL('" + nullToBlank(ds_List.getString(i, "ACC_INS")) + "', 0) \n");
		        sbSql.append("     , OUT_PAY = NVL('" + nullToBlank(ds_List.getString(i, "OUT_PAY")) + "', 0) \n");
		        sbSql.append("     , ADD_PAY = NVL('" + nullToBlank(ds_List.getString(i, "ADD_PAY")) + "', 0) \n");
		        sbSql.append("     , UUSER   = '" + g_EmpNo + "'                                            \n");
		        sbSql.append("     , UDATE   = SYSDATE        		                                        \n");
		        sbSql.append(" WHERE UPJANG = '" + nullToBlank(ds_List.getString(0, "UPJANG")) + "' \n");
		        sbSql.append("   AND SABUN =  '" + nullToBlank(ds_List.getString(i, "SABUN")) + "'  \n");
		        sbSql.append("   AND DU_MONTH = '" + nullToBlank(ds_Cond.getString(0, "DATE")) + "' \n");
out_vl.add("fa_Sql", sbSql.toString());					
				pstmt = conn.prepareStatement(sbSql.toString());
				pstmt.executeUpdate();
				pstmt.close();	
			}
        }
		
		for ( int i = 0 ; i < ds_List.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());
	        sbSql.append("DELETE FROM FMO_CHARGE   \n");	
	        sbSql.append( " WHERE DU_MONTH = '" + nullToBlank(ds_Cond.getString(0, "DATE")) + "' \n");
			sbSql.append( "   AND UPJANG = '" + ds_List.getRemovedData(i, "UPJANG") + "' \n");
			sbSql.append( "   AND SABUN = '" + ds_List.getRemovedData(i, "SABUN") + "'   \n");
out_vl.add("fa_Sql", sbSql.toString());					
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();	
		}		
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);
	}
	
	catch(Exception ex)
	{
		conn.rollback();
		//ex.printStackTrace();
		//jsp 로그남기기
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