<%
/*-----------------------------------------------------------------------------
■ 시스템명     : TOP화면 팝업처리
■ 프로그램ID   : SCCALRAM001_T002.jsp
■ 프로그램명   : TOP화면 팝업조회 후 처리
■ 작성일자     : 2008.05.30
■ 작성자       : 박은규
■ 이력관리     : 2008.05.30
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
		//logger.startIndividualLog(in_vl.getString("titLogId"));

		//입력 데이타
		//DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String g_SystemId   = nullToBlank(in_vl.getString("g_SystemId"));
		String sPtype       = nullToBlank(in_vl.getString("sPtype"));
		String sPkey        = nullToBlank(in_vl.getString("sPkey"));
		String sBlock       = nullToBlank(in_vl.getString("sBlock"));
	
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//게시물 확인
		if (sPtype.equals("게시판"))
		{
			//존재여부
			sbSql.delete(0, sbSql.length());
			//sbSql.append("/*----- 팝업확인 존재여부 -----*/ \n");
			sbSql.append("SELECT 1 FROM SCC_BBS_POPUP_CONF \n");
			sbSql.append(" WHERE CON_ID = " + sPkey + " \n");
			sbSql.append("   AND SABUN = '" + g_EmpNo + "' \n");
//out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			//jsp 로그남기기
			//logger.debug(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				//게시판 팝업 확인처리
				sbSql.delete(0, sbSql.length());
				//sbSql.append("/*----- 게시판 팝업 확인처리 -----*/ \n");
				sbSql.append("UPDATE SCC_BBS_POPUP_CONF \n");
				sbSql.append("   SET CONF_DATE = SYSDATE \n");
				sbSql.append("     , BLOCK_YN = DECODE(BLOCK_YN,'Y','Y',SCC_YN_FUN('" + sBlock + "','U')) \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE CON_ID = " + sPkey + " \n");
				sbSql.append("   AND SABUN = '" + g_EmpNo + "' \n");
			}
			else
			{
				//게시판 팝업 확인처리
				sbSql.delete(0, sbSql.length());
				//sbSql.append("/*----- 게시판 팝업 확인처리 -----*/ \n");
				sbSql.append("INSERT INTO SCC_BBS_POPUP_CONF \n");
				sbSql.append("( CON_ID, SABUN, CONF_DATE, BLOCK_YN, CUSER, CDATE) VALUES \n");
				sbSql.append("( " + sPkey + " \n");
				sbSql.append(", '" + g_EmpNo + "' \n");
				sbSql.append(", SYSDATE \n");
				sbSql.append(", SCC_YN_FUN('" + sBlock + "','U') \n");
				sbSql.append(", '" + g_EmpNo + "' \n");
				sbSql.append(", SYSDATE ) \n");
			}
			pstmt.close();
			rs.close();
//out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			//jsp 로그남기기
			//logger.debug(sbSql.toString());
			pstmt = conn.prepareStatement(sbSql.toString());
			pstmt.executeUpdate();
			pstmt.close();
		}
		//협력업체 공지 확인처리
		if ((g_SystemId.equals("FOMS")) && (sPtype.equals("협력업체공지")))
		{
			sbSql.delete(0, sbSql.length());
			//sbSql.append("/*----- 협력업체 공지 확인처리 -----*/ \n");
			sbSql.append("UPDATE HLDC_PO_ALRAM A \n");
			sbSql.append("   SET A.CONFIRM_DATE = SYSDATE \n");
			sbSql.append("     , A.UPDATE_BY    = '" + g_EmpNo + "' \n");
			sbSql.append("     , A.UPDATE_DATE  = SYSDATE \n");
			sbSql.append(" WHERE A.ALRAM_ID = " + sPkey + " \n");

//out_vl.add("fa_Sql", sbSql.toString());
			//System.out.println(sbSql.toString());
			//jsp 로그남기기
			//logger.debug(sbSql.toString());
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
		conn.rollback();
		ex.printStackTrace();
		//jsp 로그남기기
		//logger.debug(ex.getMessage(), ex);
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
//		try {
//			logger.endIndividualLog();
//		} catch( Exception logE) {
//			logE.printStackTrace();
//		}
	}

	proc_output(response,out,out_vl,out_dl);

%>
