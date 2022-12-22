<%
//*-----------------------------------------------------------------------------
// ■ 시스템명     : 타매입처입금등록
// ■ 프로그램ID   : FMW00230E_T001.jsp
// ■ 프로그램명   : 타매입처입금등록
// ■ 작성일자     : 2011-01-01
// ■ 작성자       : 노규완
// ■ 이력관리     : 
//-----------------------------------------------------------------------------*/
%> 

<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ include file = "../../sc/main/common.jsp" %>
<%
	try	{
		PlatformRequest platformRequest = this.proc_input(request);
		in_vl = platformRequest.getData().getVariableList();
		in_dl = platformRequest.getData().getDataSetList();
		
		//jsp log 서비스 시작 
		logger.startIndividualLog(in_vl.getString("titLogId"));
		
		//오토커밋 강제 false
		conn.setAutoCommit(false);		
	
		//입력 데이타
		DataSet ds_iud      = in_dl.get("ds_IUD");
		//입력 파라메터
		String g_Upjang         = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo          = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang          = nullToBlank(in_vl.getString("sUpjang"));
		String sPayment_Date    = nullToBlank(in_vl.getString("sPayment_Date"));
		String sOtcustcd        = nullToBlank(in_vl.getString("sOtcustcd"));
		String s_Payment_ID       = nullToBlank(in_vl.getString("s_Payment_ID"));
	
		int sRowStatus;
		
		//FileLog.println("d:\\aaa.txt", ds_list);


		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//입력,수정
		for ( int i = 0 ; i < ds_iud.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sRowStatus = ds_iud.getRowType(i);

			if (sRowStatus == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (sRowStatus == DataSet.ROW_TYPE_INSERTED)
			{				
				sbSql.delete(0, sbSql.length());
		        sbSql.append("INSERT INTO FMW_OTCUST_PAYMENT( 								\n");
		        sbSql.append("  PAYMENT_ID                    								\n");
		        sbSql.append(", OTCUSTCD                     								\n");
		        sbSql.append(", UPJANG                       								\n");
		        sbSql.append(", PAYMENT_DATE                 								\n");
		        sbSql.append(", PAYMENT_TYPE                 								\n");
		        sbSql.append(", PAYMENT_AMT                 								\n");
		        sbSql.append(", REMARK                 										\n");
		        sbSql.append(", CUSER               										\n");
		        sbSql.append(", CDATE) VALUES(         										\n");
		        sbSql.append("  FMW_OTCUST_PAYMENT_S.NEXTVAL          					\n");
		        sbSql.append(", '" + sOtcustcd + "'  \n");
		        sbSql.append(", '" + sUpjang + "'  \n");
		        sbSql.append(", '" + sPayment_Date + "'  \n");
		        sbSql.append(", '" + nullToBlank(ds_iud.getString(i, "PAYMENT_TYPE")) + "'  \n");
		        sbSql.append(", '" + nullToBlank(ds_iud.getString(i, "PAYMENT_AMT")) + "'  \n");		        
		        sbSql.append(", '" + nullToBlank(ds_iud.getString(i, "REMARK")) + "'  \n");
		        sbSql.append(", '" + g_EmpNo + "'         									\n");
		        sbSql.append(", SYSDATE)   		                       						\n");		
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.delete(0, sbSql.length());
		        sbSql.append("UPDATE FMW_OTCUST_PAYMENT   \n");
		        sbSql.append("   SET PAYMENT_TYPE = '" + nullToBlank(ds_iud.getString(i, "PAYMENT_TYPE")) + "'	\n");
		        sbSql.append("     , PAYMENT_AMT = '" + nullToBlank(ds_iud.getString(i, "PAYMENT_AMT")) + "' 	\n");
		        sbSql.append("     , REMARK = '" + nullToBlank(ds_iud.getString(i, "REMARK")) + "' 				\n");
		        sbSql.append("     , UUSER = '" + g_EmpNo + "'          		\n");
		        sbSql.append("     , UDATE = SYSDATE          					\n");
		        sbSql.append(" WHERE PAYMENT_ID = '" + nullToBlank(ds_iud.getString(i, "PAYMENT_ID")) + "' 		\n");
			}
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			
			pstmt.close();
		}
		//삭제
		for ( int i = 0 ; i < ds_iud.getRemovedRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());

			sbSql.append("DELETE FROM FMW_OTCUST_PAYMENT \n");
			sbSql.append(" WHERE PAYMENT_ID = '" + s_Payment_ID + "' 		\n");
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			
			pstmt.close();
		}

		/**종료**/
		conn.commit();
		out_vl.add("fa_Msg", "");
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
		//ex.printStackTrace();
		conn.rollback();
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
