<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 식재영업/수불관리/실적관리/상품별 거래실적 조회
//■ 프로그램ID   : FMP01030V_T001.jsp
//■ 프로그램명   : 제출단가 상품별 거래실적 조회
//■ 작성일자     : 2008.01.31
//■ 작성자       : 노규완
//■ 이력관리     : 2008.01.31
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
	
		//입력 데이타
		DataSet ds_cond     = in_dl.get("ds_cond");
		//입력 파라메터
	//	String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
	//	String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
	
		//out 데이타
		DataSet ds_list;
		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//
		String sCenterCode = nullToBlank(ds_cond.getString(0, "CENTER_CODE"));
		String sItemCode = nullToBlank(ds_cond.getString(0, "ITEM_CODE"));
		String sFmonth = nullToBlank(ds_cond.getString(0, "FROM_MONTH"));
		String sTmonth = nullToBlank(ds_cond.getString(0, "TO_MONTH"));

		//내역조회
        sbSql.append("SELECT A.TRANS_DATE \n");
        sbSql.append("     , A.TRANS_UPJANG \n");
        sbSql.append("     , B.UPJANGNM_DISP AS UPJANGNM \n");
        sbSql.append("     , A.ITEM_CODE \n");
        sbSql.append("     , A.ITEM_NAME \n");
        sbSql.append("     , A.ITEM_SIZE \n");
        sbSql.append("     , A.UOM_CODE \n");
        sbSql.append("     , A.TRANS_QTY \n");
        sbSql.append("     , A.CENTER_CODE \n");
        sbSql.append("     , C.ORIGIN_TYPE \n");
        sbSql.append("  FROM FMS_TRANSACTION_V A \n");
        sbSql.append("     , FMS_UPJANG B \n");
        sbSql.append("     , FMS_ITEM_V C \n");
        sbSql.append(" WHERE A.TRANS_UPJANG = B.UPJANG \n");
        sbSql.append("   AND A.ITEM_CODE = C.ITEM_CODE \n");
        sbSql.append("   AND A.TRANS_TYPE LIKE 'I%' \n");
        sbSql.append("   AND A.TRANS_DATE BETWEEN '" + sFmonth + "'||'01' AND '" + sTmonth + "'||'31' \n");
        sbSql.append("   AND A.ITEM_CODE = '" + sItemCode + "' \n");
        sbSql.append("   AND A.CENTER_CODE = '" + sCenterCode + "' \n");
        sbSql.append(" ORDER BY 1,3 \n");		
		
out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());		
		rs = pstmt.executeQuery(); 
		ds_list = this.makeDataSet(rs, "ds_list");
		
		pstmt.close();
		rs.close();

		/**종료**/
		out_dl.add(ds_list);
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
