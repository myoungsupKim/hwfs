<%
//*-----------------------------------------------------------------------------
//■ 시스템명     : 도소매관리/판매내역 일괄처리
//■ 프로그램ID   : FMW00200E_T001.jsp
//■ 프로그램명   : 판매내역 일괄처리
//■ 작성일자     : 2010.01.04
//■ 작성자       : 맹수영
//■ 이력관리     :  
//-----------------------------------------------------------------------------*/
%>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%

	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		 
		// log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));

		//오토커밋 강제 false
		conn.setAutoCommit(false);		
		
		//입력 데이타
		DataSet ds_in     = in_dl.get("ds_cond2");
			
		//입력 파라메터

		String v_HALL_CODE     = nullToBlank(in_vl.getString("HALL_CODE"));	
		String v_DATE          = nullToBlank(in_vl.getString("DATE"));
		String v_UPJANG         = nullToBlank(in_vl.getString("UPJANG"));
		String v_RCV_ID        = nullToBlank(in_vl.getString("RCV_ID"));
		String g_EmpNo       =  nullToBlank(in_vl.getString("g_EmpNo"));
		
		//변수선언
		int sRowStatus;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

        
 		for ( int i = 0 ; i < ds_in.getRowCount() ; i++ )
		{
  			
	 		sRowStatus = ds_in.getRowType(i);
	 		
	 		
	 		
	 		
			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			//else if (v_RCV_ID.equals(""))
			{ 		
		 		sbSql.delete(0, sbSql.length());
				sbSql.append("INSERT INTO FMW_RCV 	(			\n");                   
				sbSql.append("     RCV_ID       	\n");        
				sbSql.append("    ,UPJANG	\n");
				sbSql.append("    ,HALL_CODE	\n");
		     	sbSql.append("    ,RCV_DATE	\n");
				sbSql.append("    ,RCV_AMT	\n");
				sbSql.append("    ,DISCOUNT_AMT      	\n");        
				sbSql.append("    ,REMARK	\n");
				sbSql.append("    ,USE_YN	 ,CUSER, CDATE\n");
				sbSql.append(" ) \n");
				sbSql.append(" VALUES (	\n");			
				sbSql.append("     FMW_RCV_S.NEXTVAL 	\n");
				sbSql.append("    ,'" + v_UPJANG + "'	\n");
				sbSql.append("    ,'" + v_HALL_CODE + "'	\n");		
				sbSql.append("    ,'" + v_DATE + "'	\n");
				sbSql.append("    ," + nullToZero(ds_in.getString(i, "RCV_AMT")) + "	\n");
				sbSql.append("    ," + nullToZero(ds_in.getString(i, "DISCOUNT_AMT")) + "	\n");
				sbSql.append("    ,'" + nullToBlank(ds_in.getString(i, "REMARK")) + "'	\n");
				sbSql.append("    ,'Y'	\n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");  		
				sbSql.append(" ) \n"); 
			}
			//else if (! v_RCV_ID.equals(""))
				else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				
				sbSql.delete(0, sbSql.length());		
				sbSql.append("UPDATE FMW_RCV\n");
				sbSql.append("   SET RCV_AMT = " + nullToZero(ds_in.getString(i, "RCV_AMT")) + " \n");
				sbSql.append("     , DISCOUNT_AMT = " + nullToZero(ds_in.getString(i, "DISCOUNT_AMT")) + " \n");
				sbSql.append("     , REMARK = '" + nullToBlank(ds_in.getString(i, "REMARK")) + "' \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE RCV_ID = '" + nullToBlank(ds_in.getString(i, "RCV_ID")) + "' \n");	

			}
	 			
			out_vl.add("fa_Sql", sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeQuery();
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
