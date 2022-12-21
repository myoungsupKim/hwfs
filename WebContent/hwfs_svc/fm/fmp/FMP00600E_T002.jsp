<%
//-----------------------------------------------------------------------------
//■ 시스템명     : 단가관리/공급업체 관리/ 공급업체 발주내역 수정(저장)
//■ 프로그램ID   : FMP00600E_T002.jsp
//■ 프로그램명   : 공급업체 발주내역 수정
//■ 작성일자     : 2010.06.02
//■ 작성자       : 박은규
//■ 이력관리     : 2010.06.02
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

		//오토커밋 강제 false
		conn.setAutoCommit(false);		

		//입력 데이타
		DataSet ds_list     = in_dl.get("ds_list");
		//입력 파라메터
		String g_Upjang     = nullToBlank(in_vl.getString("g_Upjang"));
		String g_EmpNo      = nullToBlank(in_vl.getString("g_EmpNo"));
		String sUpjang      = nullToBlank(in_vl.getString("sUpjang"));
		String sSubinv      = nullToBlank(in_vl.getString("sSubinv"));
		String sNeedDate    = nullToBlank(in_vl.getString("sNeedDate"));

		//FileLog.println("d:\\aaa.txt", ds_list);

		//sql문 버퍼생성
		StringBuffer sbSql = new StringBuffer();
		//

		//구매신청번호 및 승인번호 가져오기
		sbSql.delete(0, sbSql.length());
		sbSql.append("SELECT NVL((SELECT PR_NUM \n");
		sbSql.append("              FROM (SELECT PR_NUM FROM SO_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1 \n");
		sbSql.append("                     UNION ALL \n");
		sbSql.append("                    SELECT PR_NUM FROM FMP_OTCUST_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
		sbSql.append("             WHERE ROWNUM <= 1) \n");
//		sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(HLDC_PO_PR_NUM_S.NEXTVAL,4,'0')) AS PRNUM \n");
		sbSql.append("          ,TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,5,'0')) AS PRNUM \n");
		sbSql.append("     , NVL((SELECT APPROVE_NUM FROM SO_PR WHERE NEED_DATE = '" + sNeedDate + "' AND SUBINV_CODE = '" + sSubinv + "' AND ROWNUM <= 1) \n");
		sbSql.append("          , '자동'||TO_CHAR(SYSDATE,'YYYYMMDD')||'-'||LPAD(SO_PR_NUM_S.NEXTVAL,4,'0')) AS PRAPPRNUM \n");
		sbSql.append("  FROM DUAL \n");

out_vl.add("fa_Sql", sbSql.toString());
		//System.out.println(sbSql.toString());
		pstmt = conn.prepareStatement(sbSql.toString());
		rs = pstmt.executeQuery();

//		if(! rs.next())
//		{
//			out_vl.add("v_ErrMsg", "신청번호 생성오류...\n관리자에게 연락하세요.");
//      this.setResultMessage(0, "OK", out_vl);
//      proc_output(response,out,out_vl,out_dl);
//		   	return;
//		}
		rs.next();

		String sPrNum = rs.getString("PRNUM");
		String sPrApprNum = rs.getString("PRAPPRNUM");

		rs.close();
		pstmt.close();

		//입력,수정
		for ( int i = 0 ; i < ds_list.getRowCount() ; i++ )
		{
			sbSql.delete(0, sbSql.length());		
			

			if (ds_list.getRowType(i) == DataSet.ROW_TYPE_NORMAL)
			{
				continue;
			}
			else if (ds_list.getRowType(i) == DataSet.ROW_TYPE_INSERTED)
			{
				sbSql.append("INSERT INTO FMP_OTCUST_PR( \n");
				sbSql.append("	  PR_ID \n");
				sbSql.append("	, PR_NUM \n");
				sbSql.append("  , DOCU_SOURCE \n");
				sbSql.append("	, PR_DATE \n");
				sbSql.append("	, PR_SABUN \n");
				sbSql.append("	, NEED_DATE \n");
				sbSql.append("	, UPJANG \n");
				sbSql.append("	, SUBINV_CODE \n");
				sbSql.append("	, ITEM_CODE \n");
				sbSql.append("	, ITEM_NAME \n");
				sbSql.append("	, ITEM_SIZE \n");
				sbSql.append("	, PO_UOM \n");
				sbSql.append("	, TAX_CODE \n");
				sbSql.append("	, PR_QTY \n");
				sbSql.append("	, PO_QTY \n");
				sbSql.append("	, SALE_PRICE \n");
				sbSql.append("	, SALE_AMOUNT \n");
				sbSql.append("	, OP_PRICE \n");
				sbSql.append("	, OP_AMOUNT \n");
				sbSql.append("	, OTCUSTCD \n");
				sbSql.append("	, CONTENTS \n");
				sbSql.append("	, LINE_STATUS \n");
				sbSql.append("	, ADD_FLAG \n");
				sbSql.append("	, CUSER \n");
				sbSql.append("	, CDATE \n");
				sbSql.append("	, UUSER \n");
				sbSql.append("	, UDATE \n");
				sbSql.append(" ) VALUES ( \n");
				sbSql.append("	SO_PR_S.NEXTVAL \n");
				sbSql.append("	, '" + sPrNum + "' \n");
				sbSql.append("	, '07 FM(상품)' \n");
				sbSql.append("	, TO_CHAR(SYSDATE,'YYYYMMDD') \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, '" + sNeedDate + "' \n");
				sbSql.append("	, " + sUpjang + " \n");
				sbSql.append("	, '" + sSubinv + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_list.getString(i, "ITEM_CODE")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_list.getString(i, "ITEM_NAME")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_list.getString(i, "ITEM_SIZE")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_list.getString(i, "PO_UOM")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_list.getString(i, "TAX_CODE")) + "' \n");
				sbSql.append("	, " + nullToBlank(ds_list.getString(i, "PR_QTY")) + " \n");
				sbSql.append("	, " + nullToBlank(ds_list.getString(i, "PO_QTY")) + " \n");
				sbSql.append("	, " + nullToBlank(ds_list.getString(i, "SALE_PRICE")) + " \n");
				sbSql.append("	, ROUND(" + nullToBlank(ds_list.getString(i, "PO_QTY")) + " * " + nullToBlank(ds_list.getString(i, "SALE_PRICE")) + ") \n");
				sbSql.append("	, " + nullToBlank(ds_list.getString(i, "OP_PRICE")) + " \n");
				sbSql.append("	, ROUND(" + nullToBlank(ds_list.getString(i, "PO_QTY")) + " * " + nullToBlank(ds_list.getString(i, "OP_PRICE")) + ") \n");
				sbSql.append("	, '" + nullToBlank(ds_list.getString(i, "OTCUSTCD")) + "' \n");
				sbSql.append("	, '" + nullToBlank(ds_list.getString(i, "CONTENTS")) + "' \n");
				sbSql.append("	, '004' \n");
				sbSql.append("	, 'Y' \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append("	, '" + g_EmpNo + "' \n");
				sbSql.append("	, SYSDATE \n");
				sbSql.append(" ) \n");
			}
			else if (ds_list.getRowType(i) == DataSet.ROW_TYPE_UPDATED)
			{
				sbSql.append("UPDATE FMP_OTCUST_PR \n");
				sbSql.append("   SET PO_QTY = " + nullToBlank(ds_list.getString(i, "PO_QTY")) + " \n");
				sbSql.append("     , PR_QTY = " + nullToBlank(ds_list.getString(i, "PR_QTY")) + " \n");
				sbSql.append("     , SALE_AMOUNT = ROUND(" + nullToBlank(ds_list.getString(i, "PO_QTY")) + " * " + nullToBlank(ds_list.getString(i, "SALE_PRICE")) + ") \n");
				sbSql.append("     , OP_AMOUNT = ROUND(" + nullToBlank(ds_list.getString(i, "PO_QTY")) + " * " + nullToBlank(ds_list.getString(i, "OP_PRICE")) + ") \n");
				sbSql.append("     , CONTENTS = '" + nullToBlank(ds_list.getString(i, "CONTENTS")) + "' \n");
				sbSql.append("     , LINE_STATUS = DECODE(" + nullToBlank(ds_list.getString(i, "PO_QTY")) + ",0,'003','004') \n");
				sbSql.append("     , UUSER = '" + g_EmpNo + "' \n");
				sbSql.append("     , UDATE = SYSDATE \n");
				sbSql.append(" WHERE PR_ID = " + nullToBlank(ds_list.getString(i, "PR_ID")) + " \n");
				sbSql.append("   AND LINE_STATUS <= '004' \n");
			}
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