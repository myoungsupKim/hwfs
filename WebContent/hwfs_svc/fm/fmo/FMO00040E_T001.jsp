<%
/*-----------------------------------------------------------------------------
■ 시스템명     : 식재영업/운영관리
■ 프로그램ID   : FMO00040E_T001.jsp
■ 프로그램명   : 가맹점메뉴 실적조회
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
		//FileLog.println("d:\\aaa.txt", ds_Cond);

		//out 데이타
		DataSet ds_ListTmp1, ds_ListTmp2;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();

		//실적조회
		sbSql.delete(0, sbSql.length());
        sbSql.append("SELECT '0' AS GB, ' ' AS UPJANG, '[ 기 준 ]' AS UPJANGNM_DISP \n");
        sbSql.append("     , 0 AS SALE_QTY \n");
        sbSql.append("     , A.ITEM_CODE \n");
        sbSql.append("     , (SELECT Z.ITEM_NAME FROM HLDC_PO_ITEM_MST Z WHERE Z.ITEM_CODE = A.ITEM_CODE) AS ITEM_NAME \n");
        sbSql.append("     , A.STD_QTY AS TRANS_QTY \n");
        sbSql.append("  FROM FMO_MENU_DTL A \n");
        sbSql.append(" WHERE A.MENU_ID = " + nullToBlank(ds_Cond.getString(0, "MENU_ID")) + " \n");
        sbSql.append(" --------- \n");
        sbSql.append(" UNION ALL \n");
        sbSql.append(" --------- \n");
        sbSql.append("SELECT '1' AS GB, TO_CHAR(A.UPJANG) AS UPJANG, A.UPJANGNM_DISP \n");
        sbSql.append("     , (SELECT Z.SALE_QTY FROM FMO_MENU_SALE Z \n");
        sbSql.append("         WHERE Z.UPJANG = A.UPJANG \n");
		sbSql.append("           AND Z.SALE_YM = '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "' \n");
		sbSql.append("           AND Z.MENU_ID = " + nullToBlank(ds_Cond.getString(0, "MENU_ID")) + ") AS SALE_QTY \n");
        sbSql.append("     , B.ITEM_CODE, B.ITEM_NAME \n");
        sbSql.append("     , B.TRANS_QTY \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("     , (SELECT TO_CHAR(A.TRANS_UPJANG) AS UPJANG \n");
		sbSql.append("             , A.ITEM_CODE \n");
		sbSql.append("             , (SELECT Z.ITEM_NAME FROM HLDC_PO_ITEM_MST Z WHERE Z.ITEM_CODE = A.ITEM_CODE) AS ITEM_NAME \n");
		sbSql.append("             , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("             , FMS_UPJANG B \n");
		sbSql.append("             , FMO_MENU_DTL C \n");
		sbSql.append("         WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "'||'01' \n");
		sbSql.append("                                AND '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "'||'31' \n");
		sbSql.append("           AND ((A.TRANS_TYPE = 'I001') OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))\n");
		sbSql.append("           AND A.SUBINV_CODE LIKE 'S10%' \n");
		sbSql.append("           AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("           AND C.MENU_ID = " + nullToBlank(ds_Cond.getString(0, "MENU_ID")) + " \n");
		sbSql.append("         GROUP BY A.TRANS_UPJANG, A.ITEM_CODE) B \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG--(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		ds_ListTmp1 = this.makeDataSet(rs, "ds_ListTmp1");
		pstmt.close();
		rs.close();

		//비율조회
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT '2' AS GB, A.UPJANG, '[비율]'||A.UPJANGNM_DISP AS UPJANGNM_DISP \n");
		sbSql.append("     , A.SALE_QTY \n");
        sbSql.append("     , A.ITEM_CODE, A.ITEM_NAME \n");
		sbSql.append("     , DECODE(NVL(A.SALE_QTY*A.STD_QTY,0),0,0,ROUND(((A.TRANS_QTY/(A.SALE_QTY*A.STD_QTY)) - 1)*100,2)) AS TRANS_QTY \n");
		sbSql.append("  FROM \n");
		sbSql.append("( \n");
		sbSql.append("SELECT TO_CHAR(A.UPJANG) AS UPJANG, A.UPJANGNM_DISP \n");
        sbSql.append("     , (SELECT Z.SALE_QTY FROM FMO_MENU_SALE Z \n");
        sbSql.append("         WHERE Z.UPJANG = A.UPJANG \n");
		sbSql.append("           AND Z.SALE_YM = '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "' \n");
		sbSql.append("           AND Z.MENU_ID = " + nullToBlank(ds_Cond.getString(0, "MENU_ID")) + ") AS SALE_QTY \n");
        sbSql.append("     , B.ITEM_CODE, B.ITEM_NAME \n");
        sbSql.append("     , B.TRANS_QTY, B.STD_QTY \n");
		sbSql.append("  FROM FMS_UPJANG A \n");
		sbSql.append("     , (SELECT TO_CHAR(A.TRANS_UPJANG) AS UPJANG \n");
		sbSql.append("             , A.ITEM_CODE, C.STD_QTY \n");
		sbSql.append("             , (SELECT Z.ITEM_NAME FROM HLDC_PO_ITEM_MST Z WHERE Z.ITEM_CODE = A.ITEM_CODE) AS ITEM_NAME \n");
		sbSql.append("             , SUM(DECODE(SUBSTR(A.TRANS_TYPE,1,1),'I',1,-1) * A.TRANS_QTY) AS TRANS_QTY \n");
		sbSql.append("          FROM HLDC_PO_TRANSACTION A \n");
		sbSql.append("             , FMS_UPJANG B \n");
		sbSql.append("             , FMO_MENU_DTL C \n");
		sbSql.append("         WHERE A.TRANS_UPJANG = B.UPJANG \n");
		sbSql.append("           AND A.ITEM_CODE = C.ITEM_CODE \n");
		sbSql.append("           AND A.TRANS_DATE BETWEEN '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "'||'01' \n");
		sbSql.append("                                AND '" + nullToBlank(ds_Cond.getString(0, "SALE_YM")) + "'||'31' \n");
		sbSql.append("           AND ((A.TRANS_TYPE = 'I001') OR (A.TRANS_TYPE LIKE '_002' AND A.SOURCE_TYPE = 'PO'))\n");
		sbSql.append("           AND A.SUBINV_CODE LIKE 'S10%' \n");
		sbSql.append("           AND B.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append("           AND C.MENU_ID = " + nullToBlank(ds_Cond.getString(0, "MENU_ID")) + " \n");
		sbSql.append("         GROUP BY A.TRANS_UPJANG, A.ITEM_CODE, C.STD_QTY) B \n");
		sbSql.append(" WHERE A.UPJANG = B.UPJANG--(+) \n");
		sbSql.append("   AND A.MAIN_UPJANG = " + nullToBlank(ds_Cond.getString(0, "MAIN_UPJANG")) + " \n");
		sbSql.append(") A \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery();
		ds_ListTmp2 = this.makeDataSet(rs, "ds_ListTmp2");
		pstmt.close();
		rs.close();


		/**종료**/
		out_dl.add(ds_ListTmp1);
		out_dl.add(ds_ListTmp2);
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