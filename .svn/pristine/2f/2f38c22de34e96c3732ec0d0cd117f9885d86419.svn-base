<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/급식운영관리
■ 프로그램ID   : FMO00060E_T002.jsp
■ 프로그램명   : 보건증/자격증 등록관리(저장)
■ 작성일자     : 2008.02.25
■ 작성자       : 박은규
■ 이력관리     : 2008.02.25
-----------------------------------------------------------------------------*/
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
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
	
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
				sbSql.append("INSERT INTO FMO_LICEN_MGMT( \n");
				sbSql.append("      MGMT_ID \n");
				sbSql.append("    , UPJANG \n");
				sbSql.append("    , LICENCER \n");
				sbSql.append("    , DUTY \n");
				sbSql.append("    , LICEN_NAME \n");
				sbSql.append("    , LICEN_NUM \n");
				sbSql.append("    , LICEN_DATE \n");
				sbSql.append("    , EXPIRE_DATE \n");
				sbSql.append("    , CONTENTS \n");
				sbSql.append("    , CUSER \n");
				sbSql.append("    , CDATE \n");
				sbSql.append("    , UUSER \n");
				sbSql.append("    , UDATE \n");
				sbSql.append(" ) VALUES ( \n");
				//sbSql.append("	FMO_LICEN_MGMT_S.NEXTVAL \n");
				sbSql.append("      (SELECT NVL(MAX(MGMT_ID), 0) + 1  FROM FMO_LICEN_MGMT) \n");
				sbSql.append("	, " + sUpjang + " \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LICENCER")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "DUTY")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LICEN_NAME")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LICEN_NUM")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "LICEN_DATE")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "EXPIRE_DATE")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_iud.getString(i, "CONTENTS")) + "' \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");
			}
			else if (sRowStatus == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.append("UPDATE FMO_LICEN_MGMT \n");
				sbSql.append("   SET LICENCER = '" + nullToBlank(ds_iud.getString(i, "LICENCER")) + "' \n");
				sbSql.append("     , DUTY = '" + nullToBlank(ds_iud.getString(i, "DUTY")) + "' \n");
				sbSql.append("     , LICEN_NAME = '" + nullToBlank(ds_iud.getString(i, "LICEN_NAME")) + "' \n");
				sbSql.append("     , LICEN_NUM = '" + nullToBlank(ds_iud.getString(i, "LICEN_NUM")) + "' \n");
				sbSql.append("     , LICEN_DATE = '" + nullToBlank(ds_iud.getString(i, "LICEN_DATE")) + "' \n");
				sbSql.append("     , EXPIRE_DATE = '" + nullToBlank(ds_iud.getString(i, "EXPIRE_DATE")) + "' \n");
				sbSql.append("     , CONTENTS = '" + nullToBlank(ds_iud.getString(i, "CONTENTS")) + "' \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE MGMT_ID = " + nullToBlank(ds_iud.getString(i, "MGMT_ID")) + " \n");
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

			sbSql.append("DELETE FROM FMO_LICEN_MGMT \n");
			sbSql.append(" WHERE MGMT_ID = " + ds_iud.getRemovedData(i, "MGMT_ID").toString() + " \n");
			
out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			
			pstmt.close();
		}

		/**종료**/
		conn.commit();
		this.setResultMessage(0, "OK", out_vl);

	}
	catch(Exception ex)
	{
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
