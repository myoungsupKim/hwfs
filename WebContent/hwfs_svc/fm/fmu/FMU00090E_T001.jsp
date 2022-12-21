<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/단가관리/공급업체관리
■ 프로그램ID   : FMU00090E_T001.jsp
■ 프로그램명   : 공급업체 단가작업 다중업장 조회(조회)
■ 작성일자     : 2013-01-28
■ 작성자       : 박은규
■ 이력관리     : 2013-01-28
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
		DataSet ds_Cond       = in_dl.get("ds_Cond");
		//입력 파라메터
		String strMainUpjang  = nullToBlank(in_vl.getString("strMainUpjang"));

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//내역조회
		sbSql.append("SELECT A.UPJANG, A.UPJANGNM_DISP, B.SAVE_CNT, '0' AS CHK \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("     , (SELECT A.UPJANG, COUNT(1) AS SAVE_CNT \n");
		sbSql.append("          FROM FMP_OTCUST_PRICE A \n");
		sbSql.append("         WHERE A.UPJANG IN (SELECT OTCUST_PRICE_UPJANG FROM FMS_UPJANG WHERE MAIN_UPJANG = " + strMainUpjang + ") \n");
		sbSql.append("           AND A.UPJANG <> " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("           AND A.SDATE = '" + nullToBlank(ds_Cond.getString(0, "SDATE")) + "' \n");
		sbSql.append("           AND A.ITEM_CODE LIKE '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "'||'%' \n");
		sbSql.append("         GROUP BY A.UPJANG) B \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = " + strMainUpjang + " \n");
		sbSql.append("   AND A.OTCUST_PRICE_UPJANG = A.UPJANG \n");
		sbSql.append("   AND A.UPJANG <> " + nullToBlank(ds_Cond.getString(0, "UPJANG")) + " \n");
		sbSql.append("   AND A.USE_YN = 'Y' \n");
		//해당 공급업체를 예외처리한 업장은 제외
		sbSql.append("   AND NOT EXISTS (SELECT 1 FROM FMP_OTCUST_LINK Z WHERE Z.UPJANG = A.UPJANG AND Z.OTCUSTCD = '" + nullToBlank(ds_Cond.getString(0, "OTCUSTCD")) + "' AND Z.USE_YN = 'N') \n");
		sbSql.append(" ORDER BY 1 \n");

out_vl.add("fa_Sql", sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_List = this.makeDataSet(rs, "ds_List");
		rs.close(); 
		pstmt.close();		

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
