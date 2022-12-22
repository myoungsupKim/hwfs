<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/운영관리
■ 프로그램ID   : FMO00020E_T001.jsp
■ 프로그램명   : 가맹점메뉴 설정관리
■ 작성일자     : 2010.06.14
■ 작성자       : 박은규
■ 이력관리     : 2010.06.14
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
		DataSet ds_Cond     = in_dl.get("ds_Cond");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sType        = nullToBlank(in_vl.getString("sType"));
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_List;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//1)메뉴Mst조회
		if (sType.equals("QryMst"))
		{
			sbSql.append("SELECT A.MENU_ID \n");
			sbSql.append("     , A.MENU_NAME, A.UPJANG, SCC_YN_FUN(A.USE_YN) AS USE_YN \n");
			sbSql.append("  FROM FMO_MENU_MST A \n");
			sbSql.append(" WHERE A.UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
			sbSql.append(" ORDER BY A.MENU_ID \n");
		}
		//2)메뉴Dtl조회
		else if (sType.equals("QryDtl"))
		{
			sbSql.append("SELECT A.MENU_ID \n");
			sbSql.append("     , A.ITEM_CODE, B.ITEM_NAME, B.ITEM_SIZE \n");
			sbSql.append("     , A.STD_QTY \n");
// 			sbSql.append("     , B.IMG_PATH AS IMAGE_PATH \n"); 구매 자재 테이블 변경으로 자재이미지 뷰 방식 변경
			sbSql.append("  FROM FMO_MENU_DTL A, HLDC_PO_ITEM_MST B \n");
			sbSql.append(" WHERE A.ITEM_CODE = B.ITEM_CODE \n");
			sbSql.append("   AND A.MENU_ID = " + nullToBlank(ds_Cond.getString(0, "MENU_ID")) + " \n");
			sbSql.append(" ORDER BY A.ITEM_CODE \n");
		}

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
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