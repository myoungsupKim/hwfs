<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/현황관리
■ 프로그램ID   : FMM00240V_T001.jsp
■ 프로그램명   : 영양성분 분석표(상단집계)
■ 작성일자     : 2008-04-08
■ 작성자       : 박은규
■ 이력관리     : 2008-04-08 - 최초작성
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
		DataSet ds_cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		//FileLog.println("d:\\aaa.txt", ds_cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		
		//내역조회
		sbSql.append("SELECT A.UPJANG, A.MENU_CD, A.MENU_NAME \n");
		sbSql.append("     , B.CODE_NAME||C.CODE_NAME AS MEAL_CORNER \n");
		sbSql.append("     , FMM_RECIPENAME_FUN(A.UPJANG, A.MENU_CD, '1') AS MENU_DISP \n");
		sbSql.append("     , A.SALE_PRICE \n");
		sbSql.append("     , A.EXPECT_MEAL_QTY \n");
		sbSql.append("     , '0' AS CHK \n");
		sbSql.append("  FROM FMM_MENU A, FMS_MEAL_CORNER A2 \n");
		sbSql.append("     ,(SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0023') B \n");
		sbSql.append("     ,(SELECT CODE, CODE_NAME FROM SCC_COMMON_CODE WHERE GROUP_CODE = 'FS0022') C \n");
		sbSql.append(" WHERE A.MEAL = B.CODE \n");
		sbSql.append("   AND A.CORNER = C.CODE \n");
		sbSql.append("   AND A.SUBINV_CODE = A2.SUBINV_CODE \n");
		sbSql.append("   AND A.MEAL = A2.MEAL \n");
		sbSql.append("   AND A.CORNER = A2.CORNER \n");
		sbSql.append("   AND A2.USE_YN = 'Y' \n");
		sbSql.append("   AND A.UPJANG = " + nullToBlank(ds_cond.getString(0,"UPJANG")) + " \n");
		sbSql.append("   AND A.MENU_DATE = '" + nullToBlank(ds_cond.getString(0,"MENU_DATE")) + "' \n");
		sbSql.append("   AND A.SUBINV_CODE = '" + nullToBlank(ds_cond.getString(0,"SUBINV_CODE")) + "' \n");
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		rs.close();
		pstmt.close();		
		//FileLog.println("d:\\aaa.txt", ds_List);

		/**종료**/
		out_dl.add(ds_List);
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