<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00300E_T004.jsp
■ 프로그램명   : 제출단가 등록관리(저장)
■ 작성일자     : 2008.04.15
■ 작성자       : 박은규
■ 이력관리     : 2008.04.15
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
		DataSet ds_MultiUpj = in_dl.get("ds_MultiUpj");
		//FileLog.println("d:\\aaa.txt", ds_MultiUpj);
	
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sRow         = nullToBlank(in_vl.getString("sRow"));
		String sSdate       = nullToBlank(in_vl.getString("sSdate"));
		String sEdate       = nullToBlank(in_vl.getString("sEdate"));
		String sOtcust      = nullToBlank(in_vl.getString("sOtcust"));

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//입력
		for ( int iRow = Integer.parseInt(sRow)+1; iRow < ds_MultiUpj.getRowCount(); iRow++ )
		{
			if (! nullToBlank(ds_MultiUpj.getString(iRow, "CHK")).equals("1")) continue;

  		//기존자료 삭제
			sbSql.delete(0, sbSql.length());
	  	sbSql.append("DELETE FROM FMU_SB_PRICE A \n");
		  sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_MultiUpj.getString(iRow, "UPJANG")) + " \n");
  		sbSql.append("   AND A.SDATE  = '" + sSdate + "' \n");
	  	sbSql.append("   AND A.EDATE  = '" + sEdate + "' \n");
		  if (! sOtcust.equals(""))
        sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = '" + sOtcust + "') \n");
out_vl.add("fa_Sql", sbSql.toString());
      //System.out.println(sbSql.toString());
	  	pstmt = conn.prepareStatement(sbSql.toString());
		  pstmt.executeUpdate();
			pstmt.close();

			//입력
			sbSql.delete(0, sbSql.length());
	  	sbSql.append("INSERT INTO FMU_SB_PRICE A \n");
	  	sbSql.append("SELECT " + nullToBlank(ds_MultiUpj.getString(iRow, "UPJANG")) + " \n");
	  	sbSql.append("     , SDATE, EDATE, ITEM_CODE, SB_PRICE, REMARK, USE_YN, ATTR01, ATTR02, ATTR03, ATTR04, ATTR05, ATTR06, ATTR07, ATTR08, ATTR09, ATTR10, CUSER, CDATE, UUSER, UDATE \n");
	  	sbSql.append("  FROM FMU_SB_PRICE A \n");
      sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_MultiUpj.getString(Integer.parseInt(sRow), "UPJANG")) + " \n");
  		sbSql.append("   AND A.SDATE  = '" + sSdate + "' \n");
	  	sbSql.append("   AND A.EDATE  = '" + sEdate + "' \n");
		  if (! sOtcust.equals(""))
        sbSql.append("   AND EXISTS (SELECT 1 FROM FMS_ITEM_V B WHERE B.ITEM_CODE = A.ITEM_CODE AND B.OTCUSTCD = '" + sOtcust + "') \n");
out_vl.add("fa_Sql", sbSql.toString());
      //System.out.println(sbSql.toString());
	  	pstmt = conn.prepareStatement(sbSql.toString());
		  pstmt.executeUpdate();
			pstmt.close();
      //
  		conn.commit();
		}

		/**종료**/
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