<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/주문관리
■ 프로그램ID   : FMP00130E_T004.jsp
■ 프로그램명   : 삭제데이터 복원
■ 작성일자     : 2008.01.21
■ 작성자       : 박은규
■ 이력관리     : 2009-03-16 박은규 CSR#(25384) 요청자:이혜은(fs기획팀)
               최초 작성
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
	
		//입력 데이타
		//DataSet ds_List     = in_dl.get("ds_List");
		//입력 파라메터
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));
		String sItemCode    = nullToBlank(in_vl.getString("sItemCode"));
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
			
		int iInsCnt         = 0;
		
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();


		//식단복원
		sbSql.delete(0, sbSql.length());
		sbSql.append("UPDATE FMM_RECIPE_ITEM A \n");
		sbSql.append("   SET A.PR_YN  = 'N' \n");
		sbSql.append("     , A.PR_ID  = NULL \n");
		sbSql.append("     , A.PR_NUM = NULL \n");
		sbSql.append("     , A.PR_QTY = 0 \n");
		sbSql.append("     , A.UUSER  = '" + g_EmpNo + "' \n");
		sbSql.append("     , A.UDATE  = SYSDATE \n");
		sbSql.append(" WHERE A.UPJANG = " + sUpjang + " \n");
		sbSql.append("   AND A.NEED_DATE = '" + sNeedDate + "' \n");
		sbSql.append("   AND A.ITEM_CODE = '" + sItemCode + "' \n");
		sbSql.append("   AND A.PR_YN  = 'Y' \n");
		sbSql.append("   AND A.PR_ID  = -999 \n");
		sbSql.append("   AND EXISTS (SELECT 1 FROM FMM_MENU B \n");
		sbSql.append("                WHERE B.UPJANG = A.UPJANG \n");
		sbSql.append("                  AND B.MENU_CD = A.MENU_CD \n");
		sbSql.append("                  AND B.UPJANG = " + sUpjang + " \n");
		sbSql.append("                  AND B.SUBINV_CODE = '" + sSubinv + "') \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		iInsCnt = pstmt.executeUpdate();
		pstmt.close();

		/**종료**/
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