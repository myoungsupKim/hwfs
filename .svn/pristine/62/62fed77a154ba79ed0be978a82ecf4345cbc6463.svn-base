<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/상품정보
■ 프로그램ID   : FMP00030V_T001.jsp
■ 프로그램명   : 주문통제 등록관리(조회)
■ 작성일자     : 2008-05-16
■ 작성자       : 박은규
■ 이력관리     : 2008-05-16
-----------------------------------------------------------------------------*/
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

		//입력 데이타
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//FileLog.println("d:\\aaa.txt", ds_Cond);


		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		String sCenterCode = nullToBlank(ds_Cond.getString(0, "CENTER_CODE"));
		String sMainUpjang = nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG"));
		String sUpjang = nullToBlank(ds_Cond.getString(0, "UPJANG"));
		String sItemType   = nullToBlank(ds_Cond.getString(0, "ITEM_TYPE"));

		//내역조회
		sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP \n");
		sbSql.append("     , NVL(ITEM_TYPE,'"+sItemType+"') AS ITEM_TYPE  \n");
		sbSql.append("     , SCC_YN_FUN(NVL(B.MON,'N'),'S') AS MON \n");
		sbSql.append("     , SCC_YN_FUN(NVL(B.TUE,'N'),'S') AS TUE \n");
		sbSql.append("     , SCC_YN_FUN(NVL(B.WED,'N'),'S') AS WED \n");
		sbSql.append("     , SCC_YN_FUN(NVL(B.THU,'N'),'S') AS THU \n");
		sbSql.append("     , SCC_YN_FUN(NVL(B.FRI,'N'),'S') AS FRI \n");
		sbSql.append("     , SCC_YN_FUN(NVL(B.SAT,'N'),'S') AS SAT \n");
		sbSql.append("     , SCC_YN_FUN(NVL(B.SUN,'N'),'S') AS SUN \n");
		sbSql.append("     , B.REMARK");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("     ,(SELECT * FROM FMP_ORD_CTRL \n");
		sbSql.append("        WHERE CTRL_TYPE = '" + nullToBlank(ds_Cond.getString(0, "CTRL_TYPE")) + "'\n          AND ITEM_TYPE <> '%' \n");
		if (! sItemType.equals("%"))
			sbSql.append("      AND ITEM_TYPE = '" + sItemType + "' \n");
		sbSql.append("      ) B \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		if (! sMainUpjang.equals("%"))
			sbSql.append("   AND A.MAIN_UPJANG = " + sMainUpjang + " \n");
		
		if (! sUpjang.equals(""))
			sbSql.append("   AND A.UPJANG = " + sUpjang + " \n");
		
		if (! sCenterCode.equals(""))
			sbSql.append("   AND EXISTS (SELECT 1 FROM VO_CENTER_UPJANG X, HLDC_ST_UPJANG Y WHERE X.CENTER_CODE = " + sCenterCode + " AND X.UPJANG = Y.AP_UNITPRICE_UPJANG AND Y.UPJANG = A.UPJANG) \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		sbSql.append(" ORDER BY A.UPJANG, B.ITEM_TYPE\n");

		out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		//로그남기기
		logger.debug(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		
		pstmt.close();
		rs.close();

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
